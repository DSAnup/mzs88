

<cfparam name="url.justlogin" default="" >
<cfparam name="url.leadtype" default="" >


<!--- check if the user is already logged in, if so, go to client info confirmation page

on the left >> Login In Form

login action page

on the right >> sign up form --->

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
                            <h1 class="page-title margin-top-clear">
                            		Signup Information
                            </h1>
                        </div>
                        <div class="col-md-4">
                            
                        </div>
                    </div>
                    <!-- page-title end -->
                    <div class="space"></div>
                    
                    
                    
               
                  	<div class="row">
                  		 <div class="col-md-12">
                  		<cfif url.justlogin neq "true">An account is required to complete your profile.</cfif>
                  		You can sign in if you already have an account, otherwise,
                  		you can create a new account.
                  		</div>
                  	</div>

                    <div id="loginSignup" class="loginSignup">
                        <div class="row">
                            <div class="col-md-6">
                                <div id="loginarea" class="loginarea">

									<fieldset>
											<legend><span> Login Registered member</span></legend>
                                    <form id="login-form" name="login-form" method="post" action="partialIndex.cfm?area=home&action=loginAction&justlogin=true" target="formpost" >
										<!---success alert --->
										<div class="alert alert-success alertHidden" id="successAlert"></div>
										
										<!--- error alert --->
										<div class="alert alert-danger alertHidden"  id="errorDiv">										
											<span id="errorMessage"></span>
										</div>

                                        <div class="form-group">
                                            <label for="username" class="col-md-3 control-label">Email Or Phone</label>
                                            <div class="col-md-9">
                                                <input type="text" class="form-control" placeholder="Email Or Phone Number" id="email" name="Email" value="">
                                            </div>
                                    	 </div>
                                        <div class="form-group">
                                            <label for="upassword" class="col-md-3 control-label">Password</label>
                                            <div class="col-md-9">
                                                <input type="password" id="upassword" class="form-control" name="Password" placeholder="Password" value="">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <input type="checkbox" class="custom-control-input" id="checkbox-signin" name="rememberme">
                                            <label class="control-label" for="checkbox-signin">Remember me</label>
                                        </div>
                                        <div class="form-group">
                                            <input type="submit" class="btn btn-success btnsubmit" value="Log In">
                                        </div>
                                        
                                        
                                    </form>
									
                                        <!--- <div class="form-group">
											<button onclick="resetPass()" id="forgetpassbtn" class="forgetpass">Forget Password?</button>
                                        </div> --->
										</fieldset>
                                </div>
                                <div id="forgetpass" class="forgetpass">
								<fieldset>
											<legend><span> Password Request</span></legend>
								
           
                                    <p class="text-left">
                                    	If you forgot your password, please provide your email below and press send password.
                                    We will send your password to your email.
                                    </p>
                                    
                                  
                                    
                                    <form  method="post" action="partialIndex.cfm?area=home&action=passwordRequestAction&justlogin=#url.justlogin#" target="formpost" >
                                        
										<!---success alert --->
										<div class="alert alert-success alertHidden" id="successAlert"></div>
										
										<!--- error alert --->
										<div class="alert alert-danger alertHidden"  id="errorDivReset">										
											<span id="errorMessageReset"></span>
										</div>

                                        	<div class="form-group">
                                            <label for="username" class="col-md-3 control-label">Email</label>
                                            <div class="col-md-9">
                                                <input type="text" class="form-control" placeholder="Your Email" id="email" name="email" value="">
                                            </div>
                                    	 </div>
                                        
                                         
                                            <div class="form-group">
                                            	<label for="username" class="col-md-3 control-label"></label>
                                            	<div class="col-md-9">
													<a class="btn btn-success btnreset" onclick="goBack()" href="javascript:void(0);"><i class="icon-left-open-big"></i> Back To Login</a>
                                                	<input type="submit" class="btn btn-success btnreset" value="Send Password">
                                                	</input>
                                                </div>
                                            </div>
                                        

                                    </form>
									</fieldset>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="registerarea">

										<fieldset>
											<legend><span>Registration for membership</span></legend>
										<div class="side-pop list">
											<div class="side-pop-img">
												<img src="assets/img/man_icon_blue.png" />				
											</div>
											<div class="side-pop-content">
												<h4>Don't have a membership?</h4>
												<span class="sp-date">Sign up to join MZS'88 alumni if you are from '88 Batch, you will need to use either your phone number or email ID. Once you become a registered member you will be able to see other members from '88 Batch and details.</span>					
											</div>
										</div>
			
			
										    <a id="formOption" class="btn btn-success btn-signup" href="index.cfm?area=home&action=signupNotAvailable">Sign up</a>
									
										
									</fieldset>
                                </div>
                            </div>
                        </div>
                    </div>

	


                    

                    <p>* Required Information</p>
                    
                  </div>
                <!-- main end -->
    
            </div>
            
            
            
            
        </div>
        
        
        
    </section>
    <!-- main-container end -->

</cfoutput>
