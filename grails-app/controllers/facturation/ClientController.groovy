package facturation

import grails.plugin.springsecurity.annotation.Secured


class ClientController extends AppController {

	ClientService clientService

	def index(ClientCommand command) {
		def clients = clientService.search(command, pagination())

		if (clients.size() == 1) {
			redirect action: "edit", id: clients[0].id
		} else {
			[command: command, clients: clients]
		}
	}


	def edit(Client client) {
		client = getRequestCommand(client ?: new Client())
		if (!client.code) {
			client.code = clientService.newCodeClient()
		}
		[client: client, modeEnvois: ModeEnvoi.list(), modeReglements: ModeReglement.list()]
	}

	@ExceptionHandler
	def save(Client client) {
		checkErrors(this, client)
		clientService.save(client)
		redirect(action: 'index')
	}

	@ExceptionHandler
	def delete(Client client) {
		checkErrors(this, client)
		clientService.delete(client)
		redirect(action: 'index')
	}
}
