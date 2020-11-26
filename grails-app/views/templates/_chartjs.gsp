<div style="position: relative; width:${width}; height:${height};" chartjs>
	<div class="d-none" chartjs-data>
	
		var brandColor = KTApp.getStateColor('brand')
		var gradient = context.createLinearGradient(0, 0, 0, 120);
        gradient.addColorStop(0, Chart.helpers.color(brandColor).alpha(0.1).rgbString());
        //gradient.addColorStop(1, Chart.helpers.color(brandColor).alpha(0).rgbString());
	
		chartOptions = {
			type: 'bar',
			data: {
				labels: ['Novembre'],
	            datasets: [
	            	{ label: 'N-1', data: [45.5], backgroundColor: gradient, barPercentage: 0.5,},
	            	{ label: 'N', data: [32.6], backgroundColor: brandColor, barPercentage: 0.5,}
	            ]
			},
			options: {
                responsive: true,
                maintainAspectRatio: true,
                legend: {
                	display: true
                },
                scales: {
                    xAxes: [{
                        display: false,
                        scaleLabel: {
                            display: false,
                            labelString: 'Année'
                        },
                        gridLines: true
                    }],
                    yAxes: [{
                        display: true,
                        scaleLabel: {
                            display: false,
                            labelString: 'CA'
                        },
                        gridLines: {
                        	drawTicks: true
                        },
                        ticks: {
                        	min: 0,
                        	display: true
                        }
                    }]
                },
                hover: {
                    mode: 'index'
                },
            }
		}
	</div>
	<canvas></canvas>
</div>
