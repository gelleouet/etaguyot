package facturation

import grails.validation.Validateable

class EcheancierCommand implements Validateable {
	List<FactureReglement> reglements = []
	Date dateEcheance
	Double totalHT
	Double totalTVA
	Integer status

		
	static constraints = {
		status nullable: true
	}
	
	Facture buildFacture() {
		Facture facture = new Facture()
		facture.dateEcheance = dateEcheance
		facture.totalHT = totalHT
		facture.totalTVA = totalTVA
		facture.reglements = reglements
		return facture
	}
	
	
	Facture updateDateEcheance(Facture facture) {
		facture.dateEcheance = dateEcheance
		if (facture.reglements) {
			facture.reglements[0].dateEcheance = dateEcheance
		}
		return facture
	}
}
