<!doctype html>
<html>
	<head>
	    <meta name="layout" content="page-default"/>
	</head>

	<content tag="subheaderTitle">
    	<div class="kt-subheader__breadcrumbs">
    		<g:link action="index" class="kt-subheader__breadcrumbs-link kt-subheader__breadcrumbs-link--home">
	   			Tableau de bord
	   		</g:link>
	   		<span class="kt-subheader__breadcrumbs-separator"></span>
    	</div>
   	</content>


	<body>
	    <div class="row">
	    	<div class="col-4">
	    		<g:applyLayout name="portlet" params="['fluid': true]">
	    			<content tag="portletTitle"><span>CA ANNUEL <span style="font-size:x-small"> (HT)</span></span></content>
	    			<content tag="portletBody">
	    				<div class="kt-widget-19">
	    					<div class="kt-widget-19__title">
	    						<div class="kt-widget-19__label">
	    							<small>€</small><g:formatNumber number="${ statFactureAnnuel.anneeN.totalHT }" format="0.0"/>K
	    						</div>
	    						<asset:image src="iconbox_bg.png" class="kt-widget-19__bg"/>
	    					</div>
	    					<div class="kt-widget-19__data">
	    						<div style="position: relative; width:220px; height:110px;" chartjs>
									<div class="d-none" chartjs-data>
									
										var brandColor = KTApp.getStateColor('brand')
										var gradient = context.createLinearGradient(0, 0, 0, 120);
								        gradient.addColorStop(0, Chart.helpers.color(brandColor).alpha(0.1).rgbString());
								        //gradient.addColorStop(1, Chart.helpers.color(brandColor).alpha(0).rgbString());
									
										chartOptions = {
											type: 'bar',
											data: {
												labels: ['CA'],
									            datasets: [
									            	{ label: 'N-1', data: [${ (statFactureAnnuel.anneeN_1.totalHT as Double)?.round(1) }], backgroundColor: gradient, barPercentage: 0.5,},
									            	{ label: 'N', data: [${ (statFactureAnnuel.anneeN.totalHT as Double)?.round(1) }], backgroundColor: brandColor, barPercentage: 0.5,}
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
								</div> <!-- div.chartjs -->
	    					</div>
	    				</div>
	    			</content>
	    		</g:applyLayout>
	    	</div>
	    	
	    	<div class="col-4">
	    		<g:applyLayout name="portlet">
	    			<content tag="portletTitle"><span>CA MENSUEL <span style="font-size:x-small"> (HT)</span></span></content>
	    			<content tag="portletBody">
	    				<div class="kt-widget-19">
	    					<div class="kt-widget-19__title">
	    						<div class="kt-widget-19__label">
	    							<small>€</small><g:formatNumber number="${ statFactureMensuel.anneeN.totalHT }" format="0.0"/>K
	    						</div>
	    						<asset:image src="iconbox_bg.png" class="kt-widget-19__bg"/>
	    					</div>
	    					<div class="kt-widget-19__data">
	    						<div style="position: relative; width:220px; height:110px;" chartjs>
									<div class="d-none" chartjs-data>
									
										var brandColor = KTApp.getStateColor('brand')
										var gradient = context.createLinearGradient(0, 0, 0, 120);
								        gradient.addColorStop(0, Chart.helpers.color(brandColor).alpha(0.1).rgbString());
								        //gradient.addColorStop(1, Chart.helpers.color(brandColor).alpha(0).rgbString());
									
										chartOptions = {
											type: 'bar',
											data: {
												labels: ['CA'],
									            datasets: [
									            	{ label: 'N-1', data: [${ (statFactureMensuel.anneeN_1.totalHT as Double)?.round(1) }], backgroundColor: gradient, barPercentage: 0.5,},
									            	{ label: 'N', data: [${ (statFactureMensuel.anneeN.totalHT as Double)?.round(1) }], backgroundColor: brandColor, barPercentage: 0.5,}
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
								                            labelString: 'Mois'
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
								</div> <!-- div.chartjs -->
	    					</div> 
	    				</div>
	    			</content>
	    		</g:applyLayout>
	    	</div>
	    	
	    	<div class="col-4">
	    		<g:applyLayout name="portlet">
	    			<content tag="portletTitle">Mes règlements</content>
	    		</g:applyLayout>
	    	</div>
	    </div>
	</body>
</html>
