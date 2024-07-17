
<cfset maxAttempt = 3>


<!---lets get the settings related to schedule --->
<cfquery datasource="#request.dsnameReader#"  name="qSetting" >
		
	select *
		from Setting
		where SettingName = 'Schedule'

</cfquery>


<!---set all Processing to Penidng if out for too long --->
<cfquery datasource="#request.dsnameWriter#"  >
		
	update Lead
		set Status = 'Pending'
		where datediff(hour, DateTimePickedUp, getDate() ) > 2
			and Status = 'In Progress'
			and NumberOfAttempt <= #maxAttempt#

</cfquery>



<!--- grab the top allowed number of leads --->
<cfquery datasource="#request.dsnameWriter#"  name="qLead" >
	
	truncate table TempLead
	
	insert into TempLead
	select top #qSetting.Setting1#  PhoneNumber
		from Lead
		where Status = 'Pending'
			and DateTimeQueued < getDate()
			and NumberOfAttempt < #maxAttempt#
			
	update Lead
		set Status = 'In Progress',
			DateTimePickedUp = getDate(),
			NumberOfAttempt = NumberOfAttempt + 1
		where PhoneNumber in (select PhoneNumber from TempLead)
		
	select * from TempLead
			
</cfquery>



<!--- loop through each lead and send out the message --->
<cfset gateway = createObject('component', 'model.gateway')>
<cfset messageComposer = createObject('component', 'model.messageComposer')>
<cfloop query="qLead">
	<cfset gateway.sendMessage (toPhoneNumber = qLead.PhoneNumber,
								message =  messageComposer.getNextMessage() )>
</cfloop>





