<cfset errorMessage = "">
<cfparam  name="session.profile.AppUser.AppUserID" default="0">
<cfparam  name="form.AccountID" default="0">


<!---show error message --->
<cfif errorMessage gt "">
	<cfset showErrorMessage (Message = errorMessage)>	
	<cfabort>
</cfif>


<cfif val(form.AccountID) gt 0 >
	<cfquery datasource="#request.dsnameWriter#" name="qAccountUpdate">	


		UPDATE [dbo].[Account]
		SET [AccountName] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.AccountName#">
			,[isClosed] = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.isClosed#">
			,[Description] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Description#">
			,[DateLastUpdated] = getDate()
			,[UpdatedBy] = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(session.profile.AppUser.AppUserID)#">
			
		WHERE AccountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(form.AccountID)#">
	</cfquery>
	<cfset session.OnLoadMessage = "success('Update successfully')">
<cfelse>
	<cfquery datasource="#request.dsnameWriter#" name="qAccountInsert">	


		INSERT INTO [dbo].[Account]
			([AccountName]
			,[isClosed]
			,[Description]
			,[DateCreated]
			,[CreatedBy])
		VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.AccountName#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#form.isClosed#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Description#">,
			getDate(),
			<cfqueryparam cfsqltype="cf_sql_integer" value="#val(session.profile.AppUser.AppUserID)#">
			)
				
	</cfquery>
	<cfset session.OnLoadMessage = "success('Insert successfully')">
</cfif>
<cfset relocate (area = "account", action = "AccountSelect" )>








