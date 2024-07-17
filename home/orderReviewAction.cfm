<!--- see if ther is any item in the cart--->
<cfparam name="session.Cart" default="#StructNew()#">
<cfif StructIsEmpty(session.cart) or not isdefined("session.cart.leadprice")>
	<cfset relocate (area = "home", action = "cartemptywarning")>
</cfif>


<cfset OrderService = createObject('component', 'model.OrderService')>


<!--- save the order in db, data passed thorugh session object--->
<cfset local.reply = OrderService.createLeadOrder()>

<cfif local.reply.success neq true>
	<cfset showErrorMessage (Message = local.reply.errorMessage)>	
	<cfabort>
</cfif>

<cfset local.LeadOrderID = local.reply.data>

<cfset urlParam = "&LeadOrderID=#local.LeadOrderID#,#session.cart.leadProductName#,#session.cart.orderQuantity#,#session.cart.orderduration#,#session.cart.priceoption#,#local.reply.orderStatus#">

<!--- reset session and cart--->
<cfset session.cart = structNew()>


<cfset relocate (area = "home", action = "orderconfirm", urlParams=urlparam)>




