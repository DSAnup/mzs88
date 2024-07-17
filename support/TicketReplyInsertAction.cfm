
	
	<cfparam name="form.AppUserID" default="" >

	<cfset errorMessage = "">
	
	<!--- make sure all required inputs are provided --->
	<cfif trim(form.Message) eq "">
		<cfset errorMessage = errorMessage & "Message must be provided.<br>">	
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

    	
	
	 
     
    <cfquery datasource="#request.dsnameWriter#" >
	
	   declare @ticketid int
		select @ticketid = ticketid 
			from ticket
			where TicketUUID = '#form.TicketID#'
	
	UPDATE ticket 
		SET status = 'Open' 
		WHERE TicketUUID = '#form.TicketID#'
			and Status = 'Closed'
			
   	INSERT INTO [dbo].[TicketReply]
           ([TicketID]
           ,[ClientID]
           ,[AppUserID]
           ,[Message]
           ,[AttachmentFileName]
	   ,[Attachment2FileName]
           ,[Attachment3FileName]
           ,[Attachment4FileName]
           ,[Attachment5FileName]
           ,[Attachment6FileName]
           ,[CreatedBy]
           ,[UpdatedBy]
           ,[DateCreated]
           ,[DateLastUpdated])
     VALUES
       (@ticketid
	   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.profile.client.ClientID#">
	   ,NULL
	   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Message#">
	   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#savedFile#">
	   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#saved2File#">
	   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#saved3File#">
	   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#saved4File#">
	   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#saved5File#">
	   ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#saved6File#">
	   ,#application.SystemUserID#
	   ,#application.SystemUserID#
	   ,getDate()
	   ,getDate())	
        
		
    </cfquery>
        
<cfset session.OnLoadMessage = "success('Replied Successfully')">
<cfset relocate (area = "support", action = "TicketUpdate&TicketID=#form.TicketID#")>