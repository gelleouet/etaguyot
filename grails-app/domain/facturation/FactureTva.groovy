package facturation

import grails.validation.Validateable
import groovy.transform.AutoClone

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
@AutoClone
class FactureTva implements Validateable {
	Facture facture
	Double totalHT
	Double totalTVA
	Double tauxTVA


	static belongsTo = [facture: Facture]

	static mapping = {
		facture index: 'facture_tva_idx'
	}
}
