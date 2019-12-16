package facturation

import grails.plugin.springsecurity.annotation.Secured


class DashboardController extends AppController {

	private static Map controllerPrefix = [
		"c": "client",
		"p": "produit",
		"f": "facture",
	]

	def index() {
		[:]
	}


	@ExceptionHandler(action = "index")
	def search(String value) {
		def controllerSearch = controllerPrefix[(value[0])]

		if (controllerSearch) {
			redirect controller: controllerSearch, params: [code: value.substring(1)]
		} else {
			throw new AppException("Aucun résultat ne correspond à votre recherche !")
		}
	}
}
