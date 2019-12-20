<div class="form-group row required">
	<label class="col-3 col-form-label">Code</label>
	<div class="col-3">
		<g:textField name="code" value="${ article?.code }" class="form-control" placeholder="Code article" required="true" maxlength="32"/>
	</div>
</div>

<div class="form-group row required">
	<label class="col-3 col-form-label">Libellé</label>
	<div class="col-9">
		<g:textField name="libelle" value="${ article?.libelle }" class="form-control" placeholder="Libellé" required="true" maxlength="255"/>
	</div>
</div>


<div class="form-group row">
	<label class="col-3 col-form-label">Famille</label>
	<div class="col-9">
		<g:select name="famille" value="${ article?.famille }" class="form-control app-combobox" placeholder="Famille" from="${ familles }"
			data-tags="true" data-placeholder="Famille" noSelection="['': ' ']"/>
		<small class="text-muted">Sélectionnez une famille existante dans la liste ou saisissez une nouvelle valeur</small>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Unité</label>
	<div class="col-3">
		<g:select name="unite" value="${ article?.unite }" class="form-control app-combobox" placeholder="Unité" from="${ unites }"
			data-tags="true" data-placeholder="Unité" noSelection="['': ' ']"/>
		<small class="text-muted">Sélectionnez une unité existante dans la liste ou saisissez une nouvelle valeur</small>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Commentaire</label>
	<div class="col-9">
		<g:textArea name="commentaire" value="${ article?.commentaire }" class="form-control" placeholder="Commentaire" rows="2"/>
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