<cfset data = '{
    "from": "+17088928705",
    "to": "+19546086744",
    "text": "This is just another test..."
  }'>
  
  
 
<cfhttp url="https://api.telnyx.com/v2/messages" method="post" >
	<cfhttpparam type="header" name="Content-Type" value="application/json" >
	<cfhttpparam type="header" name="Authorization" value="Bearer KEY0174C16BC6899A7F689B717BA1FB554C_PJGVe5uz7o9V4cJjFCBMvU" >
	
	<cfhttpparam type="body" value="#data#" >


</cfhttp>

<cfdump var="#cfhttp#" >