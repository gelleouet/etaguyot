package facturation

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
class ArticleCommand extends AbstractCommand {
	String code
	String libelle
	String famille

	static constraints = {
		code nullable: true
		libelle nullable: true
		famille nullable: true
	}
}
