package facturation

import grails.gorm.transactions.Transactional

@Transactional
class ClientService {

	List<Client> search(ClientCommand command, Map pagination) {
		return Client.createCriteria().list(pagination) {
			if (command.code) {
				ilike 'code', QueryUtils.decorateMatchAll(command.code)
			}
			if (command.raisonSociale) {
				ilike 'raisonSociale', QueryUtils.decorateMatchAll(command.raisonSociale)
			}

			order 'raisonSociale'
		}
	}
}
