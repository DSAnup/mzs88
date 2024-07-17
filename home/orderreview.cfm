
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
						<h1 class="page-title margin-top-clear">Review Order & Accept Terms</h1>
					</div>
					<div class="col-md-4">
						<cfinclude template="help-button.cfm">
					</div>
				</div>
				<!-- page-title end -->
				<div class="space"></div>
				
				<!---Progress Bar--->
				<cfset currentStep = 4>
				<cfinclude template="progressbar.cfm">
				<div class="row">
                  	<div class="col-md-12">
					<p>A composed view of your order appears below along with your details.
				Please review this page carefully to confirm all information is correct, 
				and then accept the terms of our services and press "Complete Order".</p>
					</div>
				</div>
				<div class="space"></div>
				
				

				<!--- cart--->
				<cfinclude template="cartreadonly.cfm">
	<!---			promocodefile--->
				<cfinclude template="promocodefile.cfm">
				<!--- shipping info--->
				<cfinclude template="clientinforeadonly.cfm">
				
				
				<!--- payment option --->
				<table class="table table-striped">
					<thead>
						<tr>
							<th colspan="2">Payment Information</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Payment Method</td>
							<td class="information"><cfoutput>#session.cart.PaymentOption#</cfoutput></td>
						</tr>
						
					</tbody>
				</table>
				
				
				<!--- terms--->
				<table class="table table-striped">
					<thead>
						<tr>
							<th >Accept Terms of Service </th>
						</tr>
					</thead>
					<tbody>
						
						<tr>
							<td>
							 <p><strong>Terms of service must be accepted before the order can be completed.</strong></p>
<!-- Trigger the modal with a button -->
<button type="button" class="btn btn-info btn-lg pp-button" data-toggle="modal" data-target="#myModal">Click here to read Terms of Service Agreement</button>

<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Terms of Service Agreement</h4>
      </div>
      <div class="modal-body">
<div class="terms-and-service" id="privaceytext">

					<h1>Terms of Service Agreement</h1>
					<h2>1. USAGE OF LEADS</h2>
					<p>The end use of the leads provided by Godspeed Marketing (Provider) is solely the responsibility
					of Client. Client must follow TCPA regulations, and all other applicable regulations and laws with
					regards to the usage of leads, and any methods of usage by Client. If for any reason(s) the
					leads are used unlawfully; Provider will not in any way be responsible, legally or otherwise.
					Godspeed Marketing shall not be responsible for, or incur any liability, as a result of delays or
					failures in the delivery of any leads, in schedules or in performance of its services in the event of
					any act or occurrence beyond Godspeed Marketing’s reasonable control. Leads sent to the e-mail address provided by you, 
					until we have received notice of any different e-mail address, be deemed to have been delivered to you whether actually 
					received or not. Leads are calculated by what has been sent from our system via email. As different email clients and web 
					hosting companies have different levels of spam filtering, we will not be held responsible for leads that are sent successfully 
					by our system but rejected or filtered to spam/junk folders by your email provider.</p>

					<h2>2. REPLACEMENTS</h2>
					<p>Replacements are only provided on Fresh file leads only. For any concern regarding quality, simply send the file as you received it by Provider to Quality
					Control Department within 24 hours of receiving the file from Provider. Along with the original
					file, attach your dialer disposition report that clearly marks which records are of concern, and
					make sure all dispositions are easily understood by our Quality Control team. Any leads that
					need to be replaced will be replaced with your next order. Any leads that are in fact fine, instead
					of receiving a replacement, you will receive the audio from the applicant/lead in question back
					from our QC indicating why the lead is in fact quality. QC is contacted at
					<a href="mailto:QC@godspeedcorp.com">QC@godspeedcorp.com</a>. Provider policy is replacement of all disconnected and not-in-service records timestamped for
					24 hours or less from date of record creation. For any and all replacements we require a period
					of time to review every disposition report. Following this time period we reserve the right to
					review all leads in question. It is in Provider’s discretion to decide to replace a lead, if any
					whatsoever. In the event that no leads will be replaced a report will follow detailing the reasons
					behind the decision.</p>

					<h2>3. TESTS</h2>
					<p>All test must be paid in full prior to receiving any “test” lead files. It is Provider’s policy not to
					fulfill any “free” lead test files. The smallest minimum order that Provider allows is 100 records
					per test. Provider cannot fulfill smaller orders. As statistically, results of tests will be skewed
					negatively with less records to contact and we prefer only successful tests.</p>

					<h2>4. PAYMENT</h2>
					<p>Payment for leads must be delivered in full prior to receiving lead files. There is an option to set up pre-payment terms. 
					Paying for the week provides delivery of files prior to post-payment Customers. Payments received after 5 pm Friday for lead 
					fulfillment the following week, are not guaranteed lead fulfillment, as Provider may have sold out of leads from prepaid orders. 
					
					The Bank only accepts wire deposits with a check from customers that place the order. Any other name or money orders will be returned. 
					We do accept Bank Wires to our US Bank, Bit pay, Indian Bank Pay Cash Deposit and Instant transfers (MPS) No Neft.</p>

					<h2>5. REFUNDS</h2>
					<p>Provider provides no refunds under any circumstance. If Customer makes a payment and is not
					delivered leads as fulfillment for payment made, Customer may use this payment for fulfillment
					of future orders, at Providers discretion.</p>

					<h2>6. FRAUD</h2>
					<p>If Provider suspects Customer of engaging in fraud, Customer will be banned and blocked from
					doing business with Provider, Provider’s websites and Provider’s staff. No refund will be given to
					Customer if they have credit for leads with Provider. If Customer engages Provider with
					aggressive or threatening language, or makes any negative remark publically about Provider,
					Provider will not offer a refund for any credit Customer may have for leads.</p>

					<h2>7. ACCEPTING THE TERMS</h2>
					<p>Sale  By purchasing the leads you are agreeing to use them for debt settlement, debt consolidation, and/or credit repair.</p>
					
					<h2>8. TERMINATION OF WORKING RELATIONSHIP</h2>
					<p>It is in Provider’s best interest to have a working relationship with all clients that are satisfactory
					for both parties. If for a reason(s) the relationship is no longer satisfactory both parties reserve
					the right to end the working relationship without any notice. However, it is in the best interest for
					both parties to explain the reasoning for the termination.</p>

</div>

                                               
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>							 
				
							</td>
						</tr>
						
						<tr>
							<td>
								<input type="checkbox" id="termsconfirm"  onclick="check()" />
								<p  id="checkterms" class="checkterms">Please check here to accept the terms of our service above.</p>
							</td>
						</tr>
						
						
					</tbody>
				</table>
							
				
				<div class="row">
					<div class="text-left col-md-6">
					<cfoutput>
						<a href="index.cfm?area=home&action=cart&leadtype=#session.cart.priceoption#" class="btn btn-group btn-default btn-sm"><i class="icon-left-open-big"></i> Go Back To Cart</a>
					
						<a href="index.cfm?area=home&action=clientinfo&leadtype=#session.cart.priceoption#" class="btn btn-group btn-default btn-sm"><i class="icon-left-open-big"></i> Go Back Client Info</a>
						
						<a href="index.cfm?area=home&action=paymentOption&leadtype=#session.cart.priceoption#" class="btn btn-group btn-default btn-sm"><i class="icon-left-open-big"></i> Go Back Payment Info</a>
					</cfoutput>
						
					
					</div>
					
					<div class="text-right col-md-6" title="Terms of service must be accepted before the order can be completed.">
						<form action="/partialIndex.cfm?area=home&action=orderreviewaction" target="formpost" method="post" style="margin-top:0;" onsubmit=" $('#confirmButton').prop('disabled', true); return true;">
						<div class="disabled">
						<button type="submit"    
						id="confirmButton"  
						class="btn btn-group btn-default btn-sm">Complete Order <i class="icon-check"></i>
						</button>
						</div>	
						</form>				
					</div>
					
				</div>		

				<div class="text-right">	
				
					
					
					
					
					
				</div>
			
				

</div>
			<!-- main end -->

		</div>
	</div>
</section>
<!-- main-container end -->


