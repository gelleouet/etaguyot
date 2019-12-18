package facturation

import grails.validation.Validateable

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
class FactureArticle implements Validateable {
	Facture facture
	String codeArticle
	String libelle
	String commentaire
	Double quantite
	String unite
	Double prixHT
	Double tauxTVA


	static belongsTo = [facture: Facture]

	static constraints = {
		commentaire nullable: true
		unite nullable: true
	}

	static mapping = {
		facture index: 'facture_article_idx'
		codeArticle length: 32
		unite length: 16
		commentaire type: 'text'
	}


	Double totalHT() {
		NumberUtils.round(quantite * prixHT)
	}

	Double totalTVA() {
		NumberUtils.round(quantite * prixHT * tauxTVA / 100d)
	}

	Double totalTTC() {
		// on fait la somme au lieu du calcul sur la base HT
		// pour éviter des problèmes d'arrondi
		totalHT() + totalTVA()
	}
}
