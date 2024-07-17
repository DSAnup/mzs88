

<cfset qOrderSelect = createObject('component', 'model.emailService').getOrderDataByClientID(ClientID = #session.profile.client.clientid#)>


<!-- main-container start -->
<!-- ================ -->
<section class="main-container">

	<div class="container">
		<div class="row">

			<!-- main start -->
			<!-- ================ -->
			<div class="main col-md-12">
				
				<!---title and description of the main section title --->

				<!-- page-title start -->
				<!-- ================ -->
				<div class="row">
					<div class="col-md-8">
						<h1 class="page-title">Order History</h1>
					</div>
					<div class="col-md-4">
						<cfinclude template="help-button.cfm">
					</div>
				</div>
				<div class="separator-2"></div>
				<p class="lead">Please find below history of your orders.  You can resend order confirmation or generate invoice from this page.</p>
				<!-- page-title end -->
				
				

					<table class="table cart table-hover table-striped">
					<thead>
						<tr>
							<th>Order ID</th>
							<th>Order Date</th>
							<th>Product </th>							
							<th>Quantity</th>
							<th>Duration</th>
							<th>Status</th>
							<th class="amount">Total </th>
							<th>Confirmation</th>
							<th>Invoice</th>
						</tr>
					</thead>
					<tbody>



						<cfoutput query="qOrderSelect">

							
				
					
					
						
						<tr class="remove-data">
							<td class="product">#qOrderSelect.LeadOrderID#</td>
							<td class="product">#dateformat(qOrderSelect.DateCreated, 'dd-mmm-yyyy')# #timeformat(qOrderSelect.DateCreated, 'hh:mm tt')#</td>
							<td class="product">
								#qOrderSelect.leadProductName#
							</td>
							
							<td class="product">#qOrderSelect.orderQuantity#</td>
							<td class="product">							
							<cfif qOrderSelect.orderDuration lt 5>
								#qOrderSelect.orderDuration#
								<cfif #qOrderSelect.orderDuration# gt 1>
									Days
								<cfelse>
									Day
								</cfif>
							<cfelse>								
								#qOrderSelect.orderDuration / 5#
								<cfif (qOrderSelect.orderDuration / 5) gt 1>
									Weeks
								<cfelse>
									Week
								</cfif>	
							</cfif>									
							</td>
							<td class="product">#qOrderSelect.LEADORDERSTATUSNAME#</td>
							
							<td class="price text-right">
								$#specialNumFormat(qOrderSelect.TotalPrice)#							
							</td>
							<td class="text-center">
								<a href="partialIndex.cfm?area=home&action=orderHistoryConfirmationAction&orderID=#qOrderSelect.LeadOrderID#" target="formpost" style="font-size:22px"> <i class="fa fa-envelope" title="Resend Email Confirmation"></i></a>
								
							</td>
							<td class="text-center">
								<a href="partialIndex.cfm?area=home&action=orderHistoryInvoiceAction&orderID=#qOrderSelect.LeadOrderID#" target="formpost" style="font-size:22px"> <i class="fa fa-file" title="View Invoice and Payment Instructions"></i></a>
								
							</td>
						</tr>						
						
					</cfoutput>					
					</tbody>
				</table>
				
				
			


			<div class="clearfix"></div>

				

			</div>
			<!-- main end -->

		</div>
	</div>
</section>
<!-- main-container end -->


