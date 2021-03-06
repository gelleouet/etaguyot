package facturation


/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
class FactureCommand extends AbstractCommand {
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

	Client client() {
		clientId ? Client.read(clientId) : null
	}

	List<Client> clients() {
		Client client = client()
		client ? [client]: []
	}
}
