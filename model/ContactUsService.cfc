
	
<cfcomponent output="false">
	
	
	<!---- Create ContactUs ---->
	<cffunction name="createContactUs" returntype="any">
		
	
		
		<cfquery datasource="#request.dsnameWriter#">
		
			declare @WebsiteID int
			
			select @WebsiteID = WebSiteID
				from WebSite
				where WebSiteName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(request.callerWebSite)#">
				
			INSERT INTO [dbo].[ContactUs]
		           ([FullName]
		           ,[Email]
		           ,[Phone]
		           ,[Message]
		           ,[IsAnswered]
		           ,[WebSiteID]
		           ,[ClientIP]
		           ,[CreatedBy]
		           ,[UpdatedBy]
		           ,[DateCreated]
		           ,[DateLastUpdated])
				   
			values
				(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.fullname)#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.email)#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.phone)#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.message)#">,
					0,
					@WebSiteID,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(cgi.REMOTE_ADDR)#">,
					#application.SystemUserID#,
					#application.SystemUserID#,
					getdate(),
					getdate()
				)
			  
		
		</cfquery>
		
		<!--- send email to leads--->
		<cfmail to="noreply@godspeedcorp.com" 
				subject="Contact us email - #trim(form.email)#" 
				from="leads@godspeedcorp.com" 
				type="html"
				server="smtp.gmail.com" useSSL="true" username="noreply@godspeedcorp.com" password="GMOmSoft1*$" port="465">
		<p>
		#trim(form.message)#
		</p>
		
		<hr />
		<h4>Sender Details</h4>
		Fullname: #trim(form.fullname)# <br />
		Email: #trim(form.email)#<br />
		Phone: #trim(form.phone)#
		</cfmail>
		
	
		
	</cffunction>
	
	
	<!---- Create NewsletterSubscriber ---->
	<cffunction name="CreateNewsletterSubscriber" returntype="any">
		
		<cfquery datasource="#request.dsnameWriter#">

			declare @WebsiteID int
			
			select @WebsiteID = WebSiteID
				from WebSite
				where WebSiteName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(request.callerWebSite)#">
				
					
			INSERT INTO [dbo].[NewsletterSubscriber]
		           ([FullName]
		           ,[Email]
		           ,[IsActive]
		           ,[WebSiteID]
		           ,[ClientIP]
		           ,[CreatedBy]
		           ,[UpdatedBy]
		           ,[DateCreated]
		           ,[DateLastUpdated])
				   
			values
				(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.fullname)#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.email)#">,			
					1,
					@WebSiteID,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(cgi.REMOTE_ADDR)#">,
					1,
					1,
					getdate(),
					getdate()
				)
			  
		
		</cfquery>
	
	</cffunction>
	
	
</cfcomponent> 

