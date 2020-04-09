<%@ page import="facturation.TypeFactureEnum" %>
<%@ page import="facturation.StatutFactureEnum" %>

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
			<g:select name="types" value="${ command.types }" from="${ TypeFactureEnum.values() }" class="form-control app-combobox medium"
				data-placeholder="Type ?" multiple="true">
			</g:select>
			<g:select name="statuts" value="${ command.statuts }" from="${ StatutFactureEnum.values() }" class="form-control app-combobox medium"
				data-placeholder="Statut ?" multiple="true" optionKey="id">
			</g:select>
   			<button class="btn btn-outline-brand"><i class="fa fa-search"></i></button>
   		</g:form>
   	</content>
   	
   	<content tag="subheaderToolbar">
   		<g:link action="edit" class="btn btn-default btn-sm" title="Nouveau">
   			<i class="fa fa-plus"></i>
   		</g:link>
   	</content>
    
    <body>
    
    	<div class="row">
    		<div class="col-10">
    			<g:applyLayout name="portlet">
		    		<content tag="portletTitle"><i class="fa fa-file-invoice-dollar fa-lg"></i>&nbsp;Factures / Avoirs</content>
		    		
		    		<content tag="portletBody">
		    			<app:datatable elementId="facture-datatable" value="${ factures }">
		    				<thead>
		    					<tr>
		    						<th data-orderable="false">Statut</th>
		    						<th data-orderable="false">Type</th>
		    						<th>N°</th>
		    						<th>Date</th>
		    						<th>Client</th>
		    						<th>Montant HT</th>
		    						<th>Montant TTC</th>
		    						<th>Reste dû</th>
		    						<th data-orderable="false" data-role="action">Actions</th>
		    					</tr>
		    				</thead>
		    				<tbody>
		    					<g:each var="facture" in="${ factures }">
		    						<tr>
		    							<td><g:render template="singleStatut" model="[facture: facture]"/></td>
			    						<td>${ facture.titre() }</td>
			    						<td>${ facture.numero }</td>
			    						<td><g:formatDate date="${ facture.dateFacture }" format="dd/MM/yyyy"/></td>
			    						<td>${ facture.client.raisonSociale }</td>
			    						<td>${ app.format2Decimal(number: facture.totalHT) }€</td>
			    						<td>${ app.format2Decimal(number: facture.totalTTC()) }€</td>
			    						<td>${ app.format2Decimal(number: facture.resteDu()) }€</td>
			    						<td>
			    							<g:if test="${ facture.isBrouillon() }">
			    								<g:link action="edit" id="${ facture.id }" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="Modifier">
						                          <i class="la la-edit"></i>
						                        </g:link>
					                        </g:if>
					                        <g:else>
					                        	<g:link action="edit" id="${ facture.id }" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="Consulter">
						                          <i class="la la-info-circle"></i>
						                        </g:link>
					                        </g:else>
					                        <g:link action="pdf" id="${ facture.id }" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="PDF">
									   			<i class="fa fa-file-pdf"></i>
									   		</g:link>
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
		    					<span class="kt-list__text">&nbsp;Factures</span>
		    					<span class="kt-list__time">${ synthese.count }</span>
		    				</div>
		    				
		    				<div class="kt-separator kt-separator--border-dashed"></div>
		    				
		    				<div class="kt-list__item">
		    					<span class="kt-list__badge kt-list__badge--brand"></span>
		    					<span class="kt-list__text">&nbsp;Total HT</span>
		    					<span class="kt-list__time">${ app.format2Decimal(number: synthese.totalHT) }€</span>
		    				</div>
		    				<div class="kt-list__item">
		    					<span class="kt-list__badge kt-list__badge--brand"></span>
		    					<span class="kt-list__text">&nbsp;Total TVA</span>
		    					<span class="kt-list__time">${ app.format2Decimal(number: synthese.totalTVA) }€</span>
		    				</div>
		    				<div class="kt-list__item">
		    					<span class="kt-list__badge kt-list__badge--brand"></span>
		    					<span class="kt-list__text">&nbsp;Total TTC</span>
		    					<span class="kt-list__time">${ app.format2Decimal(number: synthese.totalTTC) }€</span>
		    				</div>
		    				
		    				<div class="kt-separator kt-separator--border-dashed"></div>
		    				
		    				<div class="kt-list__item">
		    					<span class="kt-list__badge kt-list__badge--brand"></span>
		    					<span class="kt-list__text">&nbsp;Total réglé</span>
		    					<span class="kt-list__time">${ app.format2Decimal(number: synthese.totalRegle) }€</span>
		    				</div>
		    				<div class="kt-list__item">
		    					<span class="kt-list__badge kt-list__badge--brand"></span>
		    					<span class="kt-list__text">&nbsp;Total reste dû</span>
		    					<span class="kt-list__time">${ app.format2Decimal(number: synthese.totalResteDu) }€</span>
		    				</div>
		    			</div>
		    		</content>
		    	</g:applyLayout>
    		</div> <!-- div.col -->
    	</div> <!-- div.row -->
        
    </body>
    
</html>