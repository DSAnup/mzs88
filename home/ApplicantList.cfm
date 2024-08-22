<cfif session.profile.isLoggedIn eq false AND url.area neq "login">			
		<cflocation url="/?area=home&action=loginorSignin" addtoken="false" >			
</cfif>
	
	<cfquery datasource="#request.dsnameReader#" name="qScholarShipSelect"> 
		SELECT *	   
		 FROM 
			ScholarShip 
			
			<!---where AppUserID = #session.profile.AppUser.AppUserID#--->
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
						<h1 class="page-title">Applicant List</h1>
					</div>
					<div class="col-md-4">
					
					</div>
				</div>
				<div class="separator-2"></div>
				<p class="lead">Please find below history of the applicant.</p>
				<!-- page-title end -->
				
				<table id="applicant" class="display table table-hover table-striped" style="width:100%">
					<thead>
						<tr>
							<th>Full Name</th>
							<th>Class</th>
							<th>Home Teacher Name</th>
							<th>Session Year</th>
							<th>Score</th>
							<th>Photo</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
					
					<cfoutput query="qScholarShipSelect">
						<tr>
							<td>#qScholarShipSelect.FullName#</td>
							<td>#qScholarShipSelect.Class#</td>
							<td>#qScholarShipSelect.HomeTeacherName#</td>
							<td>#qScholarShipSelect.SessionYear#</td>
							<td>#qScholarShipSelect.Score#</td>
							<td>
							<cfif qScholarShipSelect.Picture eq ''>
								<img class="profile_photo" src="assets/alumni_pictures/man.jpg" alt=""/>
							<cfelse>
								<img class="profile_photo" src="assets/alumni_pictures/Profile/#qScholarShipSelect.Picture#" alt=""/>
							</cfif>
							</td>
							<td>
								<a href="index.cfm?area=home&action=scholarship&ScholarShipID=#qScholarShipSelect.ScholarShipID#">Update</a> ||
								<a href="index.cfm?area=home&action=ApplicantView&ScholarShipID=#qScholarShipSelect.ScholarShipID#">View</a>
							</td>
						</tr>
					</cfoutput>	
				
					</tbody>
					<tfoot>
						<tr>
							<th>Full Name</th>
							<th>Class</th>
							<th>Home Teacher Name</th>
							<th>Session Year</th>
							<th>Score</th>
							<th>Photo</th>
							<th>Action</th>
						</tr>
					</tfoot>
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
