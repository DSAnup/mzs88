<cfset xs = y>

<cfquery datasource="#request.dsnameWriter#" name="q">
	
	select * from LeadOrder where LeadOrderStatusID != 3
</cfquery>

<cfdump var="#q#" >

<cfloop query="q">
	
	<cfset request.quantity = q.ORDERQUANTITY>
	<cfset request.price = q.LeadPrice>
	
	<cfset request.duration = q.OrderDuration>
	
	<cfset request.subPrice = request.quantity * request.price * request.duration>
	
	<cfset request.leadorderid = q.leadorderid>
	<cfset request.method = q.PAYMENTOPTIONID>
	
	
	<cfquery datasource="#request.dsnameWriter#" name="qIn">
		
		select sum(price) as 'price'
			from leadorderfield
			where leadorderid = #request.leadorderid#
	</cfquery>
	
	<cfset request.optPrice = val(qIn.price) * request.quantity * request.duration>
	
	<cfset request.total = request.subPrice + request.optPrice>
	
	<cfif request.method eq 3>
		<cfset request.total = request.total * 1.15>
	</cfif>
	
	<hr>
		
		<cfoutput>
		
	Existing price = #q.TotalPrice#
	
	Should Be = #request.total#
	
	Mass = #request.total + request.total/15#
	</cfoutput>
	
	
	<cfquery datasource="#request.dsnameWriter#">
		
		update LeadOrder
			set TotalPrice = #numberformat(request.total, '9.99')#
			where LeadOrderID = #request.leadorderid#
		
	</cfquery>
	
</cfloop>