
  <cfquery datasource="#request.dsnameReader#" name="qSMSTemplatesSelect"> 
    select *
        from SMSTemplate where SMSTemplateID = #url.SMSTemplateID#
          
    </cfquery>
	
<div class="row">
	<div class="col-12">
		<div class="page-title-box">
			<h4 class="page-title">Edit SMS Template</h4>
			<div class="page-title-right">
				<ol class="breadcrumb p-0 m-0">
					<li class="breadcrumb-item"><a href="index.cfm?&area=dashboard&action=index">Dashboard
</a></li>
					<li class="breadcrumb-item active">Edit SMS Template</li>
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
					<cfoutput>
						<form method="post" action="partialIndex.cfm?area=SMSTemplates&action=editSMSTemplatesAction" target="formpost" >
							<!---success alert --->
							<div class="alert alert-success alertHidden"  id="successDiv">										
								<span id="successMessage"></span>
							</div>
							
							<!--- error alert --->
							<div class="alert alert-danger alertHidden"  id="errorDiv">										
								<span id="errorMessage"></span>
							</div>
	
							<div class="form-group row">
								<label class="col-lg-2 control-label" for="settings">SMS Template*</label>
								<div class="col-lg-10">
									<textarea class="form-control" id="SMSTemplate" rows="10" name="SMSTemplate">#qSMSTemplatesSelect.SMSTemplate#</textarea>
								</div>
							</div>
							<div class="form-group custom-form-group">
								<input type="hidden" name="SMSTemplateID" value="#url.SMSTemplateID#" />
								<input type="submit" name="update" value="Update" class="btn btn-success custom-btn">
							</div>
						</form>
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