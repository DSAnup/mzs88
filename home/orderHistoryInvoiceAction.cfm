
<cfset emailService = createObject('component', 'model.emailService')>


<cfset local.reply = emailService.generateInvoice(LeadOrderID = url.orderID, doIssueBitPayInvoice = false, outputType='file')>


<cfheader name="Content-Disposition" value="attachment; filename=#url.orderID#.pdf"> 
<cfcontent type="application/pdf" file="#local.reply#" deletefile="no"> 

