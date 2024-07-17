
<div class="row">
	<div class="col-12">
		<div class="page-title-box">
			<h4 class="page-title">Upload New Lead</h4>
			<div class="page-title-right">
				<ol class="breadcrumb p-0 m-0">
					<li class="breadcrumb-item"><a href="index.cfm?&area=dashboard&action=index">Dashboard
</a></li>
					<li class="breadcrumb-item active">Upload New Lead</li>
				</ol>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
</div>

<!--- make sure all required inputs are provided --->
<cfif trim(form.leads) eq "">	
	<div class="alert alert-danger" >										
		<span id="errorMessage">Upload file must be provided</span>
	</div>	
	<cfabort>
</cfif>


							
							

<cffile action="upload" filefield="leads" destination="#GetTempDirectory()#" nameconflict="overwrite" >

<cffile action="read" file="#GetTempDirectory()##cffile.serverFile#" variable="fileContent" >
	

<cfset insertedLeads = 0>
<cfset errorLeadsList = "">

<cfquery datasource="#request.dsnameWriter#" >
			
	truncate table  [dbo].[Lead]
	
	update setting	
			set Setting1 = '',
				Setting2 = '',
				Setting3 = ''
			where SettingName = 'Schedule'
	          
</cfquery>
	
   
<cfloop list="#fileContent#" index="lead" delimiters="#chr(13)#">

	<cfif len(trim(lead)) eq 10 and isnumeric(lead)>
		
		<cfset insertedLeads = insertedLeads + 1>
		
		<cfquery datasource="#request.dsnameWriter#" >
			
			INSERT INTO [dbo].[Lead]
		           ([PhoneNumber]
		           ,[Status]
		           ,[NumberOfAttempt]
		           ,[DateTimeQueued])
		     VALUES
		           ('#trim(lead)#'
		           ,'Pending'
		           ,0
		           ,'01/01/2099')
		</cfquery>
		
	<cfelse>
		
		<cfset errorLeadsList = listAppend(errorLeadsList, lead)> 
		
	</cfif>
	
</cfloop>



<cfoutput>
   
<cfif listlen(errorLeadsList) eq 0>

	<!---success alert --->
	<div class="alert alert-success"  id="successDiv">										
		<span id="successMessage">File Uploaded Successfully, saved #insertedLeads# leads...</span>
	</div>

<cfelse>

	<!---success alert --->
	<div class="alert alert-success"  id="successDiv">										
		<span id="successMessage">File Uploaded Successfully, saved #insertedLeads# leads...</span>
	</div>

	<div class="alert alert-danger" >										
		<span id="errorMessage">
			
			However, following leads were rejected
			
			<ol>
			<cfloop list="#errorLeadsList#" index="lead" >				
				<li>#lead#</li>				
			</cfloop>
			</ol>
			
			
		</span>
	</div>

</cfif>

</cfoutput>

<a class="btn btn-success" href="index.cfm?area=leads&action=showAllLeads">View Uploaded Leads</a>

<a class="btn btn-info" href="index.cfm?area=leads&action=addNewLead">Upload Lead Again</a>




   
   
   