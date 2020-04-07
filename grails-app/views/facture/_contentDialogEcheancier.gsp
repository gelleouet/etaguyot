<g:hiddenField name="dateEcheance" value="${ app.formatPicker(date: facture.dateEcheance) }"/>
<g:hiddenField name="totalHT" value="${ app.format2Decimal(number: facture.totalHT) }"/>
<g:hiddenField name="totalTVA" value="${ app.format2Decimal(number: facture.totalTVA) }"/>

<div class="row">
	<div class="col">
		<table id="facture-echeancier-datatable" class="table table-sm">
			<thead>
				<tr>
					<th>Date</th>
					<th>Montant</th>
					<th>&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				<g:each var="reglement" in="${ facture.reglements.sort{ it.dateEcheance }  }" status="status">
					<tr>
						<td>
							<g:if test="${ reglement.id }">
								<g:hiddenField name="reglements[${status}].id" value="${ reglement.id }"/>
							</g:if>
							<g:hiddenField name="reglements[${status}].status" value="${ status }"/>
							<g:hiddenField name="reglements[${status}].montantRegle" value="${ reglement.montantRegle }"/>
							
							<g:field type="date" name="reglements[${status}].dateEcheance" value="${ app.formatPicker(date: reglement.dateEcheance) }" 
								class="form-control medium" required="true" disabled="${ facture.isValidee() }"/>
						</td>
						<td>
							<g:field type="text" name="reglements[${status}].montantTTC" value="${ app.format2Decimal(number: reglement.montantTTC) }" required="true"
								class="form-control number" disabled="${ facture.isValidee() }"/>
						</td>
						<td>
							<a data-url="${ createLink(action: 'removeReglement', params: [status: status]) }" class="btn btn-sm btn-clean btn-icon btn-icon-md facture-remove-reglement-button" title="Supprimer">
		                       <li class="la la-trash"></li>
		                     </a>
						</td>
					</tr>
				</g:each>
			</tbody>
		</table>
	</div>
	<div class="col">
		<div class="row">
			<div class="col">
				<label>Reste net à payer</label>
			</div>
			<div class="col">
				<g:field type="text" name="totalTTC" value="${ app.format2Decimal(number: facture.totalTTC()) }"
					class="form-control number" readonly="true"/>
			</div>
		</div>
		<div class="row mt-2">
			<div class="col">
				<label>Montant réparti</label>
			</div>
			<div class="col">
				<g:field type="text" name="totalReparti" value="${ app.format2Decimal(number: facture.totalReparti()) }"
					class="form-control number" readonly="true"/>
			</div>
		</div>
		
		<div class="kt-separator kt-separator--space-md kt-separator--border-dashed"></div>
		
		<g:set var="resteARepartir" value="${ facture.resteARepartir() }"/>
		
		<div class="row">
			<div class="col">
				<label>Reste à répartir</label>
			</div>
			<div class="col">
				<g:field type="text" name="resteARepartir" value="${ app.format2Decimal(number: resteARepartir) }"
					class="form-control number ${ resteARepartir == 0 ? 'is-valid' : 'is-invalid' }" readonly="true"/>
			</div>
		</div>
	</div>
</div>

