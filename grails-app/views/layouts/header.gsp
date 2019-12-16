<!-- begin:: Header -->
<div id="kt_header" class="kt-header kt-grid__item kt-grid kt-grid--ver  kt-header--fixed " >
	<!-- begin:: Brand -->
	<div class="kt-header__brand   kt-grid__item" id="kt_header_brand">
		<g:link uri="/">
			<asset:image src="logo-eta-white.png"/>
		</g:link>
	</div>
	<!-- end:: Brand -->
	
	<!-- begin: Header Menu -->
	<button class="kt-header-menu-wrapper-close" id="kt_header_menu_mobile_close_btn"><i class="la la-close"></i></button>
	<div class="kt-header-menu-wrapper kt-grid__item" id="kt_header_menu_wrapper">
	    <div id="kt_header_menu" class="kt-header-menu kt-header-menu-mobile "  >
	        <ul class="kt-menu__nav ">
	            <li class="kt-menu__item ">
	            	<g:link controller="client" class="kt-menu__link">
	            		<span class="kt-menu__link-text"><i class="fa fa-address-card fa-lg"></i>&nbsp;&nbsp;Clients</span>
	            	</g:link>
				</li>
	            <li class="kt-menu__item ">
	            	<g:link controller="produit" class="kt-menu__link">
	            		<span class="kt-menu__link-text"><i class="fab fa-product-hunt fa-lg"></i>&nbsp;&nbsp;Produits</span>
	            	</g:link>
				</li>
	            <li class="kt-menu__item ">
	            	<g:link controller="devis" class="kt-menu__link disabled">
	            		<span class="kt-menu__link-text"><i class="fa fa-file-invoice fa-lg"></i>&nbsp;&nbsp;Devis</span>
	            	</g:link>
				</li>
				<li class="kt-menu__item ">
	            	<g:link controller="facture" class="kt-menu__link">
	            		<span class="kt-menu__link-text"><i class="fa fa-file-invoice-dollar fa-lg"></i>&nbsp;&nbsp;Factures</span>
	            	</g:link>
				</li>
	            <li class="kt-menu__item ">
	            	<g:link controller="reglement" class="kt-menu__link">
	            		<span class="kt-menu__link-text"><i class="fa fa-money-check-alt fa-lg"></i>&nbsp;&nbsp;Règlements</span>
	            	</g:link>
				</li>
			</ul>
	    </div>
	</div>
	<!-- end: Header Menu -->	

	<!-- begin:: Header Topbar -->
	<div class="kt-header__topbar kt-grid__item kt-grid__item--fluid">
	
		<div class="kt-header__topbar-item kt-header__topbar-item--user">
			<div class="kt-header__topbar-wrapper">
				<div class="kt-header__topbar-username">
					<g:form class="form-inline" action="globalSearch" controller="dashboard" metthod="post">
						<div class="kt-input-icon kt-input-icon--left">
							<g:textField class="form-control" name="value" placeholder="Rechercher..." required="true"/>
							<span class="kt-input-icon__icon kt-input-icon__icon--left">
								<span><i class="la la-search"></i></span>
							</span>
						</div>
					</g:form>
				</div>
			</div>
		</div>
	
	
		<!--begin: User bar -->
		<div class="kt-header__topbar-item kt-header__topbar-item--user">
			<div class="kt-header__topbar-username">
				<sec:username/>
			</div>
			<div class="kt-header__topbar-wrapper" data-toggle="dropdown">
				<span class="kt-header__topbar-icon">
					<asset:image src="user-default.jpg"/>
				</span>
			</div>
			<div class="dropdown-menu dropdown-menu-fit dropdown-menu-right dropdown-menu-anim dropdown-menu-top-unround">
				<ul class="kt-nav kt-margin-t-10 kt-margin-b-10">
					<li class="kt-nav__item kt-nav__item--active">
						<g:link uri="/logoff" class="kt-nav__link">
							<span class="kt-nav__link-icon"><i class="fa fa-user-lock"></i></span>
							<span class="kt-nav__link-text">Déconnecter</span>
						</g:link>
					</li>
				</ul>
			</div>
		</div>
		<!--end: User bar -->		
	</div>
	<!-- end:: Header Topbar -->
</div>
<!-- end:: Header -->