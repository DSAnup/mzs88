<cfquery datasource="#request.dsnameReader#" name="qMessage">
	select *
		from SMSTemplate
		where SMSTemplateID = 1
</cfquery>

<cfdump var="#qMessage#" >

<cfset local.sMessage = qMessage.SMSTemplate>

<cfset local.messagePartArray = ListToArray(qMessage.SMSTemplate, "{}##")>

<cfset local.finalMessage = "">
<cfloop array="#local.messagePartArray#" item="partMessage" >
	
	
	<cfif partMessage eq "link">
		<cfset local.finalMessage = local.finalMessage & getLink()>
		<cfcontinue>
	<cfelseif listLen(partMessage, "|") eq 1 >
		<cfset local.finalMessage = local.finalMessage & partMessage>
		<cfcontinue>
	<cfelse>
		<cfset maxIndex = listLen(partMessage, "|")>
		<cfset local.finalMessage = local.finalMessage & listGetAt(partMessage, RandRange(1, maxIndex), "|")>
	</cfif>
		
</cfloop>

<cfdump var="#local#" >


<cffunction name="getLink" >
	<cfreturn "unique Link">
</cffunction>

