package facturation.report

import facturation.AppException

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
class FactureReport extends Report {

	/**
	 * (non-Javadoc)
	 *
	 * @see facturation.report.Report#modelImpl(java.util.Map)
	 */
	@Override
	protected void modelImpl(Map model) throws AppException {
		model.facture = parameters.facture
	}

	/** (non-Javadoc)
	 *
	 * @see facturation.report.Report#name()
	 */
	@Override
	String name() {
		"${grailsApplication.config.info.app.name}-${parameters.facture.numero}"
	}
}
