
<cfparam  name="session.profile.AppUser.AppUserID" default="0">

<cfset uploadPath = "#request.imagesUploadPath#\pasteimage">

<cfif not directoryExists(uploadPath)>
	<cfdirectory action="create" directory="#uploadPath#">
</cfif>

<cfif isDefined("form.imageData") && len(trim(form.imageData))>
    <cfset base64Data = replace(form.imageData, "data:image/png;base64,", "", "all")>
    <cfset base64Data = replace(base64Data, "data:image/jpeg;base64,", "", "all")>

    <!-- Decode the base64 data -->
    <cfset binaryData = binaryDecode(base64Data, "base64")>
	<cfset fileName = createUUID() & ".png">

    <!-- Save the file to the server -->
  	<cffile action="write" 
		file="#uploadPath#/#filename#" 
		output="#binaryData#" 
		mode="777">

	<cfset savedIPicture = fileName>
<cfelse>
	<cfset session.OnLoadMessage = "error('There are no image found.')">
	<cflocation url="/index.cfm?area=home&action=pasteimage" addtoken="false" >	
</cfif>




<cfquery datasource="#request.dsnameWriter#" name="qpasteImageInsert">	

	INSERT INTO [dbo].[pasteImage]
			([pasteImage])
	VALUES
			(
			<cfif isDefined("form.imageData")>
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#savedIPicture#">
			<cfelse>
				NULL
			</cfif>
			)
				
</cfquery>

<cfset session.OnLoadMessage = "success('Submitted successfully')">
<cflocation url="/index.cfm?area=home&action=pasteimage" addtoken="false" >	







