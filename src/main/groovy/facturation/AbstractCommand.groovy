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
	
	
	/**
	 * si une valeur est passée dans la request, elle est prioritaire et doit être injectée
	 * 
	 * @param paramOffset
	 * @param paramMax
	 * @param defaultMax
	 * @return
	 */
	AbstractCommand bindPagination(Integer paramOffset, Integer paramMax, int defaultMax) {
		if (paramOffset != null) {
			this.offset = paramOffset
		} 
		
		if (paramMax != null) {
			this.max = paramMax
		} else if (!this.max) {
			this.max = defaultMax
		}
		
		return this
	}
}
