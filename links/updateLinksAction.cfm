
	<cfset errorMessage = "">


	<!--- make sure all required inputs are provided --->
	<cfif trim(form.Setting1) eq "">
		<cfset errorMessage = errorMessage & "Setting field can not be empty.">	
	</cfif>
		
	   
    <cfif errorMessage gt "">
		<cfset showErrorMessage (Message = errorMessage)>	
		<cfabort>
	</cfif>
   
 
    <cfquery datasource="#request.dsnameWriter#" >
        

		UPDATE [dbo].[Setting]
		   SET
		    [SettingName]  = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.SettingName#">
           	,[Setting1]  = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Setting1#">
		 WHERE 
		 
		 	SettingID = #form.SettingID#
        
    </cfquery>
    
    <cfset application.cache = 'null'>


<cfset showSuccessMessage (Message = 'Links saved successfully...')>	
    
    
