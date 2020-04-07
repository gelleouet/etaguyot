<!doctype html>
<html lang="fr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="ETA GUYOT"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>

	<script src="https://ajax.googleapis.com/ajax/libs/webfont/1.6.16/webfont.js"></script>
    <script>
        WebFont.load({
            google: {"families":["Poppins:300,400,500,600,700","Raleway:300,400,500,600,700"]},
            active: function() {
                sessionStorage.fonts = true;
            }
        });
    </script>

    <asset:stylesheet src="application.css"/>

    <g:layoutHead/>
</head>

<body class="kt-quick-panel--right kt-demo-panel--right kt-offcanvas-panel--right kt-header--fixed kt-header-mobile--fixed kt-subheader--fixed kt-subheader-mobile--fixed kt-aside--enabled kt-aside--left kt-aside--fixed kt-aside--offcanvas-default kt-page--loading" 
	data-onload="${pageProperty(name: 'body.data-onload')}">

	<g:applyLayout name="header-mobile"/>

	<div class="kt-grid kt-grid--hor kt-grid--root">
		<div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--ver kt-page">
			<div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor kt-wrapper" id="kt_wrapper">
				
				<g:applyLayout name="header"/>
				
				<div id="kt_subheader" class="kt-subheader kt-grid__item " >
					<div class="kt-container  kt-container--fluid ">
						<!-- begin:: Subheader Title -->
						<div class="kt-subheader__title">
							<g:pageProperty name="page.subheaderTitle"/>
						</div>
						<!-- end:: Subheader Title -->		
						
						<!-- begin:: Sub-header toolbar -->
						<div class="kt-subheader__toolbar">
						    <div class="kt-subheader__toolbar-wrapper">
						    	<g:pageProperty name="page.subheaderToolbar"/>
						    </div>
						</div>
						<!-- end:: Sub-header toolbar -->	
					
					</div> <!-- kt-container -->
				</div> <!-- kt-subheader -->
				
				<div class="kt-content  kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor" id="kt_content">
					<div class="kt-container  kt-grid__item kt-grid__item--fluid">
						<g:applyLayout name="error"/>
						<div id="ajax-error" class="d-none">error</div>
					
						<g:layoutBody/>	
						
						<div id="ajax-dialog"></div>
					</div>
				</div>
				
				<g:applyLayout name="footer"/>
			</div>
		</div>
	</div>
	
	<asset:javascript src="application.js"/>
</body>
</html>
