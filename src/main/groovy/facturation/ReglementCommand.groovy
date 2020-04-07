package facturation

import groovy.time.TimeCategory

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
class ReglementCommand extends AbstractCommand {
	String numero
	Date dateDebut
	Date dateFin
	Long clientId
	Boolean regle

	static constraints = {
		clientId nullable: true
		numero nullable: true
		regle nullable: true
	}


	ReglementCommand() {
		Date now = new Date()
		use(TimeCategory) {
			dateDebut = DateUtils.firstDayInYear(now) - 2.years
		}
		dateFin = DateUtils.lastDayInMonth(now)
		regle = false
	}

	Client client() {
		clientId ? Client.read(clientId) : null
	}

	List<Client> clients() {
		Client client = client()
		client ? [client]: []
	}
}
