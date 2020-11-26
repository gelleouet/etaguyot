package facturation

import grails.databinding.BindUsing
import grails.validation.Validateable
import groovy.transform.AutoClone

@AutoClone
class Article implements Validateable {

	String code
	String libelle
	String commentaire
	String unite
	Double prixHT = 0d
	Double tauxTVA = Constantes.TVA
	String famille
	String compteCompta


	static constraints = {
		code unique: true
		commentaire nullable: true
		unite nullable: true
		prixHT nullable: true
		tauxTVA nullable: true
		famille nullable: true
		compteCompta nullable: true
	}


	static mapping = {
		code length: 32
		unite length: 16
		compteCompta length: 32
		commentaire type: 'text'
	}
}
