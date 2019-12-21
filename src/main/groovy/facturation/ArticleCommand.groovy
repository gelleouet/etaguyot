package facturation

import grails.validation.Validateable

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
class ArticleCommand implements Validateable {
	String code
	String libelle
	String famille
	// requete ajax
	String term

	static constraints = {
		code nullable: true
		libelle nullable: true
		famille nullable: true
		term nullable: true
	}
}
