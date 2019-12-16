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
	
		<asset:stylesheet src="login-v1.css"/>
	    <asset:stylesheet src="application.css"/>
	
	    <g:layoutHead/>
	</head>
	<!-- end::Head -->

	<!-- begin::Body -->
	<body id="body-login-v1" class="kt-login-v1--enabled kt-quick-panel--right kt-demo-panel--right kt-offcanvas-panel--right kt-header--fixed kt-header-mobile--fixed kt-subheader--fixed kt-subheader-mobile--fixed kt-aside--enabled kt-aside--left kt-aside--fixed kt-aside--offcanvas-default kt-page--loading">

		<!-- begin:: Page -->
		<div class="kt-grid kt-grid--ver kt-grid--root">
			<div class="kt-grid__item  kt-grid__item--fluid kt-grid kt-grid--hor kt-login-v1" id="kt_login_v1">

				<!--begin::Item-->
				<div class="kt-grid__item">

					<!--begin::Heade-->
					<div class="kt-login-v1__head">
						<div class="kt-login-v1__logo">
							<g:link uri="/">
								<asset:image src="logo-eta-color.png" />
							</g:link>
						</div>
						<div class="kt-login-v1__signup">
							<h4 class="kt-login-v1__heading">Vous n'avez pas de compte ?</h4>
							<a href="#" style="color:white;">Créer</a>
						</div>
					</div>

					<!--begin::Head-->
				</div>

				<!--end::Item-->

				<g:if test="${ session.SPRING_SECURITY_LAST_EXCEPTION }">
					<div class="ml-4 mr-4">
						<g:applyLayout name="error" model="[error: session.SPRING_SECURITY_LAST_EXCEPTION.message]"/>
					</div>
				</g:if>

				<!--begin::Item-->
				<div class="kt-grid__item  kt-grid kt-grid--ver  kt-grid__item--fluid">
					<!--begin::Body-->
					<div class="kt-login-v1__body">

						<!--begin::Section-->
						<div class="kt-login-v1__section">
							<div class="kt-login-v1__info">
								<h3 class="kt-login-v1__intro" style="font-weight:bold; color:#008a2e">LOGICIEL DE FACTURATION</h3>
								<div class="kt-login-v1__divider">
									<div class="kt-divider">
										<span></span>
									</div>
								</div>
								<p style="font-weight:bold; color:#fce80d; font-size:medium">ENTREPRISE ETA GUYOT</p>
							</div>
						</div>

						<!--begin::Section-->

						<!--begin::Separator-->
						<div class="kt-login-v1__seaprator"></div>

						<!--end::Separator-->

						<!--begin::Wrapper-->
						<div class="kt-login-v1__wrapper">
							<div class="kt-login-v1__container">
								<h3 class="kt-login-v1__title" style="color:white; font-weight:bold;">
									Saisir vos identifiants
								</h3>
								
								<!--begin::Form-->
								<form class="kt-login-v1__form kt-form" action="${postUrl}" autocomplete="off" id="kt_login_form" method="post">
									<g:layoutBody/>
								</form>

								<!--end::Form-->
							</div>
						</div>

						<!--end::Wrapper-->
					</div>

					<!--begin::Body-->
				</div>

				<!--end::Item-->

				<!--begin::Item-->
				<div class="kt-grid__item">
					<div class="kt-login-v1__footer">
						<div class="kt-login-v1__menu">
							<a href="mailto:gregory.elleouet@gmail.com" style="color:white; font-weight:bold;">Contact</a>
						</div>
						<div class="kt-login-v1__copyright">
							<a href="#" style="color:white; font-weight:bold;">&copy; 2019 EURL ELLEOUET GREGORY</a>
						</div>
					</div>
				</div>

				<!--end::Item-->
			</div>
		</div>

		<!-- end:: Page -->

		</div>

		<!-- end:: Aside -->
		<asset:javascript src="application.js"/>
	</body>

	<!-- end::Body -->
</html>