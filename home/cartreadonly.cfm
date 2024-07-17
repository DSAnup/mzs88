<cfquery datasource="#request.dsnameReader#" name="qLeadProductSelect">

		
	select [LeadProduct].[LeadProductID]
		  ,[LeadProduct].[LeadProductName] 
		  ,[LeadProduct].[ProductDescription]
		  ,[LeadProduct].[ProductPeriod]
		  ,[LeadProduct].[MinimumProductAmount]
		  ,[LeadProduct].[OrderPeriod]
		  ,[LeadProduct].[MinimumOrderPeriod]
		  ,[LeadProduct].[MaximumOrderPeriod]
		  ,[LeadProduct].[SpecialOfferPercentage]
		  ,[LeadProduct].[SpecialOfferFrom]
		  ,[LeadProduct].[SpecialOfferTo]
		  ,[LeadProduct].[PerticipateInGlobalSpecialOffer]
		  ,[LeadProduct].[PriceUnit]
		  , '#session.Cart.PriceOption#' as LeadType
		  
		  <cfif isdefined("session.Cart.PriceOption") and trim(session.Cart.PriceOption) eq 'Exclusive'>
			,[LeadProduct].[ExclusiveLeadPrice] as 'LeadPrice'
		  </cfif>
		  <cfif isdefined("session.Cart.PriceOption") and trim(session.Cart.PriceOption)  eq 'Shared'>
			,[LeadProduct].[SharedLeadPrice] as 'LeadPrice'
		  </cfif>
		   <cfif isdefined("session.Cart.PriceOption") and trim(session.Cart.PriceOption)  eq 'Hour24'>
			,[LeadProduct].[Hour24LeadPrice] as 'LeadPrice'
		  </cfif>
		  <cfif isdefined("session.Cart.PriceOption") and trim(session.Cart.PriceOption)  eq 'Aged'>
			,[LeadProduct].[AgedLeadPrice] as 'LeadPrice'
		  </cfif>
		 
		  ,[LeadProductField].[LeadProductFieldID]      
		  ,[LeadProductField].[LeadFieldID]
		  
		  
		 <cfif isdefined("session.Cart.PriceOption") and trim(session.Cart.PriceOption)  eq 'Exclusive'>
			,[LeadProductField].[ExclusiveFieldPrice] as 'FieldPrice'
		  </cfif>
		  <cfif isdefined("session.Cart.PriceOption") and trim(session.Cart.PriceOption)  eq 'Shared'>
			,[LeadProductField].[SharedFieldPrice] as 'FieldPrice'
		  </cfif>
		  <cfif isdefined("session.Cart.PriceOption") and trim(session.Cart.PriceOption)  eq 'Hour24'>
			,[LeadProductField].[Hour24FieldPrice] as 'FieldPrice'
		  </cfif>
		  <cfif isdefined("session.Cart.PriceOption") and trim(session.Cart.PriceOption)  eq 'Aged'>
			,[LeadProductField].[AgedFieldPrice] as 'FieldPrice'
		  </cfif>
		
	
		  ,LeadField.LeadFieldName
		  ,LoanType.LoanTypeName
	  
	  from [LeadProductField]
		join [LeadProduct] on [LeadProductField].LeadProductID = [LeadProduct].LeadProductID
		join LeadField on LeadField.LeadFieldID = LeadProductField.LeadFieldID
		join WebSiteLeadProduct on WebSiteLeadProduct.LeadProductID = [LeadProduct].LeadProductID
		join WebSite on WebSite.WebSiteID = WebSiteLeadProduct.WebSiteID
		
		join LoanType on LoanType.LoanTypeID = LeadProduct.LoanTypeID
		
	  where WebSite.WebSiteName = '#trim(request.callerWebSite)#'
	  
	  
	  	and LeadProduct.LeadProductID = #val(session.Cart.LeadProductID)#
		
	  
		
		<cfif isdefined("url.LeadProductID") and val(url.LeadProductID) gt 0>
			and LeadProduct.LeadProductID = #val(url.LeadProductID)#
		</cfif>
		<cfif isdefined("session.Cart.PriceOption") and trim(session.Cart.PriceOption)  eq 'Exclusive'>
			 and [LeadProduct].[ExclusiveLeadPrice] > 0
		  </cfif>
		  <cfif isdefined("session.Cart.PriceOption") and trim(session.Cart.PriceOption)  eq 'Shared'>
			and [LeadProduct].[SharedLeadPrice] > 0
		  </cfif>
		  <cfif isdefined("session.Cart.PriceOption") and trim(session.Cart.PriceOption)  eq 'Hour24'>
			and [LeadProduct].[Hour24LeadPrice]> 0
		  </cfif>
		  <cfif isdefined("session.Cart.PriceOption") and trim(session.Cart.PriceOption)  eq 'Aged'>
			and [LeadProduct].[AgedLeadPrice] > 0
		  </cfif>
	
		order by LeadProduct.[Priority],  LeadProduct.[LeadProductID], LeadField.[Priority]


</cfquery>



<cfoutput>

							
				<table  class="table border cart table-hover table-striped">
					<thead>
						<tr>
							<th>Product </th>
							<th>Price </th>
							<th>Quantity</th>
							<th>Duration</th>
							<th style=" width:20%;" class="amount">Price </th>
						</tr>
					</thead>
					<tbody>
					

						
						<tr class="remove-data">
							<td class="product">
								<cfoutput>#qLeadProductSelect.leadProductName#</cfoutput>
								
								<cfset priceOptionSelected = listFirst(session.cart.priceOption,';')>
								
								<cfset includedFields = "">
								
								<!--- included fields--->													
								<cfloop query="qLeadProductSelect">
									
									<cfif val(#qLeadProductSelect.FieldPrice#) gt 0 >
										
									<cfelse>
										<cfset includedFields = listAppend(includedFields, qLeadProductSelect.LeadFieldName)>
									</cfif>
									
								</cfloop>
								<br />Included Details: 
								<div class="row col-md-offset-1 col-md-11">#replace(includedFields, ',', ', ', 'all')#
								</div>
									
								
								<!---optional fields--->
								<cfset additionalPrice = 0>
								<cfif session.cart.leadfieldid gt "">
									<br />&nbsp;<br />
									Optional additional items:
									<div class="row col-md-offset-1 col-md-11">								
									<cfloop query="qLeadProductSelect">							
										
										<cfif listfind(session.cart.leadFieldId, qLeadProductSelect.leadFieldId)>
											<span class="glyphicon glyphicon-ok"></span>
											#qLeadProductSelect.LeadFieldName# @ 
											#qLeadProductSelect.FieldPrice#
											per lead
											<br />	
											<cfset additionalPrice = 	additionalPrice + qLeadProductSelect.FieldPrice * session.cart.orderQuantity * session.cart.orderDuration>													
										</cfif>							
									</cfloop>
									</div>	
										
								
								</cfif>
								
								<!---specific banks--->								
								<cfif session.cart.specificBank gt "">
									<br />&nbsp;<br />
									Specific Banks:
									<div class="row col-md-offset-1 col-md-11">								
									<cfloop list="#session.cart.specificBank#" index="bankName">
										<span class="glyphicon glyphicon-ok"></span>
										#BankName# <br />			
									</cfloop>
									</div>	
										
								
								</cfif>
								
								
							</td>
							<td class="price"> 
								<cfset leadPrice = session.cart.leadprice>
								<cfset price = leadPrice * session.cart.orderQuantity * session.cart.orderDuration>
								<cfoutput>$#specialNumFormat(leadPrice)# per lead</cfoutput>
							</td>
							<td class="price">
							
								#session.cart.orderQuantity# 
								
								
							</td>
							<td class="price">
							
							<cfif session.cart.orderDuration lt 5>
								#session.cart.orderDuration#
								<cfif #session.cart.orderDuration# gt 1>
									Days
								<cfelse>
									Day
								</cfif>
							<cfelse>
								
								#session.cart.orderDuration / 5#
								<cfif (session.cart.orderDuration / 7) gt 1>
									Weeks
								<cfelse>
									Week
								</cfif>
																						
								
							</cfif>

																		
							</td>
						
							<td class="car-price">
								 $#specialNumFormat(session.Cart.totalPrice)#
							</td>
						
						</tr>
						
						<!--- discount row --->	
						<cfif val(session.Cart.DiscountPercentage) gt 0>		
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td class="car-price">
									
									<div class="car-price-head">Discount(<i>#session.Cart.DiscountPercentage#%</i>):</div> 
								
									 ($#specialNumFormat(session.Cart.totalPrice - session.Cart.DiscountedPrice)#) 
								
								</td>
							</tr>
						</cfif>
						
						
						<!--- indian rupee row --->	
												 
								  
						<cfif session.cart.gst gt 0>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td class="car-price">
									
									<div class="car-price-head">GST(<i>#request.addGstIndianRupee#%</i>):</div> 								
									 $#specialNumFormat(session.Cart.gst)# 
								</td>						
						</cfif>
						
						
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td class="car-price">
								<div class="car-price-head">Total:</div> 
														
								<cfif val(session.Cart.DiscountPercentage) gt 0>
									$#specialNumFormat(session.Cart.DiscountedPrice + session.Cart.gst)#								
								<cfelse>
									$#specialNumFormat(session.Cart.totalPrice + session.Cart.gst)#	
								</cfif>	
							</td>
						</tr>	
								
						
					</tbody>
				</table>
				
				
			

</cfoutput>


