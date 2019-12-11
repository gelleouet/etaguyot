<div class="form-group row required">
	<label class="col-3 col-form-label">Code</label>
	<div class="col-3">
		<g:textField name="code" value="${ client?.code }" class="form-control" placeholder="Code client" required="true" maxlength="16"/>
	</div>
</div>

<div class="form-group row required">
	<label class="col-3 col-form-label">Raison sociale</label>
	<div class="col-9">
		<g:textField name="raisonSociale" value="${ client?.raisonSociale }" class="form-control" placeholder="Raison sociale" required="true" maxlength="255"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Adresse</label>
	<div class="col-9">
		<g:textArea name="adresse" value="${ client?.adresse }" class="form-control" placeholder="Adresse" rows="2" maxlength="255"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Code postal</label>
	<div class="col-3">
		<g:textField name="codePostal" value="${ client?.codePostal }" class="form-control" placeholder="Code postal" maxlength="16"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Ville</label>
	<div class="col-6">
		<g:textField name="ville" value="${ client?.ville }" class="form-control" placeholder="Ville" maxlength="64"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Famille</label>
	<div class="col-9">
		<g:textField name="famille" value="${ client?.famille }" class="form-control" placeholder="Famille" maxlength="255"/>
	</div>
</div>