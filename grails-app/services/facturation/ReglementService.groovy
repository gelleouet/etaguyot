package facturation

import grails.gorm.transactions.Transactional

class ReglementService extends AppService<FactureReglement> {
	
	@Transactional(readOnly = false, rollbackFor = AppException)
	void regler(FactureReglement reglement) throws AppException {
		Facture facture = reglement.facture
		
		reglement.montantRegle = reglement.montantTTC
		this.save(reglement)
		
		facture.updateTotalRegle()
		this.save(facture)
	}
	
	
	List<FactureReglement> search(ReglementCommand command, Map pagination) {
		log.info "Recherche entre ${command.dateDebut.format('dd/MM/yyyy')} et ${command.dateFin.format('dd/MM/yyyy')}"

		boolean searchByDate = true
		
		return FactureReglement.createCriteria().list(pagination) {
			order 'dateEcheance'
			
			facture {
				order 'numero'
				
				if (command.numero) {
					ilike 'numero', QueryUtils.decorateMatchAll(command.numero)
					searchByDate = false
				}
				
				client {
					if (command.clientId) {
						idEq command.clientId
					}
				}
				
				ge 'statut', StatutFactureEnum.validee.id
			}
			
			if (searchByDate) {
				between 'dateEcheance', command.dateDebut, command.dateFin
			}
			
			if (command.regle ^ command.enAttente) {
				if (command.regle) {
					isNotNull 'dateReglement'
				} else {
					isNull 'dateReglement'
				}
			}
			
			join 'modeReglement'
		}
	}
	
	
	Map synthese(ReglementCommand command) {
		log.info "Synthese entre ${command.dateDebut.format('dd/MM/yyyy')} et ${command.dateFin.format('dd/MM/yyyy')}"
		Map synthese = [:]
		
		boolean searchByDate = true
		
		def result = FactureReglement.createCriteria().get() {
			facture {
				if (command.numero) {
					ilike 'numero', QueryUtils.decorateMatchAll(command.numero)
					searchByDate = false
				}
				
				client {
					if (command.clientId) {
						idEq command.clientId
					}
				}
				
				ge 'statut', StatutFactureEnum.validee.id
			}
			
			if (searchByDate) {
				between 'dateEcheance', command.dateDebut, command.dateFin
			}
			
			if (command.regle ^ command.enAttente) {
				if (command.regle) {
					isNotNull 'dateReglement'
				} else {
					isNull 'dateReglement'
				}
			}
			
			projections {
				count "id", "count"
				sum "montantTTC", "montantTTC"
				sum "montantRegle", "montantRegle"
			}
		}
		
		if (result) {
			synthese.count = result[0] ?: 0
			synthese.montantTTC = result[1] ?: 0
			synthese.montantRegle = result[2] ?: 0
			synthese.montantResteDu = synthese.montantTTC - synthese.montantRegle
		}
		
		return synthese
	}
}
