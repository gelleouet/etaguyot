package facturation

class DataTableTagLib {
	static namespace = "app"


	/**
	 * Render une table avec le plugin JQuery DataTable http://datatables.net/
	 * Si une url est passée en paramètre, alors les données sont chargées depuis cette URL (au format JSON).
	 * Sinon l'élément DOM est directement transformé avec les données qu'il contient déjà
	 * Rajoute un élément de pagination
	 * 
	 * @attr elementId REQUIRED l'ID de l'élément table à transformer
	 * @attr value REQUIRED le nombre total d'items
	 * @attr cssClass
	 * @attr cssStyle
	 * @attr noPaginate
	 * @attr paginateForm
	 */
	def datatable = { attrs, body ->
		def paginateDebut = 0
		def paginateFin = 0
		def value = attrs.value
		int totalCount = value.hasProperty('totalCount') ? value.totalCount : 0

		if (totalCount > 0) {
			def offset =  params.int('offset')
			def max = params.int('max')

			if (offset != null && max != null) {
				paginateDebut = offset + 1
				paginateFin = Math.min(totalCount, offset + max)
			}
		}

		// le body contient déjà la structure de la table sauf la balise <table>
		out << """<table class="table table-hover table-striped ${attrs.cssClass ?: '' } app-datatable" id="$attrs.elementId" style="${attrs.cssStyle ?: ''}"
				paginateTotal="${ totalCount }" paginateDebut="${ paginateDebut }" paginateFin="${ paginateFin }" data-page-length="${ params.max }"
				data-ordering="${ params['data-ordering'] }"> """
		out << body()
		out << "</table>"

		// on insère la pagination après la table
		if (!attrs.noPaginate) {
			out << """<div>"""
			out << """<ul class="pagination justify-content-end" data-form-id="${ attrs.paginateForm }">"""
			out << paginate(total: totalCount, prev: "<<", next: ">>")
			out << """</ul>"""
			out << """</div>"""
		}
	}
}
