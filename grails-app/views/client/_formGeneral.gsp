<div class="form-group row required">
	<label class="col-3 col-form-label">Code</label>
	<div class="col-3">
		<g:textField name="code" value="${ client?.code }" class="form-control" placeholder="Saisir un code client" required="true" maxlength="16"/>
	</div>
</div>

<div class="form-group row required">
	<label class="col-3 col-form-label">Raison sociale</label>
	<div class="col-9">
		<g:textField name="raisonSociale" value="${ client?.raisonSociale }" class="form-control" placeholder="Saisir une raison sociale"
			required="true" maxlength="255" autofocus="true"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Adresse</label>
	<div class="col-9">
		<g:textArea name="adresse" value="${ client?.adresse }" class="form-control" placeholder="Saisir une adresse" rows="2" maxlength="255"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Code postal</label>
	<div class="col-3">
		<g:textField name="codePostal" value="${ client?.codePostal }" class="form-control" placeholder="Saisir un code postal" maxlength="16"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Ville</label>
	<div class="col-6">
		<g:textField name="ville" value="${ client?.ville }" class="form-control" placeholder="Saisir une ville" maxlength="64"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Famille</label>
	<div class="col-9">
		<g:select name="famille" value="${ client?.famille }" class="form-control app-combobox" from="${ familles }"
			data-tags="true" data-placeholder="Sélectionner une famille" noSelection="['': ' ']"/>
		<small class="text-muted">Sélectionnez une famille existante dans la liste ou saisissez une nouvelle valeur</small>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Email</label>
	<div class="col-6">
		<g:field type="email" name="email" value="${ client?.email }" class="form-control" placeholder="Saisir un email" maxlength="64"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Téléphone</label>
	<div class="col-6">
		<g:field type="tel" name="telephone" value="${ client?.telephone }" class="form-control" placeholder="Saisir un téléphone" maxlength="16"/>
	</div>
</div>