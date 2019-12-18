package facturation

import grails.plugin.springsecurity.annotation.Secured


class DashboardController extends AppController {

	private static Map controllerPrefix = [
		"c": "client",
		"a": "article",
		"f": "facture",
	]

	def index() {
		[:]
	}


	@ExceptionHandler(action = "index")
	def globalSearch(String value) {
		def controllerSearch = controllerPrefix[(value[0])]

		if (controllerSearch) {
			redirect controller: controllerSearch, action: "globalSearch", params: [value: value.substring(1)]
		} else {
			throw new AppException("Aucun résultat ne correspond à votre recherche !")
		}
	}
}
