package facturation.report

import javax.servlet.http.HttpServletResponse

import facturation.AppException


/**
 * Contrat de base pour le reporting
 */
interface ReportService {

	/**
	 * Rendu dans un flux quelconque
	 *
	 * @param reportType
	 * @param parameters
	 * @param outStream
	 * @throws Exception
	 */
	void renderPdf(Class<Report> reportType, Map parameters, OutputStream outStream) throws AppException


	/**
	 * Rendu particulier dans le flux de la réponse HTTP
	 *
	 * @param reportType
	 * @param parameters
	 * @param response
	 * @throws Exception
	 */
	void renderPdf(Class<Report> reportType, Map parameters, HttpServletResponse response) throws AppException
}