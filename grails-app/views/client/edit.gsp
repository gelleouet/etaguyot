<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="page-default" />
    </head>
    
    
    <content tag="subheaderTitle">
    	<div class="kt-subheader__breadcrumbs">
    		<g:link action="index" class="kt-subheader__breadcrumbs-link kt-subheader__breadcrumbs-link--home">
	   			Clients
	   		</g:link>
	   		<span class="kt-subheader__breadcrumbs-separator"></span>
	   		<g:link action="edit" id="${ client?.id }" class="kt-subheader__breadcrumbs-link">
	   			${ client?.id ? client.raisonSociale : 'Nouveau client' }
	   		</g:link>
    	</div>
   	</content>
    
    
    <content tag="subheaderToolbar">
    	<g:if test="${ client?.id }">
	   		<a href="#" class="btn btn-secondary btn-sm" title="Dupliquer">
	   			<i class="fa fa-copy"></i>
	   		</a>
	   		<g:link action="delete" id="${ client.id }" class="btn btn-outline-danger btn-sm confirm-button" title="Supprimer">
	   			<i class="la la-trash"></i>
	   		</g:link>
   		</g:if>
   	</content>
    
    <body>
    	<g:form action="save" name="client-edit-form" class="kt-form fast-focus">
    	
    		<g:hiddenField name="id" value="${ client?.id }"/>
    	
	    	<g:applyLayout name="portlet" params="['footerSolid': true]">
	    		<content tag="portletTitle"><i class="fa fa-address-card fa-lg"></i>&nbsp;${ client?.id ? client.raisonSociale : 'Nouveau client' }</content>
	    		
	    		<content tag="portletToolbar">
	    			<g:link class="btn btn-secondary kt-margin-r-10">
	    				<i class="la la-arrow-left"></i> Retour
	    			</g:link>
	    			<button class="btn btn-brand"><i class="la la-save"></i> Enregistrer</button>
	    		</content>
	    		
	    		<content tag="portletBody">
	   				<div class="row">
	   					<div class="col-xl-2"></div>
	   					<div class="col-xl-8">
	   						<div class="kt-section kt-section--first">
								<div class="kt-section__body">
									<h3 class="kt-section__title">Informations générales</h3>
									
									<g:render template="formGeneral"></g:render>
								</div>
							</div>
							
							<div class="kt-separator kt-separator--border-dashed kt-separator--space-lg"></div>
							
							<div class="kt-section kt-section">
								<div class="kt-section__body">
									<h3 class="kt-section__title">Informations facturation</h3>
									
									<g:render template="formFacturation"></g:render>
								</div>
							</div>
							
	   					</div>
	   					<div class="col-xl-2"></div>
	   				</div>
	    		</content>
	    		
	    		
	    		<content tag="portletFooter">
	    			<div class="kt-form__actions kt-form__actions--right">
 						<g:link class="btn btn-secondary kt-margin-r-10">
		    				<i class="la la-arrow-left"></i> Retour
		    			</g:link>
		    			<button class="btn btn-brand"><i class="la la-save"></i> Enregistrer</button>
	    			</div>
	    		</content>
	    	</g:applyLayout>
    	</g:form>
        
    </body>
    
</html>