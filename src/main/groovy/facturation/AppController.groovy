package facturation

import java.lang.reflect.Method

import grails.plugin.springsecurity.annotation.Secured

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
@Secured("isAuthenticated()")
abstract class AppController {
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
		def offset = params?.offset ?: 0
		def max = params?.max ?: 25
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
}
