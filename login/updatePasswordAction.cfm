
	<cfset errorMessage = "">


  <!--- make sure all required inputs are provided --->
    <cfif trim(form.currentpassword) eq "">
        <cfset errorMessage = errorMessage & "Current password must be provided.<br>">
		  
    </cfif>

	<!-- old password -->
	<cfquery datasource="#request.dsnameWriter#" name="qAppUserSelect"> 
	select Password
	from AppUser where AppUserID = #session.profile.AppUser.AppUserID#      
	</cfquery>
	
	
	  <!--- old password must match --->
	<cfif trim(form.currentpassword) neq qAppUserSelect.Password>
		<cfset errorMessage = errorMessage & "Old password doesnt match.<br>">  
	</cfif>
	
	
    <cfif trim(form.password) eq "">
        <cfset errorMessage = errorMessage & "New Password must be provided.<br>">  
    </cfif>
    
    <cfif trim(form.repassword) eq "">
        <cfset errorMessage = errorMessage & "New Password must be re-typed.<br>">  
    </cfif>
    
    <!--- password and re type password must match --->
    <cfif trim(form.repassword) neq trim(form.password)>
        <cfset errorMessage = errorMessage & "Password and re-typed password must match.<br>">  
    </cfif>
    
	   

    <cfif errorMessage gt "">
		<cfset showErrorMessage (Message = errorMessage)>	
		<cfabort>
	</cfif>
    
    
        
        
    <!--- if a fail attempt, log the attempt, increment longin attempt and lock out if reached max try --->

       <cfquery datasource="#request.dsnameWriter#">	

		UPDATE [dbo].[AppUser]
		   SET
		   	[Password]  = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.repassword#">
		 WHERE 
		 
		 	AppUserID = #session.profile.AppUser.AppUserID#  
        
    </cfquery>

      
<cfset session.OnLoadMessage = "success('Password Updated Successfully...')">    
<cfset relocate (area = "login", action = "updatePassword&passwordUpdated=Successfull")>
     
     
     
    
    
