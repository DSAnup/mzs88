<cfoutput>
    <cfparam  name="url.TransactionID" default="0">
	
	<cfquery datasource="#request.dsnameReader#" name="qTransactionSelect">	
		SELECT TD.*, A.ACCOUNTNAME	   
		FROM TransactionDetails AS TD
			LEFT JOIN Account AS A ON A.AccountID = TD.AccountID	
		WHERE TD.TransactionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(url.TransactionID)#">	
	</cfquery>

	

	<cfif qTransactionSelect.recordCount gt 0>
		<cfset url.AccountID = qTransactionSelect.AccountID>
		<cfset local.TransactionDate = qTransactionSelect.TransactionDate>	
	<cfelse>
		<cfset local.TransactionDate = Now()>
	</cfif>

	
	<cfquery datasource="#request.dsnameReader#" name="qAccountSelect"> 
		SELECT *	   
		FROM 
			Account 
		WHERE AccountID = #url.AccountID#
			
	</cfquery>

	<cfquery datasource="#request.dsnameReader#" name="qAppUserSelect"> 
		SELECT *	   
		FROM 
			AppUser
			order by NickName
	</cfquery>
   
   <cfif qTransactionSelect.AccountID neq ''>
		<cfset AccountID = qTransactionSelect.AccountID>
	<cfelseif url.AccountID neq ''>
		<cfset AccountID = url.AccountID>
	</cfif>
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
								<h4 class="page-title">Add Fund </h4>
								<div class="page-title-right">
									<ol class="breadcrumb p-0 m-0">
										<li class="breadcrumb-item"><a href="index.cfm?area=account&action=TransactionSelect&AccountID=<cfoutput>#AccountID#</cfoutput>">Transaction List</a></li>
										<li class="breadcrumb-item active">Add Credit </li>
									</ol>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
					</div>                
                                     
                    

					<form id="validate-1" role="form" class="form-horizontal" action="partialIndex.cfm?area=account&action=CreditInsertAction"  method="post" target="formpost" enctype="multipart/form-data" onsubmit="return validateForm()">                      
						<div class="space-bottom"></div>    
						
							<!---Personal Details --->
							<fieldset>
								<legend><span>Add Credit </span></legend>
									<div class="row col-lg-6">												
										<div class="col-lg-12">
											<div class="form-group">
												<label for="AccountID" class="col-md-3 control-label">Account Type <small class="text-default">*</small></label>
												<div class="col-md-9">
													<select class="form-control required" id="Class" name="AccountID" disabled>	
														<option value="">Choose a Account</option>
														<cfloop query="qAccountSelect">
															<option value="#qAccountSelect.AccountID#" selected>
																#qAccountSelect.AccountName#</option>
														</cfloop>
													</select>
													<input type="hidden" name="AccountID" value="#AccountID#">
												</div>
											</div>
											<div class="form-group">
												<label for="Credit" class="col-md-3 control-label"> Amount Received<small class="text-default">*</small></label>
												<div class="col-md-9">
													<input type="text" class="form-control required" id="Credit" name="Credit" value="#qTransactionSelect.Credit#">
												</div>
											</div>
											<div class="form-group">
												<label for="SourceUserId" class="col-md-3 control-label"> Member</label>
												<div class="col-md-9">
													<select class="form-control" id="SourceUserID" name="SourceUserID">	
														<option value="">Choose a Member</option>
														<cfloop query="qAppUserSelect">
															<option value="#qAppUserSelect.AppUserID#" 
															<cfif qAppUserSelect.AppUserID eq qTransactionSelect.SourceUserID>
															selected</cfif>>#qAppUserSelect.NickName# - #qAppUserSelect.NameInEnglish#</option>
														</cfloop>
													</select>
												</div>
											</div>
										</div>
									</div>
									
									<div class="row col-lg-6">												
										<div class="col-lg-12">
											<div class="form-group">
												<label for="TransactionDate" class="col-md-3 control-label">Transaction Date <small class="text-default">*</small></label>
												<div class="col-md-9">
													<input class="form-control required" type="text" id="TransactionDate" name="TransactionDate" value="#dateformat(local.TransactionDate, 'mm/dd/yyyy')#">
												</div>

											</div>
											<div class="form-group">
												<label for="Note" class="col-md-3 control-label">Note</label>
												<div class="col-md-9">
													<textarea name="Note" class="form-control"><cfif trim(len(qTransactionSelect.Note)) gt 0 >#qTransactionSelect.Note#</cfif></textarea>
												</div>
											</div>
											<div class="form-group">
												<label for="SourceFromOthers" class="col-md-3 control-label"> Source (if not from Member) </label>
												<div class="col-md-9">
													<input type="text" class="form-control" id="SourceFromOthers" name="SourceFromOthers" value="#qTransactionSelect.SourceFromOthers#">
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
										<input  name="TransactionID" value="#qTransactionSelect.TransactionID#" type="hidden">
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

<script>
	
	function validateForm() {
		const SourceUser = document.getElementById("SourceUserID");
		const SourceOthers = document.getElementById("SourceFromOthers");

		const isSelectEmpty = SourceUser.value === "";
		const isTextInputEmpty = SourceOthers.value.trim() === "";
	
		if (isSelectEmpty && isTextInputEmpty) {
			alert("Please select a source user or specify a source.");
			return false; // Prevent form submission
		}

		if (!isSelectEmpty && !isTextInputEmpty) {
			alert("Please choose only one: either select a member or a source.");
			return false; // Prevent form submission
		}

		return true; // Allow form submission
	}

</script>