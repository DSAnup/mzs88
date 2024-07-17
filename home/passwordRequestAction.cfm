
<cfset errorMessageReset = "">

<!--- make sure all required inputs are provided --->
<cfif trim(form.Email) eq "">
	<cfset errorMessageReset = errorMessageReset & "A valid email must be provided.">	
</cfif>


<!---show error message --->
<cfif errorMessageReset gt "">
	<cfset showErrorMessageReset (Message = errorMessageReset)>	
	<cfabort>
</cfif>



<!--- lets get the users that matches the email --->
<cfquery datasource="#request.dsnameReader#" name="qClientSelect">	
	select Password
		from Client		
		where Email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#">	
</cfquery>



<!--- set the session level profile --->
<cfset session.Profile.IsLoggedIn = false>


<!--- check to see if the user exists // if so send password --->
<cfif qClientSelect.RecordCount gt 0>

	<cfoutput>
	
	<!--- send an email confirmation--->
		<cfmail to="#form.email#"
			bcc="fakir.hossain@gmail.com" 
			subject="Password Request" 
			from="noreply@godspeedcorp.com" 		
			server="smtp.gmail.com" useSSL="true" username="noreply@godspeedcorp.com" password="GMOmSoft1*$" port="465">
		
				
	<cfmailpart type="text/plain" >
	Password Request
	
	Here is your password: #qClientSelect.Password#
	</cfmailpart>
	
		<cfmailpart type="text/html" >
			
			<h3>Password Request</h3>
			
			Here is your password: #qClientSelect.Password#
		</cfmailpart>
		
	</cfmail>
	
	</cfoutput>
	
</cfif>

<!--- finally give real success message if an account was found --->
<cfset showSuccessMessage (Message = "We have sent the password to your email.  Click Back to Login to Proceed.")> 


<cfparam name="url.justlogin" default="" >

<cfif url.justlogin eq "true">
	<cfset relocate (area = "home", action = "loginorSignin&leadtype=#url.leadtype#&justlogin=true")>
<cfelse>
	<cfset relocate (area = "home", action = "loginorSignin&leadtype=#url.leadtype#")>
</cfif>


<cfset relocate (area = "home", action = "loginorSignin&leadtype=#url.leadtype#")>
<cfabort>