package facturation

import grails.gorm.transactions.Transactional

class FactureService extends AppService<Article> {

	List<Facture> search(FactureCommand command, Map pagination) {
		return Facture.createCriteria().list(pagination) {
			join 'client'
			order 'numero', 'desc'
		}
	}


	String newNumeroFacture(Date date) {
		def row = Article.executeQuery("SELECT max(code) from Article")
		String newCode = "0001"

		if (row && row[0]) {
			def valCode = row[0].toInteger()
			newCode = String.format("%04d", valCode + 1)
		}

		return newCode
	}


	String newNumeroBrouillon() {
	}
}
