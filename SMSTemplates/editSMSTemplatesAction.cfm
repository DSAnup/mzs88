
	<cfset errorMessage = "">
	
	<!--- make sure all required inputs are provided --->
	<cfif trim(form.SMSTemplate) eq "">
		<cfset errorMessage = errorMessage & "SMSTemplate field can not be empty.">	
	</cfif>
		
	   
    <cfif errorMessage gt "">
		<cfset showErrorMessage (Message = errorMessage)>	
		<cfabort>
	</cfif>
   
   

        
    <!--- if a fail attempt, log the attempt, increment longin attempt and lock out if reached max try --->
    <cfquery datasource="#request.dsnameWriter#" >



		UPDATE [dbo].[SMSTemplate]
		   SET
		    [SMSTemplate]  = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.SMSTemplate#">
			,[DateCreated]  = getDate()
		    ,[DateLastUpdated] = getDate()
		    ,[CreatedBy] = #application.SystemUserID#
		    ,[UpdatedBy] = #application.SystemUserID#
		 WHERE 
		 
		 	SMSTemplateID = #form.SMSTemplateID#

        
    </cfquery>
    
    <cfset application.cache = 'null'>

      
<cfset session.OnLoadMessage = "success('SMS Template Successfully Updated...')">    
<cfset relocate (area = "SMSTemplates", action = "showAllSMSTemplates")>
     
     
     
    