
<cfset errorMessage = "">
<cfparam  name="currentPicture" default="">
<cfparam  name="session.profile.AppUser.AppUserID" default="0">


<cfif len(trim(form.Picture))>
	<cffile action="upload"
		fileField="Picture"
		nameconflict="makeunique"
		destination="#request.imagesUploadPath#">
		<cfset savedIPicture = cffile.serverfile>
<cfelse>
	<cfset savedIPicture = form.currentPicture>
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

	
<cfquery datasource="#request.dsnameWriter#" name="qAppUserInsert">	
		
		UPDATE [dbo].[AppUser]
		   SET [NameInEnglish] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.NameInEnglish#">
		      ,[NickName] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.NickName#">
		      ,[FathersName] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.FathersName#">
		      ,[MothersName] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.MothersName#">		      
		      ,[PermanentAddress] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PermanentAddress#">
		      ,[PresentAddress] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PresentAddress#">
		      ,[Email] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Email#">
		      ,[Children] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Children#">
		      ,[PhoneNumer] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PhoneNumer#">
		      ,[Profession] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Profession#">
		      ,[WorkPlaceDetails] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.WorkPlaceDetails#">
		      ,[Facebook] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Facebook#">
		      ,[Linkedin] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Linkedin#">
		      ,[Skype] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Skype#">
		      ,[WhatsApp] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.WhatsApp#">
		      ,[Picture] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#savedIPicture#">
		      ,[UpdatedBy] = #val(session.profile.AppUser.AppuserID)#		     
		      ,[DateLastUpdated] = getDate()
			  
		 WHERE AppUserID = #val(form.AppUserID)#
		
		
		
		
</cfquery>
<cfset session.OnLoadMessage = "success('Information Updated Successfully.')">
<cfset relocate (area = "appuser", action = "MemberSelect")>






