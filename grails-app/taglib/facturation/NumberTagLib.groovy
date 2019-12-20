package facturation

class NumberTagLib {
	static namespace = 'app'
	static defaultEncodeAs = [taglib:'html']

	// les tags renvoyant directement une valeur pouvant être utilisé comme fonction
	static returnObjectForTags = ['format2Decimal']


	/**
	 * Formatte une date au format utilisateur
	 * 
	 * @attr number REQUIRED la date à formatter
	 */
	def format2Decimal = {attrs, body ->
		g.formatNumber(number: attrs.number, format: "0.00")
	}

}
