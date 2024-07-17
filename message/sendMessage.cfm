  <cfquery datasource="#request.dsnameReader#" name="qUserSelect"> 
      select *
        from Appuser 
          
    </cfquery>

							
							
<div class="row">
	<div class="col-12">
		<div class="page-title-box">
			<h4 class="page-title">Send Message</h4>
			<div class="page-title-right">
				<ol class="breadcrumb p-0 m-0">
					<li class="breadcrumb-item"><a href="index.cfm?&area=dashboard&action=index">Dashboard
</a></li>
					<li class="breadcrumb-item active">Send Message</li>
				</ol>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-md-12">
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">Message Details</h3>
			</div>
			<div class="card-body">

				<div class="row">
					<div class="col-6">
						<form method="post" action="partialIndex.cfm?area=message&action=sendMessageAction" target="formpost" >
							<!---success alert --->
							<div class="alert alert-success alertHidden"  id="successDiv">										
								<span id="successMessage"></span>
							</div>
							
							<!--- error alert --->
							<div class="alert alert-danger alertHidden"  id="errorDiv">										
								<span id="errorMessage"></span>
							</div>
							
							<div class="form-group row">
								<label class="col-lg-2 control-label" for="From">From*</label>
								<div class="col-lg-10">
									<input type="tel" readonly=""  class="form-control" id="fromphonenumber" name="fromphonenumber" value="7088928705">
								</div>
							</div>
							
							<div class="form-group row">
								<label class="col-lg-2 control-label" for="From">To*</label>
								<div class="col-lg-10">
									<input type="tel" required=""  class="form-control" id="tophonenumber" name="tophonenumber" value="9546086744">
								</div>
							</div>
	
							<div class="form-group row">
								<label class="col-lg-2 control-label" for="FirstName">Message*</label>
								<div class="col-lg-10">
									<textarea class="form-control" id="message" name="message" required=""></textarea>
								</div>
							</div>
							<div class="form-group custom-form-group">
								<input type="submit" name="sendMessge" value="Send Message" class="btn btn-success custom-btn">
							</div>
						</form>
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