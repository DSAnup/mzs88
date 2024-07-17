
<cfquery datasource="#request.dsnameReader#" name="qDepartmentSelect">

	select *
		from Department	

</cfquery>


<cfquery datasource="#request.dsnameReader#" name="qOrderSelect">

	select 
		[LeadOrder].LeadOrderID, 
		[LeadOrder].ClientID, 
		[LeadOrder].LeadProductID
		, [Client].FirstName + ' ' + [Client].LastName as ClientName
		
		, [LeadProduct].LeadProductName
		
		
	from  [LeadOrder] 
		left join [Client] on [LeadOrder].ClientID = [Client].ClientID 
		left join [LeadProduct] on [LeadOrder].LeadProductID = [LeadProduct].LeadProductID 
	
	where 
		
		 [LeadOrder].ClientID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.profile.client.ClientID#">

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
				<h1 class="page-title margin-top-clear">Create New Ticket</h1>
				<!-- page-title end -->
				<div class="space"></div>

					<cfoutput>
						<div class="row">
							<div class="col-md-12 loginarea openticketarea">
								<fieldset>
									<legend><span> New Ticket</span></legend>
                                    <form id="openticket" name="openticket" method="post" action="partialIndex.cfm?area=support&action=TicketInsertAction" target="formpost" enctype="multipart/form-data">
                                    	
                                    	<div class="row">
											<div class="alert alert-danger support-danger" role="alert">
                                    			NO REFUND and 1 Time Replacement Policy: we will replace all Disconnected 
												and Not In Service Phone Numbers Only as stated in the Terms Of Service Agreement.									
												</div>
                                    	</div>
                                    	
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label for="Name" class="col-md-12 control-label">Name</label>
													<div class="col-md-12">
														<input type="text" class="form-control" placeholder="Name" id="Name" name="Name" value="#session.profile.client.FirstName#" readonly="true">
													</div>
												 </div>
											</div>
											<div class="col-md-6">
												<div class="form-group">
													<label for="Email" class="col-md-12 control-label">Email Address</label>
													<div class="col-md-12">
														<input type="Email" id="Email" class="form-control" name="Email" placeholder="Email Address" value="#session.profile.client.Email#" readonly="true">
													</div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label for="Subject" class="col-md-12 control-label">Subject</label>
											<div class="col-md-12">
												<input type="text" id="Subject" class="form-control" name="Subject" placeholder="Subject" value="">
											</div>
										</div>
										<div class="row">
											<div class="col-md-4">
												<div class="form-group">
													<label for="Department" class="col-md-12 control-label">Department*</label>
													<div class="col-md-12">
														<select class="form-control required" name="DepartmentID" id="DepartmentID">
															<option value="">Select one... </option>
															<cfloop query="qDepartmentSelect">
															<option value="#qDepartmentSelect.DepartmentID#">#qDepartmentSelect.DepartmentName#</option>	
															</cfloop>
														</select>
													</div>
												 </div>
											</div>

											<div class="col-md-4">
												<div class="form-group">
													<label for="LeadOrderID" class="col-md-12 control-label">Relative Order (if applicable)</label>
													<div class="col-md-12">
														<select id="LeadProductID" name="LeadProductID" class="form-control required" >	
															<option value="">Select one...</option>
															<cfloop query="qOrderSelect">
															<option value="#qOrderSelect.LeadOrderID#">Order ID: #qOrderSelect.LeadOrderID# - #qOrderSelect.LeadProductName#</option>	
															</cfloop>								
														</select>

													</div>
												</div>
											</div>

											<div class="col-md-4">
												<div class="form-group">
													<label for="Priority" class="col-md-12 control-label">Priority</label>
													<div class="col-md-12">
														<select id="Priority" name="Priority" class="form-control required" >	
															<option value="">Select one...</option>
															<option value="High">High</option>	
															<option value="Medium">Medium</option>	
															<option value="Low">Low</option>										
														</select>

													</div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label for="Message" class="col-md-12 control-label">Message</label>
											<div class="col-md-12">
												<textarea id="Message" name="Message"  style=" width:100%" rows="5"></textarea>
											</div>
										</div>
										<div class="form-group">
											<label for="AttachmentFileName" class="col-md-12 control-label">Attachments:</label>
											<div class="col-md-4">
												<input type="file" class="form-control" name="AttachmentFileName" id="AttachmentFileName" value="">
											</div>
										</div>
										<div class="form-group">
											<label for="Attachment2FileName" class="col-form-label col-lg-12 sholwlog-label datasent">Attachment 2</label>
											<div class="col-lg-12">
												<input type="file" class="form-control"  name="Attachment2FileName" id="Attachment2FileName">
										
											</div>
										</div>

										<div class="form-group">
											<label for="Attachment3FileName" class="col-form-label col-lg-12 sholwlog-label datasent">Attachment 3</label>
											<div class="col-lg-12">
												<input type="file" class="form-control"  name="Attachment3FileName" id="Attachment3FileName">
										
											</div>
										</div>

										<div class="form-group">
											<label for="Attachment4FileName" class="col-form-label col-lg-12 sholwlog-label datasent">Attachment 4</label>
											<div class="col-lg-12">
												<input type="file" class="form-control"  name="Attachment4FileName" id="Attachment4FileName">
										
											</div>
										</div>

										<div class="form-group">
											<label for="Attachment5FileName" class="col-form-label col-lg-12 sholwlog-label datasent">Attachment 5</label>
											<div class="col-lg-12">
												<input type="file" class="form-control"  name="Attachment5FileName" id="Attachment5FileName">
										
											</div>
										</div>

										<div class="form-group">
											<label for="Attachment6FileName" class="col-form-label col-lg-12 sholwlog-label datasent">Attachment 6</label>
											<div class="col-lg-12">
												<input type="file" class="form-control"  name="Attachment6FileName" id="Attachment6FileName">
										
											</div>
										</div>										
                                        <div class="form-group">
										
										 	<input type="hidden" id="ClientID" name="ClientID" value="#session.profile.client.ClientID#" />
										 	<input type="hidden" id="Status" name="Status" value="New" />
                                            <input type="submit" class="btn btn-success btnsubmit" value="Submit">
                                        </div>
                                        
                                        
                                    </form>

								</fieldset>
							</div>
						</div>
					
					</cfoutput>
		
			</div>
			<!-- main end -->
		</div>
	</div>
</section>
<!-- main-container end -->