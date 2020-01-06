<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:fox="http://xmlgraphics.apache.org/fop/extensions" font-family="Ubuntu" color="#172b4d">

<!-- PAGINATION -->
<fo:layout-master-set>
    <fo:simple-page-master master-name="page1" page-height="29.7cm" page-width="21cm" margin-top="0.5cm" margin-bottom="0.5cm" margin-left="1cm" margin-right="1cm">
        <fo:region-body margin-top="4.5cm" margin-bottom="2cm"/>
        <fo:region-before extent="4cm"/>
        <fo:region-after extent="1.5cm"/>
    </fo:simple-page-master>
</fo:layout-master-set>


<g:set var="labelColor" value="#414b4c"></g:set>
<g:set var="brandColor" value="#008a2e"></g:set>
<g:set var="brandBorder" value="1px solid ${ brandColor }"></g:set>

<!-- MISE EN PAGE -->
<fo:page-sequence master-reference="page1" initial-page-number="1" color="${ labelColor }">


    <!-- EN-TETE -->
    <fo:static-content flow-name="xsl-region-before">
    	
	    	<fo:table table-layout="fixed" width="100%">
	            <fo:table-column column-number="1" column-width="70%"/>
	            <fo:table-column column-number="2" column-width="30%"/>
	            <fo:table-body>
	                <fo:table-row> 
	                    <fo:table-cell>
	                    	<fo:block>
	                            <fo:external-graphic src="url('${report.baseURL}/assets/logo-eta-color.png')" content-height="2.5cm"/>
	                        </fo:block>
	                        
	                        <fo:block font-size="10pt" space-before="4pt">
	                            Kerollaire - 56440 LANGUIDIC
	                        </fo:block>
	                        <fo:block font-size="10pt" space-before="4pt">
	                            Email : eta.guyot@hotmail.com
	                        </fo:block>
	                    </fo:table-cell>
	                    <fo:table-cell>
	                    	<fo:block padding-top="0.25cm">
	                        	<g:pageProperty name="page.contentHeader"/>
	                        </fo:block>
	                    </fo:table-cell>
	                </fo:table-row>
	            </fo:table-body>
	        </fo:table>
    </fo:static-content>



    <!-- PIED-DE-PAGE -->
    <fo:static-content flow-name="xsl-region-after">
    	<fo:block font-size="8pt" text-align="center" border-top="${ brandBorder }" padding-top="4pt">
            ETA GUYOT - KEROLLAIRE - 56440 LANGUIDIC - Tel : 06.87.63.20.82 - Email : eta.guyot@hotmail.com
        </fo:block>
        
    	<fo:block font-size="8pt" text-align="center" space-before="2pt">
            SIRET : 51073665500018 - N° TVA : FR14510736655 - N° APE : 0161Z 
        </fo:block>

        <fo:block font-size="8pt" text-align="center" space-before="2pt">
            Page <fo:page-number/> sur <fo:page-number-citation ref-id="end_of_document"/>
        </fo:block>
    </fo:static-content>



    <!-- CORPS PRINCIPAL -->
    <fo:flow flow-name="xsl-region-body" font-size="${ pageProperty(name: 'page.bodyfontsize', default: '12pt') }">
        <g:pageProperty name="page.body"/>

        <!-- ne pas supprimer pour conserver la pagination -->
        <fo:block id="end_of_document"></fo:block>
    </fo:flow>

</fo:page-sequence>

</fo:root>
