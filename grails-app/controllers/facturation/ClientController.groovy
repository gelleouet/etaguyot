package facturation

import grails.plugin.springsecurity.annotation.Secured


class ClientController extends AppController {

	ClientService clientService


	def query(ClientCommand command) {
		def clients = clientService.search(command, pagination())
		respond clients, model: [totalCount: clients.totalCount]
	}

	def index(ClientCommand command) {
		def clients = clientService.search(command, pagination())
		def familles = clientService.groupFamille()
		render view: 'index', model: [command: command, clients: clients,
			familles: familles]
	}

	def globalSearch(String value) {
		def command
		if (value.isInteger()) {
			command = new ClientCommand(code: value)
		} else {
			command = new ClientCommand(raisonSociale: value)
		}

		def clients = clientService.search(command, [max: 1])

		if (clients.totalCount == 1) {
			edit(clients[0])
		} else {
			index(command)
		}
	}

	def edit(Client client) {
		client = getRequestCommand(client ?: new Client())
		if (!client.code) {
			client.code = clientService.newCodeClient()
		}
		def familles = clientService.groupFamille()
		render view: 'edit', model: [client: client, modeEnvois: ModeEnvoi.list(),
			modeReglements: ModeReglement.list(), familles: familles]
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
