<%@ page import="facturation.StatutReglementEnum" %>

<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="page-default" />
    </head>
    
    <content tag="subheaderTitle">
   		<g:form class="form-inline" name="facture-index-form">
   			<g:hiddenField name="dateDebut" value="${ app.formatPicker(date: command.dateDebut) }"/>
   			<g:hiddenField name="dateFin" value="${ app.formatPicker(date: command.dateFin) }"/>
   			<input type="text" name="daterange" class="form-control app-daterangepicker" data-startDate="${ app.formatUser(date: command.dateDebut) }"
   				data-endDate="${ app.formatUser(date: command.dateFin) }" data-startDateId="dateDebut" data-endDateId="dateFin">
   			<g:field type="search" name="numero" value="${ command.numero }" class="form-control ml-2 small mr-2" placeholder="N°"/>
			
   			<button class="btn btn-outline-brand"><i class="fa fa-search"></i></button>
   		</g:form>
   	</content>
   	
    <body>
    
    	<div class="row">
    		<div class="col-10">
    			<g:applyLayout name="portlet">
		    		<content tag="portletTitle"><i class="fa fa-money-check-alt fa-lg"></i>&nbsp;Règlements</content>
		    		
		    		<content tag="portletBody">
		    			<app:datatable elementId="reglement-datatable" value="${ reglements }">
		    				<thead>
		    					<tr>
		    						<th>N°</th>
		    						<th>Date</th>
		    						<th>Client</th>
		    						<th>Echéance</th>
		    						<th>Mode règlement</th>
		    						<th>Montant</th>
		    						<th>Date règlement</th>
		    						<th data-orderable="false" data-role="action">Actions</th>
		    					</tr>
		    				</thead>
		    				<tbody>
		    					<g:each var="reglement" in="${ reglements }">
		    						<tr>
			    						<td>${ reglement.facture.numero }</td>
			    						<td><g:formatDate date="${ reglement.facture.dateFacture }" format="dd/MM/yyyy"/></td>
			    						<td>${ reglement.facture.client.raisonSociale }</td>
			    						<td><g:formatDate date="${ reglement.dateEcheance }" format="dd/MM/yyyy"/></td>
			    						<td>${ reglement.modeReglement.libelle }</td>
			    						<td>${ app.format2Decimal(number: reglement.montantTTC) }€</td>
			    						<td><g:formatDate date="${ reglement.dateReglement }" format="dd/MM/yyyy"/></td>
			    						<td>
			    						</td>
			    					</tr>
		    					</g:each>
		    				</tbody>
		    			</app:datatable>
		    		</content>
		    	</g:applyLayout>
    		</div> <!-- div.col -->
    		
    		<div class="col-2">
    		</div> <!-- div.col -->
    	</div> <!-- div.row -->
        
    </body>
    
</html>