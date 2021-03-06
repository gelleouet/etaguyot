package facturation

import grails.gorm.transactions.Transactional

class FactureService extends AppService<Article> {

	List<Facture> search(FactureCommand command, Map pagination) {
		log.info "Recherche entre ${command.dateDebut.format('dd/MM/yyyy')} et ${command.dateFin.format('dd/MM/yyyy')}"

		return Facture.createCriteria().list(pagination) {
			if (command.numero) {
				ilike 'numero', QueryUtils.decorateMatchAll(command.numero)
			} else {
				between 'dateFacture', command.dateDebut, command.dateFin
			}

			client {
				if (command.clientId) {
					idEq command.clientId
				}
			}
			
			if (command.types) {
				'in' 'type', command.types
			}
			
			if (command.statuts) {
				'in' 'statut', command.statuts
			}

			order 'numero', 'desc'
		}
	}
	
	
	Map synthese(FactureCommand command) {
		log.info "Synthese entre ${command.dateDebut.format('dd/MM/yyyy')} et ${command.dateFin.format('dd/MM/yyyy')}"
		Map synthese = [:]
		
		def result = Facture.createCriteria().get() {
			if (command.numero) {
				ilike 'numero', QueryUtils.decorateMatchAll(command.numero)
			} else {
				between 'dateFacture', command.dateDebut, command.dateFin
			}

			client {
				if (command.clientId) {
					idEq command.clientId
				}
			}
			
			if (command.types) {
				'in' 'type', command.types
			}
			
			if (command.statuts) {
				'in' 'statut', command.statuts
			}

			projections {
				count "id", "count"
				sum "totalHT", "totalHT"
				sum "totalTVA", "totalTVA"
				sum "totalRegle", "totalRegle"
			}
		}
		
		if (result) {
			synthese.count = result[0] ?: 0
			synthese.totalHT = result[1] ?: 0
			synthese.totalTVA = result[2] ?: 0
			synthese.totalRegle = result[3] ?: 0
			synthese.totalTTC = synthese.totalHT + synthese.totalTVA
			synthese.totalResteDu = synthese.totalTTC - synthese.totalRegle
		}
		
		return synthese
	}


	Facture createNewFacture(TypeFactureEnum typeFacture) {
		Facture facture = new Facture(type: typeFacture)
		facture.dateFacture = new Date().clearTime()
		facture.dateEcheance = facture.dateFacture + 45
		facture.numeroBrouillon = newNumeroBrouillon()
		facture.numero = facture.numeroBrouillon
		facture.totalHT = 0d
		facture.totalTVA = 0d
		facture.totalRegle = 0d
		return facture
	}


	String newNumeroFacture(Facture facture) {
		def row = Facture.executeQuery("""
			SELECT count(f) 
			from Facture f 
			where f.dateFacture between :dateDebut and :dateFin 
			and f.statut > 0 and type = :type""",
				[dateDebut: DateUtils.firstDayInMonth(facture.dateFacture),
					dateFin: DateUtils.lastDayInMonth(facture.dateFacture),
					type: facture.type])
		long count = 0

		if (row && row[0]) {
			count = row[0]
		}

		return String.format("${facture.prefix()}%s%03d", facture.dateFacture.format("yyyyMM"), count + 1)
	}


	String newNumeroBrouillon() {
		def row = Facture.executeQuery("SELECT max(numeroBrouillon) from Facture")
		String newCode = "${Facture.PREFIX_BROUILLON}000001"

		if (row && row[0]) {
			def valCode = row[0].replace(Facture.PREFIX_BROUILLON, "").toLong()
			newCode = String.format("${Facture.PREFIX_BROUILLON}%06d", valCode + 1)
		}

		return newCode
	}

	Facture changeClient(Facture facture) {
		if (!facture.dateFacture) {
			facture.dateFacture = new Date().clearTime()
		}

		if (facture.client) {
			if (facture.client.modeReglement) {
				facture.modeReglement = facture.client.modeReglement
			}
			if (facture.client.echeance) {
				facture.dateEcheance = calculEcheance(facture.dateFacture, facture.client.echeance)
			}
		}

		return facture
	}
	
	
	Date calculEcheance(Date date, Echeance echeance) {
		if (!date || !echeance) {
			return date
		}
		
		if (echeance.libelle == "30JFM") {
			return DateUtils.lastDayInMonth(DateUtils.incDay(date, 30))
		} else if (echeance.libelle == "30JN") {
			return DateUtils.incDay(date, 30)
		} else if (echeance.libelle == "60JFM") {
			return DateUtils.lastDayInMonth(DateUtils.incDay(date, 60))
		} else if (echeance.libelle == "60JN") {
			return DateUtils.incDay(date, 60)
		} else {
			return date
		}
	}


	Facture addArticle(Facture facture) {
		facture.clearNotPersistArticles()
		FactureArticle article = new FactureArticle()

		if (facture.articles) {
			article.ordre = facture.articles.max {
				it.ordre
			}.ordre + 1
			article.status = article.ordre
		}

		facture.addToArticles(article)

		return changeTarification(facture, 0)
	}

	Facture removeArticle(Facture facture, int status) {
		facture.clearNotPersistArticles()
		facture.articles.removeAll {
			it.status == status
		}
		return changeTarification(facture, status)
	}

	Facture changeArticle(Facture facture, int status) {
		facture.clearNotPersistArticles()
		FactureArticle farticle = facture.articles.find {
			it.status == status
		}

		if (farticle) {
			Article article = farticle.article()

			if (article) {
				farticle.libelle = article.libelle
				farticle.commentaire = article.commentaire
				farticle.unite = article.unite
				farticle.prixHT = article.prixHT
				farticle.tauxTVA = article.tauxTVA
			}
		}

		return changeTarification(facture, status)
	}

	Facture changeTarification(Facture facture, int status) {
		facture.clearNotPersistArticles()
		facture.clearNotPersistReglements()
		facture.checkArticles()
		facture.updateTotaux()
		return facture
	}

	@Transactional(readOnly = false, rollbackFor = AppException)
	Facture saveAndCheck(Facture facture) throws AppException {
		facture.clearNotPersistArticles()
		facture.clearNotPersistReglements()
		
		facture.checkArticles()
		
		facture.updateTotaux()
		facture.updateTvas()
		facture.updateReglements()
		
		return super.save(facture)
	}
	
	@Transactional(readOnly = false, rollbackFor = AppException)
	Facture valider(Facture facture) throws AppException {
		saveAndCheck(facture)
		facture.valider()
		// vrai numéro de facture
		facture.numero = newNumeroFacture(facture)
		return super.save(facture)
	}
	
	Facture avoir(Facture facture) throws AppException {
		Facture avoir = createNewFacture(TypeFactureEnum.avoir)
		
		// recopie les infos de la facture source
		avoir.client = facture.client
		avoir.modeReglement = facture.modeReglement
		avoir.reference = "Avoir sur la facture n° ${ facture.numero }"
		
		facture.articles.each { article ->
			avoir.articles << new FactureArticle(codeArticle: article.codeArticle, libelle: article.libelle,
				quantite: article.quantite, unite: article.unite, prixHT: article.prixHT,
				tauxTVA: article.tauxTVA, ordre: article.ordre)
		}
		
		avoir.checkArticles()
		avoir.updateTotaux()
		
		return avoir
	}
	
	
	/**
	 * Calcul stat CA sur une année complète
	 * Raccourci FactureService#statCAByMonth
	 * 
	 * @param date
	 * @return
	 */
	Map statCAByMonthForYear(Date date) {
		statCAByMonth(DateUtils.firstDayInYear(date), DateUtils.lastDayInYear(date), date)
	}
	
	
	/**
	 * Calcul le CA par mois entre 2 dates. 
	 * Pré-calcul des totaux sur période, et raccourci vers le total du mois en cours
	 * Comme c'est regroupé par le n° du mois, il ne faut pas que la plage
	 * de date couvre plus d'une année
	 * Le Ca est converti en milliers d'euros
	 * 
	 * @param dateDebut
	 * @param dateFin
	 * @param currentDate
	 * @return
	 */
	Map statCAByMonth(Date dateDebut, Date dateFin, Date currentDate) {
		log.info "Stat CA entre ${dateDebut.format('dd/MM/yyyy')} et ${dateFin.format('dd/MM/yyyy')}, current: ${currentDate.format('dd/MM/yyyy')}"
		
		Map stat = [dateDebut: dateDebut, dateFin: dateFin, values: []]
		
		List values = Facture.executeQuery("""\
			SELECT new map(month(f.dateFacture) as month, (sum(f.totalHT) / 1000) as totalht)
			FROM Facture f
			WHERE f.dateFacture between :dateDebut and :dateFin
			AND f.statut >= :statut
			GROUP BY month(f.dateFacture)
			ORDER BY month(f.dateFacture)
		""", [dateDebut: dateDebut, dateFin: dateFin, statut: StatutFactureEnum.validee.id])
		
		double cumulHT = 0
		
		// retravaille les valeurs pour avoir une liste complète de 12 éléments (plus
		// pratique pour les charts et plus facile pour comparer 2 années)
		// !! ATTENTION : les mois issus du HQL sont indexés de 1 à 12, alors qu'en Java c'est de 0 à 11
		for (int month = 1; month <= 12; month++) {
			Map val = values.find { it.month == month } ?: [month: month, totalht: 0]
			
			// arrondi du total
			val.totalht = (val.totalht as Double).round(1)
			
			cumulHT += val.totalht
			val.cumulht = (cumulHT as Double).round(1)
			stat.values << val
		}
		
		stat.currentHT = stat.values[currentDate[Calendar.MONTH]].totalht 
		stat.totalHT = cumulHT

		return stat
	}
}
