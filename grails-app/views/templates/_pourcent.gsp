<g:if test="${ valN != null && valN_1 }">
	<g:set var="diff" value="${ valN - valN_1 }"/>
	<g:set var="pourcent" value="${ diff * 100 / valN_1 }"/>
	
	<g:if test="${ pourcent > 0 }">
		<i class="fa fa-arrow-up"></i> +<g:formatNumber number="${ pourcent }" format="0,0"/>%
	</g:if>
	<g:elseif test="${ value < 0 }">
		<i class="fa fa-arrow-down"></i> <g:formatNumber number="${ pourcent }" format="0,0"/>%
	</g:elseif>
	<g:else>
		<g:formatNumber number="${ pourcent }" format="0,0"/>%
	</g:else>
</g:if>