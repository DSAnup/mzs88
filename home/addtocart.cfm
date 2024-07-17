<!--- clear the current cart out--->
<cfset StructClear(session.Cart)>


<!---add the lead product and any optinal field that are selected--->
<cfset session.Cart = structNew()>

<cfset session.Cart.leadProductID = form.leadProductID>
<cfset session.Cart.leadProductName = form.leadProductName>
<cfset session.Cart.orderQuantity = val(form.orderQuantity)>
<cfset session.Cart.orderDuration = val(form.orderDuration)>
<cfparam name="form.leadFieldID" default="">
<cfset session.Cart.leadFieldID = form.leadFieldID>	
<cfparam name="form.specificBank" default="">
<cfset session.Cart.specificBank = form.specificBank>	
<cfset session.Cart.priceOption = form.priceOption>
<cfset session.Cart.leadPrice = form.leadPrice>
<cfset session.Cart.totalPrice = form.totalPrice>
<cfset session.cart.gst = 0>
<cfset session.cart.PaymentOption = "">

<!--- if disocunt is valid, check amount and duration --->
<cfif val(form.DiscountPercentage) gt 0 and ( val(form.orderDuration)  gte  val(form.MINSPECIALOFFERDURATION) and   val(form.orderDuration) lte val(MAXSPECIALOFFERDURATION)    ) >	
	<cfset session.Cart.DiscountPercentage = form.DiscountPercentage>
	<cfset session.Cart.DiscountNote = form.DiscountNote>
	<cfset session.Cart.DiscountedPrice = val(form.totalPrice) - val(form.totalPrice) * val(form.DiscountPercentage) / 100>
<cfelse>
	<cfset session.Cart.DiscountPercentage = 0>
	<cfset session.Cart.DiscountNote = "">
	<cfset session.Cart.DiscountedPrice = val(form.totalPrice)>
</cfif>	



<!--- if the user is logged in, take to client confirmation, else go to login --->
<cfparam name="session.profile.IsLoggedIn" default="false" >

<cfif session.profile.IsLoggedIn eq true>
	<cflocation url="./index.cfm?area=home&action=clientConfirmation&leadType=#form.priceOption#" addtoken="false" >
<cfelse>
	<cflocation url="./index.cfm?area=home&action=loginorSignin&leadType=#form.priceOption#" addtoken="false" >
</cfif>


