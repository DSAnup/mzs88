


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
						<h1 class="page-title margin-top-clear">Order Confirmation #<cfoutput>#listFirst(url.LeadOrderID)#</cfoutput></h1>
					</div>
					<div class="col-md-4">
						<cfinclude template="help-button.cfm">
					</div>
				</div>
				<!-- page-title end -->
				<div class="space"></div>
				
				<!---Progress Bar--->
				<cfset currentStep = 5>
				<cfinclude template="progressbar.cfm">
				<div class="row">
                  	<div class="col-md-12">
					
					
							<p class="lead text-left">
								
								
				
							Your order confirmation number is: <cfoutput><b>#listFirst(url.LeadOrderID)#</b>.</cfoutput>
							<br /><br />
							
							<cfoutput>
							You have ordered <strong>#listgetat(url.LeadOrderID, 2)# (#listgetat(url.LeadOrderID, 5)#)</strong>.
							You have ordered #listgetat(url.LeadOrderID, 3)# leads per day for
							
							<cfif listgetat(url.LeadOrderID, 4) lt 5>
								#listgetat(url.LeadOrderID, 4)# day(s).								
							<cfelse>
								#listgetat(url.LeadOrderID, 4) / 5# week(s).
							</cfif>
							
							</cfoutput>
							
							
							
							<br /><br />
							We have sent you an email with your order details.
							<cfif listLast(url.LeadOrderID) eq "New">
								Your order is currently being reviewed.  Once the review is complete, we will send you
								an invoice with detail payment instructions to your email.
							<cfelse>
								We have also sent you an invoice with detail payment instructions with the order confirmation. 					
							</cfif>
							<br /><br />
												
							Once payments are made you will need to send proof of payment 
							to the skype address of: live:c5271fa1894a9b3  prior to receiving any lead files.					
							<br /><br />
							
							Please add our email address leads@godspeedcorp.com to your email address book to 
							ensure our emails with your lead files end up in your inbox every time we send them.
							
							<br /><br />
							
							
							If you have any questions concerning your order, please contact us.
							
							<br /><br />
			
			
			  Thank you for your purchase.
							
							
							</p>
							<div class="text-center"><a href="/" class="btn btn-lg btn-default">Continue Shopping</a></div>
								
					
					
					
					
					</div>
				
				
				
				</div>
				
				
				
				
				
					
				
				
			
				

</div>
			<!-- main end -->

		</div>
	</div>
</section>
<!-- main-container end -->


