<app:datatable id="facture-article-datatable" value="${ facture.articles }" noPaginate="true" data-ordering="false">
	<thead>
		<tr>
			<th>Code</th>
			<th>Libellé</th>
			<th>Quantité</th>
			<th>Unité</th>
			<th>PU HT (€)</th>
			<th>TVA (%)</th>
			<th>Total HT (€)</th>
			<th data-role="action"></th>
		</tr>
	</thead>
	<tbody>
		<g:each var="farticle" in="${ facture.articles?.sort { it.codeArticle }  }" status="status">
			<g:set var="bindPrefix" value="articles[${ status }]"/>
			<tr>
				<td>
					<g:if test="${ farticle.id }">
						<g:hiddenField name="${ bindPrefix }.id" value="${ farticle.id }"/>
					</g:if>
					<g:hiddenField name="${ bindPrefix }.status" value="${ status }"/>
					
					<g:select name="${ bindPrefix }.codeArticle" value="${ farticle.codeArticle }" from="${ farticle.articles() }" 
						class="form-control form-control-sm app-combobox medium"
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
						class="form-control form-control-sm medium" placeholder="Saisir un libellé"/>
				</td>
				<td class="text-right">
					<g:field type="text" name="${ bindPrefix}.quantite" value="${ app.format2Decimal(number: farticle.quantite) }" required="true"
						class="form-control form-control-sm xsmall number" minvalue="1"/>
				</td>
				<td>${ farticle.unite }</td>
				<td class="text-right">
					<g:field type="text" name="${ bindPrefix}.prixHT" value="${ app.format2Decimal(number: farticle.prixHT) }" required="true"
						class="form-control form-control-sm xsmall number"/>
				</td>
				<td class="text-right">
					<g:field type="text" name="${ bindPrefix}.tauxTVA" value="${ app.format2Decimal(number: farticle.tauxTVA) }" required="true"
						class="form-control form-control-sm xsmall number"/>
				</td>
				<td class="text-right">
					${ app.format2Decimal(number: farticle.totalHT()) }
				</td>
				<td>
				
				</td>
			</tr>
		</g:each>
	</tbody>
</app:datatable>

