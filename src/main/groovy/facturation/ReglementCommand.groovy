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
	boolean regle
	boolean enAttente 

	static constraints = {
		clientId nullable: true
		numero nullable: true
	}


	ReglementCommand() {
		Date now = new Date()
		use(TimeCategory) {
			dateDebut = DateUtils.firstDayInYear(now) - 2.years
			dateFin = DateUtils.lastDayInMonth(now) + 1.month
		}
		enAttente = true
	}

	Client client() {
		clientId ? Client.read(clientId) : null
	}

	List<Client> clients() {
		Client client = client()
		client ? [client]: []
	}
}
