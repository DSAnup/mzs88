<cfdump var="#form#" />
<cfparam name="form.ToPhoneNumber" default="" >
<cfparam name="form.DateSent" default="" >


<cfif trim(form.ToPhoneNumber) eq "" and trim(form.DateSent) eq "">
		
		<div id="searchResult">
		<div class="alert alert-danger">
            To limit the search result, please provide at least one of the 
            input above.  
        </div>
        </div>
        
        <script lang="javascript">  	
		  	window.parent.document.getElementById('alert').innerHTML  = document.getElementById('searchResult').innerHTML ;
		  	document.getElementById('searchResult').innerHTML = '';
		 </script>
		 
		 <cfabort>
  
		
</cfif>

<cfquery datasource="#request.dsnameReader#" name="qSmsLogSelect">
	
	Select *
		FROM SMSLog 
	
			Where 1 = 1
				<cfif form.ToPhoneNumber gt "">
					and ToPhoneNumber like '%#form.ToPhoneNumber#%'
				</cfif>
				<cfif form.DateSent gt "">
					and datediff(d, '#form.dateSent#', DateSent)  = 0
				</cfif>

</cfquery>

<cfoutput>
<div id="searchResult">
<div class="col-lg-12">
		        <div class="card">
		            <div class="card-header">
		            	<div class="row">
		            		<div class="col-md-8 col-sm-8 col-8"><h3 class="card-title">List of SMS Logs</h3></div>
		            	</div>
		            </div>
		            <div class="card-body">
		                <div class="row">
		                    <div class="col-md-12 col-sm-12 col-12">
		                        <table name="datatable" id="Resultdatatable" class="table datatable table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
		              

							<thead>
                                <tr>
									<th>ID</th>
									<th>SMS</th>
									<th>ToPhoneNumber</th>
									<th>FromPhoneNumber</th>
									<th>DateSent</th>
                                </tr>
                            </thead>

                            <tbody>
								<cfloop query="qSmsLogSelect">
								<tr>
									<td>#qSmsLogSelect.SMSLogID#</td>
									<td>#qSmsLogSelect.SMS#</td>
									<td>#qSmsLogSelect.ToPhoneNumber#</td>
									<td>#qSmsLogSelect.FromPhoneNumber#</td>
									
									<td>#dateFormat(qSmsLogSelect.DateSent, 'mm/dd/yyyy')# #timeFormat(qSmsLogSelect.DateSent, "full" )#</td>

					
								</tr>
								</cfloop>
                                
                            </tbody>
                            
              
		                    </table>
		
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
   </div>
    
   </cfoutput>
   
  
   
  <script lang="javascript">  
  	window.parent.document.getElementById('alert').innerHTML  = '' ;
  	window.parent.document.getElementById('searchResultContainer').innerHTML  = document.getElementById('searchResult').innerHTML ;  	
  	window.parent.loadTable();  
  	document.getElementById('searchResult').innerHTML  = '';  	
  </script>