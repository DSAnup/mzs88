
<cfset errorMessage = "">
<cfset successMessage = "">

<!--- make sure all required inputs are provided --->
<cfif trim(form.fromphonenumber) eq "">
	<cfset errorMessage = errorMessage & "From phone number field can not be empty.">	
</cfif>

<cfif trim(form.tophonenumber) eq "">
	<cfset errorMessage = errorMessage & "To phone number field can not be empty.">	
</cfif>

<cfif isnumeric( trim(form.tophonenumber)) eq false or len( trim(form.tophonenumber)) neq 10>
	<cfset errorMessage = errorMessage & "To phone number must be a 10 digit long valid phone number.">	
</cfif> 

<cfif trim(form.message) eq "">
	<cfset errorMessage = errorMessage & "Message number field can not be empty.">	
</cfif>
	
   
<cfif errorMessage gt "">
	<cfset showErrorMessage (Message = errorMessage)>	
	<cfabort>
</cfif>	
   


<!---send the message --->
<!---<cfset data = '{
    "from": "+17088928705",
    "to": "+1#form.tophonenumber#",
    "text": "#form.message#"
  }'>--->
  
  
 <cfset data = '{
    "messaging_profile_id": "400175b3-cec4-45fb-aa73-081418a8160a",
    "to": "+1#form.tophonenumber#",
    "text": "#form.message#"
  }'>
  
  
 
<cfhttp url="https://api.telnyx.com/v2/messages/number_pool" method="post" >
	<cfhttpparam type="header" name="Content-Type" value="application/json" >
	<cfhttpparam type="header" name="Accept" value="application/json" >
	<cfhttpparam type="header" name="Authorization" value="Bearer KEY0174C16BC6899A7F689B717BA1FB554C_PJGVe5uz7o9V4cJjFCBMvU" >		
	<cfhttpparam type="body" value="#data#" >
</cfhttp>

<cfset response = cfhttp.fileContent>

<cfset responseStruct = DeserializeJSON(response)>

<cfif arrayLen( responseStruct.data.errors) eq 0>
	
	
	<!---insert into sms log --->
	<cfquery datasource="#request.dsnameWriter#" >
		insert into SMSLog
			(ToPhoneNumber, FromPhoneNumber, SMS,
			DateSent, Response)
		values
			('#form.ToPhoneNumber#', '#form.fromPhoneNumber#', '#message#',
			getDate(), '#response#')
	</cfquery>
	
	<!--- shobuj // fix this please --->
	<cfset showSuccessMessage (Message = 'Message  sent...')>	

<cfelse>
	<cfset showErrorMessage (Message = 'Message was not sent...')>	
	<cfabort>
</cfif>

  
  
  


 
 
 
