<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="page-default" />
    </head>
    
    <content tag="subheaderTitle">
   		<g:form class="form-inline" name="facture-index-form">
   			<label>Rechercher</label>
   			<input type="text" name="daterange" class="form-control app-daterangepicker" data-startDate="${ app.formatUser(date: command.dateDebut) }"
   				data-endDate="${ app.formatUser(date: command.dateFin) }">
   			<g:textField name="numero" value="${ command.numero }" class="form-control ml-2 small" placeholder="N°"/>
   			<button class="btn btn-outline-brand"><i class="fa fa-search"></i></button>
   		</g:form>
   	</content>
   	
   	<content tag="subheaderToolbar">
   		<g:link action="edit" class="btn btn-default btn-sm btn-bold btn-upper">
   			<i class="fa fa-plus"></i>Nouveau
   		</g:link>
   	</content>
    
    <body>
    	<g:applyLayout name="portlet">
    		<content tag="portletTitle"><i class="fa fa-file-invoice-dollar fa-lg"></i>&nbsp;Factures</content>
    		
    		<content tag="portletBody">
    			<app:datatable elementId="facture-datatable" value="${ factures }">
    				<thead>
    					<tr>
    						<th data-orderable="false">Statut</th>
    						<th>N°</th>
    						<th>Date</th>
    						<th>Echéance</th>
    						<th>Client</th>
    						<th>Montant HT</th>
    						<th>Montant TTC</th>
    						<th data-orderable="false" data-role="action">Actions</th>
    					</tr>
    				</thead>
    				<tbody>
    					<g:each var="facture" in="${ factures }">
    						<tr>
    							<td>
	    						
	    						</td>
	    						<td>${ facture.numero }</td>
	    						<td><g:formatDate date="${ facture.dateFacture }" format="dd/MM/yyyy"/></td>
	    						<td><g:formatDate date="${ facture.dateEcheance }" format="dd/MM/yyyy"/></td>
	    						<td>${ facture.client.raisonSociale }</td>
	    						<td>${ facture.totalHT }</td>
	    						<td>${ facture.totalTTC() }</td>
	    						<td>
	    							<g:link action="edit" id="${ facture.id }" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="Modifier">
			                          <i class="la la-edit"></i>
			                        </g:link>
	    						</td>
	    					</tr>
    					</g:each>
    				</tbody>
    			</app:datatable>
    		</content>
    	</g:applyLayout>
        
    </body>
    
</html>