package facturation

class ReglementController extends AppController {
	
	ReglementService reglementService
	
	def index(ReglementCommand command) {
		command = getViewSearchAttribute(command)
		def reglements = reglementService.search(command, command.pagination())
		def synthese
		
		render view: 'index', model: [command: command, reglements: reglements, synthese: synthese]
	}
	
	
	def globalSearch(String value) {
		def command = new ReglementCommand(numero: value)
		index(command)
	}
}
