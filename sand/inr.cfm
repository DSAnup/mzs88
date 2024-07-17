


<cfset o = createObject('component', 'model.emailservice')>

<cfdump var="#o#" >

<cfset exchangeRate = o.usd2inr()>

<cfdump var="#exchangeRate#" >