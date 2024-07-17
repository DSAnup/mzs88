
	<cfset errorMessage = "">
	
	<!--- make sure all required inputs are provided --->
	<cfif trim(form.Setting1) eq "">
		<cfset errorMessage = errorMessage & "Setting field can not be empty.">	
	</cfif>
		
	   
    <cfif errorMessage gt "">
		<cfset showErrorMessage (Message = errorMessage)>	
		<cfabort>
	</cfif>
   
   
  
        
    <!--- if a fail attempt, log the attempt, increment longin attempt and lock out if reached max try --->
    <cfquery datasource="#request.dsnameWriter#" >

	INSERT INTO [dbo].[Setting]
           ([SettingName]
           ,[Setting1]
           ,[Setting2]
           ,[Setting3])
     VALUES
           (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.SettingName#">
		   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Setting1#">
		   ,NULL
		   ,NULL)
        
    </cfquery>
    
    <cfset application.cache = 'null'>

      
<cfset session.OnLoadMessage = "success('Setting Successfully Added...')">    
<cfset relocate (area = "links", action = "showAllLinks")>
     
     
     
    