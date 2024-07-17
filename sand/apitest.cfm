
<cfset gateway = createObject('component', 'model.gateway')>
<cfset messageComposer = createObject('component', 'model.messageComposer')>

<cfset message = messageComposer.getNextMessage() >

<textarea cols="90" rows="3" ><cfoutput>#message#</cfoutput></textarea>


<cfset gateway.sendMessage (toPhoneNumber = "9546086744",
								message = message )>

<cfabort>


