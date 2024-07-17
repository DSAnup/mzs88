
<cfset errorMessage = "">

<!--- make sure all required inputs are provided --->
<cfif trim(form.promocode) eq "">
	<cfset errorMessage = errorMessage & "Promo code must be provided.<br>">	
</cfif>

<!---show error message --->
<cfif errorMessage gt "">
	<cfset showErrorMessage (Message = errorMessage)>	
	<cfabort>
</cfif>


<cfquery datasource="#request.dsnameReader#" name="qPromoCodeSelect">
	select *
		from PromoCode
		where getdate() between ActiveFrom and ActiveTo And PromoCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.PromoCode)#">
			and isused = 0
</cfquery>



<cfif qPromoCodeSelect.RecordCount gt 0 >						
	<cfset session.Cart.DiscountedPrice = session.Cart.totalPrice - ((qPromoCodeSelect.DiscountPercentage / 100) * session.Cart.totalPrice)>
	<cfset session.Cart.PromoCode = form.PromoCode>
	<cfset session.Cart.PromoCodeID = qPromoCodeSelect.PromoCodeID>
	<cfset session.Cart.DiscountNote = 'PromoCode: #form.PromoCode#. #qPromoCodeSelect.PromoNote#'>
	<cfset session.Cart.DiscountPercentage = qPromoCodeSelect.DiscountPercentage>
	
	<cfset session.OnLoadMessage = "success('Promo Code successfully applied to this purchase.')">
	<cfset relocate (area = "home", action = "orderreview&leadtype=#form.leadtype#&PromoCode=true")>
	
<cfelse>
	<cfset errorMessage = errorMessage & "This promo code is not valid">
	<cfset showErrorMessage (Message = errorMessage)>
</cfif>

