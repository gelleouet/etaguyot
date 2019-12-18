package facturation

import groovy.transform.CompileStatic

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
@CompileStatic
enum StatutFactureEnum {
	annulee(-1),
	brouillon(0),
	validee(1),
	envoyee(2),
	reglee(4),

	int id

	StatutFactureEnum(int id) {
		this.id = id
	}
}
