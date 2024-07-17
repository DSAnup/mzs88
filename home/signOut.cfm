<cfset session.Profile = structNew()>
<cfset session.Profile.IsLoggedIn = false>

 <cfcookie name = "clientID" value = "" expires = "01/01/2000"> 
 

<cflocation url="/index.cfm" addtoken="false" >