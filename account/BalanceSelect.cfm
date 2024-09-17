<cfif session.profile.isLoggedIn eq false AND url.area neq "login">			
		<cflocation url="/?area=home&action=loginorSignin" addtoken="false" >			
</cfif>
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
				
				<!---title and description of the main section title --->

				<!-- page-title start -->
				<!-- ================ -->
				<div class="row">
					<div class="col-12">
						<div class="page-title-box">
							<h4 class="page-title">Balance Summary </h4>
							<div class="page-title-right">
								<ol class="breadcrumb p-0 m-0">
									<li class="breadcrumb-item"><a href="/">Home</a></li>
									<li class="breadcrumb-item active">Balance Summary </li>
								</ol>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-md-12">
						<div class="card">
							<div class="card-body">
								<div class="row">
									<div class="col-12">
				
										<cfoutput>
											<div class="container">                                  
												<form id="formBalanceSelect" action="partialIndex.cfm?area=account&action=BalanceSelectAction" method="post" target="formpost">
													<div class="row">
				
														<div class="col-md-3">
															<div class="form-group row">
																<label for="AccountID" class="col-form-label col-lg-12 sholwlog-label datasent">Account</label>
																<div class="col-lg-12">	
																	<cfparam name="session.AccountID"	 default="">										
																	<select class="form-control required" name="AccountID" id="AccountID">
																		<option value="">Show All</option>													
																		<cfloop query="qAccountSelect">
																			<option value="#qAccountSelect.AccountID#" <cfif session.AccountID eq qAccountSelect.AccountID>selected</cfif>>#qAccountSelect.AccountName#</option>
																		</cfloop>
																		
																	</select>
																</div>
															</div>
														</div>      
														
														<div class="col-md-3">
															<div class="form-group row">
																<label for="isClosed" class="col-form-label col-lg-12 sholwlog-label datasent">Status</label>
																<div class="col-lg-12">	
																	<cfparam name="session.isClosed"	 default="">										
																	<select class="form-control required" name="isClosed" id="isClosed">
																		<option value="">Show All</option>							
																		<option value="1" <cfif session.isClosed eq '1'>selected</cfif>>Open</option>
																		<option value="0" <cfif session.isClosed eq '0'>selected</cfif>>Close</option>
																		
																	</select>
																</div>
															</div>
														</div>  
				
														<cfset lastmonth= "1/01/2000">
				
														<!--- Date From --->
														<div class="col-md-2">
															<div class="form-group row">
																<label for="dateFrom" class="col-form-label col-lg-12">Date From</label>
																<div class="col-lg-12">
																	<input class="form-control" id="dateFrom" name="dateFrom" type="text" value="#dateformat(lastmonth, "mm/dd/yyyy")#" aria-required="true">
																</div>
															</div>
														</div>
				
														<!--- Date To --->
														<div class="col-md-2">
															<div class="form-group row">
																<label for="dateTo" class="col-form-label col-lg-12">Date To</label>
																<div class="col-lg-12">
																	<input class="form-control DateSent" id="dateTo" name="dateTo" type="text" value="#dateformat(Now(), "mm/dd/yyyy")#" aria-required="true">
																</div>
															</div>
														</div>
				
				
														<!--- Action Button --->
														<div class="col-md-2">
															<div class="form-group row">
																<div class="col-lg-12 d-flex justify-content-end">
																	<button type="submit" class="btn btn-purple waves-effect waves-light" style="min-width: 150px; margin-top: 25px;">Search</button>
																
																</div>
															</div>
														</div>
												  </div>                               
											  </form>
											</div>		
										</cfoutput>
					
								   </div>
								</div>
				
								<!-- End #wizard-vertical -->
							</div>
							<!-- End card-body -->
						</div>
						<!-- End card -->
					</div>
					<!-- end col -->
				</div>	
				<!--- alert goes here --->
				<div id="alert"></div>

				<!---start search result here --->
				<div id="searchResultContainer">	
				

			<div class="clearfix"></div>

				

			</div>
			<!-- main end -->

		</div>
	</div>
</section>
<!-- jQuery UI CSS -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery UI JS -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>
	function loadTable(){
		var table = $('#Resultdatatable').dataTable( { aaSorting : [[0, 'desc']] } );
	}
  
	window.addEventListener('load', (event) => {
		  $('#dateFrom')
			  .datepicker({
				  format: 'mm/dd/yyyy',
				  autoclose: true,
				  orientation: 'bottom',
				  immediateUpdates: true,
				  todayHighlight: true, 
				  todayBtn: true,
			  });
  
		  $('#dateTo')
			  .datepicker({
				  format: 'mm/dd/yyyy',
				  autoclose: true,
				  orientation: 'bottom',
				  immediateUpdates: true,
				  todayHighlight: true, 
				  todayBtn: true,
			  });
  
		formBalanceSelect.submit();
        
	});
  </script>
