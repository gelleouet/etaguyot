// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better
// to create separate JavaScript files as needed.
//
//= require plugins.bundle
//= require scripts.bundle
//= require datatables.bundle
//= require chart
//= require app
//= require_tree view
//= require_self


var KTAppOptions = {
	"colors": {
		"state": {
			//"brand": "#1cac81",
			"brand": "#008a2e",
			"metal": "#c4c5d6",
			"light": "#ffffff",
			"accent": "#00c5dc",
			"primary": "#5867dd",
			"success": "#34bfa3",
			"info": "#36a3f7",
			"warning": "#ffb822",
			"danger": "#fd3995",
			"focus": "#9816f4"
		},
		"base": {
			"label": [
				"#b9bdc1",
				"#aeb2b7",
				"#414b4c",
				"#343d3e"
			],
			"shape": [
				"#eef4f3",
				"#e0e9e6",
				"#80c3af",
				"#41675c"
			]
		}
	}
};


(function($) {
	// Gestion d'un spinner à chaque appel Ajax
	// Affiche / Masque un élément d'id = ajaxSpinner
	$(document).ajaxStart(function() {
		//$('#ajaxSpinner').show()
	}).ajaxStop(function() {
		//$('#ajaxSpinner').fadeOut(200);
		initGlobal()
	});
})(jQuery);


/**
 * Code à exécuter dès qu"une page est chargée
 */
jQuery(document).ready(function() {
	// ne pas afficher de popup en cas d'erreurs mais log error
	$.fn.dataTable.ext.errMode = 'throw';
	initGlobal()
	initFastFocusForm()
	
	var $body = $('body')
	
	if ($body.attr('data-onload') && typeof window[$body.attr('data-onload')]) {
		window[$body.attr('data-onload')]()
	}
})


function initGlobal() {
	initDataTable()
	initConfirmButton()
	initComboBox()
	initDateRangePicker()
	initLocaleTypeNumber()
	initChartJS()
}


