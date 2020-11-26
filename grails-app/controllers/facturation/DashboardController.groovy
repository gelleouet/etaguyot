package facturation

import grails.plugin.springsecurity.annotation.Secured


class DashboardController extends AppController {

	StatService statService
	
	
	private static Map controllerPrefix = [
		"c": "client",
		"a": "article",
		"f": "facture",
	]

	def index() {
		Date currentDate = new Date().clearTime()
		Map statFactureAnnuel = statService.statFactureAnnuel(currentDate)
		Map statFactureMensuel = statService.statFactureMensuel(currentDate)
		[statFactureAnnuel: statFactureAnnuel, statFactureMensuel: statFactureMensuel]
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
