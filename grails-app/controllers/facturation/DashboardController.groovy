package facturation

import grails.plugin.springsecurity.annotation.Secured


class DashboardController extends AppController {

	FactureService factureService
	
	
	private static Map controllerPrefix = [
		"c": "client",
		"a": "article",
		"f": "facture",
	]

	
	def index() {
		Date currentDate = new Date().clearTime()
		Map statFactureAnneeN = factureService.statCAByMonthForYear(currentDate)
		Map statFactureAnneeN_1 = factureService.statCAByMonthForYear(DateUtils.incYear(currentDate, -1))
		[statFactureAnneeN: statFactureAnneeN, statFactureAnneeN_1: statFactureAnneeN_1]
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
