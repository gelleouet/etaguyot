package facturation.report

import grails.gsp.PageRenderer
import org.apache.avalon.framework.configuration.Configuration
import org.apache.avalon.framework.configuration.DefaultConfigurationBuilder
import org.apache.fop.apps.Fop
import org.apache.fop.apps.FopFactory
import org.apache.fop.apps.FopFactoryBuilder
import org.apache.fop.apps.MimeConstants
import org.apache.xmlgraphics.io.ResourceResolver
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.beans.factory.annotation.Qualifier

import facturation.AppException

import javax.annotation.PostConstruct
import javax.servlet.ServletContext
import javax.xml.transform.Result
import javax.xml.transform.Source
import javax.xml.transform.Transformer
import javax.xml.transform.TransformerFactory
import javax.xml.transform.URIResolver
import javax.xml.transform.sax.SAXResult
import javax.xml.transform.stream.StreamSource


/**
 * Implémentation AbstractReportService en XSL-FO créé depuis un template GSP
 *
 */
@Qualifier("gspfo")
class GSPFOReportService extends AbstractReportService {

	PageRenderer groovyPageRenderer

	@Autowired
	ServletContext servletContext

	FopFactory fopFactory


	/**
	 * Init du service
	 * Création de la factory FOP qui ne doit être fait qu'une seule fois et utilisée à chaque rendu
	 *
	 */
	@PostConstruct
	void postConstruct() {
		DefaultConfigurationBuilder fopConfigBuilder = new DefaultConfigurationBuilder()
		Configuration configuration

		this.class.getResourceAsStream("/facturation/report/fop.xconf").withStream {
			configuration = fopConfigBuilder.build(it)
		}

		ResourceResolver resourceResolver = new ServletContextFopResourceResolver(servletContext)
		fopFactory = new FopFactoryBuilder(new File(".").toURI(), resourceResolver).setConfiguration(configuration).build()
	}


	@Override
	protected void implRenderPdf(Report report, OutputStream outStream) throws AppException {
		// création du flux xslfo depuis la GSP liée au report
		String foBuffer = groovyPageRenderer.render(view: "/report/${ report.view() }",
		model: report.model())

		// création du PDF avec le processeur FOP
		Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, outStream)
		// identity transformer car le flux d'entrée est déjà converti en langage fo
		Transformer transformer = TransformerFactory.newInstance().newTransformer()
		Source source = new StreamSource(new StringReader(foBuffer.toString()))
		Result result = new SAXResult(fop.getDefaultHandler())
		transformer.transform(source, result)
	}
}
