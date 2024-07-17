<cfset messageComposer = createObject('component', 'model.messageComposer')>

<cfquery datasource="#request.dsnameWriter#" name="qSMSTemplate">
				truncate table message		
			</cfquery>
			
			
			
<cfloop from="1" to="10000" index="counter" >
	
	<cfquery datasource="#request.dsnameWriter#" name="qSMSTemplate">
				insert into message (message)
				values
				('#messageComposer.getNextMessage()#'	)				
			</cfquery>

	
	<li><cfoutput>#counter#</cfoutput>

</cfloop>