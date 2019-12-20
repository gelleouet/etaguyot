package facturation

import grails.databinding.BindUsing
import grails.validation.Validateable

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
class FactureCommand implements Validateable {
	String numero
	Date dateDebut
	Date dateFin
	Long clientId
	List<TypeFactureEnum> types = []
	List<Integer> statuts = []

	static constraints = {
		clientId nullable: true
		numero nullable: true
	}


	FactureCommand() {
		Date now = new Date()
		dateDebut = DateUtils.firstDayInYear(now)
		dateFin = DateUtils.lastDayInYear(now)
	}
}
