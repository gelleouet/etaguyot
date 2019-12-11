<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
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
   		<g:link class="btn btn-default btn-sm btn-bold btn-upper">
   			<i class="fa fa-copy"></i>Dupliquer
   		</g:link>
   	</content>
    
    <body>
    	<g:form action="save" name="client-edit-form" class="kt-form">
	    	<g:applyLayout name="portlet" params="[footerSolid: true]">
	    		<content tag="portletTitle">${ client?.id ? client.raisonSociale : 'Nouveau client' }</content>
	    		
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
	    			<div class="kt-form__actions">
	    				<div class="row">
		    				<div class="col-xl-2"></div>
		   					<div class="col-xl-8">
		   						<div class="row">
		   							<div class="col-3"></div>
		   							<div class="col-9">
		   								<button class="btn btn-brand">Enregistrer</button>
		   								<g:link action="index" class="btn btn-secondary">Annuler</g:link>
		   							</div>
		   						</div>
		   					</div>
		   					<div class="col-xl-2"></div>
	   					</div>
	    			</div>
	    		</content>
	    	</g:applyLayout>
    	</g:form>
        
    </body>
    
</html>