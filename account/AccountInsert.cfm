<cfoutput>
    <cfparam  name="url.AccountId" default="0">
	
	<cfquery datasource="#request.dsnameReader#" name="qAccountSelect">	
		SELECT *
			FROM Account		
		WHERE AccountId = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(url.AccountID)#">	
	</cfquery>
   
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
                            <h2 class="page-title margin-top-clear"> Add Account</h2>
                        </div>
                        <div class="col-md-4">
                            
                        </div>
                    </div>                  
                    
                

					<form id="validate-1" role="form" class="form-horizontal" action="partialIndex.cfm?area=account&action=AccountInsertAction"  method="post" target="formpost" enctype="multipart/form-data">                      
						<div class="space-bottom"></div>    
						
							<!---Personal Details --->
							<fieldset>
								<legend><span>Add An Account </span></legend>
									<div class="row">												
										<div class="col-lg-12">
											<div class="form-group">
												<label for="AccountName" class="col-md-3 control-label">Account Name <small class="text-default">*</small></label>
												<div class="col-md-9">
													<input type="text" class="form-control required" id="AccountName" name="AccountName" value="#qAccountSelect.AccountName#">
												</div>
											</div>
											<div class="form-group">
												<label for="isClosed" class="col-md-3 control-label">Status <small class="text-default">*</small></label>
												<div class="col-md-9">
													<select class="form-control required" id="Class" name="isClosed">	
														<option value="1" <cfif qAccountSelect.isClosed eq '1'>selected</cfif>>Open</option>
														<option value="0" <cfif qAccountSelect.isClosed eq '0'>selected</cfif>>Close</option>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label for="AccountDescription" class="col-md-3 control-label">Account Description </label>
												<div class="col-md-9">
													<textarea name="Description" class="form-control">
														<cfif trim(len(qAccountSelect.Description)) gt 0 >
															#qAccountSelect.Description#
														</cfif>
													</textarea>
												</div>
											</div>
										</div>
									</div>
									
								
							</fieldset>
							

							<!--- Actions --->
							<div class="row">
							
								<div class="text-left col-md-6">

									
								</div>
								

								<div class="text-right col-md-6">
									<cfif val(qAccountSelect.AccountID) gt 0 >
										<input name="AccountID" value="#qAccountSelect.AccountID#" type="hidden">
									</cfif>
									<button type="submit" class="btn btn-group btn-default btn-sm btn-disabled updateButton" id="buttonDisabled">							
										<cfif val(qAccountSelect.AccountID) gt 0 >
											Update														
										<cfelse>
											Add														
										</cfif>
										<i class="icon-right-open-big"></i>							
									</button>
								</div>
								
							</div>
						</div>
					</form>

                    <p>* All Fields Required Information</p>
    
            </div>
            
        </div>

    </section>
    <!-- main-container end -->
	
	    
    </cfoutput>