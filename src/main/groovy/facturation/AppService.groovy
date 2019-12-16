package facturation

import grails.gorm.transactions.Transactional

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
@Transactional(readOnly = true)
abstract class AppService<T> {

	/**
	 * Save
	 * 
	 * @param domain
	 * @return
	 * @throws AppException
	 */
	@Transactional(readOnly = false, rollbackFor = AppException)
	T save(T domain) throws AppException {
		if (!domain.save()) {
			throw new AppException(domain)
		}

		return domain
	}


	/**
	 * Delete
	 * 
	 * @param domain
	 * @throws AppException
	 */
	@Transactional(readOnly = false, rollbackFor = AppException)
	void delete(T domain) throws AppException {
		domain.delete()
	}
}
