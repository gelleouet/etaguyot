function onChangeClientFacture(select, data) {
	ajaxSubmitForm(select, '#facture-edit-form', '#facture-ajax-form')
}

function onChangeArticleFacture(select, data) {
	ajaxSubmitForm(select, '#facture-edit-form', '#facture-ajax-form')
}

function onLoadFactureEdit() {
	$(document).on('click', '#facture-add-article-button', function() {
		ajaxSubmitForm($(this), '#facture-edit-form', '#facture-ajax-form')
	})
	$(document).on('click', 'a.facture-remove-article-button', function() {
		if (confirm('Voulez-vous supprimer cet article ?')) {
			ajaxSubmitForm($(this), '#facture-edit-form', '#facture-ajax-form')
		}
	})
	$(document).on('change', '.facture-update-tarification', function() {
		var $this = $(this)
		var thisId = $this.attr('id')
		formatLocaleNumber($this)
		ajaxSubmitForm($this, '#facture-edit-form', '#facture-ajax-form', function() {
			// apres la reconstruction de la page, le $this ne pointe plus sur rien
			focusNextElement($('#' + escapeSelectorName(thisId)))
		})
	})
}

function formatFactureCodeProduitOption(data) {
	if (data.code) {
		return $('<div class="row"><div class="col-9 font-italic" style="font-size:8pt">' 
				+ data.text 
				+ '</div><div class="col text-right font-weight-bold" style="font-size:8pt">'
				+ data.code
				+ '</div></div>')
	} else {
		return data.text
	}
}

function formatFactureCodeProduitSelection(data) {
	if (data.id) {
		return $('<span class="font-weight-bold" style="font-size:8pt">' 
				+ data.id
				+ '</span>')
	} else {
		return data.text
	}
}

function processFactureCodeProduitResults(data) {
	for (var idx=0; idx<data.results.length; idx++) {
		data.results[idx].id = data.results[idx].code
	}
	
	return data
}