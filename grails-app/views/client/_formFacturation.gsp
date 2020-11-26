<div class="form-group row">
	<label class="col-3 col-form-label">SIRET</label>
	<div class="col-6">
		<g:textField name="siret" value="${ client?.siret }" class="form-control" placeholder="SIRET" maxlength="32"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Numéro TVA</label>
	<div class="col-6">
		<g:textField name="numTVA" value="${ client?.numTVA }" class="form-control" placeholder="Numéro TVA" maxlength="32"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Echéance</label>
	<div class="col-3">
		<g:select name="echeance.id" value="${ client?.echeance?.id }" from="${ echeances }" class="form-control"
			optionKey="id" optionValue="libelle" noSelection="[null: ' ']"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Mode règlement</label>
	<div class="col-6">
		<g:select name="modeReglement.id" value="${ client?.modeReglement?.id }" from="${ modeReglements }" class="form-control"
			optionKey="id" optionValue="libelle" noSelection="[null: ' ']"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Mode envoi</label>
	<div class="col-6">
		<g:select name="modeEnvoi.id" value="${ client?.modeEnvoi?.id }" from="${ modeEnvois }" class="form-control"
			optionKey="id" optionValue="libelle" noSelection="[null: ' ']"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Compte compta</label>
	<div class="col-6">
		<g:textField name="compteCompta" value="${ client?.compteCompta }" class="form-control" placeholder="Compte compta" maxlength="32"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Compte central</label>
	<div class="col-6">
		<g:textField name="compteCentral" value="${ client?.compteCentral }" class="form-control" placeholder="Compte central" maxlength="32"/>
	</div>
</div>

