<!---present the sign up form

(currently in client info page...)

Action ? signupAction--->



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
                    
                    <!--- <div class="row">
                        <div class="col-md-7">
                            <h1 class="page-title margin-top-clear">Client Information</h1>
                        </div>
                        <div class="col-md-4">
                            <cfinclude template="../home/help-button.cfm">
                        </div>
                    </div> --->
                    <!-- page-title end -->
                    <div class="space"></div>
                    
                    
 

			
			<form id="validate1" role="form" class="form-horizontal" action="partialIndex.cfm?area=login&action=updatePasswordAction"  method="post" target="formpost" >  
			
					<fieldset>
						<legend><span ondblclick="setTestData();">Change Password</span></legend>
							<cfparam name="url.passwordUpdated" default="" >
						
							<cfif url.passwordUpdated eq "Successfull">
								<div class="alert alert-success" role="alert">
								Password successfully updated.
								</div>
							</cfif>
						

									
							<!---success alert --->
							<div class="alert alert-success alertHidden"  id="successDiv">										
								<span id="successMessage"></span>
							</div>
							
							<!--- error alert --->
							<div class="alert alert-danger alertHidden"  id="errorDiv">										
								<span id="errorMessage"></span>
							</div>
							<div class="row passUpdate">
								<div class="col-md-4">
									<div class="form-group row">
										<label class="col-lg-12 control-label-updatepass" for="currentpassword">Current Password*</label>
										<div class="col-lg-12">
											<input class="form-control required" id="currentpassword" name="currentpassword" type="password" placeholder="Current Password">
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group row">
										<label class="col-lg-12 control-label-updatepass" for="password1">New Password *</label>
										<div class="col-lg-12">
											<input id="password" name="password" type="password" class="required form-control" placeholder="New Password">
										</div>
									</div>
								</div>
								<div class="col-md-4">
								

								<div class="form-group row">
									<label class="col-lg-12 control-label-updatepass" for="confirm1">Confirm Password *</label>
									<div class="col-lg-12">
										<input id="repassword" name="repassword" type="password" class="required form-control"  placeholder="Confirm Password">
									</div>
								</div>
								</div>
							</div>
	

			
							
							
						
					</fieldset>	
					<div class="row">
						<div class="text-left col-md-6">

							
						</div>
						
						<div class="text-right col-md-6">
							<button type="submit" class="btn btn-group btn-default btn-sm">
							
	
											Update Password		
							<i class="icon-right-open-big"></i>

							</button>
						</div>
						
					</div>      
		
			</form>




    
            </div>
            
            
            
            
        </div>
        
        
        </div>
    </section>
    <!-- main-container end -->
	
	    
    </cfoutput>
