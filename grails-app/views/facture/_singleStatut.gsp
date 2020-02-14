<g:if test="${ facture?.isAnnulee() }">
	<span class="kt-badge kt-badge--danger kt-badge--inline">ANNULÉE</span>
</g:if>
<g:elseif test="${ facture?.isReglee() }">
	<span class="kt-badge kt-badge--brand kt-badge--inline">RÉGLÉE</span>
</g:elseif>
<g:elseif test="${ facture?.isEnvoyee() }">
	<span class="kt-badge kt-badge--accent kt-badge--inline">ENVOYÉE</span>
</g:elseif>
<g:elseif test="${ facture?.isValidee() }">
	<span class="kt-badge kt-badge--success kt-badge--inline">VALIDÉE</span>
</g:elseif>
<g:elseif test="${ facture?.isBrouillon() }">
	<span class="kt-badge kt-badge--metal kt-badge--inline">BROUILLON</span>
</g:elseif>


