package facturation

import grails.validation.Validateable
import groovy.transform.AutoClone

@AutoClone
class Facture implements Validateable {

	static final String PREFIX_BROUILLON = "BRO"
	static final String PREFIX_FACTURE = "FAC"
	static final String PREFIX_AVOIR = "AVR"


	String numero
	String numeroBrouillon
	Client client
	Date dateFacture
	Date dateEcheance
	ModeReglement modeReglement
	String reference
	String commentaire
	Double totalHT
	Double totalTVA
	Double totalRegle
	// OU logique des différents status (afin d'avoir plusieurs flags en même temps)
	int statut
	TypeFactureEnum type = TypeFactureEnum.facture

	Set<FactureTva> tvas = []
	Set<FactureArticle> articles = []
	Set<FactureReglement> reglements = []


	static hasMany = [tvas: FactureTva, articles: FactureArticle, reglements: FactureReglement]

	static constraints = {
		numero unique: true
		reference nullable: true
		commentaire nullable: true
	}

	static mapping = {
		numero length: 16
		numeroBrouillon length: 16
		commentaire type: 'text'
		type enumType: 'string', length: 16
		dateFacture index: 'facture_idx'
		tvas cascade: 'all-delete-orphan'
		articles cascade: 'all-delete-orphan'
		reglements cascade: 'all-delete-orphan'
	}


	Double totalTTC() {
		totalHT + totalTVA
	}
	
	Double resteDu() {
		totalTTC() - totalRegle
	}

	Double totalReparti() {
		reglements?.sum { it.montantTTC ?: 0 } ?: 0
	}
	
	Double resteARepartir() {
		totalTTC() - totalReparti()
	}

	Facture clearNotPersistArticles() {
		articles?.removeAll { it.status == null }
		return this
	}

	Facture clearNotPersistReglements() {
		reglements?.removeAll { it.status == null }
		return this
	}

	Facture updateTotaux() {
		// IMPORTANT !! utiliser le setter pour que gorm puisse détecter le changement interne
		setTotalHT(articles.sum { it.totalHT() } ?: 0d)
		setTotalTVA(articles.sum { it.totalTVA() } ?: 0d)
		if (totalRegle == null) {
			setTotalRegle(0d)
		}
		return this
	}
	
	
	Facture updateReglements() {
		// 1. vérifier qu'il y a au moins 1 échéance
		if (!reglements) {
			this.addToReglements(dateEcheance: this.dateEcheance,
				montantTTC: this.totalTTC(), montantRegle: 0d)
		}
		
		// 2. tri des règlements par date échéance pour les futurs traitement
		List<FactureReglement> reglementSort = reglements.sort { it.dateEcheance }
		
		// 3. maj des champs null
		reglements.each {
			if (!it.modeReglement) {
				it.modeReglement = this.modeReglement
			}
			if (it.montantRegle == null) {
				it.montantRegle = 0d
			}
			if (it.montantTTC == null) {
				it.montantTTC = 0d
			}
		}
		
		// 4. synchro du total réglé facture avec ceux des réglements
		updateTotalRegle()
		
		// 5. synchro de la date echeance facture avec la 1ère échéance
		// IMPORTANT !! utiliser le setter pour que gorm puisse détecter le changement interne
		setDateEcheance(reglementSort[0].dateEcheance)
		
		// 6. synhcro des montant reglement avec le montant total
		// si écart il est complété sur la dernière échéance
		Double resteARepartir = this.resteARepartir()
		
		if (resteARepartir) {
			reglementSort.last().montantTTC += resteARepartir
		}
		
		return this
	}
	

	Facture updateTotalRegle() {
		// IMPORTANT !! utiliser le setter pour que gorm puisse détecter le changement interne
		setTotalRegle(reglements.sum { it.dateReglement ? it.montantRegle : 0d } ?: 0d)
		
		if (totalRegle && totalRegle == totalTTC()) {
			setStatut(StatutFactureEnum.reglee.id) 
		}
		
		return this
	}
	
	
	FactureReglement addReglement() {
		// A faire avant l'ajout du nouvel objet sinon le calcul du reste qui se base
		// sur les reglements va planter avec un montant à null
		Double reste = this.resteARepartir()
		
		FactureReglement reg = new FactureReglement()
		this.addToReglements(reg)
		
		reg.modeReglement = this.modeReglement
		reg.montantTTC = reste
		reg.montantRegle = 0d
		reg.dateEcheance = (reglements.max { it.dateEcheance }?.dateEcheance ?: this.dateEcheance) + 30
		
		return reg
	}
	
	Facture removeReglement(Integer status) {
		reglements.removeAll { it.status == status }
		return updateReglements()
	}
	
	Facture checkReglement() throws AppException  {
		if (!reglements) {
			throw new AppException("Veuillez renseigner au moins une échéance !")
		}
		
		Double reste = resteARepartir()
		
		if (reste != 0) {
			throw new AppException("Le reste à répartir doit être égal à 0 !")
		}
		
		reglements.each { 
			if (!it.montantTTC) {
				throw new AppException("Le montant d'une échéance ne peut pas être égal à 0 !")
			}
		}
		
		return updateReglements()
	}


	Facture updateTvas() {
		Map tvaGroup = articles.groupBy { it.tauxTVA }

		// ajout ou update les nouveaux taux
		tvaGroup.each { tauxTVA, farticles ->
			FactureTva ftva = this.tvas.find { it.tauxTVA == tauxTVA }

			if (!ftva) {
				ftva = new FactureTva(tauxTVA: tauxTVA)
				this.addToTvas(ftva)
			}

			ftva.totalHT = farticles.sum { it.totalHT() }
			ftva.totalTVA = farticles.sum { it.totalTVA() }
		}

		// supprime les anciens taux
		tvas.removeAll {  ftva ->
			!tvaGroup.containsKey(ftva.tauxTVA)
		}

		return this
	}

	Facture checkArticles() {
		articles.each { article ->
			if (article.quantite == null) {
				article.quantite = 0d
			}
			if (article.prixHT == null) {
				article.prixHT = 0d
			}
			if (article.tauxTVA == null) {
				article.tauxTVA = Constantes.TVA
			}
			if (article.prixHT > 0 && isAvoir()) {
				article.prixHT = article.prixHT * -1.0
			}
		}
		return this
	}
	
	boolean isAvoir() {
		type == TypeFactureEnum.avoir
	}
	
	boolean isFacture() {
		type == TypeFactureEnum.facture
	}
	
	boolean isBrouillon() {
		statut == StatutFactureEnum.brouillon.id
	}
	
	boolean isValidee() {
		statut >= StatutFactureEnum.validee.id
	}
	
	boolean isEnvoyee() {
		statut >= StatutFactureEnum.envoyee.id
	}
	
	boolean isReglee() {
		statut >= StatutFactureEnum.reglee.id
	}
	
	boolean isAnnulee() {
		statut == StatutFactureEnum.annulee.id
	}

	String titre() {
		type.toString().toUpperCase()
	}
	
	String titreComplet() {
		if (id) {
			type.toString().toUpperCase() + ' ' + numero
		} else if (isAvoir()) {
			return "Nouvel avoir"
		} else {
			return "Nouvelle facture"
		}
	}
	
	Facture valider() throws AppException {
		if (isValidee()) {
			throw new AppException("La facture est déjà validée !", this)
		}
		
		if (!articles) {
			throw new AppException("Veuillez insérer au moins un article !", this)
		}
		
		if (!totalHT) {
			throw new AppException("Le total HT est égal à 0 !", this)
		}
		
		statut = StatutFactureEnum.validee.id
		
		return this
	}

	String prefix() {
		isAvoir() ? PREFIX_AVOIR : PREFIX_FACTURE
	}	
}
