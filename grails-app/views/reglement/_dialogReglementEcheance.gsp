<g:applyLayout name="dialog">

	<content tag="dialogId">reglement-echeance-dialog</content>
	<content tag="dialogTitle">Règlement échéance</content>

	<content tag="dialogBody">
		<g:form name="reglement-echeance-form" action="regler" class="kt-form fast-focus">
			
			<g:hiddenField name="id" value="${ reglement.id }"/>
			
			<div class="row">
				<label class="col col-form-label">Client</label>
				<div class="col">
					<label>${ reglement.facture.client.raisonSociale }</label>
				</div>
			</div>
			<div class="row">
				<label class="col col-form-label">N°</label>
				<div class="col">
					<label>${ reglement.facture.numero }</label>
				</div>
			</div>
			<div class="row">
				<label class="col col-form-label">Montant échéance</label>
				<div class="col">
					<label>${ app.format2Decimal(number: reglement.montantTTC) }€</label>
				</div>
			</div>
			<div class="row">
				<label class="col col-form-label">Date échéance</label>
				<div class="col">
					<label>${ app.formatUser(date: reglement.dateEcheance) }</label>
				</div>
			</div>
			
			<div class="kt-separator kt-separator--space-md kt-separator--border-dashed"></div>
			
			<div class="form-group row required">
				<label class="col col-form-label">Mode règlement</label>
				<div class="col">
					<g:select name="modeReglement.id" value="${ reglement.modeReglement?.id }" from="${ modeReglements }" class="form-control"
						optionKey="id" optionValue="libelle" required="true"/>
				</div>
			</div>
			
			<div class="form-group row required">
				<label class="col col-form-label">Date règlement</label>
				<div class="col">
					<g:field type="date" name="dateReglement" value="${ app.formatPicker(date: reglement.dateReglement) }" 
						class="form-control" required="true"/>
				</div>
			</div>
			
			<button id="dialog-reglement-echeance-submit-button" class="d-none"></button>
		</g:form>
	</content>
	
	
	<content tag="dialogFooter">
		<button type="button" class="btn btn-outline-brand" data-dismiss="modal">Annuler</button>
		<button id="dialog-reglement-echeance-save-button" type="button" class="btn btn-brand" >Valider</button>
	</content>

</g:applyLayout>
