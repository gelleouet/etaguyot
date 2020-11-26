package facturation

import grails.gorm.transactions.Transactional

class ClientService extends AppService<Client> {

	List<Client> search(ClientCommand command, Map pagination) {
		return Client.createCriteria().list(pagination) {
			if (command.term) {
				or {
					ilike 'code', QueryUtils.decorateMatchAll(command.term)
					ilike 'raisonSociale', QueryUtils.decorateMatchAll(command.term)
				}
			}

			if (command.code) {
				ilike 'code', QueryUtils.decorateMatchAll(command.code)
			}
			if (command.raisonSociale) {
				ilike 'raisonSociale', QueryUtils.decorateMatchAll(command.raisonSociale)
			}
			if (command.email) {
				ilike 'email', QueryUtils.decorateMatchAll(command.email)
			}
			if (command.famille) {
				ilike 'famille', QueryUtils.decorateMatchAll(command.famille)
			}

			order pagination.sort ?: 'raisonSociale'
		}
	}


	Client newClient(Client client) {
		if (!client) {
			client = new Client()
		}
		
		def row = Client.executeQuery("SELECT max(code) from Client")
		client.code = "0001"

		if (row && row[0] && row[0].isInteger()) {
			def valCode = row[0].toInteger()
			client.code = String.format("%04d", valCode + 1)
		}

		client.compteCentral = Client.COMPTE_CENTRAL
		client.compteCompta = Client.PREFIX_COMPTE_COMPTA + client.code
		
		return client
	}


	List<String> groupFamille() {
		Client.createCriteria().list {
			isNotNull "famille"
			projections {
				groupProperty "famille"
			}
			order "famille"
		}
	}


	@Override
	Client save(Client client) throws AppException {
		client.compteCompta = Client.PREFIX_COMPTE_COMPTA + client.code
		return super.save(client)
	}
}
