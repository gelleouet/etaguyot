<div class="kt-portlet ${ pageProperty(name: 'fluid') ? 'kt-portlet--height-fluid' : '' }">
	<div class="kt-portlet__head">
		<div class="kt-portlet__head-label">
			<h3 class="kt-portlet__head-title"><g:pageProperty name="page.portletTitle"/></h3>
		</div>
		<div class="kt-portlet__head-toolbar">
			<g:pageProperty name="page.portletToolbar"/>
		</div>
	</div>
	
	<div class="kt-portlet__body ${ pageProperty(name: 'fluid') ? 'kt-portlet__body--fluid' : '' }">
		<g:pageProperty name="page.portletBody"/>
	</div>
	
	<g:if test="${ pageProperty(name: 'page.portletFooter') }">
		<div class="kt-portlet__foot ${ pageProperty(name: 'footerSolid') ? 'kt-portlet__foot--solid' : '' }">
			<g:pageProperty name="page.portletFooter"/>
		</div>
	</g:if>
</div>