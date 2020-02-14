<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="page-default" />
    </head>
    
    <content tag="subheaderTitle">
   		<g:form class="form-inline" name="article-index-form">
   			<g:field type="search" name="code" value="${ command.code }" class="form-control ml-2 small" placeholder="Code" autofocus="true"/>
   			<g:field type="search" name="libelle" value="${ command.libelle }" class="form-control ml-2 medium" placeholder="Libellé"/>
   			<g:field type="search" name="famille" value="${ command.famille }" class="form-control ml-2 medium" placeholder="Famille"/>
   			<button class="btn btn-outline-brand"><i class="fa fa-search"></i></button>
   		</g:form>
   	</content>
   	
   	<content tag="subheaderToolbar">
   		<g:link action="edit" class="btn btn-default btn-sm" title="Nouveau">
   			<i class="fa fa-plus"></i>
   		</g:link>
   	</content>
    
    <body>
    	<g:applyLayout name="portlet">
    		<content tag="portletTitle"><i class="fa fa-shopping-cart"></i>&nbsp;Articles</content>
    		
    		<content tag="portletBody">
    			<app:datatable elementId="article-datatable" value="${ articles }">
    				<thead>
    					<tr>
    						<th>Libellé</th>
    						<th>Code</th>
    						<th>Famille</th>
    						<th>Unité</th>
    						<th>Prix HT</th>
    						<th>TVA</th>
    						<th data-orderable="false" data-role="action">Actions</th>
    					</tr>
    				</thead>
    				<tbody>
    					<g:each var="article" in="${ articles }">
    						<tr>
	    						<td>${ article.libelle }</td>
	    						<td>${ article.code }</td>
	    						<td>${ article.famille }</td>
	    						<td>${ article.unite }</td>
	    						<td><g:if test="${ article.prixHT != null }">${ app.format2Decimal(number: article.prixHT) }€</g:if></td>
	    						<td><g:if test="${ article.tauxTVA != null }">${ app.format2Decimal(number: article.tauxTVA) }%</g:if></td>
	    						<td>
	    							<g:link action="edit" id="${ article.id }" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="Modifier">
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