package facturation

import grails.databinding.BindUsing
import grails.validation.Validateable

class Article implements Validateable {

	String code
	String libelle
	String commentaire
	String unite
	Double prixHT
	Double tauxTVA = 20d
	String famille


	static constraints = {
		code unique: true
		commentaire nullable: true
		unite nullable: true
		prixHT nullable: true
		tauxTVA nullable: true
		famille nullable: true
	}


	static mapping = {
		code length: 32
		unite length: 16
		commentaire type: 'text'
	}
}
