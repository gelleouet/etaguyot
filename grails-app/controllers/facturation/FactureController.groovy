package facturation

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.beans.factory.annotation.Qualifier

import facturation.report.FactureReport
import facturation.report.ReportService


class FactureController extends AppController {

	FactureService factureService

	@Autowired
	@Qualifier("gspfo")
	ReportService reportService


	def index(FactureCommand command) {
		command = getViewSearchAttribute(command)
		def factures = factureService.search(command, command.pagination())
		def synthese = factureService.synthese(command)
		
		render view: 'index', model: [command: command, factures: factures, synthese: synthese]
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
		facture = getRequestCommand(facture ?: factureService.createNewFacture(TypeFactureEnum.facture))
		render view: 'edit', model: completeModel([facture: facture])
	}

	private Map completeModel(Map model) {
		model.modeReglements = ModeReglement.list()
		model.clients = model.facture.client ? [model.facture.client]: []
		return model
	}

	@ExceptionHandler
	def save(Facture facture) {
		checkErrors(this, facture)
		factureService.saveWithArticles(facture)
		redirect(action: 'edit', id: facture.id)
	}
	
	@ExceptionHandler(action = "edit")
	def valider(Facture facture) {
		checkErrors(this, facture)
		factureService.valider(facture)
		redirect(action: 'edit', id: facture.id)
	}

	@ExceptionHandler
	def delete(Facture facture) {
		checkErrors(this, facture)
		factureService.delete(facture)
		redirect(action: 'index')
	}
	
	def avoir(Facture facture) {
		Facture avoir = factureService.avoir(facture)
		edit(avoir)
	}

	def changeClient(Facture facture) {
		factureService.changeClient(facture)
		render template: 'form', model: completeModel([facture: facture])
	}

	def addArticle(Facture facture) {
		factureService.addArticle(facture)
		render template: 'form', model: completeModel([facture: facture])
	}

	def changeArticle(Facture facture, int status) {
		factureService.changeArticle(facture, status)
		render template: 'form', model: completeModel([facture: facture])
	}

	def changeTarification(Facture facture, int status) {
		factureService.changeTarification(facture, status)
		render template: 'form', model: completeModel([facture: facture])
	}

	def removeArticle(Facture facture, int status) {
		factureService.removeArticle(facture, status)
		render template: 'form', model: completeModel([facture: facture])
	}

	def pdf(Facture facture) {
		reportService.renderPdf(FactureReport, [facture: facture], response)
	}
}
