<div class="form-group row required">
	<label class="col-3 col-form-label">Code</label>
	<div class="col-3">
		<g:textField name="code" value="${ article?.code }" class="form-control" placeholder="Saisir un code article" required="true"
			maxlength="32" autofocus="true"/>
	</div>
</div>

<div class="form-group row required">
	<label class="col-3 col-form-label">Libellé</label>
	<div class="col-9">
		<g:textField name="libelle" value="${ article?.libelle }" class="form-control" placeholder="Saisir un libellé"
			required="true" maxlength="255"/>
	</div>
</div>


<div class="form-group row">
	<label class="col-3 col-form-label">Famille</label>
	<div class="col-9">
		<g:select name="famille" value="${ article?.famille }" class="form-control app-combobox" from="${ familles }"
			data-tags="true" data-placeholder="Sélectionner une famille" noSelection="['': ' ']"/>
		<small class="text-muted">Sélectionnez une famille existante dans la liste ou saisissez une nouvelle valeur</small>
	</div>
</div>

<div class="form-group row">
	<label class="col-3 col-form-label">Commentaire</label>
	<div class="col-9">
		<g:textArea name="commentaire" value="${ article?.commentaire }" class="form-control" placeholder="Saisir un commentaire" rows="2"/>
	</div>
</div>

