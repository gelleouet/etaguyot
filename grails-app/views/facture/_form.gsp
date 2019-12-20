<g:hiddenField name="numeroBrouillon" value="${ facture?.numeroBrouillon }"/>


<div class="form-group row required ">
	<label class="col-2 col-form-label">Numéro</label>
	<div class="col-5">
		<g:textField name="numero" value="${ facture?.numero }" class="form-control medium" required="true" maxlength="16" readonly="readonly"/>
	</div>
	<div class="col-5">
		<span class="badge badge-secondary">BROUILLON</span>
	</div>
</div>

<div class="form-group row required">
	<label class="col-2 col-form-label">Client</label>
	<div class="col-5">
		<g:select name="client.id" value="${ facture?.client?.id }" from="${ clients }" class="form-control app-combobox"
			optionKey="id" optionValue="raisonSociale" dataAttrs="['code': { it.code }]"
			data-ajax--url="${ createLink(action: 'query', controller: 'client') }" data-placeholder="Sélectionner un client">
			<option></option>
		</g:select>
	</div>
	<div class="col-5">
		<div class="parent-flow">
			<div class="address-area">
				<div class="row">
					<div class="col-8">
						<label><i class="fa fa-location-arrow"></i> Adresse</label>
					</div>
					<div class="col text-right">
						<g:if test="${ facture?.client?.id }">
							<g:link controller="client" action="edit" id="${ facture.client.id }" target="client" title="Fiche client" class="btn btn-sm btn-secondary">
								<i class="fa fa-eye"></i>
							</g:link>
						</g:if>
					</div>
				</div>
				
				<div class="kt-separator kt-separator--space-sm kt-separator--border-dashed"></div>
				
				<g:if test="${ facture?.client }">
					<div class="pl-4">
						<p>${ facture.client.adresse }</p>
						<p>${ facture.client.codePostal } - ${ facture.client.ville }</p>
					</div>
				</g:if>
			</div>
		</div>
	</div>
</div>

<div class="form-group row required">
	<label class="col-2 col-form-label">Mode règlement</label>
	<div class="col-5">
		<g:select name="modeReglement.id" value="${ facture?.modeReglement?.id }" from="${ modeReglements }" class="form-control"
			optionKey="id" optionValue="libelle"/>
	</div>
</div>

<div class="form-group row required">
	<label class="col-2 col-form-label">Date</label>
	<div class="col-5">
		<g:field type="date" name="dateFacture" value="${ app.formatPicker(date: facture?.dateFacture) }" class="form-control medium" required="true"/>
	</div>
</div>

<div class="form-group row required">
	<label class="col-2 col-form-label">Date d'échéance</label>
	<div class="col-5">
		<g:field type="date" name="dateEcheance" value="${ app.formatPicker(date: facture?.dateEcheance) }" class="form-control medium" required="true"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-2 col-form-label">Référence</label>
	<div class="col-10">
		<g:textField name="reference" value="${ facture?.reference }" class="form-control" placeholder="Référence" maxlength="255"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-2 col-form-label">Commentaire</label>
	<div class="col-10">
		<g:textArea name="commentaire" value="${ facture?.commentaire }" class="form-control" placeholder="Commentaire" rows="2"/>
	</div>
</div>

<div class="row">
	<div class="col-2"></div>
	<div class="col-5"></div>
	<div class="col-5">
		<div class="form-group row">
			<label class="col-4 col-form-label kt-font-bold kt-font-brand">Total HT (€)</label>
			<div class="col-8">
				<g:field type="text" name="totalHT" value="${ app.format2Decimal(number: facture?.totalHT) }" class="form-control number kt-font-bold kt-font-brand"/>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-2"></div>
	<div class="col-5"></div>
	<div class="col-5">
		<div class="form-group row">
			<label class="col-4 col-form-label kt-font-bold kt-font-brand">Total TVA (€)</label>
			<div class="col-8">
				<g:field type="text" name="totalTVA" value="${ app.format2Decimal(number: facture?.totalTVA) }" class="form-control number kt-font-bold kt-font-brand"/>
			</div>
		</div>
	</div>
</div>

	
			
			
			
			
			
			

			










