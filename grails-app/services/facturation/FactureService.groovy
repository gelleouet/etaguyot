package facturation

import grails.gorm.transactions.Transactional

class FactureService extends AppService<Article> {

	List<Facture> search(FactureCommand command, Map pagination) {
		log.info "Search facture from ${command.dateDebut} to ${command.dateFin}"

		return Facture.createCriteria().list(pagination) {
			join 'client'
			order 'numero', 'desc'
		}
	}


	Facture createNewFacture(TypeFactureEnum typeFacture) {
		Facture facture = new Facture(type: typeFacture)
		facture.dateFacture = new Date().clearTime()
		facture.dateEcheance = facture.dateFacture + 45
		facture.numeroBrouillon = newNumeroBrouillon()
		facture.numero = facture.numeroBrouillon
		facture.totalHT = 0d
		facture.totalTVA = 0d
		return facture
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
		def row = Facture.executeQuery("SELECT max(numeroBrouillon) from Facture")
		String newCode = "${Facture.PREFIX_BROUILLON}000001"

		if (row && row[0]) {
			def valCode = row[0].replace(Facture.PREFIX_BROUILLON, "").toLong()
			newCode = String.format("${Facture.PREFIX_BROUILLON}%06d", valCode + 1)
		}

		return newCode
	}
}
