
	
<cfcomponent output="false">
	
	<!---- Read Country ---->
	<cffunction name="getAllCountry" returntype="any">	
	
		<cftry>	
		
			<cfset arguments.callerWebSite = '#application.domain#'>
			<cfset arguments.clientIP = '#cgi.REMOTE_ADDR#'>
			<cfwddx action="cfml2wddx" input="#arguments#" output="apiinput">
	
			<cfhttp url="#application.apiRoot#/country.cfm" method="post" timeout="30" throwonerror="yes">
				<cfhttpparam type="formfield" name="arguments" value="#apiinput#">
			</cfhttp>
	
			<cfwddx action="wddx2cfml" input="#cfhttp.FileContent#" output="local.response">
			
			<cfreturn local.response.data/>
			
			<cfcatch type="any">
				<cfset local.response = structNew()>
	
				<cfset local.response.success = false>
				<cfset local.response.data = "">
				<cfset local.response.errorMessage = cfcatch.message>
				
				<cfreturn local.response/>
			</cfcatch>
		</cftry>
	</cffunction>
</cfcomponent> 

