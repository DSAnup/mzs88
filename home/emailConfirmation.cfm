
<cfparam name="url.leadorderid" default="" >
<cfparam name="form.leadorderid" default="#url.leadorderid#" >

<cfparam name="url.email" default="" >
<cfparam name="form.email" default="#url.email#" >

<cfparam name="url.PaymentOptionID" default="" >
<cfparam name="form.PaymentOptionID" default="#url.PaymentOptionID#" >


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
						<h1 class="page-title margin-top-clear">Email Confirmation</h1>
					</div>
					<div class="col-md-4">
						<cfinclude template="help-button.cfm">
					</div>
				</div>
				<!-- page-title end -->
				<div class="space"></div>
				
				
				<div class="row">
                  	
                  	<!---Order Confirmation --->
                  	<div class="col-md-6">
					
							<p class="lead text-left">
								
								<cfoutput>
				
							<h2>Confirmation & Invoice Instructions</h2>
							<fieldset>
								<legend><span> Order Confirmation</span></legend>
                                    <form id="login-form" name="login-form" method="post" action="partialIndex.cfm?area=home&action=emailConfirmationAction&task=EmailConfirmation" target="emailPdfGen" >
										<!---success alert --->
										<div class="alert alert-success alertHidden" id="successAlert"></div>
										
										<!--- error alert --->
										<div class="alert alert-danger alertHidden"  id="errorDiv">										
											<span id="errorMessage"></span>
										</div>
										
										<div class="form-group">
                                            <label for="orderID" class="col-md-3 control-label">Order ID*</label>
                                            <div class="col-md-9">
                                                <input type="text" required="" id="orderID" class="form-control" name="orderID" placeholder="Order ID" value="#form.leadorderid#">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="username" class="col-md-3 control-label">Email</label>
                                            <div class="col-md-9">
                                                <input type="text" class="form-control" placeholder="Provide to overwrite from order" id="email" name="Email" value="#form.email#">
                                            </div>
                                    	 </div>
                                        
                                       
                                        <div class="form-group">
                                        	
                                        	<input  type="checkbox" id="confirmationAndInvoice" name="confirmationAndInvoice" value="true" checked="checked"  > Include Invoice and Payment Instructions
                                        	
                                        	
                                        	<cfif form.PaymentOptionID eq 2>
                                        		<br>
                                        		<input  type="checkbox" id="bitpayInvoice" name="bitpayInvoice" value="true" > Generate BitPay Invoice
                                        		
                                        	<cfelse>
                                        	
                                        		<br>
                                        		<input disabled="disabled"   type="checkbox" id="bitpayInvoice" name="bitpayInvoice" value="true" > Bitpay Payment Not Applicable
                                        		
                                        		
                                        	</cfif>
                                        	
                                        	
                                        	                                       	
                                        	<br>
                                            <input type="submit" class="btn btn-success btnsubmit" value="Generate Email Confirmation">
                                        </div>
                                        
                                        
                                    </form>
                                    
                                  
									
                                       
								</fieldset>
					</div>
					
					<!---Order Confirmation --->
                  	<div class="col-md-6" style=" display: none;">
					
							<p class="lead text-left">
				
							<h2>Invoice and Payment Instruction</h2>
							<fieldset>
								<legend><span> Order Confirmation</span></legend>
                                    <form id="login-form" name="login-form" method="post" action="partialIndex.cfm?area=home&action=emailConfirmationAction&task=generateInvoice" target="emailPdfGen" >
										<!---success alert --->
										<div class="alert alert-success alertHidden" id="successAlert"></div>
										
										<!--- error alert --->
										<div class="alert alert-danger alertHidden"  id="errorDiv">										
											<span id="errorMessage"></span>
										</div>
										
										<div class="form-group">
                                            <label for="orderID" class="col-md-5 control-label">Order ID*</label>
                                            <div class="col-md-7">
                                                <input type="text" required="" id="orderID" class="form-control" name="orderID" placeholder="Order ID" value="#form.leadorderid#">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="username" class="col-md-5 control-label">Payment Method</label>
                                            <div class="col-md-7">
                                                <select name="PaymentOptionID" class="form-control">
                                                	
                                                	<option value="">Whatever is in the order</option>
                                                	<option value="1">USD - US Bank</option>
                                                	<option value="2">Bitcoin</option>
                                                	<option value="3">Indian Rupee</option>
                                                	
                                                </select>
                                            </div>
                                    	 </div>
                                        
                                        <input type="hidden" name="debug">
                                       
                                        <div class="form-group">
                                        	
                                        	<input  type="checkbox" id="bitpayInvoice" name="bitpayInvoice" value="true" > Generate BitPay Invoice
                                        	
                                            <input type="submit" class="btn btn-success btnsubmit" value="Generate Invoice and Payment Instructions">
                                        </div>
                                        
                                        
                                    </form>
									
                                       
								</fieldset>
					</div>
				
				
				
				</div>
				
				
				
				
				
					  </cfoutput>
				
				
			
				

</div>
			<!-- main end -->

		</div>
	</div>
</section>
<!-- main-container end -->

<iframe id="emailPdfGen" name="emailPdfGen" height="800" style="width:100%; display: block; margin-top:20px;"></iframe> 

