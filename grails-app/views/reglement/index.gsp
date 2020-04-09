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
   			<g:select name="clientId" value="${ command.clientId }" from="${ command.clients() }" class="form-control app-combobox medium1 ml-2 mr-2"
				optionKey="id" optionValue="raisonSociale" dataAttrs="['code': { it.code }]" data-placeholder="Sélectionner un client"
				data-ajax--url="${ createLink(action: 'query', controller: 'client') }" data-ajax--global="false" data-clear="true">
				<option></option>
			</g:select>
   			<div class="kt-checkbox-inline">
				<label class="kt-checkbox">
					<g:checkBox name="regle" value="${ command.regle }"/> réglé
					<span></span>
				</label>
				<label class="kt-checkbox">
					<g:checkBox name="enAttente" value="${ command.enAttente }"/> en attente
					<span></span>
				</label>
			</div>
   			<button class="btn btn-outline-brand"><i class="fa fa-search"></i></button>
   		</g:form>
   	</content>
   	
    <body data-onload="onLoadReglementIndex">
    
    	<div class="row">
    		<div class="col-10">
    			<g:applyLayout name="portlet">
		    		<content tag="portletTitle"><i class="fa fa-money-check-alt fa-lg"></i>&nbsp;Règlements</content>
		    		
		    		<content tag="portletBody">
		    			<app:datatable elementId="reglement-datatable" value="${ reglements }">
		    				<thead>
		    					<tr>
		    						<th>Statut</th>
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
		    							<td><g:render template="statut" model="[reglement: reglement]"/></td>
			    						<td>
			    							<g:link action="edit" controller="facture" id="${ reglement.facture.id }" class="kt-link">
			    								${ reglement.facture.numero }
			    							</g:link>
			    						</td>
			    						<td><g:formatDate date="${ reglement.facture.dateFacture }" format="dd/MM/yyyy"/></td>
			    						<td>${ reglement.facture.client.raisonSociale }</td>
			    						<td><g:formatDate date="${ reglement.dateEcheance }" format="dd/MM/yyyy"/></td>
			    						<td>${ reglement.modeReglement.libelle }</td>
			    						<td>${ app.format2Decimal(number: reglement.montantTTC) }€</td>
			    						<td><g:formatDate date="${ reglement.dateReglement }" format="dd/MM/yyyy"/></td>
			    						<td>		
			    							<g:if test="${ !reglement.dateReglement }">
				    							<a class="btn btn-sm btn-clean btn-icon btn-icon-md reglement-echeance-dialog-button" title="Régler"
				    								data-dialog="reglement-echeance-dialog" data-url="${ g.createLink(action: 'dialogReglementEcheance', id: reglement.id) }">
				    								<i class="fa fa-money-check-alt fa-lg"></i>
				    							</a>
			    							</g:if>
			    						</td>
			    					</tr>
		    					</g:each>
		    				</tbody>
		    			</app:datatable>
		    		</content>
		    	</g:applyLayout>
    		</div> <!-- div.col -->
    		
    		<div class="col-2">
    			<g:applyLayout name="portlet">
		    		<content tag="portletTitle"><i class="la la-lg la-bar-chart"></i>&nbsp;Synthèse</content>
		    		
		    		<content tag="portletBody">
		    			<div class="kt-list kt-list--badge">
		    				<div class="kt-list__item">
		    					<span class="kt-list__badge kt-list__badge--brand"></span>
		    					<span class="kt-list__text">&nbsp;Echéances</span>
		    					<span class="kt-list__time">${ synthese.count }</span>
		    				</div>
		    				
		    				<div class="kt-separator kt-separator--border-dashed"></div>
		    				
		    				<div class="kt-list__item">
		    					<span class="kt-list__badge kt-list__badge--brand"></span>
		    					<span class="kt-list__text">&nbsp;Total</span>
		    					<span class="kt-list__time">${ app.format2Decimal(number: synthese.montantTTC) }€</span>
		    				</div>
		    				<div class="kt-list__item">
		    					<span class="kt-list__badge kt-list__badge--brand"></span>
		    					<span class="kt-list__text">&nbsp;Réglé</span>
		    					<span class="kt-list__time">${ app.format2Decimal(number: synthese.montantRegle) }€</span>
		    				</div>
		    				<div class="kt-list__item">
		    					<span class="kt-list__badge kt-list__badge--brand"></span>
		    					<span class="kt-list__text">&nbsp;Reste dû</span>
		    					<span class="kt-list__time">${ app.format2Decimal(number: synthese.montantResteDu) }€</span>
		    				</div>
		    			</div>
		    		</content>
		    	</g:applyLayout>
    		</div> <!-- div.col -->
    	</div> <!-- div.row -->
        
    </body>
    
</html>