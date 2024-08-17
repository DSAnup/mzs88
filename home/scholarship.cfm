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
                            <h1 class="page-title margin-top-clear"> Apply For Scholarship 2024</h1>
                        </div>
                        <div class="col-md-4">
                            
                        </div>
                    </div>
                    <!-- page-title end -->
                    <div class="space"></div>                    
                    
                    
        
                     <div class="row">
                  		 <div class="col-md-12">    
							<p>Please complete the following details to apply scholarship</p>
						</div>
					</div>

					<form id="validate-1" role="form" class="form-horizontal" action="partialIndex.cfm?area=home&action=scholarshipAction"  method="post" target="formpost" enctype="multipart/form-data">                      
						<div class="space-bottom"></div>    
						
							<!---Personal Details --->
							<fieldset>
								<legend><span>Personal Details </span></legend>
									<div class="row col-md-6">												
										<div class="col-lg-12">
											<div class="form-group">
												<label for="FullName" class="col-md-5 control-label">Full Name <small class="text-default">*</small></label>
												<div class="col-md-7">
													<input type="text" class="form-control required" id="FullName" name="FullName">
												</div>
											</div>
											<div class="form-group">
												<label for="Dob" class="col-md-5 control-label">Date of Birth <small class="text-default">*</small></label>
												<div class="col-md-7">
													<input type="date" class="form-control required" id="Dob" name="Dob" minlength="10">
												</div>
											</div>
										</div>
									</div>
									
									<div class="row col-md-6">
										
										<div class="col-lg-12 center-block">

											<div class="image-area"><img id="imageResult" src="assets/alumni_pictures/man.jpg" alt=""></div>
											
											<div class="form-group">
												<div class="upload-btn-group">
													<input class="form-control" id="Picture" name="Picture" type="file" onchange="readURL(this);" >
													<label id="upload-label" for="Picture" class="btn btn-success">Upload Photo</label>
												<div class="form-group">
											</div>
										</div>
													
									</div>
								
							</fieldset>
							

							<!--- Academic Details --->
							<fieldset>
								<legend><span>Academic Details</span></legend>
								<div class="row col-md-6">
									<div class="col-lg-12">
										<div class="form-group">
											<label for="Class" class="col-md-5 control-label">Class <small class="text-default">*</small></label>
											<div class="col-md-7">
												<select class="form-control required" id="Class" name="Class">
													<option value="">Select your class</option>
													<option value="ten">Ten</option>
													<option value="nine">Nine</option>
												</select>
											</div>
										</div>								
										<div class="form-group">
											<label for="Shift" class="col-md-5 control-label">Shift <small class="text-default">*</small></label>
											<div class="col-md-7">
												<select class="form-control required" id="Shift" name="Shift">
													<option value="">Select your shift</option>
													<option value="morning">Morning</option>
													<option value="day">Day</option>
												</select>
											</div>
										</div>								
									</div>
								</div>
								<div class="row col-md-6">
									<div class="col-lg-12">
										<div class="form-group">
											<label for="Section" class="col-md-5 control-label">Section <small class="text-default">*</small></label>
											<div class="col-md-7">
												<select class="form-control required" id="Section" name="Section">
													<option value="">Select your section</option>
													<option value="A">A</option>
													<option value="B">B</option>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label for="HomeTeacherName" class="col-md-5 control-label">Home Teacher Name<small class="text-default">*</small></label>
											<div class="col-md-7">
												<input type="text" class="form-control required" id="HomeTeacherName" name="HomeTeacherName">
											</div>
										</div>
									</div>
								</div>
								<!--- <div class="space"></div> --->
							</fieldset>
							

							<!--- Contact Details --->
							<fieldset>
								<legend><span>Contact Details</span></legend>
								<div class="row col-md-6">
									<div class="col-lg-12">
										<div class="form-group">
											<label for="GuardianName" class="col-md-5 control-label">Guardian's Name <small class="text-default">*</small></label>
											<div class="col-md-7">
												<input type="text" class="form-control required" id="GuardianName" name="GuardianName">
											</div>
										</div>
										<div class="form-group">
											<label for="Number" class="col-md-5 control-label">Guardian's Phone <small class="text-default">*</small></label>
											<div class="col-md-7">
												<input type="text" class="form-control required" id="GuardianPhoneNumber" name="GuardianPhoneNumber">
											</div>
										</div>
									</div>
								</div>
								<div class="row col-md-6">
									<div class="col-lg-12">		
										<div class="form-group">
											<label for="Address" class="col-md-5 control-label">Address <small class="text-default">*</small></label>
											<div class="col-md-7">
												<textarea rows="5" id="Address" name="Address" class="form-control has-success required"></textarea>
											</div>
										</div>	
									</div>
								</div>
							</fieldset>
						

							<!--- Merit Analysis --->
							<fieldset>
								<legend><span>Merit Analysis</span></legend>
								<div class="row col-md-10">
									<div class="col-lg-12">
										<div class="form-group">
											<label for="System" class="col-md-5 control-label">Merit System <small class="text-default">*</small></label>
											<div class="col-md-7">
												<select class="form-control required" id="meritsystemselectid" name="meritsystemselectid" onchange="meritsystemselect();result();">
													<option value="">Choose An Merit System</option>
													<option value="A">Merit Symbol System</option>
													<option value="B">Merit Rank System</option>
												</select>
											</div>
										</div>
										<div id="symbol" style="display:none;">
											<small class="form-text text-muted">New system please select your symbol</small>
												<div class="form-group">
													<label for="MeritSymbol" class="col-md-5 control-label" style="padding-top:0px;">Merit Symbol</label>
													<div class="col-md-2">
														<input class="form-check-input" type="radio" name="MeritSymbol" id="MeritSymbol1" value="triangle" onchange="result(); meritsystem();"> 
														Triangle 
													</div>
													<div class="col-md-2">
														<input class="form-check-input" type="radio" name="MeritSymbol" id="MeritSymbol2" value="circle" onchange="result(); meritsystem();"> 
														Circle
													</div>
													<div class="col-md-2">
														<input class="form-check-input" type="radio" name="MeritSymbol" id="MeritSymbol3" value="rectangle" onchange="result(); meritsystem();"> 
														Rectangle
														<input class="form-check-input hidden" checked type="radio" name="MeritSymbol" id="MeritSymbol4" value="none" onchange="result(); meritsystem();"> 

													</div>
												</div>
										</div>
										
										<div id="rank" style="display:none;">
											<div class="col-lg-12">
												<small class="form-text text-muted">Under legacy system, please select your rank</small>
												<div class="form-group">
													<label for="MeritRank" class="col-md-5 control-label">Merit Rank</label>
													<div class="col-md-7">
														<select class="form-control" id="MeritRank" name="MeritRank2" onchange="result();meritsystem();">
															<option value="0">Select your rank</option>
															<option value="40">1</option>
															<option value="39">2</option>
															<option value="38">3</option>
															<option value="37">4</option>
															<option value="36">5</option>
															<option value="35">6</option>
															<option value="34">7</option>
															<option value="33">8</option>
															<option value="32">9</option>
															<option value="31">10</option>
															<option value="25">11 - 30</option>
															<option value="20">31 - 50</option>
															<option value="10">51 +</option>
														</select>
													</div>
												</div>	
											</div>
										</div>
									</div>
								</div>
								<div class="row col-md-2">
									<div class="col-lg-12">
										<p id="meritresult" class="text-default"></p>
									</div>
								</div>
								<div class="space"></div>
							</fieldset>
					
							<!--- Guardian Income --->
							<fieldset>
								<legend><span>Guardian Income</span></legend>
								<div class="row col-md-10">
									<div class="col-lg-12">
										<div class="form-group">
											<label for="ParentIncome" class="col-md-5 control-label">Parent Income <small class="text-default">*</small></label>
											<div class="col-md-7">
												<select class="form-control required" id="ParentIncome" name="ParentIncome" onchange="result();parentincomeresult();">
													<option value="">Select your parent monthly income</option>
													<option value="40">0 - 10k</option>
													<option value="35">11k - 20k</option>
													<option value="30">21k - 30k</option>
													<option value="25">31k - 40k</option>
													<option value="20">40k +</option>
												</select>
											</div>
										</div>	
									</div>
								</div>
								<div class="row col-md-2">
									<div class="col-lg-12">
										<p id="parentincomeresult" class="text-default"></p>
									</div>
								</div>
								<div class="space"></div>
							</fieldset>

							<!--- Teacher's Refference --->
							<fieldset>
								<legend><span>Teacher's Refference</span></legend>
								<div class="row col-md-10">
									<div class="col-md-6">
										<div class="col-lg-12">
											<div class="form-group">
												<label for="TeacherOne" class="col-md-5 control-label">Full Name Of Teacher One </label>
												<div class="col-md-7">
													<input type="text" class="form-control" id="TeacherOne" name="TeacherOne" onchange="result();teacherref();">
												</div>
											</div>	
											<div class="form-group">
												<label for="TeacherOnePhone" class="col-md-5 control-label">Phone Number Of Teacher One </label>
												<div class="col-md-7">
													<input type="text" class="form-control" id="TeacherOnePhone" name="TeacherOnePhone" onchange="result();teacherref();">
												</div>
											</div>	
										</div>
									</div>
									<div class="col-md-6">
										<div class="col-lg-12">
											<div class="form-group">
												<label for="TeacherTwo" class="col-md-5 control-label">Full Name Of Teacher Two</label>
												<div class="col-md-7">
													<input type="text" class="form-control" id="TeacherTwo" name="TeacherTwo" onchange="result();teacherref();">
												</div>
											</div>	
											<div class="form-group">
												<label for="TeacherTwoPhone" class="col-md-5 control-label">Phone Number Of Teacher Two </label>
												<div class="col-md-7">
													<input type="text" class="form-control" id="TeacherTwoPhone" name="TeacherTwoPhone" onchange="result();teacherref();">
												</div>
											</div>	
										</div>
									</div>
								</div>
								<div class="row col-md-2">
									<div class="col-lg-12">
										<p id="teacherref" class="text-default"></p>
									</div>
								</div>
								<div class="space"></div>
							</fieldset>

							<!--- Performance Analysis --->
							<fieldset>
								<legend><span>Performance Analysis</span></legend>
								<div class="row col-md-12">
									<h3> Performance Result</h3>
									<table class="table table-bordered">
										<thead>
										  <tr>
											<th>Category</th>
											<th>Mark</th>
										  </tr>
										</thead>
										<tbody>
											<tr>
												<td>Merit Analysis</td>
												<td id="meritresult2">0</td>
											</tr>
											<tr>
												<td>Guardian Income</td>
												<td id="parentincomeresult2">0</td>
											</tr>
											<tr>
												<td>Teacher's Refference</td>
												<td id="teacherref2">0</td>
											</tr>
											<tr>
												<td>Total Mark</td>
												<td id="resultshow">0</td>
											</tr>
										</tbody>
									  </table>
									<input type="hidden" name="Score" id="Score">
								</div>
								<div class="space"></div>
							</fieldset>
					
							
							
							<!--- Actions --->
							<div class="row">
							
								<div class="text-left col-md-6">

									
								</div>
								

								<div class="text-right col-md-6">
									<button type="submit" class="btn btn-group btn-default btn-sm btn-disabled updateButton" id="buttonDisabled">							
										Apply														
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
	<script language="javascript"> 
		function meritsystemselect(){
			var systemCheck = $("#meritsystemselectid").val();
			if (systemCheck === 'A'){
				$('#rank').hide();
				$("#MeritRank").val('0');
				$('#symbol').show();
			} else if (systemCheck === 'B'){
				$('#symbol').hide();
				$('#MeritSymbol4').prop('checked', true);
				$('#rank').show();
			} else {
				$('#symbol').hide();
				$('#rank').hide();

			}
		}

		function meritsystem(){
			var meritSymbolMark = 0;
			var meritSymbol= $('input[name="MeritSymbol"]:checked').val();
			if (meritSymbol == "triangle"){
				meritSymbolMark = 40
			} else if (meritSymbol == "circle"){
				var meritSymbolMark = 30;
			} else if (meritSymbol == "rectangle") {
				var meritSymbolMark = 20;
			} else {
				var meritSymbolMark = 0;
			}


			var meritRankMark = 0;
			var meritRank = $("#MeritRank").val();
			if(parseInt(meritRank)){
				meritRankMark = meritRank;
			}
			
			var meritMark = 0
			if (meritSymbolMark > 0) {
				meritMark = meritSymbolMark;
			} else if (meritRankMark > 0) {
				meritMark = meritRankMark;
			} else {
				meritMark = 0;
			}

			$("#meritresult").html("Merit category score is: " + meritMark);
			$("#meritresult2").html(meritMark);
			return meritMark;
		}

		function parentincomeresult(){
			
			var parentIncome = $("#ParentIncome").val();
			parentIncomeMark = parentIncome ? parentIncome : 0
			
			$("#parentincomeresult").html("Guardian category score is: " + parentIncomeMark);
			$("#parentincomeresult2").html(parentIncomeMark);
			return parentIncomeMark;
		}

		function  teacherref() {
			var refOne = $("#TeacherOne").val();
			var refTwo = $("#TeacherTwo").val();

			refOneMark = refOne ? 10 : 0;
			refTwoMark = refTwo ? 10 : 0;

			totalRefMark = refOneMark + refTwoMark;

			$("#teacherref").html("Your refference score is: " + totalRefMark);
			$("#teacherref2").html(totalRefMark);
			return totalRefMark;
		}

		function result(){
			var meritSystemMark = meritsystem();
			var parentIncomeMark = parentincomeresult();
			var teacherRefMark = teacherref();
			var currentScore = parseInt(meritSystemMark) + parseInt(parentIncomeMark) +parseInt(teacherRefMark);
			if (meritSystemMark === 0) {
				$("#resultshow").html(currentScore);
				$("#buttonDisabled").prop("disabled",true);
				$("#Score").val(0);
			} else {
				$("#resultshow").html(currentScore);
				$("#Score").val(currentScore);
				$("#buttonDisabled").prop("disabled",false);
			}
		}
    

    </script>