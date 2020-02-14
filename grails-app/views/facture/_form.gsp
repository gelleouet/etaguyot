<g:hiddenField name="numeroBrouillon" value="${ facture?.numeroBrouillon }"/>
<g:hiddenField name="type" value="${ facture?.type }"/>


<div class="form-group row required ">
	<label class="col-2 col-form-label">Numéro</label>
	<div class="col-5">
		<g:textField name="numero" value="${ facture?.numero }" class="form-control medium" required="true"
			maxlength="16" readonly="readonly"/>
	</div>
	<div class="col-5">
		<g:render template="singleStatut" model="[facture: facture]"/>
	</div>
</div>

<div class="form-group row required">
	<label class="col-2 col-form-label">Client</label>
	<div class="col-5">
		<g:select name="client.id" value="${ facture?.client?.id }" from="${ clients }" class="form-control app-combobox"
			optionKey="id" optionValue="raisonSociale" dataAttrs="['code': { it.code }]" data-placeholder="Sélectionner un client"
			data-ajax--url="${ createLink(action: 'query', controller: 'client') }" data-ajax--global="false"
			data-url="${ createLink(action: 'changeClient') }" data-onchange="onChangeClientFacture" autofocus="true"
			disabled="${ facture.isValidee() }">
			<option></option>
		</g:select>
		<small class="text-muted">Recherche possible sur raison sociale ou code client</small>
	</div>
	<div class="col-5">
		<div class="parent-flow">
			<div class="facture-address-area">
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
			optionKey="id" optionValue="libelle" disabled="${ facture.isValidee() }"/>
	</div>
</div>

<div class="form-group row required">
	<label class="col-2 col-form-label">Date</label>
	<div class="col-5">
		<g:field type="date" name="dateFacture" value="${ app.formatPicker(date: facture?.dateFacture) }" 
			class="form-control medium" required="true" disabled="${ facture.isValidee() }"/>
	</div>
</div>

<div class="form-group row required">
	<label class="col-2 col-form-label">Date d'échéance</label>
	<div class="col-5">
		<g:field type="date" name="dateEcheance" value="${ app.formatPicker(date: facture?.dateEcheance) }" 
			class="form-control medium" required="true" disabled="${ facture.isValidee() }"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-2 col-form-label">Référence</label>
	<div class="col-10">
		<g:textField name="reference" value="${ facture?.reference }" class="form-control" maxlength="255"
			placeholder="Saisir une référence" disabled="${ facture.isValidee() }"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-2 col-form-label">Commentaire</label>
	<div class="col-10">
		<g:textArea name="commentaire" value="${ facture?.commentaire }" class="form-control" rows="2"
			placeholder="Saisir un commentaire" disabled="${ facture.isValidee() }"/>
	</div>
</div>


<g:if test="${ !facture.isValidee() }">
	<div>
		<a id="facture-add-article-button" class="btn btn-secondary btn" data-url="${ createLink(action: 'addArticle') }">
			<i class="fa fa-plus"></i>&nbsp;Article
		</a>
	</div>
</g:if>

<div id="facture-article-ajax-form">
	<g:render template="formArticles"/>
</div>

<div class="kt-separator kt-separator--space-md kt-separator--border-dashed"></div>

<div class="row">
	<div class="col-2"></div>
	<div class="col-5"></div>
	<div class="col-5">
		<div class="form-group row">
			<label class="col-4 col-form-label kt-font-bold kt-font-brand">Total HT (€)</label>
			<div class="col-8">
				<g:field type="text" name="totalHT" value="${ app.format2Decimal(number: facture?.totalHT) }"
					class="form-control number kt-font-bold kt-font-brand" readonly="true"/>
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
				<g:field type="text" name="totalTVA" value="${ app.format2Decimal(number: facture?.totalTVA) }"
					class="form-control number kt-font-bold kt-font-brand" readonly="true"/>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-2"></div>
	<div class="col-5"></div>
	<div class="col-5">
		<div class="form-group row">
			<label class="col-4 col-form-label kt-font-bold kt-font-brand">Total TTC (€)</label>
			<div class="col-8">
				<g:field type="text" name="totalTTC" value="${ app.format2Decimal(number: facture?.totalTTC()) }"
					class="form-control number kt-font-bold kt-font-brand" readonly="true"/>
			</div>
		</div>
	</div>
</div>

	
			
			
			
			
			
			

			










