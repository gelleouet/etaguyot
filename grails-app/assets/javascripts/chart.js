function initChartJS() {
	$("div[chartjs]").each(function(index, element) {
		var $element = $(element)
		var divData = $element.find('div[chartjs-data]')
		var $divData = $(divData)
		var canvas = $element.find('canvas')
		var context = $(canvas)[0].getContext('2d')
		
		if ($divData) {
			var chartData = $divData.html();
			
			if (chartData) {
				var chartOptions
				eval(chartData)
				
				if (chartOptions) {
					new Chart(context, chartOptions)
				}
				
		      	// nettoie les éléments de contruction du chart
		      	divData.remove()
				$element.removeAttr('chartjs')
			}
		}
	})
}