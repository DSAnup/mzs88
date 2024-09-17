<cfoutput>
    <cfparam  name="url.TransactionID" default="0">
	
	<cfquery datasource="#request.dsnameReader#" name="qTransactionSelect">	
		SELECT TD.*, A.ACCOUNTNAME	   
		FROM TransactionDetails AS TD
			LEFT JOIN Account AS A ON A.AccountID = TD.AccountID	
		WHERE TD.TransactionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(url.TransactionID)#">	
	</cfquery>

	<cfquery datasource="#request.dsnameReader#" name="qAccountSelect"> 
		SELECT *	   
		FROM 
			Account 
		WHERE isClosed = 1
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
						<div class="col-12">
							<div class="page-title-box">
								<h4 class="page-title">Add Expense </h4>
								<div class="page-title-right">
									<ol class="breadcrumb p-0 m-0">
										<li class="breadcrumb-item"><a href="index.cfm?area=account&action=TransactionSelect">Transaction List</a></li>
										<li class="breadcrumb-item active">Add Debit </li>
									</ol>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
					</div>                
                    
                

					<form id="validate-1" role="form" class="form-horizontal" action="partialIndex.cfm?area=account&action=DebitInsertAction"  method="post" target="formpost" enctype="multipart/form-data">                      
						<div class="space-bottom"></div>    
						
							<!---Personal Details --->
							<fieldset>
								<legend><span>Add Debit </span></legend>
									<div class="row col-lg-6">												
										<div class="col-lg-12">
											<div class="form-group">
												<label for="AccountID" class="col-md-3 control-label">Account Type <small class="text-default">*</small></label>
												<div class="col-md-9">
													<select class="form-control required" id="Class" name="AccountID">	
														<option value="">Choose a Account</option>
														<cfloop query="qAccountSelect">
															<option value="#qAccountSelect.AccountID#" <cfif qTransactionSelect.AccountID eq qAccountSelect.AccountID>selected</cfif>>#qAccountSelect.AccountName#</option>
														</cfloop>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label for="Debit" class="col-md-3 control-label">Debit<small class="text-default">*</small></label>
												<div class="col-md-9">
													<input type="number" class="form-control required" id="Debit" name="Debit" value="#qTransactionSelect.Debit#">
												</div>
											</div>
										</div>
									</div>
									
									<div class="row col-lg-6">												
										<div class="col-lg-12">
											<div class="form-group">
												<label for="TransactionDate" class="col-md-3 control-label">Transaction Date <small class="text-default">*</small></label>
												<div class="col-md-9">
													<input type="date" class="form-control required" id="TransactionDate" name="TransactionDate" minlength="10"  value="#DateFormat(qTransactionSelect.TransactionDate, "yyyy-mm-dd")#">
												</div>
											</div>
											<div class="form-group">
												<label for="Note" class="col-md-3 control-label">Note </label>
												<div class="col-md-9">
													<textarea name="Note" class="form-control">
														<cfif trim(len(qTransactionSelect.Note)) gt 0 >
															#trim(qTransactionSelect.Note)#
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
									<cfif val(qTransactionSelect.TransactionID) gt 0 >
										<input name="TransactionID" value="#qTransactionSelect.TransactionID#" type="hidden">
									</cfif>
									<button type="submit" class="btn btn-group btn-default btn-sm btn-disabled updateButton" id="buttonDisabled">							
										<cfif val(qTransactionSelect.TransactionID) gt 0 >
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