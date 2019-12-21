package facturation

import grails.validation.Validateable

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
	// OU logique des différents status (afin d'avoir plusieurs flags en même temps)
	int statut
	TypeFactureEnum type = TypeFactureEnum.facture

	Set<FactureTva> tvas = []
	Set<FactureArticle> articles = []


	static hasMany = [tvas: FactureTva]

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
	}


	Double totalTTC() {
		totalHT + totalTVA
	}


	Facture clearNotPersistArticles() {
		articles?.removeAll { it.status == null }
		return this
	}
}
