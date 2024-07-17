<!--- see if ther is any item in the cart--->
<cfparam name="session.Cart" default="#StructNew()#">
<cfif StructIsEmpty(session.cart) or not isdefined("session.cart.leadprice")>
	<cfset relocate (area = "home", action = "cartemptywarning")>
</cfif>





<cfset errorMessage = "">

<!--- make sure all required inputs are provided --->
<cfif trim(form.paymentOption) eq "">
	<cfset errorMessage = errorMessage & "Payment option must be provided.<br>">	
</cfif>

<!---show error message --->
<cfif errorMessage gt "">
	<cfset showErrorMessage (Message = errorMessage)>	
	<cfabort>
</cfif>
<cfset session.Cart.paymentOption = form.paymentOption>

<cfif form.paymentOption eq "Indian Rupee">	
	<cfif val(session.Cart.DiscountPercentage) gt 0>
		<cfset session.Cart.gst = session.Cart.DiscountedPrice * request.addGstIndianRupee / 100>
	<cfelse>
		<cfset session.Cart.gst = session.Cart.totalPrice * request.addGstIndianRupee / 100>								
	</cfif>
<cfelse>
	<cfset session.Cart.gst = 0>
</cfif>

<cfset relocate (area = "home", action = "orderReview&leadtype=#url.leadtype#")>