<div class="form-group row">
	<label class="col-3 col-form-label">Unité</label>
	<div class="col-3">
		<g:select name="unite" value="${ article?.unite }" class="form-control app-combobox" from="${ unites }"
			data-tags="true" data-placeholder="Sélectionner une unité" noSelection="['': ' ']"/>
		<small class="text-muted">Sélectionnez une unité existante dans la liste ou saisissez une nouvelle valeur</small>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Prix unitaire HT (€)</label>
	<div class="col-3">
		<g:field type="text" name="prixHT" value="${ app.format2Decimal(number: article?.prixHT) }" class="form-control number"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Taux TVA (%)</label>
	<div class="col-3">
		<g:field type="text" name="tauxTVA" value="${ app.format2Decimal(number: article?.tauxTVA) }" class="form-control number"/>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Compte compta</label>
	<div class="col-9">
		<g:select name="compteCompta" value="${ article?.compteCompta }" class="form-control app-combobox" 
			data-placeholder="Sélectionner un compte" noSelection="['': ' ']"
			from="${ comptes }" optionKey="code" optionValue="libelle"/>
	</div>
</div>