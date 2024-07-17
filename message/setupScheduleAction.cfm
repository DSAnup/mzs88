

<cfset theYear = year(form.datescheduled)>
<cfset theMonth = month(form.datescheduled)>
<cfset theDay = day(form.datescheduled)>

<cfset theHour = listFirst(form.timescheduled, ":")>

<cfif right(trim(form.timescheduled), 2 ) eq "PM" and theHour neq 12>
	<cfset theHour = theHour + 12>
<cfelseif right(trim(form.timescheduled), 2 ) eq "AM" and theHour eq 12>
	<cfset theHour = 0 >
</cfif>


	
<cfset theMinute = val(left( listLast(form.timescheduled, ":"), 2 ))>

<cfset startTime = CreateDateTime ( #theYear#, #theMonth#, #theDay#, #theHour#, #theMinute# )>

<cfif startTime lt Now()>
	<cfset showErrorMessage (Message = 'Schedule can not start in the past.')>
	<cfabort>	
</cfif>

<cfquery datasource="#request.dsnameReader#" name="qLead" >
	select count(LeadID) as 'LeadCount' from Lead
</cfquery>


<cfloop from="1" to="#qLead.LeadCount#" step="#form.messageCount#" index="counter">
	
	
	
	<cfquery datasource="#request.dsnameWriter#">
		update Lead
			set DateTimeQueued = '#dateformat(startTime, "YYYY-MM-DD")# #timeformat(startTime, "HH:nn:ss")#',
				Status = 'Pending',
				NumberOfAttempt = 0
			where LeadID between #counter# and #counter + form.messageCount - 1#
			
			
		update setting	
			set Setting1 = '#form.messageCount#',
				Setting2 = '#form.datescheduled#',
				Setting3 = '#form.timescheduled#'
			where SettingName = 'Schedule'
			
			
	</cfquery>
	
	<cfset startTime = dateadd('n', 1, startTime )>
	

</cfloop>

<cfset application.cache = 'null'>


<!---success alert --->
<cfset showSuccessMessage (Message = 'Schedule has been successfully setup.')>	

