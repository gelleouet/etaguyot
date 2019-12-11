<div class="kt-portlet kt-portlet-mobile">
	<div class="kt-portlet__head">
		<div class="kt-portlet__head-label">
			<h3 class="kt-portlet__head-title"><g:pageProperty name="page.portletTitle"/></h3>
		</div>
	</div>
	
	<div class="kt-portlet__body">
		<g:pageProperty name="page.portletBody"/>
	</div>
	
	
	<div class="kt-portlet__foot ${ footerSolid ? 'kt-portlet__foot--solid' : '' }">
		<g:pageProperty name="page.portletFooter"/>
	</div>
</div>