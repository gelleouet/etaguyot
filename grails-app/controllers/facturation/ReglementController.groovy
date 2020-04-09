package facturation

class ReglementController extends AppController {
	
	ReglementService reglementService
	
	def index(ReglementCommand command) {
		command = getViewSearchAttribute(command)
		def reglements = reglementService.search(command, command.pagination())
		def synthese = reglementService.synthese(command)
		
		render view: 'index', model: [command: command, reglements: reglements, synthese: synthese]
	}
	
	
	def globalSearch(String value) {
		def command = new ReglementCommand(numero: value)
		index(command)
	}
	
	
	def dialogReglementEcheance(FactureReglement reglement) {
		render template: 'dialogReglementEcheance', model: [reglement: reglement,
			modeReglements: ModeReglement.list()]
	}
	
	@ExceptionHandler(action = "index")
	def regler(FactureReglement reglement) {
		reglementService.regler(reglement)
		redirect(action: 'index')
	}
}
