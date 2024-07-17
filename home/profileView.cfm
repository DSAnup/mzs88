

<cfparam  name="session.profile.client.BusinessName" default="">
<cfparam  name="session.profile.client.FirstName" default="">
<cfparam  name="session.profile.client.LastName" default="">
<cfparam  name="session.profile.client.Phone" default="">
<cfparam  name="session.profile.client.Email" default="">
<cfparam  name="session.profile.client.SkypeID" default="">
<cfparam  name="session.profile.client.Address1" default="">
<cfparam  name="session.profile.client.Address2" default="">
<cfparam  name="session.profile.client.City" default="">
<cfparam  name="session.profile.client.State" default="">
<cfparam  name="session.profile.client.ZipCode" default="">
<cfparam  name="session.profile.client.Country" default="">
<cfparam  name="session.profile.client.CountryID" default="">
<cfparam  name="session.profile.client.CountryName" default="">
<cfparam  name="session.profile.client.DeliveryEmail" default="">
<cfparam  name="session.profile.client.DepositBankID" default="">


<cfoutput>

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
				
				<div class="row">
					<div class="col-md-8">
						<h1 class="page-title margin-top-clear">View Profile</h1>
					</div>
					<div class="col-md-4">
						<cfinclude template="help-button.cfm">
					</div>
				</div>
				<!-- page-title end -->
				<div class="space"></div>
				
				
				
				<!---Progress Bar--->
				<cfset currentStep = 2>
				
				<div class="row">
                  		<div class="col-md-8">   			
						Please review your profile below.  If you with to make any change to your profile
							please click "Edit Profile".
							
							
							
					</div>
					
					<div class="col-md-4 text-right">   			
						
							<a href="index.cfm?area=home&action=profileEdit" class="btn btn-group btn-default btn-sm"> Edit Profile</a>
						
						
					</div>
					
					
					
					
				</div>
					
				




	<table class="table table-striped">
		<thead>
			<tr>
				<th colspan="2">Client Information </th>
			</tr>
		</thead>
		<tbody>
			<cfif trim(session.profile.client.BusinessName) gt "">
				<tr>
					<td>Business Name</td>
					<td class="information">#session.profile.client.BusinessName#</td>
				</tr>
			</cfif>
			<tr>
				<td>Full Name</td>
				<td class="information">#session.profile.client.FirstName# 
						#session.profile.client.LastName#</td>
			</tr>
			<tr>
				<td>Email</td>
				<td class="information">#session.profile.client.Email#</td>
			</tr>
			<tr>
				<td>Skype ID</td>
				<td class="information">#session.profile.client.SkypeID#</td>
			</tr>
			<tr>
				<td>Phone</td>
				<td class="information">#session.profile.client.Phone#</td>
			</tr>
			<tr>
				<td>Address</td>
				<td class="information">
					#session.profile.client.Address1#,
					<cfif session.profile.client.Address2 gt ''>
						#session.profile.client.Address2#,
					</cfif>
					#session.profile.client.City#, #session.profile.client.State#
					#session.profile.client.ZipCode#, #session.profile.client.CountryName#
					
					
				</td>
			</tr>
		</tbody>
	</table>
	
	<table class="table table-striped">
		<thead>
			<tr>
				<th colspan="2">Shipping Information </th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>Delivery Email</td>
				<td class="information">#session.profile.client.DeliveryEmail#</td>
			</tr>
			
		</tbody>
	</table>
</cfoutput>

</div>

</div>
	
	
	
</section>
<!-- main-container end -->
