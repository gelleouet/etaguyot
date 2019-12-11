<!-- begin:: Header -->
<div id="kt_header" class="kt-header kt-grid__item kt-grid kt-grid--ver  kt-header--fixed " >
	<!-- begin:: Brand -->
	<div class="kt-header__brand   kt-grid__item" id="kt_header_brand">
		<g:link uri="/">
			<asset:image src="logo-1.png"/>
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
	            	<g:link controller="devis" class="kt-menu__link">
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
	
		<!--begin: User bar -->
		<div class="kt-header__topbar-item kt-header__topbar-item--user" id="kt_offcanvas_toolbar_profile_toggler_btn">
			<div class="kt-header__topbar-username">
				<sec:loggedInUserInfo field="prenom"/> <sec:loggedInUserInfo field="nom"/>
			</div>
			<div class="kt-header__topbar-wrapper" >
				<asset:image src="user-default.jpg"/>
			</div>
		</div>
		<!--end: User bar -->		
	</div>
	<!-- end:: Header Topbar -->
</div>
<!-- end:: Header -->