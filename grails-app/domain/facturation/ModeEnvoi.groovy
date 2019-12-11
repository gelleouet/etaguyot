package facturation

import grails.validation.Validateable

class ModeEnvoi implements Validateable {

	String libelle


	static constraints = {
		libelle unique: true
	}

	static mapping = {
		sort 'libelle'
	}
}
