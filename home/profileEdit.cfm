
<cfquery datasource="#request.dsnameReader#" name="qCountrySelect">

	
	select CountryID, CountryName from country where ISO2 = 'US'
	union all
	select CountryID, CountryName from country where ISO2 = 'GB'
	union all
	select CountryID, CountryName from country where ISO2 = 'CA'
	union all
	select CountryID, CountryName from country where ISO2 = 'IN'
	union all
	
	select CountryID, CountryName 
		from Country
		

</cfquery>



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
						<h1 class="page-title margin-top-clear">Edit Profile</h1>
					</div>
					<div class="col-md-4">
						<cfinclude template="help-button.cfm">
					</div>
				</div>
								
								
				<form id="validate-1" role="form" class="form-horizontal" action="index.cfm?area=home&action=profileEditAction"  method="post">
					
								
				
				<fieldset>
					<legend><span ondblclick="setTestData();">Edit Profile </span></legend>
						<div class="row col-md-6">
						
							
							<div class="col-lg-12 col-lg-offset-1">
								<div class="form-group">
									<label for="businessname" class="col-md-4 control-label">Business Name<small class="text-default">*</small></label>
									<div class="col-md-8">
										<input type="text" class="form-control required" id="businessname" name="businessname" value="#session.profile.client.businessname#">
									</div>
								</div>
								<div class="form-group">
									<label for="firstname" class="col-md-4 control-label">First Name<small class="text-default">*</small></label>
									<div class="col-md-8">
										<input type="text" class="form-control required" id="firstname" name="firstname" value="#session.profile.client.firstname#">
									</div>
								</div>
								<div class="form-group">
									<label for="lastname" class="col-md-4 control-label">Last Name<small class="text-default">*</small></label>
									<div class="col-md-8">
										<input type="text" class="form-control required" id="lastname" name="lastname" 	value="#session.profile.client.lastname#">
									</div>
								</div>
								<div class="form-group">
									<label for="phone" class="col-md-4 control-label">Telephone<small class="text-default">*</small></label>
									<div class="col-md-8">
										<input type="text" class="form-control required" id="phone" name="phone" minlength="10" value="#session.profile.client.phone#">
									</div>
								</div>
								
								<div class="form-group">
									<label for="email" class="col-md-4 control-label">Email<small class="text-default">*</small></label>
									<div class="col-md-8">
										<input type="text" class="form-control required email" id="email" name="email" value="#session.profile.client.email#">
									</div>
								</div>
								
								<div class="form-group">
									<label for="skypeid" class="col-md-4 control-label">Skype ID</label>
									<div class="col-md-8">
										<input type="text" class="form-control" id="skypeid" name="skypeid" value="#session.profile.client.skypeid#">
									</div>
								</div>
								
								
							</div>
						</div>
						
						<div class="row col-md-6">
							
							<div class="col-lg-12">
								<div class="form-group">
									<label for="address1" class="col-md-4 control-label">Address 1<small class="text-default">*</small></label>
									<div class="col-md-8">
										<input type="text" class="form-control required" id="address1" name="address1" value="#session.profile.client.address1#">
									</div>
								</div>
								<div class="form-group">
									<label for="address2" class="col-md-4 control-label">Address 2</label>
									<div class="col-md-8">
										<input type="text" class="form-control" id="address2" name="address2" value="#session.profile.client.address2#">
									</div>
								</div>
								
								<div class="form-group">
									<label for="city" class="col-md-4 control-label">City<small class="text-default">*</small></label>
									<div class="col-md-8">
										<input type="text" class="form-control required" id="city" name="city" value="#session.profile.client.city#">
									</div>
								</div>
								<div class="form-group">
									<label for="city" class="col-md-4 control-label">State/Province<small class="text-default">*</small></label>
									<div class="col-md-8">
										<input type="text" class="form-control required" id="state" name="state" value="#session.profile.client.state#">
									</div>
								</div>
								<div class="form-group">
									<label for="city" class="col-md-4 control-label">Zip/Postal Code<small class="text-default">*</small></label>
									<div class="col-md-8">
										<input type="text" class="form-control required" id="zipcode" name="zipcode" value="#session.profile.client.zipcode#">
									</div>
								</div>
								
								
								
								<div class="form-group">
									<label for="state" class="col-md-4 control-label">Country<small class="text-default">*</small></label>
									<div class="col-md-8">
										<select class="form-control required" name="country" id="country">
											<option value="">Select one...</option>
											
											<cfloop query="qCountrySelect">
											<option value="#qCountrySelect.CountryID#:#qCountrySelect.CountryName#"										
												<cfif session.profile.client.countryid eq qCountrySelect.CountryID>
													selected="selected"
												</cfif>												
											>#qCountrySelect.CountryName#</option>	
												</cfloop>
										</select>
									</div>
									
									
									
									</div>
									

									
								</div>
								
								
								
							</div>

						<div class="space"></div>
						
					
				</fieldset>
				
<div class="row">
						
						<!--- Shipping --->
						<div class="col-md-12">
			
							<fieldset>
								<legend><span>Shipping Details</span></legend>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label for="email" class="col-md-6 control-label">Lead Delivery Email<small class="text-default">*</small>
												
											</label>
											<div class="col-md-6">
												<input type="text" class="form-control required email" id="deliveryemail" name="deliveryemail" value="#session.profile.client.deliveryemail#">
												Leads are emailed to this address (can be same as above).
											
											</div>
										</div>
									</div>
									
									<div class="col-md-6 text-right">
							
										<div class="space"></div>
						
										<button type="submit" class="btn btn-group btn-default btn-sm">
											Update Profile </i>
										</button>
								
							
									</div>
									
									
								</div>
							</fieldset>
					
				
						</div>
					
			
					
					
					
						
					</div>
				

				
				
			</div>
			<!-- main end -->
			
						
				
				</form>
				
				<p>* Required Information</p>
				
			

		</div>
		
		
		
		
	</div>
	
	
	
</section>
<!-- main-container end -->


</cfoutput>

<script language="javascript">

	function setTestData(){
		$('#businessname').val("Some Corp");
		$("#firstname").val("John");
		$("#lastname").val("Walker");
		$("#phone").val("1234567890");
		$("#email").val("fakir.hossain@yahoo.com");
		$("#skypeid").val("skype123");
		$("#address1").val("104 Oak Ridge Ave");
		$("#city").val("Temple Terrace");
		$('#state').val("FL");
		$("#zipcode").val("33617");
		$("#country").val("236:United States");
	
	
	}

</script>


