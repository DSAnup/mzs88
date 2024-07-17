<!--- see if ther is any item in the cart--->
<cfparam name="session.Cart" default="#StructNew()#">
<cfif StructIsEmpty(session.cart) or not isdefined("session.cart.leadprice")>
	<cflocation url="/index.cfm?area=home&action=cartemptywarning" addtoken="no" >	
</cfif>
    
    <cfparam  name="session.cart.PaymentOption" default="">
    
<!--- set Deposit Bank ID if from India --->
<cfif session.profile.client.CountryID eq 102>
	<cfset bankService = createObject('component', 'model.bankService')>
	<cfset qDepositBankSelect = bankService.setDepositBank(ClientID = session.profile.Client.ClientID)>	
</cfif>
       
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
                            <h1 class="page-title margin-top-clear">Payment Option</h1>
                        </div>
                        <div class="col-md-4">
                            <cfinclude template="help-button.cfm">
                        </div>
                    </div>
                    <!-- page-title end -->
                    <div class="space"></div>
                    
                    
                    
                    <!---Progress Bar--->
                    <cfset currentStep = 3>
                    <cfinclude template="progressbar.cfm">
                   <div class="row">
                  		 <div class="col-md-12">
							<p>Please select one of the payment option from below 
								and press "Next Step" to review your Order.
							 </p>
					 	</div>
					 </div>
                     
                     <!--- if India, we will have the rupee option --->
				  	<cfif session.profile.Client.CountryID eq 102>
				  		<cfset displayItem = 3>
				  	<cfelse>
				  		<cfset displayItem = 2>
				  	</cfif>
			
			<form  class="form-horizontal paymentMethords" action="partialIndex.cfm?area=home&action=paymentOptionAction&leadtype=#url.leadtype#"  method="post"  target="formpost" >                      
				<div class="space-bottom"></div>     
					
					
					
					<div class="row">
						
						
						<!--- USD --->
						<div class="col-md-#12/displayItem#">
			
							<fieldset>
								<legend><span>US Dollar</span></legend>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label for="email" class="col-md-6 control-label">
												
												<img src="/assets/img/Dollar_icon.png">
												
											</label>
											<div class="col-md-6">
												
												
												
												<input <cfif session.cart.PaymentOption eq "US Dollars">checked="checked"</cfif>  type="radio" onclick="$('##nextButton').prop('disabled', false);" class="custom-control-input" id="paymentoption" name="paymentoption" value="US Dollars">
												<p>													
													Payment can be made by USD directly to GodSpeed Corporate Bank Account held at 
													Wells Fargo.  
												</p>											
											</div>
										</div>
									</div>
								</div>
							</fieldset>
					
				
						</div>
						
						<!--- bitcoin --->
						<div class="col-md-#12/displayItem#">
			
							<fieldset>
								<legend><span>Bitcoin</span></legend>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label for="email" class="col-md-6 control-label">
												
												<img src="/assets/img/bitcoin_icon.png">
												
											</label>
											<div class="col-md-6">
												
												<br>
												
												
												
												<input <cfif session.cart.PaymentOption eq "Bitcoin">checked="checked"</cfif> type="radio" onclick="$('##nextButton').prop('disabled', false);" class="custom-control-input" id="paymentoption" name="paymentoption" value="Bitcoin">
												<p>													
													If you are already a Bitcoin user and would like to place an order using this form of payment, select the Pay with Bitcoin option. 
												</p>										
											
											
											
											
											</div>
										</div>
									</div>
								</div>
							</fieldset>
					
				
						</div>
					
			
					
						
						<!--- rupee --->
						<cfif session.profile.Client.CountryID eq 102>
						<div class="col-md-#12/displayItem#">
			
							<fieldset>
								<legend><span>Indian Rupee</span></legend>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label for="email" class="col-md-6 control-label">
												
												<img src="/assets/img/INR_icon.png">
												
											</label>
											<div class="col-md-6">
												
												<input <cfif session.cart.PaymentOption eq "Indian Rupee">checked="checked"</cfif> type="radio" onclick="$('##nextButton').prop('disabled', false);" class="custom-control-input" id="paymentoption" name="paymentoption" value="Indian Rupee">
												
												<p>
													Pay into the following Bank:
													
													<li>#qDepositBankSelect.DepositBankName#<br>&nbsp;<br>&nbsp;</li>	
													
												</p>
											
											</div>
											<p><strong>Note</strong>: GST #request.addGstIndianRupee#% will be charged.</p>
										</div>
									</div>
								</div>
							</fieldset>
					
				
						</div>
						</cfif>
						
						
						
					</div>
			
			
				
			
			
					<div class="row">
						
						
						
						<div class="col-md-11 offset-md-1">
							
								<strong>							
								<cfif session.cart.totalPrice gt request.MaxAutoInvoiceAmount>
                    	
			                    	Once your order request is reviewed and approved, you will be sent an 
			                    	invoice along with detail payment instructions including account details.
			                    	
			                    <cfelse>
			                    
			                    	With order confirmation, you will be sent an 
			                    	invoice along with detail payment instructions including account details.
			                    	
			                    </cfif>	
			                    </strong>							
							
							
						</div>
						
						
						
						<div class="text-left col-md-6">
						
						<a href="index.cfm?area=home&action=product&LeadProductID=#session.Cart.leadProductID#&leadtype=#url.leadtype#" class="btn btn-group btn-default btn-sm"><i class="icon-left-open-big"></i> Go Back To Order Details</a>	
				
						<a href="index.cfm?area=home&action=clientinfo&leadtype=#session.cart.priceoption#" class="btn btn-group btn-default btn-sm"><i class="icon-left-open-big"></i> Go Back To Client Info</a>
					
							
						</div>
						
						<div class="text-right col-md-6">
							
							<cfif session.cart.paymentOption eq "">
							
								<button id="nextButton" type="submit" class="btn btn-group btn-default btn-sm btn-disabled" disabled="">
									Next Step <i class="icon-right-open-big"></i>
								</button>
							
							<cfelse>
								<button id="nextButton" type="submit" class="btn btn-group btn-default btn-sm">
									Next Step <i class="icon-right-open-big"></i>
								</button>
								
							</cfif>
							
							
						
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
            
            $("#password").val("1234");
            $("#confirmpassword").val("1234");
            $("#deliveryemail").val("fakir.hossain@yahoo.com");
        
        
        }
    
    </script>