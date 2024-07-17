<cfcomponent>
	
	
	
	<cffunction name="issueInvoice" >
		<cfargument name="orderData" required="true" >
		
		<cftry>
		
			<cfset local.bill = issueBill(arguments.orderData)>
			
			<cfdump var="#local.bill#" >
			
			<cfset sendBitPayEmail(local.bill)>
			
			<cfcatch type="">
				...
			</cfcatch>
		
		</cftry>
		
		
	</cffunction>
	
	
	
	<cffunction name="sendBitPayEmail" >
		
		<cfargument name="bill" required="true" >
		<cfoutput>
		<cfsavecontent variable="body">
			{	
			   "token": "#arguments.bill.data.token#"
			}
		
		</cfsavecontent>
		</cfoutput>
		
		
		<cfhttp url="https://bitpay.com/bills/#arguments.bill.data.id#/deliveries"  method="post" >
			<cfhttpparam type="header" name="x-accept-version" value="2.0.0" >
			<cfhttpparam type="header" name="Content-type" value="application/json" >
			<cfhttpparam type="body" value="#body#" >
		</cfhttp>
		
		
		<cfset response = DeserializeJSON (cfhttp.filecontent)>
		
	
	</cffunction>
		
		
	<cffunction name="issueBill" >
		<cfargument name="orderData" required="true" >
		
		<cfif val(arguments.orderData.qLeadOrderSelect.DiscountedPrice) gt 0>
			<cfset actualPrice = val(arguments.orderData.qLeadOrderSelect.DiscountedPrice)>
		<cfelse>
			<cfset actualPrice = val(arguments.orderData.qLeadOrderSelect.TotalPrice)>
		</cfif>
			 
		
		<cfoutput>
		<cfsavecontent variable="body">
			{
			   "number": "#arguments.orderData.qLeadOrderSelect.LeadOrderID# - #arguments.orderData.qLeadOrderSelect.ClientName# <cfif arguments.orderData.qLeadOrderSelect.BusinessName gt "">(#arguments.orderData.qLeadOrderSelect.BusinessName#)</cfif>",
			   "currency": "USD",
			   "name": "#arguments.orderData.qLeadOrderSelect.ClientName# <cfif arguments.orderData.qLeadOrderSelect.BusinessName gt "">, #arguments.orderData.qLeadOrderSelect.BusinessName#"</cfif>,
			   "address1": "#arguments.orderData.qLeadOrderSelect.Address1#",
			   "address2": "#arguments.orderData.qLeadOrderSelect.Address2#",
			   "city": "#arguments.orderData.qLeadOrderSelect.City#",
			   "state": "#arguments.orderData.qLeadOrderSelect.State#",
			   "zip": "#arguments.orderData.qLeadOrderSelect.ZipCode#",
			   "country": "#arguments.orderData.qLeadOrderSelect.CountryName#",
			   "email": "#arguments.orderData.qLeadOrderSelect.Email#",
			   "cc": [
			       "leads@godspeedcorp.com"
			   ],
			   "phone": "#arguments.orderData.qLeadOrderSelect.Phone#",
			   "dueDate": "#DateFormat(arguments.orderData.qLeadOrderSelect.DateCreated, "yyyy-mm-dd")#",
			   "passProcessingFee": true,
			   "items": [
			       {
			           "description": "#arguments.orderData.qLeadOrderSelect.LeadProductName#",
			           "price": #numberFormat(actualPrice / arguments.orderData.qLeadOrderSelect.OrderQuantity, '0.0000')#,
			           "quantity": #arguments.orderData.qLeadOrderSelect.OrderQuantity#
			       }			      
			   ],
			   "token": "72uL2ahuL5e6hoJgpxWjn6LbuuxzgY8xr2nxgzL7rt6j"
			}
		
		</cfsavecontent>
		
		
		<cfhttp url="https://bitpay.com/bills"  method="post" >
			<cfhttpparam type="header" name="x-accept-version" value="2.0.0" >
			<cfhttpparam type="header" name="Content-type" value="application/json" >
			<cfhttpparam type="body" value="#body#" >
		</cfhttp>
		
		</cfoutput>
		
				
		<cfset response = DeserializeJSON (cfhttp.filecontent)>
		
		<cfreturn response >
	
			
	</cffunction>
		
	

</cfcomponent>