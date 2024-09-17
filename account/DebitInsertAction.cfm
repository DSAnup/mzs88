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
			,[Debit] = <cfqueryparam cfsqltype="cf_sql_float" value="#form.Debit#">
			,[Note] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Note#">
			,[TransactionDate] = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.TransactionDate#">
			,[DateLastUpdated] = getDate()
			,[UpdatedBy] = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(session.profile.AppUser.AppUserID)#">
			
		WHERE TransactionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(form.TransactionID)#">
	</cfquery>
	<cfset session.OnLoadMessage = "success('Debit Update successfully')">

<cfelse>
	
	<cfquery datasource="#request.dsnameWriter#" name="qTransactionInsert">	
		INSERT INTO [dbo].[TransactionDetails]
			([AccountID]
			,[Debit]
			,[Note]
			,[TransactionDate]
			,[DateCreated]
			,[CreatedBy]
			)
		VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.AccountID#">,
			<cfqueryparam cfsqltype="cf_sql_float" value="#form.Debit#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Note#">,
			<cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.TransactionDate#">,
			getDate(),
			<cfqueryparam cfsqltype="cf_sql_integer" value="#val(session.profile.AppUser.AppUserID)#">
			)
				
	</cfquery>
	<cfset session.OnLoadMessage = "success('Debit Insert successfully')">
</cfif>
<cfset relocate (area = "account", action = "DebitInsert" )>








