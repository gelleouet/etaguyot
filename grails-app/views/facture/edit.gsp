<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="page-default" />
    </head>
    
    
    <content tag="subheaderTitle">
    	<div class="kt-subheader__breadcrumbs">
    		<g:link action="index" class="kt-subheader__breadcrumbs-link kt-subheader__breadcrumbs-link--home">
	   			Factures
	   		</g:link>
	   		<span class="kt-subheader__breadcrumbs-separator"></span>
	   		<g:link action="edit" id="${ facture?.id }" class="kt-subheader__breadcrumbs-link">
	   			${ facture?.titreComplet() }
	   		</g:link>
    	</div>
   	</content>
    
    
    <content tag="subheaderToolbar">
    	<g:if test="${ facture?.id }">
    		<g:if test="${ facture.isBrouillon() }">
				<button class="btn btn-success" onclick="onValiderFacture(this)" data-url="${ g.createLink(action: 'valider') }">
					<i class="la la-check-circle"></i> Valider
				</button>
			</g:if>
			<g:elseif test="${ !facture.isAvoir() }">
				<g:link action="avoir" id="${ facture.id }" class="btn btn-secondary btn-sm" title="Avoir">
		   			<i class="fa fa-file-invoice-dollar"></i> Avoir
		   		</g:link>
			</g:elseif>
    		<g:link action="pdf" id="${ facture.id }" class="btn btn-secondary btn-sm" title="PDF">
	   			<i class="fa fa-file-pdf"></i>
	   		</g:link>
	   		<a href="#" class="btn btn-secondary btn-sm" title="Dupliquer">
	   			<i class="fa fa-copy"></i>
	   		</a>
	   		<g:if test="${ !facture.isValidee() }">
		   		<g:link action="delete" id="${ facture.id }" class="btn btn-outline-danger btn-sm confirm-button" title="Supprimer">
		   			<i class="la la-trash"></i>
		   		</g:link>
	   		</g:if>
   		</g:if>
   	</content>
    
    <body data-onload="onLoadFactureEdit">
    	<g:form action="save" name="facture-edit-form" class="kt-form fast-focus">
    	
    		<g:hiddenField name="id" value="${ facture?.id }"/>
    	
	    	<g:applyLayout name="portlet" params="['footerSolid': true]">
	    		<content tag="portletTitle"><i class="fa fa-shopping-cart"></i>&nbsp;${ facture?.titreComplet() }</content>
	    		
	    		<content tag="portletToolbar">
	    			<g:link class="btn btn-secondary kt-margin-r-10">
	    				<i class="la la-arrow-left"></i> Retour
	    			</g:link>
	    			<g:if test="${ !facture.isValidee() }">
	    				<button id="facture-edit-form-submit" class="btn btn-brand"><i class="la la-save"></i> Enregistrer</button>
	    			</g:if>
	    		</content>
	    		
	    		<content tag="portletBody">
	   				<div class="row">
	   					<div class="col-xl-2"></div>
	   					<div class="col-xl-8">
	   						<div class="kt-section kt-section--first">
								<div class="kt-section__body">
									<div id="facture-ajax-form">
										<g:render template="form"></g:render>
									</div>
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
		    			<g:if test="${ !facture.isValidee() }">
		    				<button class="btn btn-brand"><i class="la la-save"></i> Enregistrer</button>
		    			</g:if>
	    			</div>
	    		</content>
	    	</g:applyLayout>
    	</g:form>
        
    </body>
    
</html>