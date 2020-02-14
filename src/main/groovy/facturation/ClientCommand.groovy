package facturation


/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
class ClientCommand extends AbstractCommand {
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
