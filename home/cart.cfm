

<!-- main-container start -->
<!-- ================ -->
<section class="main-container">

	<div class="container">
		<div class="row">

			<!-- main start -->
			<!-- ================ -->
			<div class="main col-md-12">

				<!-- page-title start -->
				<!-- ================ -->
				<h1 class="page-title margin-top-clear">Shopping Cart</h1>
				<!-- page-title end -->
				<div class="space"></div>
				
			



				
				<cfinclude template="cartreadonly.cfm">

						
					
				

				
					<cfoutput>
					<div class="row">
					<div class="text-left col-md-6">
						<a href="index.cfm?area=home&action=product&leadproductid=#session.cart.LeadProductID#&leadtype=#session.cart.priceoption#" class="btn btn-group btn-default btn-sm"><i class="icon-left-open-big"></i> Go Back To Order Details</a>
					</div>
					
					<div class="text-right col-md-6">
					
					
					
						<cfif session.profile.IsLoggedIn eq true>
							<a href="index.cfm?area=home&action=clientConfirmation&leadtype=#session.cart.priceoption#" class="btn btn-group btn-default btn-sm">Checkout</a>							
						<cfelse>
							<a href="index.cfm?area=home&action=loginorSignin&leadtype=#session.cart.priceoption#" class="btn btn-group btn-default btn-sm">Checkout</a>							
						</cfif>
						
					</button>
					</div>
					
				</div>
					
					
					</cfoutput>
		
				
				
			








</div>
			<!-- main end -->

		</div>
	</div>
</section>
<!-- main-container end -->