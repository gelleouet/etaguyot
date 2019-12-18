package facturation

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
class NumberUtils {
	static Double round(Double value, int precision = 2) {
		if (value == null) {
			return null
		}
		return value.round(precision)
	}
}
