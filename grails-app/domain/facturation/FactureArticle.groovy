package facturation

import grails.validation.Validateable
import groovy.transform.AutoClone

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
@AutoClone
class FactureArticle implements Validateable {
	Facture facture
	String codeArticle
	String libelle
	String commentaire
	Double quantite
	String unite
	Double prixHT
	Double tauxTVA
	int ordre

	// user properties
	Integer status


	static transients = ['status']

	static belongsTo = [facture: Facture]

	static constraints = {
		commentaire nullable: true
		unite nullable: true
		status bindable: true
	}

	static mapping = {
		facture index: 'facture_article_idx'
		codeArticle length: 32
		unite length: 16
		commentaire type: 'text'
	}


	FactureArticle() {
		quantite = 1
		prixHT = 0d
		tauxTVA = Constantes.TVA
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

	List<Article> articles() {
		def article = article()
		return article ? [article]: []
	}

	Article article() {
		if (codeArticle) {
			return Article.findByCode(codeArticle)
		} else {
			return null
		}
	}
}
