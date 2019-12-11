function initDataTable() {
	$('.app-datatable').each(function(index) {
		var $element = $(this)
		var isPaginateClient = $element.attr('data-client-pagination') == 'true' 
		var paginateInfo = ""
			
		if (isPaginateClient) {
			paginateInfo = "_START_ à _END_ sur _TOTAL_"
		} else if ($element.attr('paginatetotal') > 0 && $element.attr('paginatedebut') > 0) {
			paginateInfo = $element.attr('paginatedebut') + ' à ' + $element.attr('paginatefin') + ' sur ' + $element.attr('paginatetotal');
		}
			
		// rajoute quelques styles auto
		$element.addClass("table table-hover table-striped")
		$element.find("th[data-role='action']").css('width', '68.5px')
		
		$element.DataTable({
			'destroy': true,
			'lengthMenu': 50,
			'paging': isPaginateClient,
			'lengthChange': false,
			'searching': false,
			'pageLength': 25,
			'order': [],
			'language': {
			    emptyTable: 'Aucune donnée trouvée',
			    info : paginateInfo,
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
