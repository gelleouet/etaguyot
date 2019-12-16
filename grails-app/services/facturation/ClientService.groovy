package facturation

import grails.gorm.transactions.Transactional

class ClientService extends AppService<Client> {

	List<Client> search(ClientCommand command, Map pagination) {
		return Client.createCriteria().list(pagination) {
			if (command.code) {
				ilike 'code', QueryUtils.decorateMatchAll(command.code)
			}
			if (command.raisonSociale) {
				ilike 'raisonSociale', QueryUtils.decorateMatchAll(command.raisonSociale)
			}
			if (command.email) {
				ilike 'email', QueryUtils.decorateMatchAll(command.email)
			}

			order 'raisonSociale'
		}
	}


	/**
	 * Calcul un nouveau code client
	 * 
	 * @return
	 */
	String newCodeClient() {
		def row = Client.executeQuery("SELECT max(code) from Client")
		String newCode = "0001"

		if (row && row[0]) {
			def valCode = row[0].toInteger()
			newCode = String.format("%04d", valCode + 1)
		}

		return newCode
	}
}
