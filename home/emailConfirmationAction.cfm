
<cfparam name="form.bitpayInvoice" default="false" >

<cfset emailService = createObject('component', 'model.emailService')>


<cfif url.task eq "EmailConfirmation">
	<cfif isdefined("form.confirmationAndInvoice")>		
		<cfset doIncludeInvoice = true>
	<cfelse>
		<cfset doIncludeInvoice = false>
	</cfif>
	
	<cfif isdefined("form.bitpayInvoice") and form.bitpayInvoice eq true>		
		<cfset doIssueBitPayInvoice = true>
	<cfelse>
		<cfset doIssueBitPayInvoice = false>
	</cfif>
		
	<cfset local.reply = emailService.sendOrderConfirmationManual(LeadOrderID = form.orderID, email = form.email, doIncludeInvoice=doIncludeInvoice, doIssueBitPayInvoice = doIssueBitPayInvoice)>
	
	
</cfif>

<cfif url.task eq "generateInvoice">
	<cfset local.reply = emailService.generateInvoice(LeadOrderID = form.orderID, doIssueBitPayInvoice = form.bitpayInvoice)>
</cfif>


<cfset showSuccessMessage (Message = "Sent Successfully.")>	



