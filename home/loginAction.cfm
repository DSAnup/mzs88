
<cfset errorMessage = "">

<!--- make sure all required inputs are provided --->
<cfif trim(form.Email) eq "">
	<cfset errorMessage = errorMessage & "A valid email or phone number must be provided.<br>">	
</cfif>

<cfif trim(form.password) eq "">
	<cfset errorMessage = errorMessage & "Password must be provided.">	
</cfif>

<!---show error message --->
<cfif errorMessage gt "">
	<cfset showErrorMessage (Message = errorMessage)>	
	<cfabort>
</cfif>

<!--- lets get the users that matches the email/password --->
<cfquery datasource="#request.dsnameReader#" name="qAppUserSelect">	
	select *
		from AppUser		
	where 
		(
		Email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Email#">
	or
		PhoneNumer = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Email#">
		)
		
		and Password =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.password#">	
</cfquery>

<!--- check to see if the user exists --->
<cfif qAppUserSelect.RecordCount eq 0>
	<cfset showErrorMessage (Message = "There is no account with the Username and Password provided. Please try again. ")>
	<cfabort>								
</cfif>



<!--- on success init the profile --->
<!--- set the session level profile --->
<cfset session.Profile.IsLoggedIn = true>
 <cfloop list="#qAppUserSelect.columnList#" index="col">
 	<cfset session.Profile.AppUser[col] = qAppUserSelect[col]>
 </cfloop>
 
 <!--- check the remember be situation  --->
 <cfif isdefined("form.rememberme")>
 	 <cfcookie name = "AppUserID" value = "#qAppUserSelect.AppUserID#" expires = "01/01/2099"> 
 </cfif>

<cfset session.OnLoadMessage = "success('You have been successfully logged in...')">

<cfparam name="url.justlogin" default="" >

<cfset relocate (area = "home", action = "AlumniSelect")>
 



