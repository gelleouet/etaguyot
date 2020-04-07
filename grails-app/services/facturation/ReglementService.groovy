package facturation

class ReglementService extends AppService<FactureReglement> {
	
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
			
			if (command.regle != null) {
				if (command.regle) {
					isNotNull 'dateReglement'
				} else {
					isNull 'dateReglement'
				}
			}
			
			join 'modeReglement'
		}
	}
}
