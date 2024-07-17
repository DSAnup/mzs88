
<cfquery datasource="#request.dsnameReader#" name="qDepartmentSelect">

	select *
		from Department	

</cfquery>


<cfquery datasource="#request.dsnameReader#" name="qTicketSelect">
	select *
		from Ticket	
	Where 
		ClientID = #session.profile.client.ClientID#
	order by Ticket.DateCreated desc;
</cfquery>



<!-- main-container start -->
<!-- ================ -->
<section class="main-container">

	<div class="container">
		<div class="row">

			<!-- main start -->
			<!-- ================ -->
			<div class="main col-md-12">

				<!-- page-title start -->
				<!-- ================ -->
				<h1 class="page-title margin-top-clear">My Tickets</h1>
				
					<div class="text-left"><a href="/index.cfm?area=support&action=ticketinsert" class="btn btn-lg btn-default">Create New Ticket</a></div>
									
                                 
				
				
				
				
				
				
				

					<cfoutput>
						<div class="row">
							<div class="col-md-12 loginarea openticketarea">
								<fieldset>
									<legend><span> My Tickets</span></legend>
									
									
									
									<cfif qTicketSelect.RecordCount eq 0>
					
											You have not created any support ticket yet.
											
											To create a new ticket click below.
											
											<div class="text-left"><a href="/index.cfm?area=support&action=ticketinsert" class="btn btn-lg btn-default">Create New Ticket</a></div>
							
					
					
									<cfelse>
									
									
										
											
										
								 
								 	<table class="table table-hover">
										<thead>
											<tr>
												<th>Date</th>
												<th>Department</th>
												<th>Subject</th>
												<th>Status</th>
												<th>Last Updated</th>
												<th>Action</th>
											</tr>
										</thead>
										<tbody>
									
											<cfloop query="qTicketSelect">
											<tr>
												<td>#qTicketSelect.DateCreated#</td>
												
												
												<cfloop query="qDepartmentSelect">
												
												<cfif qDepartmentSelect.DepartmentID eq qTicketSelect.DepartmentID >
													<td>#qDepartmentSelect.DepartmentName#</td>
												</cfif>
												</cfloop>
												<td>#qTicketSelect.Subject#</td>
												<td>#qTicketSelect.Status#</td>
												<td>#qTicketSelect.DateLastUpdated#</td>
												<td>
													<a href="#cgi.script_name#?area=#url.area#&action=TicketUpdate&TicketID=#toString(qTicketSelect.TicketUUID)#">View</a>
												</td>
											
											</tr>
											</cfloop>
										</tbody>
									</table>
									
									</cfif>
								 
								 </fieldset>
					
							</div>
						</div>
					
					</cfoutput>
					
				
		
			</div>
			<!-- main end -->
		</div>
	</div>
</section>
<!-- main-container end -->