<cfdump var="#form#">
<cfset errorMessage = "">

<!--- make sure all required inputs are provided --->
<cfif trim(form.Email) eq "">
	<cfset errorMessage = errorMessage & "A valid email must be provided.<br>">	
</cfif>

<cfif trim(form.password) eq "">
	<cfset errorMessage = errorMessage & "Password must be provided.<br>">	
</cfif>


<!--- lets get the users that matches the email/password --->
<cfquery datasource="#request.dsnameReader#" name="qUserSelect">	
	select *
		from Appuser		
		where Email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#">	
</cfquery>

<!--- check to see if the user exists --->
<cfif qUserSelect.RecordCount eq 0>
	<cfset showErrorMessage (Message = "User does not exist with the details your provided.  Please try again.")>
	<cfabort>		
<cfelseif  qUserSelect.RecordCount gt 1>	
	<cfset showErrorMessage (Message = "Multiple User with same details you provided.  Please contact your administrator.")>	
	<cfabort>						
</cfif>

<cfoutput>
	<cfset oldPass="#qUserSelect.PasswordHash#">
</cfoutput> 

  <!---check to see if the password matches --->
<cfif trim(form.password) neq oldPass>
	<cfset errorMessage = errorMessage & "Password doesn't match">  
</cfif>


<cfif errorMessage gt "">
	<cfset showErrorMessage (Message = errorMessage)>	
	<cfabort>
</cfif>



<!--- set the session level profile --->
<cfset session.Profile.IsLoggedIn = true>
 <cfloop list="#qUserSelect.columnList#" index="col">
 	<cfset session.Profile[col] = qUserSelect[col]>
 </cfloop>
 
 
 <cfif isdefined("form.rememberme")>
 	 <cfcookie name = "appUserID" value = "#qUserSelect.AppUserID#" expires = "01/01/2099"> 
 </cfif>

<cfset session.OnLoadMessage = "success('You have been successfully logged in...')">
<cfset relocate (area = "home", action = "AlumniSelect")>






