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
	// OU logique des différents status (afin d'avoir plusieurs flags en même temps)
	int statut
	TypeFactureEnum type = TypeFactureEnum.facture

	Set<FactureTva> tvas = []
	Set<FactureArticle> articles = []


	static hasMany = [tvas: FactureTva, articles: FactureArticle]

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

	Facture updateTotaux() {
		totalHT = articles.sum { it.totalHT() } ?: 0d
		totalTVA = articles.sum { it.totalTVA() } ?: 0d
		return this
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
		}
		return this
	}

}
