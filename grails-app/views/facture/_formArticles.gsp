<table id="facture-article-datatable" class="table table-striped">
	<thead>
		<tr>
			<th>Code</th>
			<th>Libellé</th>
			<th>Quantité</th>
			<th>Unité</th>
			<th>PU HT (€)</th>
			<th>TVA (%)</th>
			<th>Total HT (€)</th>
			<th>&nbsp;</th>
		</tr>
	</thead>
	<tbody>
		<g:each var="farticle" in="${ facture.articles?.sort { it.ordre }  }" status="status">
			<g:set var="bindPrefix" value="articles[${ status }]"/>
			<tr>
				<td>
					<g:if test="${ farticle.id }">
						<g:hiddenField name="${ bindPrefix }.id" value="${ farticle.id }"/>
					</g:if>
					<g:hiddenField name="${ bindPrefix }.status" value="${ status }"/>
					<g:hiddenField name="${ bindPrefix }.unite" value="${ farticle.unite }"/>
					<g:hiddenField name="${ bindPrefix }.ordre" value="${ farticle.ordre }"/>
					
					<g:select name="${ bindPrefix }.codeArticle" value="${ farticle.codeArticle }" from="${ farticle.articles() }" 
						class="form-control form-control-sm app-combobox small" disabled="${ facture.isValidee() }"
						optionKey="code" optionValue="libelle" data-placeholder="Sélectionner un article"
						data-ajax--url="${ createLink(action: 'query', controller: 'article') }" data-ajax--global="false"
						data-processResults="processFactureCodeProduitResults"
						data-url="${ createLink(action: 'changeArticle', params: [status: status]) }" data-onchange="onChangeArticleFacture"
						data-format-selection="formatFactureCodeProduitSelection" data-format-option="formatFactureCodeProduitOption">
						<option></option>
					</g:select>
				</td>
				<td>
					<g:field type="text" name="${ bindPrefix }.libelle" value="${ farticle.libelle }" required="true" maxlength="255"
						class="form-control form-control-sm medium" placeholder="Saisir un libellé" disabled="${ facture.isValidee() }"/>
				</td>
				<td class="text-right">
					<g:field type="text" name="${ bindPrefix}.quantite" value="${ app.format2Decimal(number: farticle.quantite) }" required="true"
						data-url="${ createLink(action: 'changeTarification', params: [status: status]) }" disabled="${ facture.isValidee() }"
						class="form-control form-control-sm xsmall number facture-update-tarification" minvalue="1"/>
				</td>
				<td class="font-size-sm">${ farticle.unite }</td>
				<td class="text-right">
					<g:field type="text" name="${ bindPrefix}.prixHT" value="${ app.format2Decimal(number: farticle.prixHT) }" required="true"
						data-url="${ createLink(action: 'changeTarification', params: [status: status]) }" disabled="${ facture.isValidee() }"
						class="form-control form-control-sm xsmall number facture-update-tarification"/>
				</td>
				<td class="text-right">
					<g:field type="text" name="${ bindPrefix}.tauxTVA" value="${ app.format2Decimal(number: farticle.tauxTVA) }" required="true"
						data-url="${ createLink(action: 'changeTarification', params: [status: status]) }" disabled="${ facture.isValidee() }"
						class="form-control form-control-sm xsmall number facture-update-tarification"/>
				</td>
				<td class="text-right font-weight-bold">
					<span>${ app.format2Decimal(number: farticle.totalHT()) }</span>
					<span class="font-size-sm font-weight-normal">(TVA ${ app.format2Decimal(number: farticle.totalTVA()) })</span>
				</td>
				<td>
					<g:if test="${ !facture.isValidee() }">
						<a data-url="${ createLink(action: 'removeArticle', params: [status: status]) }" class="btn btn-sm btn-clean btn-icon btn-icon-md facture-remove-article-button" title="Supprimer">
	                       <li class="la la-trash"></li>
	                     </a>
                     </g:if>
				</td>
			</tr>
			<tr>
				<td></td>
				<td colspan="5">
					<g:textArea name="${ bindPrefix }.commentaire" value="${ farticle.commentaire }" rows="2"
						class="form-control form-control-sm medium" placeholder="Saisir un commentaire" disabled="${ facture.isValidee() }"/>
				</td>
				<td></td>
				<td></td>
			</tr>
		</g:each>
	</tbody>
</table>

