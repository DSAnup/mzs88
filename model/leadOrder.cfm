
<cfset reply = structNew()>

<cfset reply.success = false>
<cfset reply.data = "">
<cfset reply.errorMessage = "">

<cftry>






<!--- abort unless a post call and argument is sent as a form variable in wddx format --->
<cfif not isdefined("form.arguments") or not iswddx(form.arguments)>
	No data sent 
	<cfabort>
<cfelse>
	<cfwddx action="wddx2cfml" input="#form.arguments#" output="local.arguments">
</cfif>

<!---check if the client is barrd based on IP or email address --->
<cfquery datasource="#application.ReadableDataSourceName#" name="qBlackListSelect">
	select BlackListID
		from BlackList
		where IPorEmail = <cfqueryparam cfsqltype="cf_sql_varchar" 
										value="#trim(local.arguments.ClientIP)#">
										
			or IPorEmail = <cfqueryparam cfsqltype="cf_sql_varchar" 
										value="#trim(local.arguments.client.Email)#">

</cfquery>

<cfif qBlackListSelect.RecordCount gt 0>
	<cfthrow message="System is currently not able to take order. 
						Please contact our officce for further assisstance.">
</cfif>
	
	


<cfquery datasource="#application.WritableDataSourceName#" name="qLeadOrderInsert">

	declare @WebsiteID int
	
	select @WebsiteID = WebSiteID
		from WebSite
		where WebSiteName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(local.arguments.callerWebSite)#">
		
	<!--- dedup client--->	
	declare @ClientID int = 0
	select @ClientID = ClientID
		from Client
		where Email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(local.arguments.client.email)#">
			or Phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(local.arguments.client.phone)#">
		
	if @ClientID > 0
		<!--- update client--->
		begin
		
			UPDATE [dbo].[Client]
			   SET [BusinessName] = <cfqueryparam cfsqltype="cf_sql_varchar" 
			   								value="#trim(local.arguments.client.businessName)#">
				  ,[FirstName] = <cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.client.FirstName)#">
				  ,[LastName] = <cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.client.LastName)#">
				  ,[Phone] = <cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.client.Phone)#">
				  ,[Email] = <cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.client.Email)#">
				  ,[SkypeID] = <cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.client.SkypeID)#">						
				  ,[Address1] = <cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.client.Address1)#">
				  ,[Address2] = <cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.client.Address2)#">
				  ,[City] = <cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.client.City)#">
				  ,[State] = <cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.client.State)#">
				  ,[ZipCode] = <cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.client.ZipCode)#">
				  ,[CountryID] = <cfqueryparam cfsqltype="cf_sql_integer" 
				  							value="#trim(local.arguments.client.CountryID)#">
				  ,[WebSiteID] = @WebsiteID
				  ,[ClientIP] = <cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.ClientIP)#">				  
				  ,[UpdatedBy] = 1				  
				  ,[DateLastUpdated] = getdate()
			 WHERE ClientID = @ClientID
		
		
		end
	
	else
		<!---create client--->
		begin
			INSERT INTO [dbo].[Client]
			   ([BusinessName]
			   ,[FirstName]
			   ,[LastName]
			   ,[Phone]
			   ,[Email]
			   ,[SkypeID]
			   ,[Address1]
			   ,[Address2]
			   ,[City]
			   ,[State]
			   ,[ZipCode]
			   ,[CountryID]
			   ,[WebSiteID]
			   ,[ClientIP]
			   ,[CreatedBy]
			   ,[UpdatedBy]
			   ,[DateCreated]
			   ,[DateLastUpdated])
			values (
					<cfqueryparam cfsqltype="cf_sql_varchar" 
			   								value="#trim(local.arguments.client.businessName)#">
				  ,<cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.client.FirstName)#">
				  ,<cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.client.LastName)#">
				  ,<cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.client.Phone)#">
				  ,<cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.client.Email)#">
				  ,<cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.client.SkypeID)#">
				  ,<cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.client.Address1)#">
				  ,<cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.client.Address2)#">
				  ,<cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.client.City)#">
				  ,<cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.client.State)#">
				  ,<cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.client.ZipCode)#">
				  ,<cfqueryparam cfsqltype="cf_sql_integer" 
				  							value="#trim(local.arguments.client.CountryID)#">
				  ,@WebsiteID
				  ,<cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.ClientIP)#">				  
				  ,1
				  ,1				  
				  ,getdate()
				  ,getdate()
			
			)
			
			
			select @ClientID =  SCOPE_IDENTITY()
		
		end
<cfset session.Cart.DiscountPercentage = form.DiscountPercentage>
<cfset session.Cart.DiscountNote = form.DiscountNote>
	
	<!--- create lead order--->
	INSERT INTO [dbo].[LeadOrder]
           ([ClientID]
           ,[LeadProductID]
           ,[OrderQuantity]
           ,[OrderDuration]
           ,[PriceOption]
           ,[LeadPrice]
           ,[TotalPrice]
		   ,[LeadOrderStatusID]
		   ,[DiscountedPrice]
		   ,[DiscountNote]
		   ,[DiscountPercentage]
           ,[WebSiteID]
           ,[ClientIP]
           ,[CreatedBy]
           ,[UpdatedBy]
           ,[DateCreated]
           ,[DateLastUpdated])
	values (
			@ClientID
			,<cfqueryparam cfsqltype="cf_sql_integer" 
				  							value="#trim(local.arguments.cart.leadProductID)#">
			,<cfqueryparam cfsqltype="cf_sql_integer" 
				  							value="#trim(local.arguments.cart.orderQuantity)#">	
			,<cfqueryparam cfsqltype="cf_sql_integer" 
				  							value="#trim(local.arguments.cart.orderDuration)#">
			,<cfqueryparam cfsqltype="cf_sql_varchar" 
				  							value="#trim(local.arguments.cart.PriceOption)#">
			,<cfqueryparam cfsqltype="cf_sql_float" 
				  							value="#val(local.arguments.cart.LeadPrice)#">
			,<cfqueryparam cfsqltype="cf_sql_float" 
				  							value="#trim(local.arguments.cart.totalPrice)#">
			,1					<!---new order status is 1--->
			
			,<cfqueryparam cfsqltype="cf_sql_float" 
				  							value="#trim(local.arguments.cart.DiscountedPrice)#">
			,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(local.arguments.DiscountNote)#">
			,<cfqueryparam cfsqltype="cf_sql_float" value="#trim(local.arguments.DiscountPercentage)#">
			,@WebSiteID
			,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(local.arguments.ClientIP)#">
			,1
			,1
			,getdate()
			,getdate()
	)
	declare @LeadOrderID int 
	select @LeadOrderID =  SCOPE_IDENTITY() 
		
	
	<!--- insert order lead fields--->
	INSERT INTO [dbo].[LeadOrderField]
           ([LeadOrderID]
           ,[LeadFieldID]
           ,[Price]
           ,[CreatedBy]
           ,[UpdatedBy]
           ,[DateCreated]
           ,[DateLastUpdated])
	select @LeadOrderID
			, LeadFieldID
			, #trim(listFirst(local.arguments.cart.PriceOption, ';'))#FieldPrice
			, 1
			, 1
			, getdate()
			, getdate()
		from LeadProductField
		
			where LeadProductID = <cfqueryparam cfsqltype="cf_sql_integer" 
											value="#local.arguments.cart.LeadProductID#">
				and (
						#trim(local.arguments.cart.PriceOption)#FieldPrice = 0
						
						<cfif trim(local.arguments.cart.LeadFieldID) gt "">
						
							or 
						
							LeadFieldID in (#local.arguments.cart.LeadFieldID#)
						
						</cfif>
					)
					
	  <!--- Insert Specific bank (as note to field Specific Bank for the order--->
	  <cfif local.arguments.cart.SpecificBank gt "">
	  	
			update LeadOrderField
				set [Note] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(local.arguments.cart.SpecificBank)#">
				where LeadOrderID = @LeadOrderID
					and LeadFieldID = 10 <!--- 10 is for specific bank--->
	  
	  
	  
	  </cfif>
					
	  select @LeadOrderID as LeadOrderID

</cfquery>

<cfset reply.data = qLeadOrderInsert.LeadOrderID>
<cfset reply.success = true>

<!--- send an email confirmation--->
<cfinclude template="emailConfirmation.cfm" >

<cfset sendEmailConfirmation(LeadOrderID = qLeadOrderInsert.LeadOrderID)>


<cfcatch type="any">
	<cfset reply.success = false>	
	<cfset reply.errorMessage = "There was an error in processing your order.  Please contact our office for further assistance.">
	<cfif isdefined("cfcatch.queryError")>
		<cfset reply.errorMessage = cfcatch.message & "<br>" & cfcatch.queryError & "<br>" & cfcatch.Sql>
	</cfif>
	
</cfcatch>

</cftry>


<cfwddx action="cfml2wddx" input="#reply#" output="local.returnValue">
<cfoutput>#local.returnValue#</cfoutput>


