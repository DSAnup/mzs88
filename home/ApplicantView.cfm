<cfoutput>
    <cfparam  name="url.ScholarShipID" default="0">
	
	<cfquery datasource="#request.dsnameReader#" name="qScholarShipSelect">	
		SELECT *
			FROM ScholarShip		
		WHERE ScholarShipID = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(url.ScholarShipID)#">	
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
                            <h1 class="page-title margin-top-clear"> Apply For Scholarship 2024</h1>
                        </div>
                        <div class="col-md-4">
                            
                        </div>
                    </div>
                    <!-- page-title end -->
                    <div class="space"></div>                    
                    
                    
					<div class="row col-12 text-right">
						<button class="btn btn-group btn-default btn-sm" onclick="printDiv('printableArea')">Print</button>
					</div>
                    <div class="row" id="printableArea">
						
							<!---Personal Details --->
							<fieldset>
								<legend><span>Personal Details </span></legend>										
								<div class="col-md-12">
									<div class="col-md-6">
										<table class="table">
											<tbody>
												<tr>
													<th scope="row"></th>
													<td>
														<cfif val(qScholarShipSelect.ScholarShipID) gt 0 >
															<cfif qScholarShipSelect.Picture neq '' >
																<div class="image-area"><img src="assets/alumni_pictures/Profile/#qScholarShipSelect.Picture#" alt=""></div>
															<cfelse>
																<div class="image-area"><img src="assets/alumni_pictures/man.jpg" alt=""></div>
															</cfif>
														<cfelse>
															<div class="image-area"><img src="assets/alumni_pictures/man.jpg" alt=""></div>
						
														</cfif>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="col-md-6">
										<table class="table">
											<tbody>
												<tr>
													<th scope="row">Full Name :</th>
													<td>#qScholarShipSelect.FullName#</td>
												</tr>
												<tr>
													<th scope="row">Date of Birth :</th>
													<td> #DateFormat(qScholarShipSelect.Dob, "yyyy-mm-dd")#</td>
												</tr>
												<tr>
													<th scope="row">Application Tracking Number :</th>
													<td>#qScholarShipSelect.ApplicationTrackingNumber#</td>
												</tr>
												<tr>
													<th scope="row">Session Year:</th>
													<td>#qScholarShipSelect.SessionYear#</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</fieldset>
							

							<!--- Academic Details --->
							<fieldset>
								<legend><span>Academic Details</span></legend>
								<div class="row col-md-12">
									<table class="table">
										<tbody>
											<tr>
												<th scope="row">Class :</th>
												<td>#qScholarShipSelect.Class#</td>
												<th scope="row">Shift :</th>
												<td>#qScholarShipSelect.Shift#</td>
											</tr>
											<tr>
												<th scope="row">Section :</th>
												<td>#qScholarShipSelect.Section#</td>
												<th scope="row">Home Teacher Name :</th>
												<td>#qScholarShipSelect.HomeTeacherName#</td>
											</tr>
										</tbody>
									</table>
								</div>
								<!--- <div class="space"></div> --->
							</fieldset>
							

							<!--- Contact Details --->
							<fieldset>
								<legend><span>Contact Details</span></legend>
								<div class="row col-md-12">
									<table class="table">
										<tbody>
											<tr>
												<th scope="row">Guardian's Name :</th>
												<td>#qScholarShipSelect.GuardianName#</td>
												<th scope="row">Guardian's Phone :</th>
												<td>#qScholarShipSelect.GuardianPhoneNumber#</td>
											</tr>
											<tr>
												<th scope="row">Address :</th>
												<td>#qScholarShipSelect.Address#</td>
											</tr>
										</tbody>
									</table>
								</div>
							</fieldset>
						

							<!--- Merit Analysis --->
							<fieldset>
								<legend><span>Merit Details</span></legend>
								<div class="row col-md-12">
									<table class="table">
										<tbody>
											<tr>
												<th scope="row">
													<cfif qScholarShipSelect.MeritRank gt '0'>
														Merit Rank :
													<cfelse>
														Merit Symbol :
													</cfif>
												</th>
												<td>
													<cfif qScholarShipSelect.MeritRank gt '0'>
														#qScholarShipSelect.MeritRank#
													<cfelse>
														#qScholarShipSelect.MeritSymbol#
													</cfif>
												</td>
												<th scope="row">
													Score :
												</th>
												<td>
													<cfif qScholarShipSelect.MeritRank gt '0'>
														#qScholarShipSelect.MeritRank#
													<cfelse>
														<cfif qScholarShipSelect.MeritSymbol eq 'triangle'>
															40
														<cfelseif qScholarShipSelect.MeritSymbol eq 'circle'>
															30
														<cfelse>
															20
														</cfif>
													</cfif>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="space"></div>
							</fieldset>
					
							<!--- Guardian Income --->
							<fieldset>
								<legend><span>Guardian Income Details</span></legend>
								<div class="row col-md-12">
									<table class="table">
										<tbody>
											<tr>
												<th scope="row">
													Parent Income :
												</th>
												<td>
													<cfif qScholarShipSelect.ParentIncome eq '40'>
														0 - 10k
													<cfelseif qScholarShipSelect.ParentIncome eq '35'>
														11k - 20k
													<cfelseif qScholarShipSelect.ParentIncome eq '30'>
														21k - 30k
													<cfelseif qScholarShipSelect.ParentIncome eq '25'>
														31k - 40k
													<cfelse>
														40k +
													</cfif>
												</td>
												<th scope="row">
													Score :
												</th>
												<td>
													#qScholarShipSelect.ParentIncome#
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="space"></div>
							</fieldset>

							<!--- Teacher's Refference --->
							<fieldset>
								<legend><span>Teacher's Refference Details</span></legend>
								<div class="row col-md-12">
									<table class="table">
										<tbody>
											<tr>
												<th scope="row">Full Name Of Teacher One :</th>
												<td>
													<cfif qScholarShipSelect.TeacherOne neq ''>
														#qScholarShipSelect.TeacherOne#
													<cfelse>
														N/A
													</cfif>
												</td>
												<th scope="row">Full Name Of Teacher Two :</th>
												<td>
													<cfif qScholarShipSelect.TeacherTwo neq ''>
														#qScholarShipSelect.TeacherTwo#
													<cfelse>
														N/A
													</cfif>
												</td>
											</tr>
											<tr>
												<th scope="row">Phone Number Of Teacher One :</th>
												<td>
													
													<cfif qScholarShipSelect.TeacherOnePhone neq ''>
														#qScholarShipSelect.TeacherOnePhone#
													<cfelse>
														N/A
													</cfif>
												</td>
												<th scope="row">Phone Number Of Teacher Two  :</th>
												<td>
													
													<cfif qScholarShipSelect.TeacherTwoPhone neq ''>
														#qScholarShipSelect.TeacherTwoPhone#
													<cfelse>
														N/A
													</cfif>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="space"></div>
							</fieldset>

							<!--- Performance Analysis --->
							<fieldset>
								<legend><span>Performance Result</span></legend>
								<div class="row col-md-12">
									<table class="table">
										<thead>
										  <tr>
											<th>Category</th>
											<th>Mark</th>
										  </tr>
										</thead>
										<tbody>
											<tr>
												<td>Merit Analysis</td>
												<td>
													<cfif qScholarShipSelect.MeritRank gt '0'>
														#qScholarShipSelect.MeritRank#
													<cfelse>
														<cfif qScholarShipSelect.MeritSymbol eq 'triangle'>
															40
														<cfelseif qScholarShipSelect.MeritSymbol eq 'circle'>
															30
														<cfelse>
															20
														</cfif>
													</cfif>
												</td>
											</tr>
											<tr>
												<td>Guardian Income</td>
												<td>#qScholarShipSelect.ParentIncome#</td>
											</tr>
											<tr>
												<td>Teacher's Refference</td>
												<td>
													<cfset TeacherNumber = 0>
													<cfif qScholarShipSelect.TeacherOne neq ''>
														<cfset TeacherNumber = TeacherNumber + 10 >
													</cfif>
													<cfif qScholarShipSelect.TeacherOnePhone neq ''>
														<cfset TeacherNumber = TeacherNumber + 10 >
													</cfif>
													<cfif qScholarShipSelect.TeacherTwo neq ''>
														<cfset TeacherNumber = TeacherNumber + 10 >
													</cfif>
													<cfif qScholarShipSelect.TeacherTwoPhone neq ''>
														<cfset TeacherNumber = TeacherNumber + 10 >
													</cfif>
													#TeacherNumber#
												</td>
											</tr>
											<tr>
												<td>Total Mark</td>
												<td>#qScholarShipSelect.Score#</td>
											</tr>
										</tbody>
									  </table>
									<input type="hidden" name="Score" id="Score">
								</div>
								<div class="space"></div>
							</fieldset>
					
						</div>
						
					</div>
    
            </div>
            
        </div>

    </section>
    <!-- main-container end -->
	
	    
</cfoutput>

<script language="javascript"> 
	function printDiv(divId) {
		var printContents = document.getElementById(divId).innerHTML;
		var originalContents = document.body.innerHTML;

		document.body.innerHTML = printContents;

		window.print();

		document.body.innerHTML = originalContents;
		window.location.reload(); // Reload the page to reset the original content
	}
</script>