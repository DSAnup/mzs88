<cfcomponent output="true">


<!--- this sends an email confirmation of the order from an admin screen --->
<cffunction name="sendOrderConfirmationManual" >
	<cfargument name="LeadOrderID" required="true" >
	<cfargument name="email" required="true" >
	<cfargument name="doIncludeInvoice" required="true" >
	<cfargument name="doIssueBitPayInvoice" required="true" >
	

	<cfset local.orderData = getOrderData(arguments.LeadOrderID)>
	
	
	<cfif local.orderData.qLeadOrderSelect.recordCount neq 1>
		<cfthrow message="No order found for Order ID: #arguments.LeadOrderID#">
	</cfif>
	
	<cfset local.confirmationContent = generateConfirmationContent(local.orderData)>
	
	<cfset local.invoiceFile = generateInvoice(LeadOrderID = arguments.LeadOrderID, outputType = "fileName", doIssueBitPayInvoice = arguments.doIssueBitPayInvoice)>
	
	
	<cfoutput>#local.confirmationContent#</cfoutput>
		
		
			
	<!--- send an email confirmation--->
	<cfmail to="#trim(arguments.email)#"
		bcc="leads@godspeedcorp.com" 
		subject="Order Confirmation - #arguments.LeadOrderID#" 
		from="noreply@godspeedcorp.com" 		
		server="smtp.gmail.com" useSSL="true" username="noreply@godspeedcorp.com" password="GMOmSoft1*$" port="465">
		
			<cfmailpart type="text/plain" >
			Order Confirmation
			
			Thank you for your order.  Your order confirmation number is:  #arguments.LeadOrderID#
			
			GodSpeed Sales Team
			</cfmailpart>				
		
			<cfmailpart type="text/html" >
				<cfoutput>#local.confirmationContent#</cfoutput>
			</cfmailpart>
			
			<cfif arguments.doIncludeInvoice>				
				<cfmailparam
					file="#local.invoiceFile#"
					type="application/pdf"			
					/>
			</cfif>
			
		
	</cfmail>
	
</cffunction>





<!--- this sends an email confirmation of the order --->
<cffunction name="sendOrderConfirmation" >
	<cfargument name="LeadOrderID" required="true" >
	<cfargument name="email" required="false" default="" >
	<cfargument name="outputType" required="false" default="showOnScreen" >

	
	<cfset local.orderData = getOrderData(arguments.LeadOrderID)>
	
	
	<cfif local.orderData.qLeadOrderSelect.recordCount neq 1>
		<cfthrow message="No order found for Order ID: #arguments.LeadOrderID#">
	</cfif>
	
	<cfset local.confirmationContent = generateConfirmationContent(local.orderData)>
	
	<!--- showOnScreen option will display the content and optionally send to the email provided --->
	<cfif arguments.outputType eq "showOnScreen">		
		<cfoutput>#local.confirmationContent#</cfoutput>
		
		<!--- if an email is provided, send it to this email --->
		<cfif arguments.email gt "">
			
			<!--- send an email confirmation--->
			<cfmail to="#trim(arguments.email)#"
				bcc="leads@godspeedcorp.com" 
				subject="Order Confirmation - #arguments.LeadOrderID#" 
				from="noreply@godspeedcorp.com" 		
				server="smtp.gmail.com" useSSL="true" username="noreply@godspeedcorp.com" password="GMOmSoft1*$" port="465">
				
					<cfmailpart type="text/plain" >
					Order Confirmation
					
					Thank you for your order.  Your order confirmation number is:  #arguments.LeadOrderID#
					
					GodSpeed Sales Team
					</cfmailpart>				
				
					<cfmailpart type="text/html" >
						<cfoutput>#local.confirmationContent#</cfoutput>
					</cfmailpart>
				
			</cfmail>
			
		</cfif>
		
		<cfabort>
		
	</cfif>
	
	<!--- if its passed this point, we know its not showing on screen, so send it to the actual user --->
	<cfif arguments.outputType eq "confirmationAndInvoice">
		<cfset local.invoiceFile = generateInvoice(LeadOrderID = arguments.LeadOrderID, outputType = "fileName", doIssueBitPayInvoice = true)>
	</cfif>
	
	<!--- send an email confirmation--->
	<cfmail to="#trim(local.orderData.qLeadOrderSelect.DeliveryEmail)#"
		bcc="leads@godspeedcorp.com" 
		subject="Order Confirmation - #arguments.LeadOrderID#" 
		from="noreply@godspeedcorp.com" 		
		server="smtp.gmail.com" useSSL="true" username="noreply@godspeedcorp.com" password="GMOmSoft1*$" port="465">
			
<cfmailpart type="text/plain" >
Order Confirmation

Thank you for your order.  Your order confirmation number is:  #arguments.LeadOrderID#

GodSpeed Sales Team
</cfmailpart>


		<cfmailpart type="text/html" >
			<cfoutput>#local.confirmationContent#</cfoutput>
		</cfmailpart>
		
		<cfif arguments.outputType eq "confirmationAndInvoice">
			<cfmailparam
				file="#local.invoiceFile#"
				type="application/pdf"			
				/>
		</cfif>
			
	
	</cfmail>
	
	
</cffunction>





<!--- this generated an invoce and payment instruction for the order --->
<cffunction name="generateInvoice" >
	<cfargument name="LeadOrderID" required="true" >
	<cfargument name="outputType" required="false" default="showOnScreen" > 
	<cfargument name="doIssueBitPayInvoice" required="false" default="no">
	
	
	
	<cfset local.orderData = getOrderData(arguments.LeadOrderID)>
	
	<cfif local.orderData.qLeadOrderSelect.recordCount neq 1>
		<cfthrow message="No order found for Order ID: #arguments.LeadOrderID#">
	</cfif>
	
	
	
	
	
	<!--- send out the bitpay invoice --->
	<cfif isdefined("form.paymentOptionID") and val(form.paymentOptionID) gt 0>			
		<cfset local.orderData.qLeadOrderSelect.PaymentOptionID[1] = form.paymentOptionID>
	</cfif>
	
	<cfif local.orderData.qLeadOrderSelect.PaymentOptionID eq 2 and arguments.doIssueBitPayInvoice eq true>		
		<cfset bitPay = createObject("component", "model.bitpay")>		
		<cfset bitPay.issueInvoice(local.orderData)>
	</cfif>
	
	
	
	<cfset response = generateInvoiceContent(local.orderData)>
	
	<!--- show on screen --->
	<cfif arguments.outputType eq "showOnScreen">
		<cfdocument format="PDF" pagetype="letter" >
			<cfoutput>#response.invoiceContent#</cfoutput>		
			<cfloop array="#response.AdditionalImage#" item="image" >
				
					<cfoutput><img src="#image#" width="90%" ></img></cfoutput>
			</cfloop>		
		</cfdocument>	
		
	<cfelse>
	<!--- save in a pdf and sends back the file name --->
		<cfset local.filePath = "#request.tempFilePath#\#arguments.LeadOrderID#.pdf">		
		 <cfdocument format="PDF" pagetype="letter" filename="#local.filePath#" overwrite="true" >
			<cfoutput>#response.invoiceContent#</cfoutput>		
			<cfloop array="#response.AdditionalImage#" item="image" >
				
					<cfoutput><img src="#image#" width="90%" ></img></cfoutput>
			</cfloop>		
		</cfdocument>
	
		<cfreturn local.filePath>
		
	</cfif>
	
</cffunction>





<!--- Generate Invoice Content--->
<cffunction name="GenerateInvoiceContent" returntype="any">
	<cfargument name="OrderData" required="true" >
	
	
	

	
	
	<cfset arguments.qLeadOrderSelect = arguments.OrderData.qLeadOrderSelect>
	<cfset arguments.qLeadOrderFieldSelect = arguments.OrderData.qLeadOrderFieldSelect>
	
	<cfset lolca.response = structnew()>
	<cfset local.response.AdditionalImage = Arraynew(1)>
	
	<!---add images only for indian rupee --->
	<cfif isdefined("form.paymentOptionID") and isdefined("form.debug") and val(form.paymentOptionID) gt 0>			
		<cfset arguments.qLeadOrderSelect.PaymentOptionID[1] = form.paymentOptionID>
	</cfif>
	<cfif arguments.qLeadOrderSelect.PaymentOptionID eq 3>
		<cfoutput>
		<cfset ArrayAppend(local.response.AdditionalImage, "https://www.godspeedcorp.com/assets/img/bank/#arguments.qLeadOrderSelect.InstructionFileName#")>
		</cfoutput>		
	</cfif>

	
<cfsavecontent variable="local.InvoiceContent">
		
		
   <style>
.invoiceContainer {
    width: 860px;
    margin: 60px auto;
	color: ##4e4e4e;
	font-size: 14px;
}
.ml-row {
    width: 100%;
    overflow: hidden;
}
.ml-col {
    width: 50%;
    float: left;
    
}
.ml-heading {
    margin-bottom: 8px;
    overflow: hidden;
	height: 58px;
}
.ml-logo {
    padding: 16px 0  6px 0;
    border-radius: 5px;
    color: ##2c92f2;
    font-size: 36px;
    font-weight: 800;
}
.ml-details-section {
    overflow: hidden;
    display: block;
    width: 100%;
}
.ml-details {
    border: 1px dotted ##adadad;
    margin: 10px;
    padding: 14px;
    height: 285px;
    border-radius: 5px;
}
.ml-from {
	margin-left: 0;
}
.ml-details span {
    font-weight: 600;
    color: ##adadad;
    text-transform: uppercase;
    letter-spacing: 1px;
    margin-top: 10px;
    display: block;
    font-size: 15px;
    margin-bottom: 15px;
}
.ml-details-title {
    font-size: 18px;
    font-weight: 600;
}
h2.ml-company-name {
    margin: 6px 0;
    font-size: 18px;
}
p.ml-address{
    line-height: 24px;
    font-size: 14px;
    margin-top: 0;
}
.ml-to {
	margin-right: 0;
}
.ml-invoice {
    margin: 13px 0 0 0;
    text-align: right;
}
.ml-invoice div {
    font-size: 14px;
    margin-bottom: 3px;
}
.ml-invoice-data {
    margin-bottom: 0 !important;
}
.ml-invoice span {
    font-weight: bold;
    margin-right: 10px;
    font-size: 18px;
}
.ml-invoice-items {
}
.ml-invoice-items table {
    border-bottom: 2px solid ##eee;
    border-top: 2px solid ##ddd;
}
.ml-invoice-items thead tr {
    background: ##f5f5f5;
    text-align: left;
}
.ml-invoice-items thead tr th {
    padding: 10px 8px;
    border-bottom: 2px solid ##ddd !important;
}
tr.ml-table-row td {
    padding: 15px 10px;
    border-bottom: 1px solid ##ddd !important;
    vertical-align: initial;
    font-size: 14px;
}
tr.ml-table-row:last-child td {
    border: none !important;
}
.ml-item-name {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 5px;
}
.ml-item-details-title {
    font-weight: 500;
}
ul.ml-item-included {
    padding: 0 0 0 14px !important;
    list-style: decimal;
	
}
ul.ml-item-included li {
    float: left;
    width: 38%;
    line-height: 24px;
}
.ml-payment-details {
    border-bottom: 2px solid ##ddd;
    padding: 0 0 20px 0;
}
h2.ml-payment-title {
    font-size: 18px;
}
.ml-payment-details p{
}
.ml-payment-details ol {
    padding: 0 0 20px 18px;
    list-style: disc;
    margin-bottom: 0;
}
.ml-payment-details ol li {
    line-height: 24px;
}
p.ml-footer-question {
    margin: 2px 0;
    display: block;
}
.ml-bank-info {
    padding-left: 0;
    margin-top: 10px;
}
.ml-bank-info p {
    margin: 0;
    line-height: 23px;
}

.ml-row.ml-rupee-payment {
    overflow: hidden;
}
.ml-row.ml-rupee-payment {
    overflow: hidden;
  
    margin-top: 25px;
}
.ml-bank-name {
    font-size: 18px;
    font-weight: bold;
}
.ml-bank-info.ml-indian-bank-info {
    margin-top: 4px;
}
.ml-indent {
	padding-left: 40px;
}
.total-balance {
    width: 150px;
    border-bottom: 1px solid ##ccc;
    margin: 3px 0 0 auto;

}
</style>		

<cfoutput >
	

<div class="invoiceContainer">
		<div class="ml-heading">
			<div class="ml-row">
				<div class="ml-col">
					<div class="ml-logo">
						GSC
					</div>
				</div>
				<div class="ml-col">
					<div class="ml-invoice">

						<div class="ml-invoice-number"><span>Invoice##</span> #arguments.qLeadOrderSelect.LeadOrderID#</div>
						<div class="ml-invoice-data"><span>Invoice Date:</span>#DateFormat(arguments.qLeadOrderSelect.DateCreated, "mmmm dd, yyyy")#</div>
					</div>
				</div>
			</div>
		</div>
		
		
		<div class="ml-details-section">
			<div class="ml-row">
				<div class="ml-col">
					<div class="ml-details ml-from">
						<span>From</span>
						<h2 class="ml-company-name">GodSpeed Corporation</h2>
						<p class="ml-address">19046 Bruce B Downs Blvd <br> Ste B6 ##802
	Tampa, FL 33647 <br> <br><strong>Email:</strong> leads@godspeedcorp.com <br><strong>Skype:</strong> live:c5271fa1894a9b3 </p>

					</div>
				</div>
				<div class="ml-col">
					<div class="ml-details ml-to">

						<span>To</span>
						<h2 class="ml-company-name">#arguments.qLeadOrderSelect.ClientName#</h2>
						<p class="ml-address">#arguments.qLeadOrderSelect.BusinessName#<br>#arguments.qLeadOrderSelect.Address1#
					<cfif arguments.qLeadOrderSelect.Address2 gt "">
						#arguments.qLeadOrderSelect.Address2#<br>
					</cfif>
					#arguments.qLeadOrderSelect.City#, 
					#arguments.qLeadOrderSelect.State# #arguments.qLeadOrderSelect.ZipCode#, 
					#arguments.qLeadOrderSelect.CountryName# <br><strong>Email:</strong> #arguments.qLeadOrderSelect.Email#<br><strong>SkypeID:</strong> #arguments.qLeadOrderSelect.skypeID#<br><strong>Phone:</strong> #arguments.qLeadOrderSelect.Phone#</p>
					</div>
				</div>
			</div>
		</div>

		<div class="ml-invoice-items">
			<table style="width:100%" cellpadding="0" cellspacing="0">
				<thead>
				  <tr>
				    <th>Product</th>
				    <th>Price</th> 
				    <th>Quantity</th>
				    <th>Duration</th> 
				    <th style="text-align:right">Total</th>
				  </tr>
				</thead>
			  <tr class="ml-table-row">
			    <td>
			    	<!---name of product --->
					<div class="ml-item-name">
						#arguments.qLeadOrderSelect.LeadProductName#
					</div>
					<!--- Included details --->
					<div class="ml-item-details-title">
						Included Details:
					</div>
					<cfset isExtraItem = 0>
					<ul class="ml-item-included">
					<cfloop query="arguments.qLeadOrderFieldSelect" >
						<cfif arguments.qLeadOrderFieldSelect.Price eq 0>
							<li style=""> #arguments.qLeadOrderFieldSelect.LeadFieldName#</li>
						<cfelse>
							<cfset isExtraItem = 1>
						</cfif>
					</cfloop>
					</ul>
					<cfif isExtraItem eq 1>
					<div class="ml-item-details-title">
					Optional Additional Items: 
					</div>
					<ul class="ml-item-included">
					<cfloop query="arguments.qLeadOrderFieldSelect" >
						<cfif arguments.qLeadOrderFieldSelect.Price gt 0>
							<li style=""> #arguments.qLeadOrderFieldSelect.LeadFieldName#
								
								@ $#numberFormat(arguments.qLeadOrderFieldSelect.Price, '0.000')# per lead
							
								<br> #arguments.qLeadOrderFieldSelect.Note#
							</li>										
						</cfif>
					</cfloop>
					</ul>
					</cfif>
			    </td>
			    
			  
			    
			    <!---lead price  --->
			    <td>$#numberFormat(arguments.qLeadOrderSelect.LeadPrice, '0.000')# per lead</td>
			    <td>#arguments.qLeadOrderSelect.OrderQuantity#</td>
			    <td>		
				<cfif arguments.qLeadOrderSelect.OrderDuration gt 6>
					#int(arguments.qLeadOrderSelect.OrderDuration / 5)# weeks
				<cfelse>
					#arguments.qLeadOrderSelect.OrderDuration# days
				</cfif>
				</td>
			    <td style="text-align: right">
				
								
						Total Amount: $#specialNumFormat(arguments.qLeadOrderSelect.TotalPrice)# <br>
									<cfif arguments.qLeadOrderSelect.DiscountPercentage gt 0>
									Discount (#arguments.qLeadOrderSelect.DiscountPercentage#)%: $#specialNumFormat(arguments.qLeadOrderSelect.TotalPrice * arguments.qLeadOrderSelect.DiscountPercentage / 100)#<br>
									</cfif>
									<cfif arguments.qLeadOrderSelect.GST gt 0>										
										GST @ #request.addGstIndianRupee#%: $#specialNumFormat(arguments.qLeadOrderSelect.GST)# <br>
									</cfif>
									
									<cfif arguments.qLeadOrderSelect.DiscountPercentage gt 0 or arguments.qLeadOrderSelect.GST gt 0>										
										Final Amount Due: $#specialNumFormat( val(arguments.qLeadOrderSelect.GST) + arguments.qLeadOrderSelect.TotalPrice - arguments.qLeadOrderSelect.TotalPrice * arguments.qLeadOrderSelect.DiscountPercentage / 100 )#
									</cfif>
			
			
				</td>
			  </tr>
			</table>
		</div>

		<div class="ml-payment-details">
			<h2 class="ml-payment-title">Payment Details:</h2>
			
<!---US Bank --->
<cfif arguments.qLeadOrderSelect.PaymentOptionID eq 1 >
			<div class="ml-usa-bank">
				<p>Please pay the total invoice amount to the following account:</p>
				<div class="ml-details-title">Bank Details:</div>
				<div class="ml-bank-info ml-indent">
					<p><strong>Bank Name:</strong> Wells Fargo</p>
					<p><strong>Account Holder Name:</strong> Godspeed Marketing</p>
					<p><strong>Account Number:</strong> 1654687175</p>
					<p><strong>Routing Number:</strong> 063107513</p>
					<p><strong>Wire Routing Number:</strong> 121000248</p>
					<p><strong>Swift/BIC:</strong> WFBIUS6S</p>
				</div>
			</div> 
<!---BitCoin --->
<cfelseif arguments.qLeadOrderSelect.PaymentOptionID eq 2>			
			<div class="ml-witout-bank">
				<p>These are the steps to making the invoice payment* : </p>
				<ol>
					<li>Open the bitcoin email and click "view bill"</li>
					<li>Fill out the name and address form and click "save changes"</li>
					<li>Click "pay with Bitpay"</li>
					<li>Click continue</li>
					<li>Select the wallet you wish to use. You can download the Bitpay wallet or use blockchain.</li>
					<li>Click bitcoin payment</li>
					<li>Click "Pay in wallet"</li>
					<li>Make the payment in your wallet</li>
				</ol>
			</div> 
<!---Indian  Rupee --->
<cfelseif arguments.qLeadOrderSelect.PaymentOptionID eq 3>				
			
	<cfset exchangeRate = usd2inr()>


			<div class="ml-usa-bank">
				<div class="ml-bank-info">
					<p><strong>Please pay this amount:</strong>&##8377;#specialNumFormat( (val(arguments.qLeadOrderSelect.GST) + arguments.qLeadOrderSelect.TotalPrice - arguments.qLeadOrderSelect.TotalPrice * arguments.qLeadOrderSelect.DiscountPercentage / 100 ) *  exchangeRate)#  (1USD = #exchangeRate# INR)</p>
					<p><strong>Please add remark:</strong> Commission</p>
					<p><strong>Please pay to the following account:</strong> </p>
										
					<div class="ml-row ml-rupee-payment">
						<div class="ml-col">
							<div class="ml-indent">
								<div class="ml-bank-name">#arguments.qLeadOrderSelect.DepositBankName#</div>
								<div class="ml-bank-info ml-indian-bank-info">
									#arguments.qLeadOrderSelect.AccountDetails#
								</div>
							</div>
						</div>
						<div class="ml-col">
							<div class="ml-indent">
								<div class="ml-bank-name"><!---ICICI Bank---></div>
								<div class="ml-bank-info ml-indian-bank-info">
									<!---<p><strong>Account Name:</strong> Saffron Solutions</p>
									<p><strong>ALC ##:</strong> 007705019692</p>
									<p><strong>Branch Name:</strong> KK Nagar</p>
									<p><strong>Routing Number:</strong> ICIC0000077</p>--->
								</div>
							</div>
						</div>
					</div>
					
					
					
				</div>
			</div>
</cfif>
		</div>
		<p class="ml-footer-question">If you have any questions concerning this invoice, contact GodSpeed at the address above.</p>

	</div>

      		

</cfoutput>	
		
		
</cfsavecontent>

	<cfset local.response.InvoiceContent = local.InvoiceContent>
	
	<cfreturn local.response>
	
	
</cffunction>



<cffunction name="sendEmailConfirmation" >
	<cfargument name="LeadOrderID" required="true" >
	<cfargument name="email" required="false" >
	
	<!--- get Order Data --->
	<cfquery datasource="#request.dsnameReader#" name="qLeadOrderSelect">
		
		select 
				[LeadOrder].LeadOrderID, 
				[LeadOrder].ClientID, 
				[LeadOrder].LeadProductID, 
				[LeadOrder].OrderQuantity, 
				[LeadOrder].OrderDuration, 
				[LeadOrder].PriceOption, 
				[LeadOrder].LeadPrice, 
				[LeadOrder].TotalPrice, 
				[LeadOrder].LeadOrderStatusID, 
				[LeadOrder].DiscountedPrice,
				[LeadOrder].DiscountPercentage,
				[LeadOrder].WebSiteID, 
				[LeadOrder].ClientIP, 
				[LeadOrder].CreatedBy, 
				[LeadOrder].UpdatedBy, 
				[LeadOrder].DateCreated, 
				[LeadOrder].DateLastUpdated 
				<!---- lookup properties are complemented by name... ---->
				, [Client].FirstName + ' ' + [Client].LastName as ClientName
				
				, Client.BusinessName
				
				, Client.Email
				,Client.SkypeID
				,Client.Phone
				,Client.Address1
				,Client.Address2
				,Client.City
				,Client.State
				,Client.ZipCode
				,Country.CountryName
				
				,Client.DeliveryEmail
				
				, [LeadProduct].LeadProductName
				
				, [LeadOrderStatus].LeadOrderStatusName
				
				, [WebSite].WebSiteName
				
				,PaymentOption.PaymentOptionName
				
			from  [LeadOrder] 
				left join [Client] on [LeadOrder].ClientID = [Client].ClientID 
				left join Country on Client.CountryID = Country.CountryID
				left join [LeadProduct] on [LeadOrder].LeadProductID = [LeadProduct].LeadProductID 
				left join [LeadOrderStatus] on [LeadOrder].LeadOrderStatusID = [LeadOrderStatus].LeadOrderStatusID 
				left join [WebSite] on [LeadOrder].WebSiteID = [WebSite].WebSiteID 
				left join PaymentOption on PaymentOption.PaymentOptionID = LeadOrder.PaymentOptionID
				
					
			where [LeadOrder].LeadOrderID = #arguments.LeadOrderID#
		
		
	</cfquery>
	
	
	<cfif isdefined("arguments.email") and arguments.email gt "">
		<cfset qLeadOrderSelect.DeliveryEmail = arguments.email>
	</cfif>
	
	
	
	<cfquery datasource="#request.dsnameReader#" name="qLeadOrderFieldSelect">					
			select 
				[LeadOrderField].LeadOrderFieldID, 
				[LeadOrderField].LeadOrderID, 
				[LeadOrderField].LeadFieldID, 
				[LeadOrderField].Price, 
				[LeadOrderField].Note, 
				[LeadOrderField].CreatedBy, 
				[LeadOrderField].UpdatedBy, 
				[LeadOrderField].DateCreated, 
				[LeadOrderField].DateLastUpdated 
				, [LeadField].LeadFieldName
				
			from  [LeadOrderField] 
				
				left join [LeadField] on [LeadOrderField].LeadFieldID = [LeadField].LeadFieldID 
				
				
				where [LeadOrderField].LeadOrderID = #arguments.LeadOrderID#
					
				order by [LeadOrderField].Price, [LeadField].LeadFieldName
				
				
				          
		</cfquery>
		
		<cfset content = GenerateConfirmationContent(qLeadOrderSelect,qLeadOrderFieldSelect)>
		
		
		
		
	<!--- send an email confirmation--->
	<!---<cfmail to="#trim(qLeadOrderSelect.Email)#"
		bcc="leads@godspeedcorp.com" 
		subject="Order Confirmation - #arguments.LeadOrderID#" 
		from="leads@godspeedcorp.com" 		
		server="smtp.gmail.com" useSSL="true" username="leads@godspeedcorp.com" password="7LeadGS*" port="465">--->
		
		
		<cfoutput>#content#</cfoutput>
		
	<!---<cfmail to="#qLeadOrderSelect.DeliveryEmail#"
		 
		subject="Order Confirmation - #arguments.LeadOrderID#" 
		from="leads@godspeedcorp.com" 		
		server="smtp.gmail.com" useSSL="true" username="leads@godspeedcorp.com" password="7LeadGS*" port="465">	
		
		
		
			
<cfmailpart type="text/plain" >
Order Confirmation

Thank you for your order.  Your order confirmation number is:  #arguments.LeadOrderID#

GodSpeed Sales Team
</cfmailpart>


	<cfmailpart type="text/html" >
		#content#
	</cfmailpart>
	
		
	
	</cfmail>--->
	
</cffunction>


<!--- Generate Confirmation Content--->
<cffunction name="GenerateConfirmationContent" returntype="any">
	<cfargument name="OrderData" required="true" >
	
	
	
	<cfset arguments.qLeadOrderSelect = arguments.OrderData.qLeadOrderSelect>
	<cfset arguments.qLeadOrderFieldSelect = arguments.OrderData.qLeadOrderFieldSelect>
	
	
	
	<cfif arguments.qLeadOrderSelect.TotalPrice gt request.MaxAutoInvoiceAmount>
		<cfset contentType = "Request">
	<cfelse>
		<cfset contentType = "Confirmation">
	</cfif>

	
	<cfsavecontent variable="local.ConfirmationContent">
	<style>
	*{
		margin: 0;
		padding:0;
	}
	.main, .mailconfirmation {
		font-family: 'Open Sans', sans-serif;
	}
	h1, h2, h3, h4 {
		font-weight: normal;
	}
	table tr th {
		font-weight: normal;
		padding: 4px 0;
	}
	.product-name {
		text-align: left;
		padding-left: 43px;
		font-weight: 600;
		font-size: 24px;
	}
	ul li {
		font-size: 14px;
		line-height: 26px;
	}
	td.information {
		font-size: 14px;
		line-height: 26px;
	}
	.client-info {
		float: left;
		width: 50%;
	}
	table.table.footer {
		display: inline-block;
		width: 100%;
		overflow: hidden;
		background: ##f2f4f6;
		padding: 50px 0;
		margin-top: 30px;
	}
	
.footer {
    padding: 30px 0;
    background-color: ##262626;
    border-top: 1px solid ##3a3a3a;
    border-bottom: 1px solid ##333333;
}
.footer {
    font-size: 14px;
	    padding-bottom: 55px;
    color: ##999999;
	overflow:hidden;
	width: 100%;
}
.container {
    padding: 0 50px;
}
.logo-footer {
    margin: 25px 0 20px;
}
.list-icons, .list {
    list-style: none;
    padding: 0;
}
.list-icons li, .list li {
    padding: 5px 0;
}

.list-icons li i {
    width: 25px;
    text-align: center;
}
.list-icons li i {
    width: 25px;
    text-align: center;
    height: 25px;
    float: left;
    margin-top: 5px;
}
table.table.cart tbody tr td {
    vertical-align: initial;
}
.col-2 {
    width: 28%;
    float: left;
    padding-left: 14%;
}
.col-right-logo {
    float: left;
    margin-right: 15px;
}
.main-container {
    margin-bottom: 50px;
	overflow: hidden;
}
.topnav {
    overflow: hidden;
    background-color: ##333;
    padding: 20px 15%;
}

.topnav a {
  display: inline-block;
  color: ##e1e1e1;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
}

.topnav a:hover {
  background: none;
  color: ##fff;
}

.topnav a.active {
  background: none;
  color: ##fff;
}
.menubar {
    text-align: right;
}
.topnav .icon {
  display: none;
}
.logo,.menubar {
    float: left;
    width: 50%;
}
.logo img {
    padding-top: 7px;
}
</style>
<cfoutput>	
<cfquery datasource="#request.dsnameReader#" name="qLeadProductSelect">		
	SELECT [LeadProductID]
		  ,[SpecialOfferPercentage]
		  ,[SpecialOfferFrom]
		  ,[SpecialOfferTo]
		  ,[PerticipateInGlobalSpecialOffer]
	FROM [dbo].[LeadProduct]
	WHERE LeadProductID = #qLeadOrderSelect.LeadProductID#
</cfquery>
<cfquery datasource="#request.dsnameReader#" name="qSpecialOfferSelect"> 
	SELECT DiscountPercentage
	FROM SpecialOffer 
	WHERE getdate() between SpecialOfferFrom and SpecialOfferTo
		and AppliesTo like '%#qLeadOrderSelect.priceOption#%'
</cfquery>


<cfquery datasource="#request.dsnameReader#" name="qPromoCodeSelect">
	select *
		from PromoCode
		where getdate() between ActiveFrom and ActiveTo
</cfquery>
</cfoutput>
<div class="topnav" id="myTopnav">
	<div class="logo">
		<img src="https://www.godspeedcorp.com/assets/logo.png" />
	</div>
	<div class="menubar">
		<a href="https://www.godspeedcorp.com/">Home</a>
		<a href="https://www.godspeedcorp.com/index.cfm?area=home&action=contactus">Contact</a>
	</div>			
</div>					

			
<!-- main-container start -->
<!-- ================ -->
<section class="main-container">

	<div class="container">
		<div class="row">

			<!-- main start -->
			<!-- ================ -->
			<div class="main">

				<!-- page-title start -->
				<!-- ================ -->
				<h1 class="page-title margin-top-clear" style=" text-align: center;font-weight: 700;padding: 25px 0;color: ##4e4e4e;">Order <cfoutput>#contentType#</cfoutput></h1>
				<!-- page-title end -->
				
				
				
				<h3 style="text-align: center;margin: 0 0 15px 0;
			font-size: 20px;">
					
					Thank you for your order.  Your order <cfoutput>#lcase(contentType)#</cfoutput> number is: 
					<cfoutput><b>#qLeadOrderSelect.LeadOrderID#</b></cfoutput> <br><br>
					
					A composed view of your order appears below along with your details.
				
				
				</h3>
				
				<h4 style="text-align: center;margin: 8px 0 30px 0;
			font-size: 17px;">		
					
					<cfif contentType eq "request">
						
							Your order is currently being reviewed. Once the review is complete, we will send you an invoice 
							with detail payment instructions to your email.  <br><br>
						
					</cfif>
									
					Once your order is processed you will need to send proof of payment 
					to the skype address of: <a style="color: ##398439;font-weight: bold;" href="skype:live:c5271fa1894a9b3?chat">live:c5271fa1894a9b3</a>  prior to receiving any lead files.					
				</h4>
				
			
				
				<div class="space"></div>
				
				


				
				
				<cfoutput>
							
				<table class="table cart table-hover table-striped" style="margin: 0 auto 15px auto;width: 100%;text-align: center;border-bottom: 1px solid ##eee;">
					<thead>
						<tr style="background: rgba(54, 55, 60, 0.95);color: ##e1e1e1">
							<th>Product </th>
							<th>Price </th>
							<th>Quantity</th>
							<th>Duration</th>
							<th class="amount">Total </th>
						</tr>
					</thead>
					<tbody>
					
					
						
							<tr class="remove-data">
							<td class="product">
								<div style="text-align: left;font-weight: 600;font-size: 24px;padding-top: 15px;">#arguments.qLeadOrderSelect.LeadProductName#</div>
								
								<span style="text-align: left !important;font-size: 16px;margin-top: 5px;display: block;font-weight: 600;
">Included Details:</span>
								<div class="row col-md-offset-1 col-md-11">
									<cfset isExtraItem = 0>
									<ul style="list-style: none;text-align: left;padding: 0;">
									<cfloop query="arguments.qLeadOrderFieldSelect" >
										<cfif arguments.qLeadOrderFieldSelect.Price eq 0>
											<li style=""> #arguments.qLeadOrderFieldSelect.LeadFieldName#</li>
										<cfelse>
											<cfset isExtraItem = 1>
										</cfif>
									</cfloop>
									</ul>
								</div>
									
								
								
								<cfif isExtraItem eq 1>
									
								<!--- Optional Details --->
								<br />Optional Additional Items: 
								<div class="row col-md-offset-1 col-md-11">									
									<ul style="list-style: none;text-align: left;padding: 0 18px;">
									<cfloop query="arguments.qLeadOrderFieldSelect" >
										<cfif arguments.qLeadOrderFieldSelect.Price gt 0>
											<li style=""> #arguments.qLeadOrderFieldSelect.LeadFieldName#
												
												@ $#numberFormat(arguments.qLeadOrderFieldSelect.Price, '0.00')# per lead
											
												<br> #arguments.qLeadOrderFieldSelect.Note#
											</li>										
										</cfif>
									</cfloop>
									</ul>
								</div>
									
									
									
									
								</cfif>
								
								
								
							</td>
							<td class="price"> 
								$#numberFormat(arguments.qLeadOrderSelect.LeadPrice, '0.00')# per lead
							</td>
							<td class="price">
							
								#arguments.qLeadOrderSelect.OrderQuantity#
								
								
							</td>
							<td class="price">
							
							<cfif arguments.qLeadOrderSelect.OrderDuration gt 6>
								#int(arguments.qLeadOrderSelect.OrderDuration / 5)# weeks
							<cfelse>
								#arguments.qLeadOrderSelect.OrderDuration# days
							</cfif>

							
							
							
								
																		
							</td>
							
							<td class="amount">
							
									Total Amount: $#specialNumFormat(arguments.qLeadOrderSelect.TotalPrice)# <br>
									<cfif arguments.qLeadOrderSelect.DiscountPercentage gt 0>
									Discount (#arguments.qLeadOrderSelect.DiscountPercentage#)%: $#specialNumFormat(arguments.qLeadOrderSelect.TotalPrice * arguments.qLeadOrderSelect.DiscountPercentage / 100)#<br>
									</cfif>
									<cfif arguments.qLeadOrderSelect.GST gt 0>										
										GST @ #request.addGstIndianRupee#%: $#specialNumFormat(arguments.qLeadOrderSelect.GST)# <br>
									</cfif>
									
									<cfif arguments.qLeadOrderSelect.DiscountPercentage gt 0 or arguments.qLeadOrderSelect.GST gt 0>										
										Final Amount Due: $#specialNumFormat( val(arguments.qLeadOrderSelect.GST) + arguments.qLeadOrderSelect.TotalPrice - arguments.qLeadOrderSelect.TotalPrice * arguments.qLeadOrderSelect.DiscountPercentage / 100 )#
									</cfif>

							</td>
						</tr>						
						
						
					</tbody>
				</table>
				
				
			</cfoutput>


				
				<div class="space-bottom"></div>
				
				
				
				
	<!--- Client Informaiton --->
	<cfoutput>
	<table class="table table-striped client-info">
		<thead>
			<tr>
				<th colspan="2" style="text-align: left;font-weight: 600;">Client Information </th>
			</tr>
		</thead>
		<tbody>
			
			<cfif arguments.qLeadOrderSelect.BusinessName gt "">
				<tr>
					<td class="information" style="width: 30%;">Business Name</td>
					<td class="information">#arguments.qLeadOrderSelect.BusinessName#</td>
				</tr>
				
				
			</cfif>
				
			
			<tr>
				<td class="information" style="width: 30%;">Full Name</td>
				<td class="information">#arguments.qLeadOrderSelect.ClientName#</td>
			</tr>
			<tr>
				<td class="information" style="width: 30%;">Email</td>
				<td class="information">#arguments.qLeadOrderSelect.Email#</td>
			</tr>
			<tr>
				<td class="information" style="width: 30%;">Skype ID</td>
				<td class="information">#arguments.qLeadOrderSelect.skypeID#</td>
			</tr>
			<tr>
				<td class="information" style="width: 30%;">Phone</td>
				<td class="information">#arguments.qLeadOrderSelect.Phone#</td>
			</tr>
			<tr>
				<td class="information" style="width: 30%;">Address</td>
				<td class="information">
					#arguments.qLeadOrderSelect.Address1#,
					<cfif arguments.qLeadOrderSelect.Address2 gt "">
						,#arguments.qLeadOrderSelect.Address2#
					</cfif>
					#arguments.qLeadOrderSelect.City#, #arguments.qLeadOrderSelect.State# #arguments.qLeadOrderSelect.ZipCode#, #arguments.qLeadOrderSelect.CountryName#
					
					
				</td>
			</tr>
		</tbody>
	</table>
	</cfoutput>
				

				
				
				
				
	<!--- Payment Informaiton --->
	<cfoutput>
	<table class="table table-striped client-info">
		<thead>
			<tr>
				<th colspan="2" style="text-align: left;font-weight: 600;">Payment Information </th>
			</tr>
		</thead>
		<tbody>
			
			<tr>
				<td>Payment Option</td>
				<td class="information">Pay by #arguments.qLeadOrderSelect.PaymentOptionName#</td>
			</tr>
		
		</tbody>
	</table>
	
	</cfoutput>
				
			
				

</div>
			<!-- main end -->

		</div>
	</div>
	
</section>
<!-- main-container end -->

<footer id="footer">
	<div class="footer mailconfirmation">
		<div class="container">

				<div class="col-2">
					<div class="footer-content">
						<div class="logo-footer"><img id="logo-footer" src="https://www.godspeedcorp.com/assets/logo.png" alt=""></div>
						<div class="col-2-left">
							19046 Bruce B Downs Blvd Ste B6 ##802 Tampa, FL 33647
								<br> info@godspeedcorp.com</li>
							
						</div>
					</div>
				</div>
		
				<div class="col-2">
					<div class="footer-content">
						
						<div class="col-2-right" style="margin-top: 30px;">
						<p> Site and Payment Processing Secured By: </p>
							<div class="col-right-logo"> <img class="img-thumbnail" src="https://www.godspeedcorp.com//assets/img/lead/bitpay-logo.png" /> </div>
							<div class="col-right-logo"> <img class="img-thumbnail" src="https://www.godspeedcorp.com//assets/img/lead/letlogo.png" /> </div>
						</div>
					</div>
				</div>

		</div>
	</div>
</footer>



	</cfsavecontent>
			
	<cfreturn local.confirmationContent>	
			

</cffunction>

<cffunction name="getOrderDataByClientID" >
	<cfargument name="ClientID" required="true" >
	
	<!--- get Order Data --->
	<cfquery datasource="#request.dsnameReader#" name="qLeadOrderSelect">
		
		select 
				[LeadOrder].LeadOrderID, 
				[LeadOrder].ClientID, 
				[LeadOrder].LeadProductID, 
				[LeadOrder].OrderQuantity, 
				[LeadOrder].OrderDuration, 
				[LeadOrder].PriceOption, 
				[LeadOrder].LeadPrice, 
				[LeadOrder].TotalPrice, 
				[LeadOrder].DiscountedPrice,
				[LeadOrder].DiscountNote,
				[LeadOrder].DiscountPercentage,
				[LeadOrder].GST,
				[LeadOrder].LeadOrderStatusID, 
				[LeadOrder].WebSiteID, 
				[LeadOrder].ClientIP, 
				[LeadOrder].CreatedBy, 
				[LeadOrder].UpdatedBy, 
				[LeadOrder].DateCreated, 
				[LeadOrder].DateLastUpdated 
				<!---- lookup properties are complemented by name... ---->
				, [Client].FirstName + ' ' + [Client].LastName as ClientName
				
				, Client.BusinessName
				
				, Client.Email
				,Client.SkypeID
				,Client.Phone
				,Client.Address1
				,Client.Address2
				,Client.City
				,Client.State
				,Client.ZipCode
				,Country.CountryName
				
				,Client.DeliveryEmail
				
				, [LeadProduct].LeadProductName
				
				, [LeadOrderStatus].LeadOrderStatusName
				
				, [WebSite].WebSiteName
				
				,LeadOrder.PaymentOptionID
				,PaymentOption.PaymentOptionName
				
				,DepositBank.AccountDetails
				,DepositBank.InstructionFileName
				,DepositBank.DepositBankName
				
			from  [LeadOrder] 
				left join [Client] on [LeadOrder].ClientID = [Client].ClientID 
				left join Country on Client.CountryID = Country.CountryID
				left join [LeadProduct] on [LeadOrder].LeadProductID = [LeadProduct].LeadProductID 
				left join [LeadOrderStatus] on [LeadOrder].LeadOrderStatusID = [LeadOrderStatus].LeadOrderStatusID 
				left join [WebSite] on [LeadOrder].WebSiteID = [WebSite].WebSiteID 
				left join PaymentOption on PaymentOption.PaymentOptionID = LeadOrder.PaymentOptionID
				left join DepositBank on DepositBank.DepositBankID = Client.DepositBankID
				
					
			where Client.ClientID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ClientID#">
		
		
	</cfquery>
	
	<cfreturn qLeadOrderSelect>

</cffunction>

<cffunction name="getOrderData" >
	<cfargument name="LeadOrderID" required="true" >
	
	<!--- get Order Data --->
	<cfquery datasource="#request.dsnameReader#" name="qLeadOrderSelect">
		
		select 
				[LeadOrder].LeadOrderID, 
				[LeadOrder].ClientID, 
				[LeadOrder].LeadProductID, 
				[LeadOrder].OrderQuantity, 
				[LeadOrder].OrderDuration, 
				[LeadOrder].PriceOption, 
				[LeadOrder].LeadPrice, 
				[LeadOrder].TotalPrice, 
				[LeadOrder].DiscountedPrice,
				[LeadOrder].DiscountNote,
				[LeadOrder].DiscountPercentage,
				[LeadOrder].GST,
				[LeadOrder].LeadOrderStatusID, 
				[LeadOrder].WebSiteID, 
				[LeadOrder].ClientIP, 
				[LeadOrder].CreatedBy, 
				[LeadOrder].UpdatedBy, 
				[LeadOrder].DateCreated, 
				[LeadOrder].DateLastUpdated 
				<!---- lookup properties are complemented by name... ---->
				, [Client].FirstName + ' ' + [Client].LastName as ClientName
				
				, Client.BusinessName
				
				, Client.Email
				,Client.SkypeID
				,Client.Phone
				,Client.Address1
				,Client.Address2
				,Client.City
				,Client.State
				,Client.ZipCode
				,Country.CountryName
				
				,Client.DeliveryEmail
				
				, [LeadProduct].LeadProductName
				
				, [LeadOrderStatus].LeadOrderStatusName
				
				, [WebSite].WebSiteName
				
				,LeadOrder.PaymentOptionID
				,PaymentOption.PaymentOptionName
				
				,DepositBank.AccountDetails
				,DepositBank.InstructionFileName
				,DepositBank.DepositBankName
				
			from  [LeadOrder] 
				left join [Client] on [LeadOrder].ClientID = [Client].ClientID 
				left join Country on Client.CountryID = Country.CountryID
				left join [LeadProduct] on [LeadOrder].LeadProductID = [LeadProduct].LeadProductID 
				left join [LeadOrderStatus] on [LeadOrder].LeadOrderStatusID = [LeadOrderStatus].LeadOrderStatusID 
				left join [WebSite] on [LeadOrder].WebSiteID = [WebSite].WebSiteID 
				left join PaymentOption on PaymentOption.PaymentOptionID = LeadOrder.PaymentOptionID
				left join DepositBank on DepositBank.DepositBankID = Client.DepositBankID
				
					
			where [LeadOrder].LeadOrderID = #arguments.LeadOrderID#
		
		
	</cfquery>
	

	

	<cfquery datasource="#request.dsnameReader#" name="qLeadOrderFieldSelect">					
			select 
				[LeadOrderField].LeadOrderFieldID, 
				[LeadOrderField].LeadOrderID, 
				[LeadOrderField].LeadFieldID, 
				[LeadOrderField].Price, 
				[LeadOrderField].Note, 
				[LeadOrderField].CreatedBy, 
				[LeadOrderField].UpdatedBy, 
				[LeadOrderField].DateCreated, 
				[LeadOrderField].DateLastUpdated 
				, [LeadField].LeadFieldName
				
			from  [LeadOrderField] 
				
				left join [LeadField] on [LeadOrderField].LeadFieldID = [LeadField].LeadFieldID 
				
				
				where [LeadOrderField].LeadOrderID = #arguments.LeadOrderID#
					
				order by [LeadOrderField].Price, [LeadField].LeadFieldName
				
				
				          
		</cfquery>
		
		<cfset response.qLeadOrderSelect = qLeadOrderSelect>
		<cfset response.qLeadOrderFieldSelect = qLeadOrderFieldSelect>
		
		<cfreturn response>
		
		
	
</cffunction>






<cffunction name="usd2inr" >
	
	<cftry>
	
		<cfhttp url="https://free.currconv.com/api/v7/convert?q=USD_INR&compact=ultra&apiKey=ffb087f7d3df17002853" >
		
		
		<cfset response = DeserializeJSON(cfhttp.fileContent)>
		
		
		<cfreturn numberFormat(val(response.USD_INR) + 2, "0.00")> 
	
		<cfcatch>
			<cfreturn 75.00>
		</cfcatch>
	</cftry>
	
</cffunction>



















</cfcomponent>

