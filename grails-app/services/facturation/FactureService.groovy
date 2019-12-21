package facturation

import grails.gorm.transactions.Transactional

class FactureService extends AppService<Article> {

	List<Facture> search(FactureCommand command, Map pagination) {
		log.info "Search from ${command.dateDebut.format('dd/MM/yyyy')} to ${command.dateFin.format('dd/MM/yyyy')}"

		return Facture.createCriteria().list(pagination) {
			join 'client'
			order 'numero', 'desc'
		}
	}


	Facture createNewFacture(TypeFactureEnum typeFacture) {
		Facture facture = new Facture(type: typeFacture)
		facture.dateFacture = new Date().clearTime()
		facture.dateEcheance = facture.dateFacture + 45
		facture.numeroBrouillon = newNumeroBrouillon()
		facture.numero = facture.numeroBrouillon
		facture.totalHT = 0d
		facture.totalTVA = 0d
		return facture
	}


	String newNumeroFacture(Date date) {
		def row = Article.executeQuery("SELECT max(code) from Article")
		String newCode = "0001"

		if (row && row[0]) {
			def valCode = row[0].toInteger()
			newCode = String.format("%04d", valCode + 1)
		}

		return newCode
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
				facture.dateEcheance = facture.dateFacture + facture.client.echeance
			}
		}

		return facture
	}


	Facture addArticle(Facture facture) {
		facture.clearNotPersistArticles()
		facture.addToArticles(new FactureArticle())
		return facture
	}

	Facture changeArticle(Facture facture, int status) {
		facture.clearNotPersistArticles()
		FactureArticle farticle = facture.articles.find { it.status == status }

		if (farticle) {
			Article article = farticle.article()

			if (article) {
				farticle.libelle = article.libelle
				farticle.unite = article.unite
				farticle.prixHT = article.prixHT
				farticle.tauxTVA = article.tauxTVA
			}
		}

		return facture
	}

	@Transactional(readOnly = false, rollbackFor = AppException)
	Facture saveWithArticles(Facture facture) throws AppException {
		facture.clearNotPersistArticles()
		return super.save(facture)
	}
}
