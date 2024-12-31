<cfparam  name="session.profile.AppUser.AppUserID" default="0">
<cfparam  name="url.AppUserID" default="0">

<cfquery datasource="#request.dsnameReader#" name="qAppUserSelect"> 
	SELECT *	   
		FROM 
		AppUser where AppUserID = #val(url.AppUserID)#
</cfquery>

    
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
                        <div class="col-md-7">
                            <h1 class="page-title margin-top-clear"> Information</h1>
                        </div>
                        <div class="col-md-4">
                            
                        </div>
                    </div>
                    <!-- page-title end -->
                    <div class="space"></div>                    
                    
                    
        
                     <div class="row">
                  		 <div class="col-md-12">           

							<p>Please complete the following details and press Update Details.</p>
						</div>
					</div>

					<form id="validate-1" role="form" class="form-horizontal" action="partialIndex.cfm?area=appuser&action=editUserAction"  method="post" target="formpost" enctype="multipart/form-data">                      
						<div class="space-bottom"></div>    
						
							<!---Personal Details --->
							<fieldset>
								<legend><span>Personal Details </span></legend>
									<div class="row col-md-6">												
										<div class="col-lg-12">
											<div class="form-group">
												<label for="NameInEnglish" class="col-md-5 control-label">Full Name<small class="text-default">*</small></label>
												<div class="col-md-7">
													<input type="text" class="form-control required" id="NameInEnglish" name="NameInEnglish" value="#qAppUserSelect.NameInEnglish#">
												</div>
											</div>
											<div class="form-group">
												<label for="NickName" class="col-md-5 control-label">Nick Name<small class="text-default">*</small></label>
												<div class="col-md-7">
													<input type="text" class="form-control required" id="NickName" name="NickName" 	value="#qAppUserSelect.NickName#">
												</div>
											</div>
											<div class="form-group">
												<label for="FathersName" class="col-md-5 control-label">Father's Name</label>
												<div class="col-md-7">
													<input type="text" class="form-control" id="FathersName" name="FathersName" minlength="10" value="#qAppUserSelect.FathersName#">
												</div>
											</div>
											<div class="form-group">
												<label for="MothersName" class="col-md-5 control-label">Mother's Name</label>
												<div class="col-md-7">
													<input type="text" class="form-control" id="MothersName" name="MothersName" value="#qAppUserSelect.MothersName#">
												</div>
											</div>
										</div>
									</div>
									
									<div class="row col-md-6">
										
										<div class="col-lg-12 center-block">
											<cfif qAppUserSelect.Picture neq '' >
												<div class="image-area"><img id="imageResult" src="assets/alumni_pictures/#qAppUserSelect.Picture#" alt=""></div>
											<cfelse>
												<div class="image-area"><img id="imageResult" src="assets/alumni_pictures/man.jpg" alt=""></div>
											</cfif>
											<div class="form-group">
												<div class="upload-btn-group">
													<input class="form-control" id="Picture" name="Picture" type="file" onchange="readURL(this);" >
													<input type="hidden" name="currentPicture" id="currentPicture" value="#qAppUserSelect.Picture#">
													<label id="upload-label" for="Picture" class="btn btn-success">Upload Photo</label>
												<div class="form-group">
											</div>
										</div>
													
									</div>
							</fieldset>
							

							<!--- Family Details --->
							<fieldset>
								<legend><span ondblclick="setTestData();">Family Details</span></legend>
								<div class="row col-md-6">
									<div class="col-lg-12">
										<div class="form-group">
											<label for="Children" class="col-md-5 control-label">Number of Children</label>
											<div class="col-md-7">
												<input type="text" class="form-control" id="Children" name="Children" value="#qAppUserSelect.Children#">
											</div>
										</div>								
									</div>
								</div>
								<div class="row col-md-6">
									<div class="col-lg-12">
									</div>
								</div>
								<!--- <div class="space"></div> --->
							</fieldset>
							

							<!--- Contact Details --->
							<fieldset>
								<legend><span ondblclick="setTestData();">Contact Details</span></legend>
								<div class="row col-md-6">
									<div class="col-lg-12">
										<div class="form-group">
											<label for="PhoneNumer" class="col-md-5 control-label">Phone Number<small class="text-default">*</small></label>
											<div class="col-md-7">
												<input type="text" class="form-control required" id="PhoneNumer" name="PhoneNumer" value="#qAppUserSelect.PhoneNumer#">
											</div>
										</div>
									</div>
								</div>
								<div class="row col-md-6">
									<div class="col-lg-12">			
										<div class="form-group">
											<label for="Email" class="col-md-5 control-label">Email</label>
											<div class="col-md-7">
												<input type="Email" class="form-control" id="Email" name="Email" value="#qAppUserSelect.Email#">
											</div>
										</div>	
									</div>
								</div>
							</fieldset>
							

							<!--- Address --->
							<fieldset>
								<legend><span ondblclick="setTestData();">Address</span></legend>
								<div class="row col-md-6">
									<div class="col-lg-12">
										<div class="form-group">
											<label for="PermanentAddress" class="col-md-5 control-label">Permanent Address<small class="text-default">*</small></label>
											<div class="col-md-7">
												<textarea rows="5" id="PermanentAddress" name="PermanentAddress" class="form-control required has-success">#qAppUserSelect.PermanentAddress#</textarea>
											</div>
										</div>

									</div>
								</div>
								<div class="row col-md-6">
									<div class="col-lg-12">					
										<div class="form-group">
											<label for="PresentAddress" class="col-md-5 control-label">Present Address<small class="text-default">*</small></label>
											<div class="col-md-7">
												<textarea rows="5" id="PresentAddress" name="PresentAddress" class="form-control has-success">#qAppUserSelect.PresentAddress#</textarea>
											</div>
										</div>
									</div>
								</div>
							</fieldset>
					

							<!--- Profession Details --->
							<fieldset>
								<legend><span ondblclick="setTestData();">Profession Details</span></legend>
								<div class="row col-md-6">
									<div class="col-lg-12">
										<div class="form-group">
											<label for="Profession" class="col-md-5 control-label">Profession</label>
											<div class="col-md-7">
											<input type="text" class="form-control" id="Profession" name="Profession" value="#qAppUserSelect.Profession#">
											</div>
										</div>	
									</div>
								</div>
								<div class="row col-md-6">
									<div class="col-lg-12">
										<div class="form-group">
											<label for="WorkPlaceDetails" class="col-md-5 control-label">Work Place Details</label>
											<div class="col-md-7">
												<textarea rows="5" id="WorkPlaceDetails" name="WorkPlaceDetails" class="form-control has-success">#qAppUserSelect.WorkPlaceDetails#</textarea>
											</div>
										</div>
									</div>
								</div>
							</fieldset>


							<!--- Social Media Account --->
							<fieldset>
								<legend><span ondblclick="setTestData();">Social Media Account</span></legend>
								<div class="row col-md-6">
									<div class="col-lg-12">
										<div class="form-group">
											<label for="Facebook" class="col-md-5 control-label">Facebook</label>
											<div class="col-md-7">
											<input type="text" class="form-control" id="Facebook" name="Facebook" value="#qAppUserSelect.Facebook#">
											</div>
										</div>	
										<div class="form-group">
											<label for="Linkedin" class="col-md-5 control-label">Linkedin</label>
											<div class="col-md-7">
											<input type="text" class="form-control" id="Linkedin" name="Linkedin" value="#qAppUserSelect.Linkedin#">
											</div>
										</div>	
									</div>
								</div>
								<div class="row col-md-6">
									<div class="col-lg-12">
										<div class="form-group">
											<label for="Skype" class="col-md-5 control-label">Skype</label>
											<div class="col-md-7">
											<input type="text" class="form-control" id="Skype" name="Skype" value="#qAppUserSelect.Skype#">
											</div>
										</div>
										<div class="form-group">
											<label for="WhatsApp" class="col-md-5 control-label">WhatsApp</label>
											<div class="col-md-7">
											<input type="text" class="form-control" id="WhatsApp" name="WhatsApp" value="#qAppUserSelect.WhatsApp#">
											</div>
										</div>	
									</div>
								</div>
								<div class="space"></div>
							</fieldset>
					

							<!--- Login Details --->
					
							<cfif session.profile.AppUser.AppUserID eq url.AppUserID>

								<fieldset>
									<legend><span ondblclick="setTestData();">Login Details</span></legend>
									<div class="passchange-notify text-center">
										<a href="index.cfm?area=login&action=updatePassword" class="btn btn-success btnpass">Please click here to change the password</a>
									<div class="form-group">
									<div class="space"></div>
								</fieldset>	
							
							</cfif>
							
							
							<!--- Actions --->
							<div class="row">
							
								<div class="text-left col-md-6">
									
								<cfif val(qAppUserSelect.AppUserID) neq 0>
									<a href="index.cfm?area=home&action=MemberSelect" class="btn btn-success btnreset signupbackup"><i class="icon-left-open-big"></i>Member List</a>							
								<cfelse>
									<a href="index.cfm?area=home&action=loginorSignin" class="btn btn-success btnreset signupbackup"><i class="icon-left-open-big"></i> Back To Login</a>
								</cfif>
									
								</div>
								
								<input type="hidden" name="AppUserID" id="AppUserID" value="#val(url.AppUserID)#">

								<div class="text-right col-md-6">
									<button type="submit" class="btn btn-group btn-default btn-sm btn-disabled updateButton">
										Update Details														
										<i class="icon-right-open-big"></i>							
									</button>
								</div>
								
							</div>
						</div>
					</form>

                    <p>* Required Information</p>
    
            </div>
            
        </div>

    </section>
    <!-- main-container end -->
	
	    
    </cfoutput>
	
	
   
    <script language="javascript">    
	
        function setTestData(){
            $('#NameInBangla').val("");
            $("#NameInEnglish").val("John Walker");
            $("#NickName").val("Walker");
            $("#PhoneNumer").val("1234567890");
            $("#Email").val("fakir.hossain@yahoo.com");
            $("#PermanentAddress").val("104 Oak Ridge Ave");

            
            $("#password").val("1234");        
        
        }
    
    </script>