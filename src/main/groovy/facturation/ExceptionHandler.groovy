package facturation

import java.lang.annotation.Documented
import java.lang.annotation.ElementType
import java.lang.annotation.Inherited
import java.lang.annotation.Retention
import java.lang.annotation.RetentionPolicy
import java.lang.annotation.Target

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
@Target([ElementType.METHOD])
@Retention(RetentionPolicy.RUNTIME)
@Inherited
@Documented
@interface ExceptionHandler {
	/**
	 * L'action à exécuter (doit être spécifié avec controller)
	 *
	 * @return
	 */
	String action() default ""


	/**
	 * Le controller utilisé (si vide on utilise le controller courant)
	 */
	String controller() default ""


	/**
	 * Si activé, renvoit l'erreur au format json
	 *
	 * @return
	 */
	boolean json() default false
}
