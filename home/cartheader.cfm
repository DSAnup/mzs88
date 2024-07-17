<!--- see if ther is any item in the cart--->



<cfparam name="session.Cart" default="#StructNew()#">
<cfparam name="session.Cart.PaymentOption" default="">
<cfparam name="session.Cart.PromoCodeDiscount" default="">

<cfif StructIsEmpty(session.cart) or not isdefined("session.cart.leadprice")>
	<p style="padding:20px; margin-bottom:0px;">
	<strong>
	You currently do not have any item in your cart. <br><br>
	Please continue shopping.
	</strong>
	</p>
	
	<div class="panel-body text-right">	
	
	<a href="/" class="btn btn-group btn-default btn-sm">OK</a>
	</div>
	
<cfelse>

<cfquery datasource="#request.dsnameReader#" name="qLeadProductSelect">		
	SELECT [LeadProductID]
		  ,[SpecialOfferPercentage]
		  ,[SpecialOfferFrom]
		  ,[SpecialOfferTo]
		  ,[PerticipateInGlobalSpecialOffer]
	FROM [dbo].[LeadProduct]
	WHERE LeadProductID = #session.Cart.LeadProductID#
</cfquery>
<cfquery datasource="#request.dsnameReader#" name="qSpecialOfferSelect"> 
	SELECT DiscountPercentage
	FROM SpecialOffer 
	WHERE getdate() between SpecialOfferFrom and SpecialOfferTo
		and AppliesTo like '%#session.cart.priceOption#%'
</cfquery>

<cfquery datasource="#request.dsnameReader#" name="qPromoCodeSelect">
	select *
		from PromoCode
		where getdate() between ActiveFrom and ActiveTo
</cfquery>





	<cfoutput>
	


	

	<table class="table table-hover">
		<thead>
			<tr>
				<th class="quantity">Quantity</th>
				<th class="product">Product</th>
				<th class="amount">Base&nbsp;Price</th>
				<cfif session.cart.leadprice  * session.cart.orderQuantity * session.cart.orderDuration lt session.cart.totalPrice>
					<th class="amount"></th>
				</cfif>
				<th class="amount">Total&nbsp;(Base&nbsp;+&nbsp;Extra)</th>
			</tr>
		</thead>
		<tbody>
		
					
			<tr>
				<td class="quantity">#session.cart.orderQuantity# x</td>
				<td class="product">
				<a href="index.cfm?area=home&action=product&leadproductid=#session.cart.leadproductid#&leadtype=#session.cart.priceoption#">#session.cart.leadproductname#</a>
				</td>
				<td class="amount text-right">
						$#numberFormat(session.cart.leadprice  * session.cart.orderQuantity * session.cart.orderDuration, "0.00")# 	
				</td>
						<td><div class="gstincluded">Excluding 
							
							<cfif session.cart.gst gt 0>GST(#request.addGstIndianRupee#%) or  </cfif>
							
							any discount</div></td>

				
				
				<td class="amount text-right">
				
<!---	#session.cart.totalPrice#--->




					<cfif session.cart.leadprice  * session.cart.orderQuantity * session.cart.orderDuration lt session.cart.totalPrice>



							<cfif qSpecialOfferSelect.RecordCount gt 0 and qLeadProductSelect.PerticipateInGlobalSpecialOffer eq 1>
								<cfset totalAmount = #numberFormat(session.cart.totalPrice, "0.00")# - ((#qSpecialOfferSelect.DiscountPercentage# / 100) * #numberFormat(session.cart.totalPrice, "0.00")#)>
								$#totalAmount#
								
								<br><small style="font-weight: normal;"><i>( #qSpecialOfferSelect.DiscountPercentage#% discount from regular price $#numberFormat(session.cart.totalPrice, "0.00")# ) </i></small> 
								
							<cfelseif Now() gt qLeadProductSelect.SpecialOfferFrom and Now() lt qLeadProductSelect.SpecialOfferTo and qLeadProductSelect.SpecialOfferPercentage gt 0>
								<cfset totalAmount = #numberFormat(session.cart.totalPrice, "0.00")# - ((#qLeadProductSelect.SpecialOfferPercentage# / 100) * #numberFormat(session.cart.totalPrice, "0.00")#)>
								$#totalAmount#
								
								<br><small style="font-weight: normal;"><i>( #qLeadProductSelect.SpecialOfferPercentage#% discount from regular price $#numberFormat(session.cart.totalPrice, "0.00")# ) </i> 
							<cfelseif qPromoCodeSelect.RecordCount gt 0 and session.Cart.PromoCodeDiscount gt 0>
							
								
								$#specialNumFormat(session.Cart.DiscountedPrice)#
								
								<br><small style="font-weight: normal;"><i>saved <span style="font-size: x-large;" <strong="">$#session.Cart.PromoCodeDiscount#</span> ($#session.Cart.DiscountPercentage#% discount from regular price $#numberFormat(session.cart.totalPrice, "0.00")#)</i></small>
								
							<cfelse>
								$#numberFormat(session.cart.totalPrice, "0.00")#
							</cfif>	
						
	
					<cfelse>

						
						
					
						

							<cfif qSpecialOfferSelect.RecordCount gt 0 and qLeadProductSelect.PerticipateInGlobalSpecialOffer eq 1>

								<cfset totalAmount = #numberFormat(session.cart.leadprice  * session.cart.orderQuantity * session.cart.orderDuration, "0.00")# - ((#qSpecialOfferSelect.DiscountPercentage# / 100) * #numberFormat(session.cart.leadprice  * session.cart.orderQuantity * session.cart.orderDuration, "0.00")#)>
								$#totalAmount#
																
								<br><small style="font-weight: normal;"><i>( #qSpecialOfferSelect.DiscountPercentage#% discount from regular price $#numberFormat(session.cart.leadprice  * session.cart.orderQuantity * session.cart.orderDuration, "0.00")# ) </i></small> 
								
							<cfelseif Now() gt qLeadProductSelect.SpecialOfferFrom and Now() lt qLeadProductSelect.SpecialOfferTo and qLeadProductSelect.SpecialOfferPercentage gt 0>
								
								<cfset totalAmount = #numberFormat(session.cart.leadprice  * session.cart.orderQuantity * session.cart.orderDuration, "0.00")# - ((#qLeadProductSelect.SpecialOfferPercentage# / 100) * #numberFormat(session.cart.leadprice  * session.cart.orderQuantity * session.cart.orderDuration, "0.00")#)>
								$#totalAmount#
								
								<br><small style="font-weight: normal;"><i>( #qLeadProductSelect.SpecialOfferPercentage#% discount from regular price $#numberFormat(session.cart.leadprice  * session.cart.orderQuantity * session.cart.orderDuration, "0.00")# ) </i></small> 
							<cfelseif qPromoCodeSelect.RecordCount gt 0 and session.Cart.PromoCodeDiscount gt 0>
							
								
								$#specialNumFormat(session.Cart.DiscountedPrice)#
								
								<br><small style="font-weight: normal;"><i>saved <span style="font-size: x-large;" <strong="">$#session.Cart.PromoCodeDiscount#</span> ($#session.Cart.DiscountPercentage#% discount from regular price $#numberFormat(session.cart.totalPrice, "0.00")#)</i></small>	
								
							<cfelse>
								$#numberFormat(session.cart.leadprice  * session.cart.orderQuantity * session.cart.orderDuration, "0.00")#
							</cfif>						
						
						
						
					
						
						 	
					</cfif>
						
					
				
						 	
				</td>
			</tr>

			
		
		</tbody>
	</table>
	<div class="panel-body text-right">	
	<a href="index.cfm?area=home&action=cart&leadtype=#session.cart.priceoption#" class="btn btn-group btn-default btn-sm">View Cart</a>
	
	
	<cfif session.profile.IsLoggedIn eq true>
		<a href="index.cfm?area=home&action=clientConfirmation&leadtype=#session.cart.priceoption#" class="btn btn-group btn-default btn-sm">Checkout</a>							
	<cfelse>
		<a href="index.cfm?area=home&action=loginorSignin&leadtype=#session.cart.priceoption#" class="btn btn-group btn-default btn-sm">Checkout</a>							
	</cfif>
	
	
	
	</div>
	
	</cfoutput>
	
</cfif>