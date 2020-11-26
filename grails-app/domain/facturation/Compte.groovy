package facturation

import grails.validation.Validateable

class Compte implements Validateable {

	String code
	String libelle


	static constraints = {
		code unique: true
	}

	static mapping = {
		code length: 32
		sort 'libelle'
	}
}
