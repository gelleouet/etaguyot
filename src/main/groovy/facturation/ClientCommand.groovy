package facturation

import grails.validation.Validateable

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
class ClientCommand implements Validateable {
	String code
	String raisonSociale
	String email
	String famille

	static constraints = {
		code nullable: true
		raisonSociale nullable: true
		email nullable: true
		famille nullable: true
	}
}
