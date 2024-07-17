
	
<cfcomponent output="true">
	
	
	<!---- Create Lead Order ---->
	<cffunction name="createLeadOrder" returntype="any">
		
		<cfset local.response = structNew()>
		<cfset local.response.success = false>
		<cfset local.response.data = "">
		<cfset local.response.errorMessage = "">
				
		
	
	<cftry>
			
			
			<!---check if the client is barrd based on IP or email address --->
			<cfquery datasource="#request.dsnameReader#" name="qBlackListSelect">
				select BlackListID
					from BlackList
					where IPorEmail = <cfqueryparam cfsqltype="cf_sql_varchar" 
													value="#trim(session.profile.client.Email)#">
													
						<cfif trim(cgi.REMOTE_ADDR) gt "">
							
							or IPorEmail = <cfqueryparam cfsqltype="cf_sql_varchar" 
													value="#trim(cgi.REMOTE_ADDR)#">
							
						</cfif>
			
			</cfquery>
			
			
			
			<cfif qBlackListSelect.RecordCount gt 0>
				<cfthrow message="System is currently not able to take order. 
									Please contact our officce for further assisstance [Preferred client].">
			</cfif>
			
			<!--- check to see if there is an order in the last 2 mins --->
			<cfquery datasource="#request.dsnameReader#" name="qLeadOrderSelect">
				select LeadOrderID 
					from LeadOrder 
					where datediff(mi, datecreated,  getdate()) < 2
						 and ClientID = #session.profile.client.clientID#			
			</cfquery>
			<cfif qLeadOrderSelect.RecordCount gt 0>
				<cfthrow message="System is currently not able to take order. 
									Please contact our officce for further assisstance [Order too soon].">				
			</cfif>
			
			
			<!--- check to see if there is already max number of order placed for this client --->
			<cfquery datasource="#request.dsnameReader#" name="qLeadOrderSelect">
				select LeadOrderID 
					from LeadOrder 
					where datediff(d, datecreated,  getdate()) = 0
						 and ClientID = #session.profile.client.clientID#			
			</cfquery>
			<cfif qLeadOrderSelect.RecordCount gt 5>
				<cfthrow message="System is currently not able to take order. 
									Please contact our officce for further assisstance [Too many orders in one day].">				
			</cfif>
			
	
			
			<!--- check to see if this is a new client--->
			<cfquery datasource="#request.dsnameReader#" name="qClientSelect">			
				select LeadOrderID
					from LeadOrder 
						where LeadOrderStatusID not in (1, 3)	<!--- not new or rejected--->
							and ClientID = #session.profile.client.clientID#			
			</cfquery>
			
			
			<!--- if this is being paid by indian rupee, set the client to a bank if not already set //TODO--->
			<cfif session.cart.PaymentOption eq "Indian Rupee">
				
				
				
				
			</cfif>
			
			
			<cfquery datasource="#request.dsnameWriter#" name="qLeadOrderInsert">
				
				
				declare @PaymentOptionID int
				select @PaymentOptionID = PaymentOptionID
					from PaymentOption where PaymentOptionName = '#session.cart.paymentOption#'
			
				
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
					   ,[PaymentOptionID]
					   ,[DiscountedPrice]
					   ,[DiscountNote]
					   ,[DiscountPercentage]
					   ,[GST]
			           ,[WebSiteID]
			           ,[ClientIP]
			           ,[CreatedBy]
			           ,[UpdatedBy]
			           ,[DateCreated]
			           ,[DateLastUpdated])
				values (
						#session.profile.client.clientID#
						,<cfqueryparam cfsqltype="cf_sql_integer" 
							  							value="#val(session.cart.leadProductID)#">
						,<cfqueryparam cfsqltype="cf_sql_integer" 
							  							value="#val(session.cart.orderQuantity)#">	
						,<cfqueryparam cfsqltype="cf_sql_integer" 
							  							value="#val(session.cart.orderDuration)#">
						,<cfqueryparam cfsqltype="cf_sql_varchar" 
							  							value="#trim(session.cart.PriceOption)#">
						,<cfqueryparam cfsqltype="cf_sql_float" 
							  							value="#val(session.cart.LeadPrice)#">
						,<cfqueryparam cfsqltype="cf_sql_float" 
							  							value="#val(session.cart.totalPrice)#">
							  							
						<cfif qClientSelect.RecordCount gt 0 and session.cart.totalPrice lte request.MaxAutoInvoiceAmount>							
							,5					<!---invoiced is 5--->
						<cfelse>
							,1					<!---new order status is 1--->						
						</cfif>
						
						
						, @PaymentOptionID
						,<cfqueryparam cfsqltype="cf_sql_float" value="#val(session.cart.DiscountedPrice)#">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(session.cart.DiscountNote)#">
						,<cfqueryparam cfsqltype="cf_sql_float" value="#val(session.cart.DiscountPercentage)#">
						,<cfqueryparam cfsqltype="cf_sql_float" value="#val(session.cart.GST)#">
						,#request.callerWebSiteID#
						,'#trim(cgi.REMOTE_ADDR)#'
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
						, #trim(listFirst(session.cart.PriceOption, ';'))#FieldPrice
						, 1
						, 1
						, getdate()
						, getdate()
					from LeadProductField
					
						where LeadProductID = <cfqueryparam cfsqltype="cf_sql_integer" 
														value="#session.cart.LeadProductID#">
							and (
									#trim(session.cart.PriceOption)#FieldPrice = 0
									
									<cfif trim(session.cart.LeadFieldID) gt "">
									
										or 
									
										LeadFieldID in (#session.cart.LeadFieldID#)
									
									</cfif>
								)
								
				  <!--- Insert Specific bank (as note to field Specific Bank for the order--->
				  <cfif session.cart.SpecificBank gt "">
				  	
						update LeadOrderField
							set [Note] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(session.cart.SpecificBank)#">
							where LeadOrderID = @LeadOrderID
								and LeadFieldID = 10 <!--- 10 is for specific bank--->
				  
				  
				  
				  </cfif>
							
				<cfif isDefined("session.cart.PromoCodeID") and val(session.cart.PromoCodeID) gt 0>
					update PromoCode 
						set isUsed = 1, 
							LeadOrderID = @LeadOrderID
						where PromoCodeID = #val(session.cart.PromoCodeID)#
				</cfif>
								
				  select @LeadOrderID as LeadOrderID
			
			</cfquery>
			
			<cfset local.response.data = qLeadOrderInsert.LeadOrderID>
			<cfset local.response.success = true>
			
			
			<!--- send an email confirmation--->
			<cfset emailService = createObject('component', 'model.emailService')>
			
			<cfif qClientSelect.RecordCount gt 0 and session.cart.totalPrice lte request.MaxAutoInvoiceAmount>
				<cfset emailService.sendOrderConfirmation(LeadOrderID = qLeadOrderInsert.LeadOrderID, outputType = "confirmationAndInvoice")>
				<cfset local.response.orderStatus = "Invoiced">
			<cfelse>
				<cfset emailService.sendOrderConfirmation(LeadOrderID = qLeadOrderInsert.LeadOrderID, outputType = "confirmationOnly")>
				<cfset local.response.orderStatus = "New">
			</cfif>
			
			<!--- send few other data to be shown in the confirmation page --->
			
			
			<cfcatch type="any">
				<cffile action="write" file="c:\log\order.txt" output="#cfcatch.message#" >
				<cfset local.response.success = false>	
				<cfset local.response.errorMessage = "There was an unexpected error in processing your order.  Please contact our office for further assistance.">
				<cfif isdefined("cfcatch.queryError")>
					<cfset local.response.errorMessage = local.response.errorMessage & "<br>" & cfcatch.queryError & "<br>" & cfcatch.Sql>
				</cfif>
				
				<cfreturn local.response/>
				
			</cfcatch>
			
			</cftry>
			
		
		
		<cfreturn local.response/>
			
	</cffunction>
	
	
</cfcomponent> 

