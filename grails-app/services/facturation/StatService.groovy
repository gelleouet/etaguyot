package facturation

import grails.gorm.transactions.Transactional

@Transactional(readOnly = true)
class StatService {
	
	/**
	 * Stat annuelle facture sur année en cours et année passée
	 * 
	 * @param date
	 * @return Map
	 */
	Map statFactureAnnuel(Date date) {
		Map stat = [:]
		Date lastYear = DateUtils.incYear(date, -1)
		
		stat.anneeN = statFacture(DateUtils.firstDayInYear(date), DateUtils.lastDayInYear(date))
		stat.anneeN.year = date[Calendar.YEAR]
		stat.anneeN_1 = statFacture(DateUtils.firstDayInYear(lastYear), DateUtils.lastDayInYear(lastYear))
		stat.anneeN_1.year = lastYear[Calendar.YEAR]
		
		return stat
	}
	
	
	/**
	 * Stat annuelle facture sur mois en cours et mois année N-1
	 *
	 * @param date
	 * @return Map
	 */
	Map statFactureMensuel(Date date) {
		Map stat = [:]
		Date lastYear = DateUtils.incYear(date, -1)
		
		stat.anneeN = statFacture(DateUtils.firstDayInMonth(date), DateUtils.lastDayInMonth(date))
		stat.anneeN.year = date[Calendar.YEAR]
		stat.anneeN_1 = statFacture(DateUtils.firstDayInMonth(lastYear), DateUtils.lastDayInMonth(lastYear))
		stat.anneeN_1.year = lastYear[Calendar.YEAR]
		
		return stat
	}
	
	
	Map statFacture(Date dateDebut, Date dateFin) {
		Map stat = [:]
		
		def result = Facture.createCriteria().get() {
			between 'dateFacture', dateDebut, dateFin

			// ne prendre que les factures validées
			ge 'statut', StatutFactureEnum.validee.id

			projections {
				count "id", "count"
				sum "totalHT", "totalHT"
			}
		}
		
		if (result) {
			stat.count = result[0] ?: 0
			stat.totalHT = result[1] ? result[1] / 1000 : 0
		}
		
		return stat
	}
	
}
