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
		return $('<div class="row"><div class="col-10 font-weight-bold">' 
				+ data.text 
				+ '</div><div class="col text-right font-italic">'
				+ code
				+ '</div></div>')
	} else {
		return data.text
	}
}


function initComboBox() {
	$("select.app-combobox").each(function() {
		var $this = $(this)
		
		$this.select2({
			openOnEnter: false,
			allowClear: $this.attr('data-tags') == 'true',
			templateResult: formatOption,
			templateSelection: formatOption,
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
					
					if (data.element.dataset.code) {
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
				
				// si rien trouvé plus haut : recherche normale
			    if (data.text.toLowerCase().indexOf(params.term.toLowerCase()) != -1) {
			    	return data
			    }
			    
			    // Return `null` if the term should not be displayed
			    return null;
			}
		})
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
			console.log('picker change')
			if ($this.attr('data-startDateId')) {
				console.log('picker change debut')
				$('#' + $this.attr('data-startDateId')).val(picker.startDate.format('YYYY-MM-DD'))
			}
			if ($this.attr('data-endDateId')) {
				console.log('picker change fin')
				$('#' + $this.attr('data-endDateId')).val(picker.endDate.format('YYYY-MM-DD'))
			}
		})
	})
}


function initLocaleTypeNumber() {
	$('input.number').on("blur", function() {
		var $this = $(this)
		$this.val($this.val().replace(/\./g, ','))
	})
}