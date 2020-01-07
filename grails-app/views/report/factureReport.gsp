<%@ page contentType="application/xml" %>
<%@ page defaultCodec="xml" %>

<g:set var="labelColor" value="#414b4c"></g:set>
<g:set var="lightgreyColor" value="#efeff5"></g:set>
<g:set var="brandColor" value="#008a2e"></g:set>
<g:set var="brandBorder" value="1px solid ${ brandColor }"></g:set>
<g:set var="brandBorderDashed" value="1px dashed ${ brandColor }"></g:set>
<g:set var="defaultBorder" value="1px solid lightgrey"></g:set>


<g:applyLayout name="report/page-paysage">

	<content tag="contentHeader">
		<fo:block font-size="20pt" font-weight="bold" color="${ brandColor }">
           FACTURE
    	</fo:block>
		<fo:block font-size="12pt" font-weight="bold" space-before="4pt">
          N° : ${ facture.numero }
    	</fo:block>
		<fo:block font-size="12pt" space-before="4pt">
          Date : ${ app.formatUser(date: facture.dateFacture) }
    	</fo:block>
		<fo:block font-size="12pt" space-before="4pt">
          N° client : ${ facture.client.code }
    	</fo:block>
	</content>
	

    <content tag="body">
    
    	<fo:block-container absolute-position="absolute" top="-0.5cm" left="8cm" width="10cm" height="3cm" border="${ brandBorder }"
    		fox:border-radius="4pt" padding="12pt">
    		<fo:block font-size="12pt" font-weight="bold" color="${ brandColor }" padding-before="10pt" text-transform="uppercase">
           		${ facture.client.raisonSociale }
    		</fo:block>
    		<fo:block font-size="12pt" space-before="4pt">
           		${ facture.client.adresse }
    		</fo:block>
    		<fo:block font-size="12pt" space-before="4pt">
           		${ facture.client.codePostal } - ${ facture.client.ville }
    		</fo:block>
    	</fo:block-container>
    	
    
        <fo:block font-size="12pt" space-before="4cm">
        </fo:block>
        
        <g:if test="${ facture.reference }">
        	<fo:block font-size="10pt" space-before="4pt">
        		<fo:inline font-weight="bold">Référence :</fo:inline> ${ facture.reference }
        	</fo:block>
        </g:if>
        <g:if test="${ facture.commentaire }">
        	<fo:block font-size="10pt" font-weight="bold" font-style="italic" space-before="4pt">
        		${ facture.commentaire }
        	</fo:block>
        </g:if>
        
        
        <fo:block-container border-bottom="${ brandBorder }" space-before="8pt">
        <fo:table table-layout="fixed" width="100%" font-size="10pt">
            <fo:table-column column-number="1" column-width="8cm"/>
            <fo:table-column column-number="2" column-width="1.5cm"/>
            <fo:table-column column-number="3" column-width="2cm"/>
            <fo:table-column column-number="4" column-width="3cm"/>
            <fo:table-column column-number="5" column-width="3cm"/>
            <fo:table-column column-number="6" column-width="1.5cm"/>
            
            <fo:table-header>
            	<fo:table-row background-color="${ brandColor }" color="white" font-weight="bold"> 
                    <fo:table-cell padding="4pt">
                    	<fo:block text-align="left">
                    		Article
                    	</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="4pt">
                    	<fo:block text-align="center">
                    		Qté
                    	</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="4pt">
                    	<fo:block text-align="left">
                    		Unité
                    	</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="4pt">
                    	<fo:block text-align="center">
                    		PU HT
                    	</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="4pt">
                    	<fo:block text-align="center">
                    		Montant HT
                    	</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="4pt">
                    	<fo:block text-align="center">
                    		TVA
                    	</fo:block>
                    </fo:table-cell>
            	</fo:table-row>
            </fo:table-header>
            
            <fo:table-body>
            	<g:each var="farticle" in="${ facture.articles.sort { it.ordre } }">
	                <fo:table-row> 
	                    <fo:table-cell padding="8pt 4pt">
	                    	<fo:block>
	                    		${ farticle.codeArticle } - ${ farticle.libelle }
	                    	</fo:block>
	                    	<g:if test="${ farticle.commentaire }">
	                    		<fo:block font-size="8pt" font-style="italic" margin-left="0.5cm" space-before="4pt">
		                    		${ farticle.commentaire }
		                    	</fo:block>
	                    	</g:if>
	                    </fo:table-cell>
	                    <fo:table-cell padding="8pt 4pt">
	                    	<fo:block text-align="right">
	                    		${ app.format2Decimal(number: farticle.quantite) }
	                    	</fo:block>
	                    </fo:table-cell>
	                    <fo:table-cell padding="8pt 4pt">
	                    	<fo:block>
	                    		${ farticle.unite }
	                    	</fo:block>
	                    </fo:table-cell>
	                    <fo:table-cell padding="8pt 4pt">
	                    	<fo:block text-align="right">
	                    		${ app.format2Decimal(number: farticle.prixHT) }€
	                    	</fo:block>
	                    </fo:table-cell>
	                    <fo:table-cell padding="8pt 4pt">
	                    	<fo:block text-align="right">
	                    		${ app.format2Decimal(number: farticle.totalHT()) }€
	                    	</fo:block>
	                    </fo:table-cell>
	                    <fo:table-cell padding="8pt 4pt">
	                    	<fo:block text-align="right">
	                    		${ app.formatInt(number: farticle.tauxTVA) }%
	                    	</fo:block>
	                    </fo:table-cell>
	            	</fo:table-row>
            	</g:each>
            	
            	<fo:table-row> 
                    <fo:table-cell padding="8pt 4pt">
                    	<fo:block>
                    		
                    	</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="8pt 4pt">
                    	<fo:block text-align="right">
                    		
                    	</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="8pt 4pt">
                    	<fo:block>
                    		
                    	</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="8pt 4pt">
                    	<fo:block text-align="right">
                    		
                    	</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="8pt 4pt">
                    	<fo:block text-align="right">
                    		
                    	</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="8pt 4pt">
                    	<fo:block text-align="right">
                    		
                    	</fo:block>
                    </fo:table-cell>
            	</fo:table-row>
            	
            </fo:table-body>
        </fo:table>
        </fo:block-container>
        
        
        <fo:table table-layout="fixed" width="100%" space-before="8pt" font-size="10pt">
            <fo:table-column column-number="1" column-width="10cm"/>
            <fo:table-column column-number="2" column-width="2cm"/>
            <fo:table-column column-number="3" column-width="7cm"/>
			
			<fo:table-body>
                <fo:table-row> 
                    <fo:table-cell>
                    	<fo:table table-layout="fixed" width="100%">
            				<fo:table-column column-number="1" column-width="2cm"/>
            				<fo:table-column column-number="2" column-width="4cm"/>
            				<fo:table-column column-number="3" column-width="4cm"/>
            				<fo:table-body>
            					<fo:table-row>
            						<fo:table-cell padding="4pt 4pt" background-color="${ brandColor }" number-columns-spanned="3">
            							<fo:block font-weight="bold" color="white">
            								Détail de la TVA
            							</fo:block>
            						</fo:table-cell>
            					</fo:table-row>
            					<fo:table-row font-size="8pt">
            						<fo:table-cell padding="4pt 4pt">
            							<fo:block font-weight="bold">
            								Taux
            							</fo:block>
            						</fo:table-cell>
            						<fo:table-cell padding="4pt 4pt">
            							<fo:block font-weight="bold" text-align="center">
            								Base HT
            							</fo:block>
            						</fo:table-cell>
            						<fo:table-cell padding="4pt 4pt">
            							<fo:block font-weight="bold" text-align="center">
            								Montant TVA
            							</fo:block>
            						</fo:table-cell>
            					</fo:table-row>
            				</fo:table-body>
            			</fo:table>
            			
                    	<fo:table table-layout="fixed" width="100%" space-before="10pt">
            				<fo:table-column column-number="1" column-width="40%"/>
            				<fo:table-column column-number="2" column-width="60%"/>
            				<fo:table-body>
            					<fo:table-row>
            						<fo:table-cell padding="4pt 4pt" background-color="${ brandColor }">
            							<fo:block  font-weight="bold" color="white">
            								Règlement
            							</fo:block>
            						</fo:table-cell>
            						<fo:table-cell padding="4pt 4pt">
            							<fo:block>
            								${ facture.modeReglement.libelle }
            							</fo:block>
            						</fo:table-cell>
            					</fo:table-row>
            					<fo:table-row>
            						<fo:table-cell padding="4pt 4pt" background-color="${ brandColor }">
            							<fo:block  font-weight="bold" color="white">
            								Echéance
            							</fo:block>
            						</fo:table-cell>
            						<fo:table-cell padding="4pt 4pt">
            							<fo:block>
            								${ app.format2Decimal(number: facture.totalTTC()) }€ au ${ app.formatUser(date: facture.dateEcheance) }
            							</fo:block>
            						</fo:table-cell>
            					</fo:table-row>
            				</fo:table-body>
            			</fo:table>
            			
            			<fo:table table-layout="fixed" width="100%" space-before="10pt">
            				<fo:table-column column-number="1" column-width="2.5cm"/>
            				<fo:table-column column-number="2" column-width="7.5cm"/>
            				<fo:table-body>
            					<fo:table-row>
            						<fo:table-cell padding="4pt 4pt" background-color="${ brandColor }" number-columns-spanned="2">
            							<fo:block  font-weight="bold" color="white">
            								Coordonnées bancaires
            							</fo:block>
            						</fo:table-cell>
            					</fo:table-row>
            					<fo:table-row font-size="8pt">
            						<fo:table-cell padding="4pt 4pt">
            							<fo:block font-weight="bold">
            								Nom
            							</fo:block>
            						</fo:table-cell>
            						<fo:table-cell padding="4pt 4pt">
            							<fo:block>
            								
            							</fo:block>
            						</fo:table-cell>
            					</fo:table-row>
            					<fo:table-row font-size="8pt">
            						<fo:table-cell padding="4pt 4pt">
            							<fo:block font-weight="bold">
            								IBAN
            							</fo:block>
            						</fo:table-cell>
            						<fo:table-cell padding="4pt 4pt">
            							<fo:block>
            								
            							</fo:block>
            						</fo:table-cell>
            					</fo:table-row>
            					<fo:table-row font-size="8pt">
            						<fo:table-cell padding="4pt 4pt">
            							<fo:block font-weight="bold">
            								BIC
            							</fo:block>
            						</fo:table-cell>
            						<fo:table-cell padding="4pt 4pt">
            							<fo:block>
            								
            							</fo:block>
            						</fo:table-cell>
            					</fo:table-row>
            				</fo:table-body>
            			</fo:table>
                    	
                    </fo:table-cell>
                    <fo:table-cell>
                    	<fo:block>
                    	</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                    	<fo:table table-layout="fixed" width="100%">
            				<fo:table-column column-number="1" column-width="40%"/>
            				<fo:table-column column-number="2" column-width="60%"/>
            				<fo:table-body>
            					<fo:table-row>
            						<fo:table-cell padding="4pt 4pt" background-color="${ lightgreyColor }">
            							<fo:block >
            								Total HT
            							</fo:block>
            						</fo:table-cell>
            						<fo:table-cell padding="4pt 4pt" background-color="${ lightgreyColor }">
            							<fo:block text-align="right">
            								${ app.format2Decimal(number: facture.totalHT) }€
            							</fo:block>
            						</fo:table-cell>
            					</fo:table-row>
            					<fo:table-row>
            						<fo:table-cell padding="4pt 4pt">
            							<fo:block>
            								TVA
            							</fo:block>
            						</fo:table-cell>
            						<fo:table-cell padding="4pt 4pt">
            							<fo:block text-align="right">
            								${ app.format2Decimal(number: facture.totalTVA) }€
            							</fo:block>
            						</fo:table-cell>
            					</fo:table-row>
            					<fo:table-row>
            						<fo:table-cell padding="4pt 4pt">
            							<fo:block font-weight="bold" color="${ brandColor }">
            								Total TTC
            							</fo:block>
            						</fo:table-cell>
            						<fo:table-cell padding="4pt 4pt">
            							<fo:block font-weight="bold" color="${ brandColor }" text-align="right">
            								${ app.format2Decimal(number: facture.totalTTC()) }€
            							</fo:block>
            						</fo:table-cell>
            					</fo:table-row>
            				</fo:table-body>
            			</fo:table>
                    </fo:table-cell>
				</fo:table-row> 
			</fo:table-body>
		</fo:table>
		
		
		<fo:block font-size="6pt" space-before="1cm">
			Accepte le règlement des sommes dues par chèques libellés à mon nom, en ma qualité de membre d'un 
			Centre de Gestion Agréé par l'Administration Fiscale.
		</fo:block>
		<fo:block font-size="6pt" space-before="4pt">
			Pas d'escompte pour règlement anticipé. En cas de retard de paiement, une pénalité égale à 3 fois 
			le taux intérêt légal sera exigible (Article L 441-6, alinéa 12 du Code de Commerce).
		</fo:block>
		<fo:block font-size="6pt" space-before="4pt">
			Pour tout professionnel, en sus des indemnités de retard, toute somme, y compris l'acompte, non payée
			à sa date d'exigibilité produira de plein droit le paiement d'une indemnité forfaitaire de 40 euros due
			 au titre des frais de recouvrement (Art. 441-6, I al. 12 du code de commerce et D. 441-5 ibidem).
		</fo:block>
		
		
    </content>
</g:applyLayout>