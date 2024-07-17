	<cfparam name="form.OrderID" default="" >

	<cfset errorMessage = "">
	
	<!--- make sure all required inputs are provided --->
	<cfif trim(form.Subject) eq "">
		<cfset errorMessage = errorMessage & "Subject must be provided.<br>">	
	</cfif>
	<cfif trim(form.DepartmentID) eq "">
		<cfset errorMessage = errorMessage & "Department must be provided.<br>">	
	</cfif>

	<cfif trim(form.Priority) eq "">
		<cfset errorMessage = errorMessage & "Priority must be provided.<br>">	
	</cfif>

	<cfif trim(form.Message) eq "">
		<cfset errorMessage = errorMessage & "Message must be provided.<br>">	
	</cfif>


	<cfif trim(form.Status) eq "">
		<cfset errorMessage = errorMessage & "Status must be provided.<br>">	
	</cfif>

      <cfif errorMessage gt "">
		<cfset showErrorMessage (Message = errorMessage)>	
		<cfabort>
	</cfif>  

 	<cfif len(trim(form.AttachmentFileName))>
		  <cffile action="upload"
			 fileField="AttachmentFileName"
			 nameconflict="makeunique"
			 destination="#request.imagesUploadPath#">
			 
		  <cfset savedFile = cffile.serverFile>
	
	<cfelse>
		<cfset savedFile = ''>
		
	</cfif>

	
	<cfif len(trim(form.Attachment2FileName))>
		  <cffile action="upload"
			 fileField="Attachment2FileName"
			 nameconflict="makeunique"
			 destination="#request.imagesUploadPath#">
			 
		  <cfset saved2File = cffile.serverFile>
	
	<cfelse>
		<cfset saved2File = ''>
		
	</cfif>
	
	<cfif len(trim(form.Attachment3FileName))>
		  <cffile action="upload"
			 fileField="Attachment3FileName"
			 nameconflict="makeunique"
			 destination="#request.imagesUploadPath#">
			 
		  <cfset saved3File = cffile.serverFile>
	
	<cfelse>
		<cfset saved3File = ''>
		
	</cfif>
	

	<cfif len(trim(form.Attachment4FileName))>
		  <cffile action="upload"
			 fileField="Attachment4FileName"
			 nameconflict="makeunique"
			 destination="#request.imagesUploadPath#">
			 
		  <cfset saved4File = cffile.serverFile>
	
	<cfelse>
		<cfset saved4File = ''>
		
	</cfif>
	

	<cfif len(trim(form.Attachment5FileName))>
		  <cffile action="upload"
			 fileField="Attachment5FileName"
			 nameconflict="makeunique"
			 destination="#request.imagesUploadPath#">
			 
		  <cfset saved5File = cffile.serverFile>
	
	<cfelse>
		<cfset saved5File = ''>
		
	</cfif>
	

	<cfif len(trim(form.Attachment6FileName))>
		  <cffile action="upload"
			 fileField="Attachment6FileName"
			 nameconflict="makeunique"
			 destination="#request.imagesUploadPath#">
			 
		  <cfset saved6File = cffile.serverFile>
	
	<cfelse>
		<cfset saved6File = ''>
		
	</cfif>
   
	  
     <!--- if a fail attempt, log the attempt, increment longin attempt and lock out if reached max try --->
    <cfquery datasource="#request.dsnameWriter#" >
	
	INSERT INTO [dbo].[Ticket]
           (TicketUUID
           	,[ClientID]
           ,[Subject]
           ,[DepartmentID]
           ,[OrderID]
           ,[Priority]
           ,[Message]
           ,[AttachmentFileName]
	   ,[Attachment2FileName]
           ,[Attachment3FileName]
           ,[Attachment4FileName]
           ,[Attachment5FileName]
           ,[Attachment6FileName]
           ,[Status]
           ,[CreatedBy]
           ,[UpdatedBy]
           ,[DateCreated]
           ,[DateLastUpdated])
     VALUES
       ( '#CreateUUID()#'
       ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ClientID#">
	   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Subject#">
	   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.DepartmentID#">
	   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.OrderID#">
	   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Priority#">
	   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Message#">
	   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#savedFile#">
	   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#saved2File#">
	   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#saved3File#">
	   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#saved4File#">
	   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#saved5File#">
	   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#saved6File#">
	   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Status#">
	   ,#form.ClientID#
	   ,#form.ClientID#
	   ,getDate()
	   ,getDate())	
        
		
    </cfquery>
        
<cfset session.OnLoadMessage = "success('Your Ticket Submitted Successfully')">
<cfset relocate (area = "support", action = "TicketSelect")>