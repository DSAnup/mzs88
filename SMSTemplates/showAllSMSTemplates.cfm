  <cfquery datasource="#request.dsnameReader#" name="qSMSTemplateSelect"> 
      select *
        from SMSTemplate
          
    </cfquery>

				
							
<div class="row">
	<div class="col-12">
		<div class="page-title-box">
			<h4 class="page-title">SMS Templates</h4>
			<div class="page-title-right">
				<ol class="breadcrumb p-0 m-0">
					<li class="breadcrumb-item"><a href="index.cfm?&area=dashboard&action=index">Dashboard
</a></li>
					<li class="breadcrumb-item active">Show All SMS Templates</li>
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
				<h3 class="card-title">List of SMS Templates</h3>
			</div>
			<div class="card-body">

				<div class="row">
					<div class="col-12">
						<cfoutput>
						
							<div class="table-responsive">
								<table id="datatable" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                                                
									<thead>
										<tr>
											<th>ID</th>
											<th>SMSTemplate</th>
											<th>DateCreated</th>
											<th>Action</th>
										</tr>
									</thead>

									<tfoot>
										<tr>
											<th>ID</th>
											<th>SMSTemplate</th>
											<th>DateCreated</th>
											<th>Action</th>	
										</tr>
									</tfoot>
									<tbody>
										
									<cfloop query="qSMSTemplateSelect">
									<tr>
										<td>#qSMSTemplateSelect.SMSTemplateID#</td>
										<td>#qSMSTemplateSelect.SMSTemplate#</td>
										<td>#DateFormat(qSMSTemplateSelect.DateCreated,'mm-dd-yyyy')#</td>
										<td>
											
										<a href="#cgi.script_name#?area=#url.area#&action=editSMSTemplates&SMSTemplateID=#qSMSTemplateSelect.SMSTemplateID#">Edit</a> |
										<a href="#cgi.script_name#?area=#url.area#&action=SMSTemplateDeleteAction&SMSTemplateID=#qSMSTemplateSelect.SMSTemplateID#" target="formpost">Delete</a>
											
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