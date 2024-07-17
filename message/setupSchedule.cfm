<div class="row">
	<div class="col-12">
		<div class="page-title-box">
			<h4 class="page-title">Setup Schedule</h4>
			<div class="page-title-right">
				<ol class="breadcrumb p-0 m-0">
					<li class="breadcrumb-item"><a href="/">Dashboard</a></li>
					<li class="breadcrumb-item active">Setup Schedule</li>
				</ol>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
</div>


<cfparam name="url.datescheduled"  default="#dateformat(Now(), 'mm/dd/yyyy')#">
<cfparam name="url.timescheduled"  default="#timeformat( dateadd('n', 30, Now()), 'hh:nn tt')#">
<cfparam name="url.messagecount"  default="10">

<cfoutput>

<div class="row">
	<div class="col-md-12">
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">Setup a New Schedule</h3>
			</div>
			<div class="card-body">

				<div class="row">
					<div class="col-12">
						<form method="post" action="partialindex.cfm?area=message&action=setupScheduleAction" target="formpost" enctype="multipart/form-data"  >
							<!---success alert --->
							<div class="alert alert-success alertHidden"  id="successDiv">										
								<span id="successMessage"></span>
							</div>
							
							<!--- error alert --->
							<div class="alert alert-danger alertHidden"  id="errorDiv">										
								<span id="errorMessage"></span>
							</div>
							
							<!--- warning alert --->
							<div class="alert alert-warning" >										
								Please note that when a new schedule is set up,
								<strong>it removes any existing schedule and all leads are queued to receive a new message according to the new schedule, 
								including the ones that may have already received message</strong>.
							</div>
							
							<p>Please provide the following details to set up the new schedule.
							</p>
							
							<!---date part of timeclock --->	
								<div class="form-group row">
									<label class="col-lg-2 control-label" for="LastName">Date*</label>								
	                        		<div class="col-lg-2 input-group">
				                        <input type="text" class="form-control" required=""   name="datescheduled" 
				                        value="#url.datescheduled#"	                                            
		                                 placeholder="mm/dd/yyyy" data-provide="datepicker" data-date-autoclose="true" 
		                                 data-date-orientation="bottom">
		                                <div class="input-group-append">
		                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                </div>
									</div>
								</div>
							
							
								<!---time part of timeclock --->	
								<div class="form-group row">
									<label class="col-lg-2 control-label" for="LastName">Time*</label>								
	                        		<div class="col-lg-2 input-group">
	                        			<input id="timepicker" type="text" class="form-control"   name="timescheduled" 
	                        				value="#url.timescheduled#"
	                        			>	                        			
		                                <div class="input-group-append">
		                                    <span class="input-group-text"><i class="mdi mdi-clock"></i></span>
		                                </div>
									</div>
								</div>
								
								<!---message per minute --->	
								<div class="form-group row">
									<label class="col-lg-2 control-label" for="LastName">Number of Messages per Minute*</label>								
	                        		<div class="col-lg-2 input-group">
	                        			<input id="messagecount" type="text" class="form-control"  name="messagecount" 
	                        				value="#url.messagecount#"
	                        			>	                        			
		                                <div class="input-group-append">
		                                    <span class="input-group-text"><i class="mdi mdi-scale"></i></span>
		                                </div>
									</div>
								</div>
	
							
							
							<div class="form-group custom-form-group col-lg-4">
								<input type="submit" name="upload" value="Setup Schedule" class="btn btn-success custom-btn">
							</div>
						</form>
                    </div>
				</div>


</cfoutput>	


				<!-- End #wizard-vertical -->
			</div>
			<!-- End card-body -->
		</div>
		<!-- End card -->
	</div>
	<!-- end col -->
</div>		

				