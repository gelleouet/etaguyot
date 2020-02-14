package facturation

import java.lang.reflect.Method

import grails.core.GrailsApplication
import grails.plugin.springsecurity.annotation.Secured

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
@Secured("isAuthenticated()")
abstract class AppController {

	/**
	 * L'attribut en session pour stocker les moteurs de recherche
	 * Si placé dans cet attribut, il aura un comportement de type scope view
	 * car à chaque nouvelle page, il sera remplacé par le moteur de la page actuelle
	 */
	public static final String VIEW_SEARCH_ATTRIBUTE = "viewSearch"
	
	
	GrailsApplication grailsApplication


	/**
	 * Controle des erreurs de validation et de binding.
	 * A appeler en 1er dans une action du controller
	 *
	 * IMPORTANT : la méthode est statique pour éviter d'être traitée avec le système AOP des exceptions handling
	 *
	 * @param controller
	 * @return
	 * @throws AppException
	 */
	static void checkErrors(controller) throws AppException {
		if (controller.hasErrors()) {
			throw new AppException(controller)
		}
	}


	/**
	 * Controle des erreurs de validation et de binding.
	 * A appeler en 1er dans une action du controller
	 *
	 * IMPORTANT : la méthode est statique pour éviter d'être traitée avec le système AOP des exceptions handling
	 *
	 * @param controller
	 * @param command
	 * @return
	 * @throws AppException
	 */
	static void checkErrors(controller, command) throws AppException {
		checkErrors(controller)

		if (command.hasErrors()) {
			throw new AppException(command)
		}
	}


	/**
	 * 
	 * @return
	 */
	Map pagination() {
		def offset
		def max = params?.max ?: grailsApplication.config.app.pagination.max

		// pagination en général des appels ajax
		if (params.page != null && params.page.isInteger()) {
			offset = params.'int'('page') > 0 ? params.'int'('page') - 1 : 0
		} else {
			offset = params?.offset ?: 0
		}

		//reinject les valeur dans la request
		params.max = max
		params.offset = offset

		[offset: offset, max: max]
	}


	/**
	 * 
	 * @param appException
	 */
	void handleAppException(AppException appException) {
		setRequestException(appException)
		setRequestError(appException.message)
		if (appException.command) {
			setRequestCommand(appException.command)
		}

		// recherche du exception handler
		Method method = this.getClass().getDeclaredMethod(actionName)
		ExceptionHandler handler = method.getAnnotation(ExceptionHandler)

		if (handler?.json()) {
			render status: 400, contentType: "application/json" {
				[error: appException.message]
			}
		} else if (request.xhr) {
			render status: 400, template: '/templates/error', model: [error: appException.message]
		} else if (handler) {
			// redirection auto de l'action save vers edit
			String actionForward = (actionName == "save" ? "edit" : actionName)
			forward controller: handler.controller() ?: controllerName, action: handler.action() ?: actionForward
		}
	}


	/**
	 * 
	 * @return
	 */
	def getRequestCommand() {
		request["command"]
	}

	/**
	 *
	 * @return
	 */
	def getRequestCommand(defaultValue) {
		request["command"] ?: defaultValue
	}


	/**
	 * 
	 * @param command
	 */
	void setRequestCommand(command) {
		request["command"] = command
	}


	/**
	 * 
	 * @param error
	 */
	void setRequestError(error) {
		request["error"] = error
	}


	/**
	 * 
	 * @param info
	 */
	void setRequestInfo(info) {
		request["info"] = info
	}


	/**
	 * 
	 * @param warning
	 */
	void setRequestWarning(warning) {
		request["warning"] = warning
	}


	/**
	 * 
	 * @param exception
	 */
	void setRequestException(exception) {
		request["exception"] = exception
	}
	
	
	/**
	 * Renvoit un objet de la session. Si l'objet n'est pas trouvé, l'objet par défaut
	 * est mis en session et renvoyé.
	 *
	 * La méthode géère aussi le cas où l'objet existe en session mais n'est pas du même type
	 * que l'objet par défaut. On utilise pour diminuer le nombre d'objets en session le même nom
	 * d'attribut pour certains objets notamment pour les moteurs de recherche. En changeant de page
	 * l'objet de la page précédente est écrasé. Cela correspond un peu au scope view
	 *
	 * @param attribute
	 * @return
	 */
	Object getSessionAttribute(String attribute, defaultValue) {
		Object value = getSessionAttribute(attribute)

		if (defaultValue) {
			if (!value || value.getClass() != defaultValue.getClass()) {
				value = defaultValue
			}
		}

		return value
	}
	
	
	/**
	 * Récupère un objet en session
	 * 
	 * @param attribute
	 * @return
	 */
	Object getSessionAttribute(String attribute) {
		session[(attribute)]
	}
	
	
	/**
	 * Insère un objet dans la session
	 *
	 * @param attribute
	 * @param value
	 * @return
	 */
	Object setSessionAttribute(String attribute, value) {
		session[(attribute)] = value
		return value
	}
	
	
	/**
	 * Gestion d'un objet command en session
	 * Sur les appels POST, l'objet est récupéré depuis la request et mis en session
	 * Sur les appels GET, l'objet est récupéré depuis la session s'il existe ou depuis la request
	 *
	 * Dans tous les cas, l'objet est remis en session
	 *
	 * @param defaultObject
	 * @return
	 */
	Object getViewSearchAttribute(defaultObject) {
		def value

		if (request.post) {
			value = defaultObject
		} else {
			value = getSessionAttribute(VIEW_SEARCH_ATTRIBUTE, defaultObject)
		}
		
		// on gère la pagination pour les moteurs de recherche
		if (value instanceof AbstractCommand) {
			Map pagination = pagination()
			value.offset = pagination.offset
			value.max = pagination.max
		}

		return setSessionAttribute(VIEW_SEARCH_ATTRIBUTE, value)
	}
}
