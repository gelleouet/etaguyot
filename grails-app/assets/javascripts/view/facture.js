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
}

function formatFactureCodeProduitOption(data) {
	if (data.code) {
		return $('<div class="row"><div class="col-10 font-italic" style="font-size:8pt">' 
				+ data.text 
				+ '</div><div class="col text-right font-weight-bold" style="font-size:8pt">'
				+ data.code
				+ '</div></div>')
	} else {
		return data.text
	}
}

function formatFactureCodeProduitSelection(data) {
	if (data.code) {
		return $('<span class="font-weight-bold" style="font-size:8pt">' 
				+ data.code
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