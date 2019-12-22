package facturation

import grails.validation.Validateable
import groovy.transform.AutoClone

@AutoClone
class Client implements Validateable {

	String code
	String raisonSociale
	String email
	String adresse
	String codePostal
	String ville
	String siret
	String numTVA
	String famille
	String telephone
	ModeReglement modeReglement
	ModeEnvoi modeEnvoi
	Integer echeance


	static constraints = {
		code unique: true
		email nullable: true
		telephone nullable: true
		adresse nullable: true
		codePostal nullable: true
		ville nullable: true
		siret nullable: true
		numTVA nullable: true
		modeReglement nullable: true
		modeEnvoi nullable: true
		echeance nullable: true
		famille nullable: true
	}


	static mapping = {
		code length:16
		codePostal length:16
		ville length:64
		siret length:32
		numTVA length:32
		telephone length:16
		email length:64
		sort 'raisonSociale'
	}
}
