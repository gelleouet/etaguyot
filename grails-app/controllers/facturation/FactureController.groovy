package facturation

class FactureController extends AppController {

	FactureService factureService


	def index(FactureCommand command) {
		def factures = factureService.search(command, pagination())
		render view: 'index', model: [command: command, factures: factures]
	}

	def globalSearch(String value) {
		def command
		if (value.isInteger()) {
			command = new FactureCommand(code: value)
		} else {
			command = new FactureCommand(libelle: value)
		}

		def factures = factureService.search(command, [max: 1])

		if (factures.totalCount == 1) {
			edit(factures[0])
		} else {
			index(command)
		}
	}

	def edit(Facture facture) {
		facture = getRequestCommand(facture ?: new Facture())
		if (!facture.code) {
			facture.code = factureService.newCodeFacture()
		}
		def familles = factureService.groupFamille()
		def unites = factureService.groupUnite()
		render view: 'edit', model: [facture: facture, familles: familles,
			unites: unites]
	}

	@ExceptionHandler
	def save(Facture facture) {
		checkErrors(this, facture)
		factureService.save(facture)
		redirect(action: 'index')
	}

	@ExceptionHandler
	def delete(Facture facture) {
		checkErrors(this, facture)
		factureService.delete(facture)
		redirect(action: 'index')
	}
}
