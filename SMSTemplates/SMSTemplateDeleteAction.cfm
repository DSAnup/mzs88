	<cfdump var="#form#" />
	<cfset errorMessage = "">
	
	   
    <cfif errorMessage gt "">
		<cfset showErrorMessage (Message = errorMessage)>	
		<cfabort>
	</cfif>
   
   

        
    <!--- if a fail attempt, log the attempt, increment longin attempt and lock out if reached max try --->
    <cfquery datasource="#request.dsnameWriter#" >

	delete from  [dbo].[SMSTemplate]
           
      where SMSTemplateID = #url.SMSTemplateID#
        
    </cfquery>
    
    <cfset application.cache = 'null'>

      
<cfset session.OnLoadMessage = "success('SMS Template Successfully Deleted...')">    
<cfset relocate (area = "SMSTemplates", action = "showAllSMSTemplates")>
     
     
     
    