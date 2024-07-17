

<cfset emailService = createObject('component', 'model.emailService')>

<cfset local.reply = emailService.sendOrderConfirmation(LeadOrderID = url.orderID, outputType = 'email')>


<cfset showSuccessMessage (Message = "Confirmation Sent Successfully.")>	