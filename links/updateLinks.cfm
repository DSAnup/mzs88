<cfquery datasource="#request.dsnameReader#" name="qLinksSelect"> 
select *
	from Setting where SettingID = #url.SettingID#
	  
</cfquery>
	
<div class="row">
	<div class="col-12">
		<div class="page-title-box">
			<h4 class="page-title">Update Link</h4>
			<div class="page-title-right">
				<ol class="breadcrumb p-0 m-0">
					<li class="breadcrumb-item"><a href="index.cfm?&area=dashboard&action=index">Dashboard
</a></li>
					<li class="breadcrumb-item active">Update Link</li>
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
				<h3 class="card-title">Link Details</h3>
			</div>
			<div class="card-body">

				<div class="row">
					<div class="col-12">
					<cfoutput>
						<form  method="post" action="partialIndex.cfm?area=links&action=updateLinksAction" target="formpost" >
							<!---success alert --->
							<div class="alert alert-success alertHidden"  id="successDiv">										
								<span id="successMessage"></span>
							</div>
							
							<!--- error alert --->
							<div class="alert alert-danger alertHidden"  id="errorDiv">										
								<span id="errorMessage"></span>
							</div>
	
							<div class="form-group row">
								<label class="col-lg-2 control-label" for="settings">Link*</label>
								<div class="col-lg-10">
									<textarea onkeypress="clearErrorSuccess();"" class="form-control" id="Setting1" rows="10" name="Setting1">#qLinksSelect.Setting1#</textarea>
								</div>
							</div>
							<div class="form-group custom-form-group">
								<input type="hidden" name="SettingName" value="#qLinksSelect.SettingName#" />
								<input type="hidden" name="SettingID" value="#url.SettingID#" />
								<button type="submit" name="updateLink" class="btn btn-success custom-btn">Update</button>							
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