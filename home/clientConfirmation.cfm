<!--- see if ther is any item in the cart--->
<cfparam name="session.Cart" default="#StructNew()#">
<cfif StructIsEmpty(session.cart) or not isdefined("session.cart.leadprice")>
	<cflocation url="/index.cfm?area=home&action=cartemptywarning" addtoken="no" >	
</cfif>


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
				
				<div class="row">
					<div class="col-md-8">
						<h1 class="page-title margin-top-clear">Client Details Confirmation</h1>
					</div>
					<div class="col-md-4">
						<cfinclude template="help-button.cfm">
					</div>
				</div>
				<!-- page-title end -->
				<div class="space"></div>
				
				<!---Progress Bar--->
				<cfset currentStep = 2>
				<cfinclude template="progressbar.cfm">
				
				<cfparam name="url.previousAction" default="" >
				
				<cfif url.previousAction eq "Insert">
					<div class="alert alert-success" role="alert">
					 You account set up has been successfull.
					</div>
				</cfif>
				<cfif url.previousAction eq "Update">
					<div class="alert alert-success" role="alert">
					 You account has been successfully updated.
					</div>
				</cfif>
				<div class="row">
                  	<div class="col-md-12">   
					<p>Please review your details carefully to confirm all information is correct, 
				and then press "Next Step" to payment options. To make any changes, please press Go Back  to Client Info.</p>
					</div>
				</div>
				<div class="space"></div>
				
				
				
				<!--- billing info--->
				<cfinclude template="clientinforeadonly.cfm">
				
				
				
							
				<cfoutput>
				<div class="row">
					<div class="text-left col-md-6">
					
						<a href="index.cfm?area=home&action=cart&leadtype=#session.cart.priceoption#" class="btn btn-group btn-default btn-sm"><i class="icon-left-open-big"></i> Go Back To Cart</a>
					
						<a href="index.cfm?area=home&action=clientinfo&leadtype=#session.cart.priceoption#" class="btn btn-group btn-default btn-sm"><i class="icon-left-open-big"></i> Go Back To Client Info</a>
					
						
					
					</div>
					
					<div class="text-right col-md-6">
						
						
						<a href="index.cfm?area=home&action=paymentOption&leadtype=#session.cart.priceoption#" class="btn btn-group btn-default btn-sm"> Next Step <i class="icon-right-open-big"></i></a>
					
						
					
					</div>
					
				</div>	
				
				</cfoutput>	

				
			
				

</div>
			<!-- main end -->

		</div>
	</div>
</section>
<!-- main-container end -->


