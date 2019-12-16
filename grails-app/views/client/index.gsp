<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="page-default" />
    </head>
    
    <content tag="subheaderTitle">
   		<g:form class="form-inline" name="client-index-form">
   			<label>Rechercher</label>
   			<g:textField name="code" value="${ command.code }" class="form-control ml-2" placeholder="Code"/>
   			<g:textField name="raisonSociale" value="${ command.raisonSociale }" class="form-control ml-2" placeholder="Raison sociale"/>
   			<g:textField name="email" value="${ command.email }" class="form-control ml-2" placeholder="Email"/>
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
    		<content tag="portletTitle">Clients</content>
    		
    		<content tag="portletBody">
    			<table class="app-datatable" id="client-datatable">
    				<thead>
    					<tr>
    						<th>Raison sociale</th>
    						<th>Code</th>
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
    			</table>
    			
    			<g:paginate total="${ clients.totalCount }"/>
    		</content>
    	</g:applyLayout>
        
    </body>
    
</html>