
<cfset errorMessage = "">
<cfparam  name="currentPicture" default="">
<cfparam  name="session.profile.AppUser.AppUserID" default="0">

<cfparam name="form.password" default="">
<cfparam name="form.Cpassword" default="">



<cfif len(form.password) lt 6>
	<cfset errorMessage = errorMessage & "Length of password must be minimum 6 characters!<br>" >
<cfelseif form.password neq form.Cpassword>
	<cfset errorMessage = errorMessage & "Password and Confirm password doesnt match!<br>" >
</cfif>


<cfif len(trim(form.Picture))>
	<cffile action="upload"
		fileField="Picture"
		nameconflict="makeunique"
		destination="#request.imagesUploadPath#">
		<cfset savedIPicture = cffile.serverfile>
</cfif> 

<!---show error message --->
<cfif errorMessage gt "">
	<cfset showErrorMessage (Message = errorMessage)>	
	<cfabort>
</cfif>


<!--- init the session variables from the form scope --->
<cfloop  list="#form.FieldNames#" item="field" >
	<cfset session.profile.AppUser.AppUser[field] = form[field]>	
</cfloop>

<!--- if a new client, insert it into the db now --->

<cfquery datasource="#request.dsnameWriter#" name="qAppUserInsert">	
	
	
	INSERT INTO [dbo].[AppUser]
           ([NameInEnglish]
           ,[NickName]
           ,[FathersName]
           ,[MothersName]
           ,[PermanentAddress]
           ,[PresentAddress]
           ,[Email]
           ,[Children]
           ,[PhoneNumer]
           ,[Profession]
           ,[WorkPlaceDetails]
		   ,[Facebook]
           ,[Linkedin]
           ,[Skype]
           ,[WhatsApp]
           ,[Password]
           ,[Picture]
           ,[DateCreated]
           ,[CreatedBy]
           ,[DateLastUpdated]
           ,[UpdatedBy])
	     VALUES
	     		(
	     		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.NameInEnglish#">,
	     		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.NickName#">,
	     		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.FathersName#">,
	     		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.MothersName#">,
	     		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PermanentAddress#">,
	     		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PresentAddress#">,
	     		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Email#">,
	     		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Children#">,
	     		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PhoneNumer#">,
	     		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Profession#">,
	     		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.WorkPlaceDetails#">,
	     		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Facebook#">,
	     		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Linkedin#">,
	     		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Skype#">,
	     		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.WhatsApp#">,
	     		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Password#">,
				<cfif form.Picture neq ''>
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#savedIPicture#">,
				<cfelse>
					NULL,
				</cfif>
	            getDate(),
				#val(session.profile.AppUser.AppUserID)#,
				getDate(),
	            #val(session.profile.AppUser.AppUserID)#
	          )
	          
	      select SCOPE_IDENTITY() as AppUserID
           
</cfquery>
<cfset session.OnLoadMessage = "success('Submitted successfully')">
<cfset relocate (area = "home", action = "thankyou")>






