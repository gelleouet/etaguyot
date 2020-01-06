package facturation


/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
class ClassUtils {

	/**
	 * Instance un objet directement à partir de la classe
	 *
	 * @param classe
	 * @return
	 * @throws LimsException
	 */
	static Object newInstance(Class classe) throws AppException {
		try {
			return classe.newInstance()
		} catch (Exception ex) {
			throw new AppException(ex)
		}
	}
}
