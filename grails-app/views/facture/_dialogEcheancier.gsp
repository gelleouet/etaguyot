<g:applyLayout name="dialog">

	<content tag="dialogId">facture-echeancier-dialog</content>
	<content tag="dialogTitle">Echéancier</content>
	<content tag="dialogSize">modal-lg</content>

	<content tag="dialogBody">
		<g:form name="facture-echeancier-form" class="kt-form fast-focus">
			
			<div class="btn-group">
				<a id="facture-add-echeancier-button" class="btn btn-secondary btn" title="Ajouter une échéance"
					data-url="${ createLink(action: 'addReglement') }" data-form="facture-echeancier-form" data-update="ajax-content-dialog-echeancier" data-error="dialog">
					<i class="fa fa-plus"></i>&nbsp;Echéance
				</a>
				<a id="facture-repartir-echeancier-button" class="btn btn-secondary btn ml-2" title="Répartir le reste à payer"
					data-url="${ createLink(action: 'repartirReglement') }" data-form="facture-echeancier-form" data-update="ajax-content-dialog-echeancier" data-error="dialog">
					<i class="flaticon-signs-1"></i>&nbsp;Répartir
				</a>
			</div>
			
			<div id="ajax-content-dialog-echeancier">
				<g:render template="contentDialogEcheancier"/>
			</div>
		</g:form>
	</content>
	
	
	<content tag="dialogFooter">
		<button type="button" class="btn btn-outline-brand" data-dismiss="modal">Annuler</button>
		<button id="dialog-echeancier-save-button" type="button" class="btn btn-brand" data-error="dialog"
			data-update="ajax-facture-form-echeancier" data-url="${ createLink(action: 'validerReglement') }"
			data-dialog="facture-echeancier-dialog" data-form="facture-echeancier-form">Valider</button>
	</content>

</g:applyLayout>
