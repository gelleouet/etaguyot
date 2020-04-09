var _daysOfWeek = [
    "Di",
    "Lu",
    "Ma",
    "Me",
    "Je",
    "Ve",
    "Sa"
]
var _monthNames = [
    "Janvier",
    "Février",
    "Mars",
    "Avril",
    "Mai",
    "Juin",
    "Juillet",
    "Août",
    "Septembre",
    "Octobre",
    "Novembre",
    "Décembre"
]

var _defaultRanges = {
    'Les 30 derniers jours': [moment().subtract(30, 'days'), moment()],
    'Les 60 derniers jours': [moment().subtract(60, 'days'), moment()],
    'Le mois dernier': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
    'Ce mois-ci': [moment().startOf('month'), moment().endOf('month')],
    'Les 6 derniers mois': [moment().subtract(6, 'month').startOf('month'), moment().endOf('month')],
    'Exercice N-1': [moment().subtract(1, 'year').startOf('year'), moment().subtract(1, 'year').endOf('year')],
    'Exercice': [moment().startOf('year'), moment().endOf('year')],
}



function initDataTable() {
	$('.app-datatable').each(function(index) {
		var $element = $(this)
		var isPaginateClient = $element.attr('data-client-pagination') == 'true' 
		var paginateInfo = ""
			
		if ($element.attr('paginatetotal') > 0 && $element.attr('paginatedebut') > 0) {
			paginateInfo = $element.attr('paginatedebut') + ' à ' + $element.attr('paginatefin') + ' sur ' + $element.attr('paginatetotal');
		} else {
			paginateInfo = "_START_ à _END_ sur _TOTAL_"
		}
		
		// rajoute quelques styles auto
		//$element.addClass("table table-hover table-striped")
		$element.find("th[data-role='action']").css('width', '68.5px')
		
		$element.DataTable({
			'destroy': true,
			'lengthMenu': 50,
			'paging': isPaginateClient,
			'lengthChange': false,
			'searching': false,
			'order': [],
			'language': {
			    emptyTable: 'Aucune donnée trouvée',
			    info : paginateInfo,
			    infoEmpty: "",
			    paginate: {
			    	first: 'Premier',
			    	last: 'Dernier',
			    	previous: 'Précédent',
			    	next: 'Suivant'
			    }
			  }
		});
	}) 
	
	// englobage dans un un li
	$('ul.pagination a:not([aria-controls])').addClass('page-link').wrap('<li class="page-item"></li>')
	
	// remplace le bouton en cours
	$('ul.pagination span.currentStep').wrap('<li class="page-item active"></li>')
	$('ul.pagination span.currentStep').contents().unwrap().wrap('<a class="page-link"></a>');
}


function initConfirmButton() {
	$(document).on('click', '.confirm-button', function(event) {
		var $element = $(this)
		var message = $element.attr('data-confirm')
		
		if (!message) {
			message = 'continuer'
		}
		
		if (! confirm('Voulez-vous ' + message + " ?")) {
			event.preventDefault();
			return false
		}
		
		return true
	});
}


function formatOption(data) {
	var code
	
	// si option html
	if (data.element && data.element.dataset && data.element.dataset.code) {
		code = data.element.dataset.code
	} 
	// si option javascript ou ajax
	else if (data.code) {
		code = data.code
	}
	
	if (code) {
		return $('<div class="row mr-1"><div class="col-9 font-weight-bold kt-font-small">' 
				+ data.text 
				+ '</div><div class="col text-right font-italic kt-font-small">'
				+ code
				+ '</div></div>')
	} else {
		return data.text
	}
}


function initComboBox() {
	$("select.app-combobox").each(function() {
		var $this = $(this)
		var onChange
		var formatOptionCallback
		var formatSelectionCallback
		var ajaxOptions = {}
		
		if ($this.attr("data-onchange") && typeof window[$this.attr("data-onchange")]) {
			onChange = window[$this.attr("data-onchange")]
		}
		
		if ($this.attr("data-format-selection") && typeof window[$this.attr("data-format-selection")]) {
			formatSelectionCallback = window[$this.attr("data-format-selection")]
		} else {
			formatSelectionCallback = formatOption
		}
		
		if ($this.attr("data-format-option") && typeof window[$this.attr("data-format-option")]) {
			formatOptionCallback = window[$this.attr("data-format-option")]
		} else {
			formatOptionCallback = formatOption
		}
		
		if ($this.attr("data-processResults") && typeof window[$this.attr("data-processResults")]) {
			ajaxOptions.processResults = window[$this.attr("data-processResults")]
		} 
		
		var options = {
			dropdownAutoWidth: true,
			openOnEnter: false,
			allowClear: $this.attr('data-tags') == 'true' || $this.attr('data-clear') == 'true',
			templateResult: formatOptionCallback,
			templateSelection: formatSelectionCallback,
			matcher: function(params, data) {
				// If there are no search terms, return all of the data
			    if ($.trim(params.term) === '') {
			      return data;
			    }
			    
			    // Do not display the item if there is no 'text' property
			    if (typeof data.text === 'undefined') {
			      return null;
			    }
			    
			    var match = false
				
				// un nombre est saisi, on tente un match avec le value ou data-code
				if (!isNaN(params.term)) {
					var intValue = parseInt(params.term)
					
					if (data.element.dataset.code && !isNaN(data.element.dataset.code)) {
						match = (intValue == parseInt(data.element.dataset.code))
					} else {
						match = (params.term == data.id)
					}
					
					// seulement si y'a une correspondance, on retourne déjà
					// sinon il faut laisser le test par défaut
					if (match) {
						return data;
					}
				}
				
			    // recherche texte sur le code
			    if (data.element.dataset.code) {
			    	if (data.element.dataset.code.toLowerCase().indexOf(params.term.toLowerCase()) != -1) {
				    	return data
				    }
			    }
			    
				// si rien trouvé plus haut : recherche normale
			    if (data.text.toLowerCase().indexOf(params.term.toLowerCase()) != -1) {
			    	return data
			    }
			    
			    // Return `null` if the term should not be displayed
			    return null;
			}
		}
		
		if (Object.keys(ajaxOptions).length > 0) {
			options.ajax = ajaxOptions
		}
		
		$this.select2(options)
		
		if (onChange) {
			$this.on('select2:select', function(event) {
				var data = event.params.data
				onChange($this, data)
			})
		}
	})
}


function initDateRangePicker() {
	$("input.app-daterangepicker").each(function() {
		var $this = $(this)
		
		$this.daterangepicker({
			locale: {
				format: "DD/MM/YYYY",
				applyLabel: "Appliquer",
				cancelLabel: "Annuler",
				weekLabel: "S",
				daysOfWeek: _daysOfWeek,
		        monthNames: _monthNames,
			},
			ranges: _defaultRanges,
			showDropdowns: true,
			autoUpdateInput: true,
			showWeekNumbers: true,
			linkedCalendars: false,
		    showCustomRangeLabel: false,
		    alwaysShowCalendars: true,
			buttonClasses: "btn btn-sm",
			applyClass: "btn-primary",
			cancelClass: "btn-secondary",
			startDate: $this.attr('data-startDate'),
		    endDate: $this.attr('data-endDate')
		})
		
		$this.on('apply.daterangepicker', function(ev, picker) {
			if ($this.attr('data-startDateId')) {
				$('#' + $this.attr('data-startDateId')).val(picker.startDate.format('YYYY-MM-DD'))
			}
			if ($this.attr('data-endDateId')) {
				$('#' + $this.attr('data-endDateId')).val(picker.endDate.format('YYYY-MM-DD'))
			}
		})
	})
}


function initLocaleTypeNumber() {
	$('input.number').on("blur", function() {
		formatLocaleNumber($(this))
	})
}


function formatLocaleNumber(element) {
	element.val(element.val().replace(/\./g, ','))
}


function onAjaxError(jqXHR, textStatus, errorThrown, updateId) {
	var $div = $('#' + updateId)
	if (jqXHR.responseText) {
		$div.html(jqXHR.responseText);
	} else {
		$div.html(errorThrown);
	}
	$div.show();
	$div.fadeOut(10000);
}


function ajaxPost(eltSrcId, datas, divDstId, onSuccess) {
	var urlAction = $(eltSrcId).attr('data-url');
	var global = !($(eltSrcId).attr('data-immediate') == 'true');
	var ajaxDialog = ($(eltSrcId).attr('data-error') == 'dialog')
	var ajaxErrorUpdate = ajaxDialog ? 'ajax-dialog-error' : 'ajax-error' 
	
	jQuery.ajax({
		type: 'POST',
		data: datas,
		url: urlAction,
		global: global,
		success: function(data, textStatus) {
			if (divDstId) {
				$(divDstId).html(data);
			}
			if (onSuccess) {
				onSuccess(data, textStatus);
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
			onAjaxError(jqXHR, textStatus, errorThrown, ajaxErrorUpdate)
		}
	});
}

function ajaxSubmitForm(eltSrcId, formId, divDstId, onSuccess) {
	var urlAction = $(eltSrcId).attr('data-url');
	var datas = $(formId).serializeArray();
	var global = !($(eltSrcId).attr('data-immediate') == 'true')
	var ajaxDialog = ($(eltSrcId).attr('data-error') == 'dialog')
	var ajaxErrorUpdate = ajaxDialog ? 'ajax-dialog-error' : 'ajax-error' 
	
	jQuery.ajax({
		type: 'POST',
		data: datas,
		url: urlAction,
		global: global,
		success: function(data, textStatus) {
			if (divDstId) {
				$(divDstId).html(data);
			}
			if (onSuccess) {
				onSuccess();
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
			onAjaxError(jqXHR, textStatus, errorThrown, ajaxErrorUpdate)
		}
	});
}

function initFastFocusForm() {
	$(document).on('keydown', 'form.fast-focus input,form.fast-focus select', function(event) {
		if (event.which == 13) {
			focusNextElement($(this))
			return false
		}
		return true
	});
	
	$(document).on('focus', 'form.fast-focus input,form.fast-focus select', function(e) {
		$(this).select()
	});
}

function focusNextElement(element) {
	var form = element.parents('form:eq(0)'),
		focusable, next;

    focusable = form.find(':input').filter(':visible').filter(':enabled');
    var index = focusable.index(element)
    next = focusable.slice(index + 1).not('select.select2-offscreen').first();
    if (next.length) {
        next.focus();
    }
}

function escapeSelectorName(name) {
	return name.replace(/\./g, '\\.').replace(/\[/g, '\\[').replace(/\]/g, '\\]')
}

function showDialog(dialogId) {
	$('#' + dialogId).modal('show')
}

function hideDialog(dialogId) {
	var $dialog = $('#' + dialogId)
	
	$dialog.modal('hide')
	
	if ($dialog.attr('data-dispose') == 'true') {
		$('#' + dialogId).modal('dispose')
	}
}

function configDialogButton(buttonId) {
	$(document).on('click', '#' + buttonId, function() {
		var $this = $(this)
		
		ajaxSubmitForm($this, '#' + $this.attr('data-form'), '#ajax-dialog', function() {
			showDialog($this.attr('data-dialog'))
		})
	})
}

function configSaveDialogButton(buttonId) {
	$(document).on('click', '#' + buttonId, function() {
		var $this = $(this)
		
		ajaxSubmitForm($this, '#' + $this.attr('data-form'), '#' + $this.attr('data-update'), function() {
			hideDialog($this.attr('data-dialog'))
		})
	})
}

function configSubmitButton(buttonId) {
	$(document).on('click', '#' + buttonId, function() {
		var $this = $(this)
		var confirmMsg = $this.attr("data-confirm")
		var renderId = ""
		var continuer = true
			
		if ($this.attr('data-update')) {
			renderId = '#' + $this.attr('data-update')
		}
		
		if (confirmMsg) {
			continuer = confirm(confirmMsg)
		}
		
		if (continuer) {
			ajaxSubmitForm($this, '#' + $this.attr('data-form'), renderId)
		}
	})
}