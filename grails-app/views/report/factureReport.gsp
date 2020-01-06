<%@ page contentType="application/xml" %>
<%@ page defaultCodec="xml" %>

<g:set var="labelColor" value="#414b4c"></g:set>
<g:set var="brandColor" value="#008a2e"></g:set>
<g:set var="brandBorder" value="1px solid ${ brandColor }"></g:set>
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
    
    	<fo:block-container absolute-position="absolute" top="-0.5cm" left="8cm" width="10cm" height="3.5cm" border="${ brandBorder }"
    		fox:border-radius="4pt" padding="12pt">
    		<fo:block font-size="14pt" font-weight="bold" color="${ brandColor }" padding-before="10pt" text-transform="uppercase">
           		${ facture.client.raisonSociale }
    		</fo:block>
    		<fo:block font-size="12pt" space-before="4pt">
           		${ facture.client.adresse }
    		</fo:block>
    		<fo:block font-size="12pt" space-before="4pt">
           		${ facture.client.codePostal } - ${ facture.client.ville }
    		</fo:block>
    	</fo:block-container>
    	
    
        <fo:block font-size="12pt" space-before="5cm">
        	
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
        
        
        <fo:block height.minimum="10cm" border-bottom="${ brandBorder }">
        <fo:table table-layout="fixed" width="100%" space-before="8pt" font-size="10pt" height.minimum="10cm">
            <fo:table-column column-number="1" column-width="8cm"/>
            <fo:table-column column-number="2" column-width="1.5cm"/>
            <fo:table-column column-number="3" column-width="1.5cm"/>
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
            </fo:table-body>
        </fo:table>
        </fo:block>


    </content>
</g:applyLayout>