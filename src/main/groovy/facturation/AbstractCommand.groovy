package facturation

import grails.validation.Validateable

abstract class AbstractCommand implements Validateable {
	// requete ajax
	String term
	
	// pagination
	int max
	int offset
	
	
	static constraints = {
		term nullable: true
	}
	
	
	/**
	 * Retourne un objet pagination avec ses infos
	 * 
	 * @return
	 */
	Map pagination() {
		[offset: offset, max: max]
	}
}
