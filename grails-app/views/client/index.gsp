<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="page-default" />
    </head>
    
    <content tag="subheaderTitle">
   		<g:form class="form-inline" name="client-index-form">
   			<label>Rechercher</label>
   			<g:textField name="code" value="${ command.code }" class="form-control ml-2 small" placeholder="Code" autofocus="true"/>
   			<g:textField name="raisonSociale" value="${ command.raisonSociale }" class="form-control ml-2 medium" placeholder="Raison sociale"/>
   			<g:textField name="email" value="${ command.email }" class="form-control ml-2 medium" placeholder="Email"/>
   			<g:textField name="famille" value="${ command.famille }" class="form-control ml-2 medium" placeholder="Famille"/>
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
    		<content tag="portletTitle"><i class="fa fa-address-card fa-lg"></i>&nbsp;Clients</content>
    		
    		<content tag="portletBody">
    			<app:datatable elementId="client-datatable" value="${ clients }">
    				<thead>
    					<tr>
    						<th>Raison sociale</th>
    						<th>Code</th>
    						<th>Famille</th>
    						<th>Email</th>
    						<th>Tel</th>
    						<th>Adresse</th>
    						<th data-orderable="false" data-role="action">Actions</th>
    					</tr>
    				</thead>
    				<tbody>
    					<g:each var="client" in="${ clients }">
    						<tr>
	    						<td>${ client.raisonSociale }</td>
	    						<td>${ client.code }</td>
	    						<td>${ client.famille }</td>
	    						<td>${ client.email }</td>
	    						<td>${ client.telephone }</td>
	    						<td>${ client.codePostal } ${ client.ville }</td>
	    						<td>
	    							<g:link action="edit" id="${ client.id }" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="Modifier">
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