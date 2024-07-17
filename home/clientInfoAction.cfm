<!--- save the client info in session object--->
<cfloop list="#form.fieldnames#" index="field">	
	<cfif left(field, 1) neq "G">
		<cfset "session.profile.client.#field#" = evaluate("form.#field#")>	
	</cfif>					
</cfloop>

<cfset session.profile.client.countryid = listFirst(form.country, ":")>
<cfset session.profile.client.countryname = listLast(form.country, ":")>


<cfquery datasource="#request.dsnameWriter#" name="qClientInsert">	
		
	UPDATE [dbo].[Client]
	   SET [BusinessName] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.profile.client.BusinessName#">
	      ,[FirstName] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.profile.client.FirstName#">
	      ,[LastName] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.profile.client.LastName#">
	      ,[Phone] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.profile.client.Phone#">
	      ,[Email] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.profile.client.Email#">		      
	      ,[SkypeID] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.profile.client.SkypeID#">
	      ,[Address1] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.profile.client.Address1#">
	      ,[Address2] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.profile.client.Address2#">
	      ,[City] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.profile.client.City#">
	      ,[State] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.profile.client.State#">
	      ,[ZipCode] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.profile.client.ZipCode#">
	      ,[CountryID] = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.profile.client.CountryID#">
	      ,[DeliveryEmail] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.profile.client.DeliveryEmail#">
	      ,[WebSiteID] = <cfqueryparam cfsqltype="cf_sql_integer" value="#request.callerWebSiteID#">
	      ,[ClientIP] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cgi.REMOTE_ADDR#">
	      ,[UpdatedBy] = #application.SystemUserID#		     
	      ,[DateLastUpdated] = getDate()
	 WHERE ClientID = #session.profile.Client.ClientID#
	
</cfquery>




<!--- redirect to orderreview--->
<cflocation url="./index.cfm?area=home&action=orderreview" addtoken="no">	