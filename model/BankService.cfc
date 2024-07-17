
	
<cfcomponent output="false">
	
	<!---- Read Country ---->
	<cffunction name="getAllBank" returntype="any">	

		<cftry>	
		
			<cfset arguments.callerWebSite = '#application.domain#'>
			<cfset arguments.clientIP = '#cgi.REMOTE_ADDR#'>
			<cfwddx action="cfml2wddx" input="#arguments#" output="apiinput">
	
			<cfhttp url="#application.apiRoot#/bank.cfm" method="post" timeout="30" throwonerror="yes">
				<cfhttpparam type="formfield" name="arguments" value="#apiinput#">
			</cfhttp>
	
			<cfwddx action="wddx2cfml" input="#cfhttp.FileContent#" output="local.response">
			
			<cfreturn local.response.data/>
			
			<cfcatch type="any">
				<cfset local.response = structNew()>
	
				<cfset local.response.success = false>
				<cfset local.response.data = "">
				<cfset local.response.errorMessage = cfcatch.message>
				
				<cfreturn local.response/>
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="setDepositBank" >
		<cfargument name="ClientID" required="true" >
		
		<cfquery datasource="#request.dsnameWriter#" name="qDepositBankSelect">

	
			update client set DepositBankID = 0
			where DepositBankID in (select DepositBankID from DepositBank where isActive = 0)


			declare @DepositBankID int
				select @DepositBankID = DepositBankID
					from Client
					where ClientID = #arguments.ClientID#
				
				if @DepositBankID is not null and @DepositBankID != 0
				begin
					select * from DepositBank where DepositBankID = @DepositBankID
					return
				end
	
			DECLARE @bank TABLE(BankID INT, Total int)
	 
			INSERT INTO @bank
	
			select top 1 DepositBank.DepositBankID, count (DepositBank.DepositBankID) 'total'
				from DepositBank
					left join Client on DepositBank.DepositBankID =  Client.DepositBankID
	
					where DepositBank.isActive = 1
	
					group by DepositBank.DepositBankID
	
					order by count (DepositBank.DepositBankID)
	
				select @DepositBankID = BankID from @Bank
	
				update Client set 
					DepositBankID = @DepositBankID
					where ClientID = #arguments.ClientID#
					
				select * from DepositBank where DepositBankID = @DepositBankID
	
				
		
		</cfquery>
		
		
		<cfreturn qDepositBankSelect>
		
		
	</cffunction>
	
	
	
	
	
</cfcomponent> 

