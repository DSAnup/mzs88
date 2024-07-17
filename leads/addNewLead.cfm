<div class="row">
	<div class="col-12">
		<div class="page-title-box">
			<h4 class="page-title">Upload New Lead</h4>
			<div class="page-title-right">
				<ol class="breadcrumb p-0 m-0">
					<li class="breadcrumb-item"><a href="index.cfm?&area=dashboard&action=index">Dashboard
</a></li>
					<li class="breadcrumb-item active">Upload New Lead</li>
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
				<h3 class="card-title">Lead File</h3>
			</div>
			<div class="card-body">

				<div class="row">
					<div class="col-12">
						<form method="post" action="index.cfm?area=leads&action=addNewLeadAction" enctype="multipart/form-data"  >
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
								Please note that when this feature is used to upload leads,
								<strong>it removes any existing leads and cancels any pending sent out schedule</strong>.
							</div>
							
							<p>Please select the file containing the leads and press Upload Leads.
								File needs to contain only one column with valid phone numbes 
								that are 10 digit long and only contains numers.  No '-' or '()' are allowed.
							</p>
	
							<div class="form-group row">
								<label class="col-lg-2 control-label" for="settings">Lead File*</label>
								<div class="col-lg-10">
									<input type="file" id="leads" name="leads" required="">
								</div>
							</div>
							<div class="form-group custom-form-group">
								<input type="submit" name="upload" value="Upload Lead" class="btn btn-success custom-btn">
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