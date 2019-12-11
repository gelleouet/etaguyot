package facturation.trait

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
trait PaginationController {
	Map pagination() {
		def offset = params?.offset ?: 0
		def max = params?.max ?: 25
		[offset: offset, max: max]
	}
}
