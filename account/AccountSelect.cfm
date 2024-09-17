<cfif session.profile.isLoggedIn eq false AND url.area neq "login">			
		<cflocation url="/?area=home&action=loginorSignin" addtoken="false" >			
</cfif>
	
	<cfquery datasource="#request.dsnameReader#" name="qAccountSelect"> 
		SELECT *	   
		 FROM 
			Account 
	</cfquery>
<!-- main-container start -->
<!-- ================ -->
<section class="main-container">

	<div class="container">
		<div class="row">

			<!-- main start -->
			<!-- ================ -->
			<div class="main col-md-12">
				
				<!---title and description of the main section title --->

				<!-- page-title start -->
				<!-- ================ -->
				<div class="row">
					<div class="col-md-8">
						<h2 class="page-title">Account List</h2>
					</div>
					<div class="col-md-4">
						<a id="formOption" style="float:right;" class="btn btn-success btn-signup" href="index.cfm?area=account&action=AccountInsert">Add New</a>
					</div>
				</div>
				<div class="separator-2"></div>
				<!-- page-title end -->
				
				<table id="applicant" class="display table table-hover table-striped" style="width:100%">
					<thead>
						<tr>
							<th>Account Name</th>
							<th>Description</th>
							<th>Status</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
					
					<cfoutput query="qAccountSelect">
						<tr>
							<td>#qAccountSelect.AccountName#</td>
							<td>#qAccountSelect.Description#</td>
							<td>
								<cfif qAccountSelect.isClosed eq 0>
									Close
								<cfelse>
									Open
								</cfif>
							</td>
							<td>
								<a href="index.cfm?area=account&action=AccountInsert&AccountID=#qAccountSelect.AccountID#">Update</a>
							</td>
						</tr>
					</cfoutput>	
				
					</tbody>
				</table>

			<div class="clearfix"></div>

				

			</div>
			<!-- main end -->

		</div>
	</div>
</section>
<!-- main-container end -->

<script language="javascript">
	$(document).ready(function() {
			$('#applicant').DataTable();
		} );
</script>
