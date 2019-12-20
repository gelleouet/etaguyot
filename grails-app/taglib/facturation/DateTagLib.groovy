package facturation

class DateTagLib {
	static namespace = 'app'
	static defaultEncodeAs = [taglib:'html']

	// les tags renvoyant directement une valeur pouvant être utilisé comme fonction
	static returnObjectForTags = [
		'formatUser',
		'formatPicker',
		'formatUserDateTime',
		'formatTimeAgo',
		'formatDateTimePickerUser'
	]


	/**
	 * Formatte une date au format utilisateur
	 * 
	 * @attr date REQUIRED la date à formatter
	 */
	def formatUser = {attrs, body ->
		g.formatDate(date: attrs.date, format: DateUtils.FORMAT_DATE_USER)
	}


	/**
	 * formatte suivant "Il y a ....."
	 * 
	 */
	def formatTimeAgo = { attrs, body ->
		DateUtils.formatTimeAgo(attrs.date)
	}


	/**
	 * Formatte une date pour l'insérer dans un input datepicker
	 * 
	 * @attr date REQUIRED la date à formatter
	 */
	def formatPicker = {attrs, body ->
		g.formatDate(date: attrs.date, format: DateUtils.FORMAT_DATE_PICKER)
	}


	/**
	 * Formatte une date au format utilisateur
	 *
	 * @attr date REQUIRED la date à formatter
	 */
	def formatUserDateTime = {attrs, body ->
		g.formatDate(date: attrs.date, format: "dd/MM/yyyy 'à' HH:mm")
	}


	/**
	 * Formatte une date pour l'insérer dans un input datetimepicker
	 *
	 * @attr date REQUIRED la date à formatter
	 */
	def formatDateTimePickerUser = {attrs, body ->
		g.formatDate(date: attrs.date, format: DateUtils.FORMAT_DATETIME_USER)
	}
}
