package facturation.report

import grails.core.GrailsApplication
import javax.servlet.http.HttpServletResponse

import org.springframework.beans.BeansException
import org.springframework.context.ApplicationContext
import org.springframework.context.ApplicationContextAware

import facturation.AppException
import facturation.ApplicationUtils
import facturation.ClassUtils


/**
 * Contrat de base pour le reporting
 */
abstract class AbstractReportService implements ReportService {

	static final String DEFAULT_CONTENT_TYPE = "application/download"
	static final String DEFAULT_EXTENSION = "pdf"


	GrailsApplication grailsApplication


	/**
	 * La méthode haut niveau à implémenter sans tenir compte de aspects bas niveau (fermeture flux, buffer, ...)
	 *
	 * @param report
	 * @param outStream
	 * @throws Exception
	 */
	protected abstract void implRenderPdf(Report report, OutputStream outStream) throws AppException


	private Report buidReport(Class reportType, Map parameters) throws AppException {
		Report report = ClassUtils.newInstance(reportType)

		// traitement commun avant le rendu
		report.baseURL = grailsApplication.config.getProperty("etaguyot.server.localBaseURL")
		report.parameters = parameters

		return ApplicationUtils.autowirebean(grailsApplication, report)
	}


	/**
	 * (non-Javadoc)
	 *
	 * @see facturation.report.ReportService#render(java.lang.Class, java.util.Map, java.io.OutputStream)
	 */
	@Override
	final void renderPdf(Class<Report> reportType, Map parameters, OutputStream outStream) throws AppException {
		Report report = buidReport(reportType, parameters)

		new BufferedOutputStream(outStream).withStream {
			implRenderPdf(report, it)
		}
	}


	/**
	 * (non-Javadoc)
	 *
	 * @see facturation.report.ReportService#render(java.lang.Class, java.util.Map, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	final void renderPdf(Class<Report> reportType, Map parameters, HttpServletResponse response) throws AppException {
		Report report = buidReport(reportType, parameters)

		response.setContentType(DEFAULT_CONTENT_TYPE)
		response.setHeader("Content-Disposition", "attachment; filename=${ report.name() }.${ DEFAULT_EXTENSION }")

		new BufferedOutputStream(response.getOutputStream()).withStream {
			implRenderPdf(report, it)
		}
	}
}