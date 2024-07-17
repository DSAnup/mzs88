<div class="row">
	<div class="col-12">
		<div class="page-title-box">
			<h4 class="page-title">Add New SMS  Template</h4>
			<div class="page-title-right">
				<ol class="breadcrumb p-0 m-0">
					<li class="breadcrumb-item"><a href="index.cfm?&area=dashboard&action=index">Dashboard
</a></li>
					<li class="breadcrumb-item active">Add New SMS Template</li>
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
				<h3 class="card-title">SMS Template Details</h3>
			</div>
			<div class="card-body">

				<div class="row">
					<div class="col-12">
						<form method="post" action="partialIndex.cfm?area=SMSTemplates&action=addNewSMSTemplatesAction" target="formpost" >
							<!---success alert --->
							<div class="alert alert-success alertHidden"  id="successDiv">										
								<span id="successMessage"></span>
							</div>
							
							<!--- error alert --->
							<div class="alert alert-danger alertHidden"  id="errorDiv">										
								<span id="errorMessage"></span>
							</div>
	
							<div class="form-group row">
								<label class="col-lg-2 control-label" for="SMSTemplate">SMS Templates*</label>
								<div class="col-lg-10">
									<textarea class="form-control" id="SMSTemplate" rows="10" name="SMSTemplate"></textarea>
								</div>
							</div>
							<div class="form-group custom-form-group">
								<input type="submit" name="save" value="Save" class="btn btn-success custom-btn">
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