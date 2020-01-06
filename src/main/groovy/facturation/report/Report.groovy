package facturation.report

import org.apache.commons.lang.StringUtils

import facturation.AppException

abstract class Report {
	String baseURL
	Map parameters = [:]


	/**
	 * Nom par défaut du report
	 *
	 * @return
	 */
	String name() {
		return StringUtils.uncapitalize(this.class.simpleName)
	}


	/**
	 * Nom par défaut du report
	 *
	 * @return
	 */
	String view() {
		return StringUtils.uncapitalize(this.class.simpleName)
	}

	/**
	 * Le modèle des datas
	 *
	 * @return
	 * @throws AppException
	 */
	final Map model() throws AppException {
		Map model = [report: this]
		modelImpl(model)
		return model
	}

	/**
	 * Le modèle à impléménter
	 *
	 * @throws AppException
	 */
	protected abstract void modelImpl(Map model) throws AppException
}
