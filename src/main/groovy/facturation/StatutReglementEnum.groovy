package facturation

import groovy.transform.CompileStatic

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
@CompileStatic
enum StatutReglementEnum {
	tous(null),
	regle(true),
	attente(false)

	Boolean value

	StatutReglementEnum(Boolean value) {
		this.value = value
	}
}
