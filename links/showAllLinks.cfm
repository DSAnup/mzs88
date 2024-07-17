  <cfquery datasource="#request.dsnameReader#" name="qLinksSelect"> 
      select *
        from Setting where SettingName = 'Links'
          
    </cfquery>

				
							
<div class="row">
	<div class="col-12">
		<div class="page-title-box">
			<h4 class="page-title">Show All Links</h4>
			<div class="page-title-right">
				<ol class="breadcrumb p-0 m-0">
					<li class="breadcrumb-item"><a href="#">Home</a></li>
					<li class="breadcrumb-item active">Show All Links</li>
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
				<h3 class="card-title">Links table</h3>
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
											<th>Setting Name</th>
											<th>Setting 1</th>
											<th>Action</th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<th>ID</th>
											<th>Setting Name</th>
											<th>Setting 1</th>
											<th>Action</th>	
										</tr>
									</tfoot>
									<tbody>
										
									<cfloop query="qLinksSelect">
									<tr>
										<td>#qLinksSelect.SettingID#</td>
										<td>#qLinksSelect.SettingName#</td>
										<td>#left(qLinksSelect.Setting1, 35)#</td>
										<td>
											
										<a href="#cgi.script_name#?area=#url.area#&action=viewLinks&SettingID=#qLinksSelect.SettingID#">Edit</a>
											
											
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