<cfcomponent>
	
	<cfset this.name = "MZS">
	<cfset this.sessionmanagement="Yes">
	<cfset this.sessiontimeout="#CreateTimeSpan(0, 0, 30, 0)#" >
	<cfset this.clientmanagement="no">
	<cfset this.setclientcookies="Yes" >
	<cfset request.addGstIndianRupee = 15>
	<cfset this.searchimplicitscopes=True>

	
	<cffunction name="onSessionStart" returnType="void">
		<cfset session.Profile = structNew()>
		<cfset session.Profile.isLoggedIn = false>
		<cfset session.isDebugMode = false>
		
		<cfset session.isTrustedClient = true>
		

		
		
		<!--- default area / action --->
		<cfparam name="url.area" default="home" >
		<cfparam name="url.action" default="home" >
		
		<!--- send to login page --->
		<cfif session.profile.isLoggedIn eq false AND url.area neq "home" >			
			<cflocation url="/?area=home&action=login" addtoken="false" >			
		</cfif>
		
	
		
	</cffunction>
	

	<cffunction name="onApplicationStart" returnType="boolean">
		
<!--- 		<cfset application.domain = "https://www.mzs88alumni.com"> --->
		
		<cfreturn true>
	</cffunction>
	
	
	
	
	
	<!---implement this method to handle any request start needs, 
	do not use OnRequest as it is used by the Fraworm to navigete trafic --->
	<cffunction name="OnRequestStart" returntype="boolean" >
		<cfargument type="String" name="targetPage" required=true/>
		
<!--- 		<cfset enforceSSLRequirement()> --->

		
		<cfset request.dsnameReader = "mzs">
		<cfset request.dsnameWriter = "mzs">

		<cfset request.imagesUploadPath = "C:\sites\mzs88alumni.hope-tech.net\mzs88\assets\alumni_pictures">
		
		<cfset request.MaxAutoInvoiceAmount = 5000>
		
		<cfparam name="session.Profile" default="#structNew()#">
		<cfparam name="session.Profile.isLoggedIn" default="false">
		<cfparam name='session.IsSpecialOfferAvailable' default='false'>
		
		<!--- default area / action --->
		<cfif session.profile.isLoggedIn eq false>			
			<cfparam name="url.area" default="home" >
			<cfparam name="url.action" default="home" >
		<cfelse>
			<cfparam name="url.area" default="home" >
			<cfparam name="url.action" default="home" >
		</cfif>
		
		
		<!--- During development, starting the app anyway, comment our for production  --->
		<cfset onApplicationStart()> 
		
		<!---include the user defined functions --->		
		<cfinclude template="fusebox/udf.cfm" >		
		<cfreturn true>
	</cffunction>
	
	
<!--- 	<cffunction name="enforceSSLRequirement" access="package" returntype="void"> 
	
		<cfif cgi.https neq "on">
			
			<!--- Redirect the user to the target connection. --->
       		<cflocation url="#application.domain#" addtoken="false" />
			
		</cfif>
	
	</cffunction>--->
	
</cfcomponent>


