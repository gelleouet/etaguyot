<div class="form-group row">
	<label class="col-3 col-form-label">SIRET</label>
	<div class="col-9">
		<g:textField name="siret" value="${ client?.siret }" class="form-control" placeholder="SIRET" maxlength="32"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Numéro TVA</label>
	<div class="col-9">
		<g:textField name="numTVA" value="${ client?.numTVA }" class="form-control" placeholder="Numéro TVA" maxlength="32"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Echéance</label>
	<div class="col-3">
		<g:field type="number" name="echeance" value="${ client?.echeance }" class="form-control"/>
		<small class="form-text text-muted">En nombre de jours</small>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Mode règlement</label>
	<div class="col-9">
		<g:select name="modeReglement.id" value="${ client?.modeReglement?.id }" from="${ modeReglements }"class="form-control"
			optionKey="id" optionValue="libelle" noSelection="[null: ' ']"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Mode envoi</label>
	<div class="col-9">
		<g:select name="modeEnvoi.id" value="${ client?.modeEnvoi?.id }" from="${ modeEnvois }"class="form-control"
			optionKey="id" optionValue="libelle" noSelection="[null: ' ']"/>
	</div>
</div>

