<g:if test="${ error }">
	<div class="alert alert-danger">
		<div class="alert-icon">
			<i class="flaticon2-warning"></i>
		</div>
		<div class="alert-text">
			${ error }
			
			<g:if test="${ exception?.errors }">
				<g:renderErrors bean="${ exception?.errors }" />
			</g:if>
		</div>
		<div class="alert-close">
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">
		    	<span aria-hidden="true"><i class="la la-close"></i></span>
		  	</button>
		</div>
	</div>
</g:if>