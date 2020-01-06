package facturation.report

import org.apache.fop.apps.io.ResourceResolverFactory
import org.apache.xmlgraphics.io.Resource
import org.apache.xmlgraphics.io.ResourceResolver
import javax.servlet.ServletContext


class ServletContextFopResourceResolver implements ResourceResolver {
	/** The protocol name for the servlet context URIs. */
	public static final String SERVLET_CONTEXT_PROTOCOL = "servlet-context:"

	ServletContext servletContext
	ResourceResolver defaultResolver


	ServletContextFopResourceResolver(ServletContext servletContext) {
		this.servletContext = servletContext
		defaultResolver = ResourceResolverFactory.createDefaultResourceResolver()
	}


	/**
	 * Get a resource given the URI pointing to said resource.
	 *
	 * @param uri the resource URI
	 * @return the resource
	 * @throws IOException if an I/O error occured during resource acquisition
	 */
	@Override
	Resource getResource(URI uri) throws IOException {
		String path = uri.toASCIIString()

		if (path.startsWith(SERVLET_CONTEXT_PROTOCOL)) {
			String resourceName = path.substring(SERVLET_CONTEXT_PROTOCOL.length())
			InputStream inStream = servletContext.getResourceAsStream(resourceName)

			if (inStream) {
				return new Resource(inStream)
			} else {
				return null
			}
		} else {
			return defaultResolver.getResource(uri)
		}
	}

	/**
	 * Gets an output stream of a given URI.
	 *
	 * @param uri the output stream URI
	 * @return the output stream
	 * @throws IOException if an I/O error occured while creating an output stream
	 */
	@Override
	OutputStream getOutputStream(URI uri) throws IOException {
		return null
	}
}
