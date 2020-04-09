function onLoadReglementIndex() {
	$(document).on('click', 'a.reglement-echeance-dialog-button', function() {
		var $this = $(this)
		ajaxPost($this, {}, '#ajax-dialog', function() {
			showDialog($this.attr('data-dialog'))
		})
	})
	$(document).on('click', '#dialog-reglement-echeance-save-button', function() {
		$('#dialog-reglement-echeance-submit-button').click()
	})
}

