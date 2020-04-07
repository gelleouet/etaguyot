<g:each var="reglement" in="${ facture.reglements.sort{ it.dateEcheance } }" status="status"> 
	<g:if test="${ reglement.id }">
		<g:hiddenField name="reglements[${ status }].id" value="${ reglement.id }"/>
	</g:if>
	<g:hiddenField name="reglements[${ status }].status" value="${ status }"/>
	<g:hiddenField name="reglements[${ status }].dateEcheance" value="${ app.formatPicker(date: reglement.dateEcheance) }"/>
	<g:hiddenField name="reglements[${ status }].montantTTC" value="${ app.format2Decimal(number: reglement.montantTTC) }"/>
	<g:hiddenField name="reglements[${ status }].montantRegle" value="${ app.format2Decimal(number: reglement.montantRegle) }"/>
</g:each>

<g:hiddenField name="totalRegle" value="${ app.format2Decimal(number: facture?.totalRegle) }"/>

<div class="form-group row required ">
	<label class="col-2 col-form-label">Date d'échéance</label>
	<div class="col-5">
		<g:field type="date" name="dateEcheance" value="${ app.formatPicker(date: facture?.dateEcheance) }" 
			class="form-control medium" required="true" disabled="${ facture.isValidee() }"/>
	</div>
	<div class="col-5">
		<a class="btn btn-secondary" id="facture-echeancier-button" title="Modifier l'échéancier"
			data-dialog="facture-echeancier-dialog" data-form="facture-edit-form" data-url="${ g.createLink(action: 'dialogEcheancier') }">
			<i class="flaticon-calendar-with-a-clock-time-tools"></i> Echéancier (${ facture.reglements.size() })
		</a>
	</div>
</div>