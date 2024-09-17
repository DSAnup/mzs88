<cfset errorMessage = "">
<cfparam  name="session.profile.AppUser.AppUserID" default="0">
<cfparam  name="form.TransactionID" default="0">


<!---show error message --->
<cfif errorMessage gt "">
	<cfset showErrorMessage (Message = errorMessage)>	
	<cfabort>
</cfif>


<cfif val(form.TransactionID) gt 0 >

	<cfquery datasource="#request.dsnameWriter#" name="qTransactionUpdate">	
		UPDATE [dbo].[TransactionDetails]
		SET [AccountID] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.AccountID#">
			,[Credit] = <cfqueryparam cfsqltype="cf_sql_float" value="#form.Credit#">
			,[Note] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Note#">
			,[TransactionDate] = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.TransactionDate#">
			,[DateLastUpdated] = getDate()
			,[UpdatedBy] = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(session.profile.AppUser.AppUserID)#">
			
		WHERE TransactionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(form.TransactionID)#">
	</cfquery>
	<cfset session.OnLoadMessage = "success('Credit Update successfully')">

<cfelse>
	
	<cfquery datasource="#request.dsnameWriter#" name="qTransactionInsert">	
		INSERT INTO [dbo].[TransactionDetails]
			([AccountID]
			,[Credit]
			,[Note]
			,[TransactionDate]
			,[DateCreated]
			,[CreatedBy]
			)
		VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.AccountID#">,
			<cfqueryparam cfsqltype="cf_sql_float" value="#form.Credit#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Note#">,
			<cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.TransactionDate#">,
			getDate(),
			<cfqueryparam cfsqltype="cf_sql_integer" value="#val(session.profile.AppUser.AppUserID)#">
			)
				
	</cfquery>
	<cfset session.OnLoadMessage = "success('Credit Insert successfully')">
</cfif>
<cfset relocate (area = "account", action = "CreditInsert" )>








