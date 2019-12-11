package facturation

import facturation.trait.PaginationController
import grails.plugin.springsecurity.annotation.Secured

@Secured("permitAll")
class ClientController implements PaginationController {

	ClientService clientService

	def index(ClientCommand command) {
		def clients = clientService.search(command, pagination())
		[command: command, clients: clients]
	}


	def edit(Client client) {
		[client: client, modeEnvois: ModeEnvoi.list(), modeReglements: ModeReglement.list()]
	}
}
