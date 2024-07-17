<cfset bitPay = createObject("component", "model.bitpay")>

<cfset email = createObject("component", "model.emailService")>


<cfset orderData = email.getOrderData(140261)>

<cfset bitpay.issueBill(orderData)>

<!---<cfset bitpay.issueInvoice()>--->


