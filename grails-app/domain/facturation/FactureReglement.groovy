package facturation

import grails.validation.Validateable
import groovy.transform.AutoClone

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
@AutoClone
class FactureReglement implements Validateable {
	Facture facture
	Date dateEcheance
	Date dateReglement
	Double montantTTC
	Double montantRegle
	ModeReglement modeReglement

	// user properties
	Integer status


	static transients = ['status']

	static belongsTo = [facture: Facture]

	static constraints = {
		dateReglement nullable: true
		status bindable: true
	}
	
	static mapping = {
		facture index: 'facture_reglement_idx'
		dateEcheance index: 'facture_reglement_echeance_idx'
	}
}
