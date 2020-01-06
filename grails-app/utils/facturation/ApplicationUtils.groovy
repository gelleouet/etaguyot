package facturation

import org.springframework.context.ApplicationContext

import grails.core.GrailsApplication

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
class ApplicationUtils {

	static Object autowirebean(ApplicationContext applicationContext, Object bean) {
		applicationContext.getAutowireCapableBeanFactory().autowireBean(bean)
		return bean
	}


	static Object autowirebean(GrailsApplication grailsApplication, Object bean) {
		grailsApplication.getMainContext().getAutowireCapableBeanFactory().autowireBean(bean)
		return bean
	}
}
