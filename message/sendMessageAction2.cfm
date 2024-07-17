	<cfdump var="#form#" />
	<cfset errorMessage = "">
	
	<!--- make sure all required inputs are provided --->
	<cfif trim(form.SMSTemplate) eq "">
		<cfset errorMessage = errorMessage & "Messsage field can not be empty.">	
	</cfif>
		
	   
    <cfif errorMessage gt "">
		<cfset showErrorMessage (Message = errorMessage)>	
		<cfabort>
	</cfif>
   
        
    <!--- if a fail attempt, log the attempt, increment longin attempt and lock out if reached max try --->
    <cfquery datasource="#request.dsnameWriter#" >

	INSERT INTO [dbo].[SMSTemplate]
           ([SMSTemplate]    
		   ,[DateCreated]
		   ,[DateLastUpdated]
		   ,[CreatedBy]
		   ,[UpdatedBy])
     VALUES
           (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.SMSTemplate#">
		   ,getDate()
		   ,getDate()
		   ,#application.SystemUserID#
		   ,#application.SystemUserID#)
        
    </cfquery>

      
<cfset session.OnLoadMessage = "success('User Successfully Added...')">    
<cfset relocate (area = "message", action = "inbox")>
     
     
     
    