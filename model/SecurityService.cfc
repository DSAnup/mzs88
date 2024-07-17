<cfcomponent>
	
	<!---- init the service for all data access ---->
	<cfset INSTANCE.AppUserService = createObject('component', 'model.AppUserService')>	
	<cfset INSTANCE.DAL = createObject('component', 'model.SecurityDAL')>	
	
	<cfset INSTANCE.MaxAccessFailedCount = 6>
	<cfset INSTANCE.MaxLockOutPeriod = 6> 				<!---in hours --->
	
	
	
	<cffunction name="Authenticate" access="public">		
		<cfargument name="Email" required="true" >
		<cfargument name="Password" required="true" >
		
		<!---- create the response object ---->
		<cfset local.response = structNew()>
		<cfset local.response.Status = "success">
		<cfset local.response.Message = "">
		
		
		
		<cfset local.AppUser = new ("AppUser")>
		<cfset local.Appuser.setEmail(arguments.email)>
		 
		<cfset local.AppUserArray = INSTANCE.AppUserService.getAppUserByExample(AppUser = local.AppUser, matchtype = "Exact")>
		
		
		<!--- check to see if the user exists --->
		<cfif arrayLen(local.AppUserArray) eq 0>
			<cfset local.response.Status = "fail">
			<cfset local.response.Message = "Username does not exist.  Please try again.">			
			<cfreturn local.response>
		<cfelseif arrayLen(local.AppUserArray) gt 1>	
			<cfset local.response.Status = "fail">
			<cfset local.response.Message = "Multiple User with same Username.  Please contact your administrator.">			
			<cfreturn local.response>				
		</cfif> 
		
		<!---passed this point, we know that there is only one user found with the user name, so proceed --->
		
		
		<!--- check to see if the user is not locked out, if so, has lockout ended --->
		<cfif local.AppUserArray[1].getLockOutEnabled() eq 1 and Now() lt local.AppUserArray[1].getLockOutEndDate()>
			<cfset local.response.Status = "fail">
			<cfset local.response.Message = "Your account is locked out until #dateformat(local.AppUserArray[1].getLockOutEndDate(), 'dd mmm yyyy')# #timeformat(local.AppUserArray[1].getLockOutEndDate(), 'HH:mm tt')#.  Please try later.">			
			<cfreturn local.response>			
		</cfif>
		
		
		
		<!---check to see if the password matches --->
		<cfif trim(arguments.password) neq local.AppUserArray[1].getPasswordhash()> 
			
			<!--- if a fail attempt, log the attempt, increment longin attempt and lock out if reached max try --->
			<cfset INSTANCE.DAL.LogFailedLoginAttempt(AppUserID = local.AppUserArray[1].getAppUserID(),
															MaxAccessFailedCount = INSTANCE.MaxAccessFailedCount,
															MaxLockOutPeriod = INSTANCE.MaxLockOutPeriod)>
			<cfset local.response.Status = "fail">
			<cfset local.response.Message = "Password does not match. Please try again. You have #INSTANCE.MaxLockOutPeriod - local.AppUserArray[1].getAccessfailedcount() - 1# attempt(s) remaining.">			
			<cfreturn local.response>	
		</cfif>
		
		
		<!---log the successful attempt --->
		<cfset INSTANCE.DAL.LogSuccessfulLogin(AppUserID = local.AppUserArray[1].getAppUserID())>
		
		<!--- return the user so that the session can be set  --->
		<cfset local.response.Appuser = local.AppUserArray[1]>
		
		<cfreturn local.response>	
		
		
	</cffunction>
	
	<cffunction name="Logout" access="public">		
		<cfargument name="AppUserID" required="true" >
	
		<!---log the successful attempt --->
		<cfset INSTANCE.DAL.Logout(AppUserID = arguments.AppUserID)>
	
	</cffunction>
	
	

</cfcomponent>