  <cfquery datasource="#request.dsnameReader#" name="qLeadSelect"> 
      select *
        from Lead
        
        order by LeadID
          
    </cfquery>

				
							
<div class="row">
	<div class="col-12">
		<div class="page-title-box">
			<h4 class="page-title">Show All Leads</h4>
			<div class="page-title-right">
				<ol class="breadcrumb p-0 m-0">
					<li class="breadcrumb-item"><a href="index.cfm?&area=dashboard&action=index">Dashboard
</a></li>
					<li class="breadcrumb-item active">Show All Leads</li>
				</ol>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-md-12">
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">Leads table</h3>
			</div>
			<div class="card-body">

				<div class="row">
					<div class="col-12">
						<cfoutput>
						
							<div class="table-responsive">
								<table id="datatable" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                                                
									<thead>
										<tr>
											<th>Lead ID</th>
											<th>PhoneNumber</th>
           									<th>Status</th>
											<th>Attempt</th>
											<th>Time Queued</th>
											<th>Time Sent</th>
											<th>Message</th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<th>Lead ID</th>
											<th>PhoneNumber</th>
           									<th>Status</th>
											<th>Attempt</th>
											<th>Time Queued</th>
											<th>Time Sent</th>
											<th>Message</th>
										</tr>
									</tfoot>
									<tbody>
										
									<cfloop query="qLeadSelect">
									<tr>
										<td>#qLeadSelect.LeadID#</td>
										<td>#qLeadSelect.PhoneNumber#</td>
										<td>#qLeadSelect.Status#</td>
										<td>#qLeadSelect.NumberOfAttempt#</td>
										<td>
											<cfif datediff('d', qLeadSelect.DateTimeQueued, '01/01/2099') eq 0>
												Not yet queued
											<cfelse>
												#dateFormat(qLeadSelect.DateTimeQueued, 'mm/dd/yyyy')# #timeFormat(qLeadSelect.DateTimeQueued, "full" )#
											</cfif>
										</td>
										<td>
											<cfif isDate(qLeadSelect.DateSent) eq false>
												Not yet sent
											<cfelse>
												#dateFormat(qLeadSelect.DateSent, 'mm/dd/yyyy')# #timeFormat(qLeadSelect.DateSent, "full" )#
											</cfif>
											
											
										</td>
										
										<td title="#qLeadSelect.SMS#">											
											<cfif trim(qLeadSelect.SMS) gt "">
												#left(qLeadSelect.SMS, 50)#...
											</cfif>											
										</td>
										
										
										
									</tr>
									</cfloop>

									</tbody>
								</table>
							</div>		
						</cfoutput>
                    </div>
				</div>


				<!-- End #wizard-vertical -->
			</div>
			<!-- End card-body -->
		</div>
		<!-- End card -->
	</div>
	<!-- end col -->
</div>