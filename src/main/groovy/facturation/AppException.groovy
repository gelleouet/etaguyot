package facturation

import org.springframework.validation.Errors

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
class AppException extends Exception {
	Object command
	Errors errors


	/**
	 * 
	 */
	AppException() {
		super()
	}


	/**
	 * 
	 * @param message
	 * @param command
	 */
	AppException(Object command) {
		this("Erreur formulaire ${command.class.simpleName}")
		this.command = command
		this.errors = this.command.errors
	}


	/**
	 * 
	 * @param cause
	 * @param command
	 */
	AppException(Throwable cause, Object command) {
		this(cause)
		this.command = command
		this.errors = this.command.errors
	}

	/**
	 * @param message
	 * @param cause
	 * @param enableSuppression
	 * @param writableStackTrace
	 */
	AppException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace)
	}

	/**
	 * @param message
	 * @param cause
	 */
	AppException(String message, Throwable cause) {
		super(message, cause)
	}

	/**
	 * @param message
	 */
	AppException(String message) {
		super(message)
	}

	/**
	 * @param cause
	 */
	AppException(Throwable cause) {
		super(cause)
	}
}
