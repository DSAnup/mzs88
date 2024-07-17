<cfif session.profile.isLoggedIn eq false AND url.area neq "login">			
		<cflocation url="/?area=home&action=loginorSignin" addtoken="false" >			
</cfif>
	
	<cfquery datasource="#request.dsnameReader#" name="qAppUserSelect"> 
		SELECT *	   
		 FROM 
			AppUser 
			
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
						<h1 class="page-title">Alumni List</h1>
					</div>
					<div class="col-md-4">
					
					</div>
				</div>
				<div class="separator-2"></div>
				<p class="lead">Please find below history of the alumnis.</p>
				<!-- page-title end -->
				
				<table id="alumni" class="display table table-hover table-striped" style="width:100%">
					<thead>
						<tr>
							<th>Full Name</th>
							<th>Nick Name</th>
							<th>Email</th>
							<th>Phone Number</th>
							<th>Photo</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
					
					<cfoutput query="qAppUserSelect">
						<tr>
							<td>#qAppUserSelect.NameInEnglish#</td>
							<td>#qAppUserSelect.NickName#</td>
							<td>#qAppUserSelect.Email#</td>
							<td>#qAppUserSelect.PhoneNumer#</td>
							<td>
							<cfif qAppUserSelect.Picture eq ''>
								<img class="profile_photo" src="assets/alumni_pictures/man.jpg" alt=""/>
							<cfelse>
								<img class="profile_photo" src="assets/alumni_pictures/#qAppUserSelect.Picture#" alt=""/>
							</cfif>
							</td>
							<td><a href="index.cfm?area=home&action=signup&AppUserID=#qAppUserSelect.AppUserID#">View Full Profile</a></td>
						</tr>
					</cfoutput>	
				
					</tbody>
					<tfoot>
						<tr>
							<th>Full Name</th>
							<th>Nick Name</th>
							<th>Father's Name</th>
							<th>Phone Number</th>
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
