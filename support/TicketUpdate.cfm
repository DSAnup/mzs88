
<script>

$(function() {
	$('.replybutton').on('click', function() {
		$('.replybox').hide();
		$('.cancelbutton').hide();
		$('.replybutton').show();
		var commentboxId= $(this).attr('data-commentbox');
		$('.replybutton').hide();
		$('#'+commentboxId).toggle();
		$('.cancelbutton').show();
		
		$('#message').focus();
		
	});
	
	$('.cancelbutton').on('click', function() {
		$('.replybox').hide();
		$('.replybutton').show();
		$('.cancelbutton').hide();
	});
});
initSample();

</script>


<cfquery datasource="#request.dsnameReader#" name="qDepartmentSelect">

	select *
		from Department	

</cfquery>
<cfquery datasource="#request.dsnameReader#" name="qTicketSelect">
	SELECT [TicketID]
		  ,[Ticket].[TicketUUID]	
		  ,[Ticket].[ClientID]
		  ,[Ticket].[Subject]
		  ,[Ticket].[DepartmentID]
		  ,[Ticket].[OrderID]
		  ,[Ticket].[Priority]
		  ,[Ticket].[Message]
		  ,[Ticket].[AttachmentFileName]
		  ,[Ticket].[Attachment2FileName]
		  ,[Ticket].[Attachment3FileName]
		  ,[Ticket].[Attachment4FileName]
		  ,[Ticket].[Attachment5FileName]
		  ,[Ticket].[Attachment6FileName]
		  ,[Ticket].[Status]
		  ,[Ticket].[CreatedBy]
		  ,[Ticket].[UpdatedBy]
		  ,[Ticket].[DateCreated]
		  ,[Ticket].[DateLastUpdated]
		  ,DepartmentName
		  , Client.FirstName + ' ' + Client.LastName as ClientName
	FROM [dbo].[Ticket]
		join Client on Client.ClientID = Ticket.ClientID	 
		join Department on Department.DepartmentID = Ticket.DepartmentID 
	WHERE 
		
		TicketUUID = '#url.TicketID#'
</cfquery>


<cfquery datasource="#request.dsnameReader#" name="qReplySelect">


SELECT [TicketReplyID]
      ,[TicketReply].[TicketID]
      ,[TicketReply].[ClientID]
      ,[TicketReply].[AppUserID]
      ,[TicketReply].[Message]
      ,[TicketReply].[AttachmentFileName]
      ,[TicketReply].[Attachment2FileName]
      ,[TicketReply].[Attachment3FileName]
      ,[TicketReply].[Attachment4FileName]
      ,[TicketReply].[Attachment5FileName]
      ,[TicketReply].[Attachment6FileName]	  
      ,[TicketReply].[CreatedBy]
      ,[TicketReply].[UpdatedBy]
      ,[TicketReply].[DateCreated]
      ,[TicketReply].[DateLastUpdated]
	  ,TicketUUID
	  , AppUser.FirstName + ' ' + AppUser.LastName as AppUserName
	  , Client.FirstName + ' ' + Client.LastName as ClientName
	  
  FROM [dbo].[TicketReply]
  
		left join AppUser on AppUser.AppUserID = TicketReply.AppUserID
		left join Client on Client.ClientID = TicketReply.ClientID
		left join Ticket on Ticket.TicketID = TicketReply.TicketID
	WHERE 
		TicketUUID = '#url.TicketID#'
		
		order by TicketReplyID desc 
					
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
				<h1 class="page-title margin-top-clear">View Tickets</h1>
				<!-- page-title end -->
				<div class="space"></div>

					<cfoutput>
						<div class="row">
							<div class="col-md-12 loginarea openticketarea">
								<fieldset>
									<legend><span> Ticket ID## #qTicketSelect.TicketID# </span></legend>
								 	<div class="row viewboxarea">
										<div class="col-md-3">
											<div class="viewsupportbox">
												<h2>Submitted</h2>
												<span>#qTicketSelect.DateCreated#</span>
											</div>
										</div>
										<div class="col-md-2">
											<div class="viewsupportbox">
												<h2>Department</h2>
												<cfloop query="qDepartmentSelect">
													<cfif qDepartmentSelect.DepartmentID eq qTicketSelect.DepartmentID >
														<span>#qDepartmentSelect.DepartmentName#</span>
													</cfif>
												</cfloop>
											</div>
										</div>
										<div class="col-md-2">
											<div class="viewsupportbox">
												<h2>Priority</h2>
												<span>#qTicketSelect.Priority#</span>
											</div>
										</div>
										<div class="col-md-2">
											<div class="viewsupportbox">
												<h2>Status</h2>
												<span>#qTicketSelect.Status#</span>
											</div>
										</div>
										<div class="col-md-3">
											<div class="viewsupportbox">
											<div class="replyform">
										<a class="btn btn-goback" href="#cgi.script_name#?area=#url.area#&action=ticketSelect">&##171; Back</a>
										<button class="btn btn-primary replybutton" data-commentbox="replyToStuff">Reply</button>
										<button class="btn btn-danger cancelbutton" style="display:none">Cancel</button>
										</div>
											</div>
										</div>
									</div><!-- Viewbox -->
									
									
									<div class="replyform">
										 <form id="replytoticket" name="replytoticket" method="post" action="partialIndex.cfm?area=support&action=TicketReplyInsertAction" target="formpost" enctype="multipart/form-data">
											<div class="replybox" style="display:none" id="replyToStuff">
											
											
											
											
												<div class="form-group">
													<label for="Message" class="col-md-12 control-label">Message</label>
													<div class="col-md-12">
														<textarea rows="7" id="message" name="message" style=" width:98%"></textarea>
													</div>
												</div>
												<div class="form-group">
													<label for="AttachmentFileName" class="col-md-12 control-label">Attachments:</label>
													<div class="col-md-12">
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

												<input type="hidden" name="TicketID" value="#url.TicketID#">
												<button class="btn btn-primary submit">Submit</button>
											</div>
										</form>
								 	</div>
									
<!--- list of earlier comm --->
<cfloop  query="qReplySelect" >

                            <cfif qReplySelect.AppUserID gt 0> 
                                <div class="ticketDetails">
                                    <div class="tickethead stuffhead">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <h2>#qReplySelect.AppUserName# | Staff</h2>
                                            </div>
                                            <div class="col-md-4">
                                                <span>#dateFormat(qReplySelect.DateCreated, 'dd mmm yyyy')#
                                                    #timeFormat(qReplySelect.DateCreated, 'hh:mm:ss TT')#</span>
                                            </div>
                                        </div>
                                    </div>
                            <cfelse>

                                <div class="ticketDetails">
                                    <div class="tickethead">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <h2>#qReplySelect.ClientName# | Client</h2>
                                            </div>
                                            <div class="col-md-4">
                                                <span>
												#dateFormat(qReplySelect.DateCreated, 'dd mmm yyyy')#
                                                #timeFormat(qReplySelect.DateCreated, 'hh:mm:ss TT')#</span>
                                            </div>
                                        </div>
                                    </div>
                            </cfif>
										<div class="ticketMessage">
                                            <p class="mb-0">
												#replaceNoCase(qReplySelect.Message, chr(13), "<br>", "all")#
                                            </p>
                                    
												
											<cfif qReplySelect.AttachmentFileName neq "">
												<a class="downloadablefile" href="/assets/img/upload/#qReplySelect.AttachmentFileName#" target="_blank">Download file 1</a>
											</cfif>
											<cfif qReplySelect.Attachment2FileName neq "">
												<a class="downloadablefile" href="/assets/img/upload/#qReplySelect.Attachment2FileName#" target="_blank">Download file 2</a>
											</cfif>
											<cfif qReplySelect.Attachment3FileName neq "">
												<a class="downloadablefile" href="/assets/img/upload/#qReplySelect.Attachment3FileName#" target="_blank">Download file 3</a>
											</cfif>
											<cfif qReplySelect.Attachment4FileName neq "">
												<a class="downloadablefile" href="/assets/img/upload/#qReplySelect.Attachment4FileName#" target="_blank">Download file 4</a>
											</cfif>
											<cfif qReplySelect.Attachment5FileName neq "">
												<a class="downloadablefile" href="/assets/img/upload/#qReplySelect.Attachment5FileName#" target="_blank">Download file 5</a>
											</cfif>
											<cfif qReplySelect.Attachment6FileName neq "">
												<a class="downloadablefile" href="/assets/img/upload/#qReplySelect.Attachment6FileName#" target="_blank">Download file 6</a>
											</cfif>
										</div>
									</div>


									

                               


                                </cfloop>
								
							<div class="ticketDetails">
                                    <div class="tickethead">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <h2>#qTicketSelect.ClientName# | Client</h2>
                                            </div>
                                            <div class="col-md-4">
                                                <span>
												#dateFormat(qTicketSelect.DateCreated, 'dd mmm yyyy')#
                                                #timeFormat(qTicketSelect.DateCreated, 'hh:mm:ss TT')#</span>
                                            </div>
                                        </div>
                                    </div>
                            
										<div class="ticketMessage">
                                            <p class="mb-0">
												#replaceNoCase(qTicketSelect.Message, chr(13), "<br>", "all")#
                                            </p>
                                          					
												<cfif qTicketSelect.AttachmentFileName neq "">
													<a class="downloadablefile" href="/assets/img/upload/#qTicketSelect.AttachmentFileName#" target="_blank">Download file 1</a>
												</cfif>
												<cfif qTicketSelect.Attachment2FileName neq "">
													<a class="downloadablefile" href="/assets/img/upload/#qTicketSelect.Attachment2FileName#" target="_blank">Download file 2</a>
												</cfif>
												<cfif qTicketSelect.Attachment3FileName neq "">
													<a class="downloadablefile" href="/assets/img/upload/#qTicketSelect.Attachment3FileName#" target="_blank">Download file 3</a>
												</cfif>
												<cfif qTicketSelect.Attachment4FileName neq "">
													<a class="downloadablefile" href="/assets/img/upload/#qTicketSelect.Attachment4FileName#" target="_blank">Download file 4</a>
												</cfif>
												<cfif qTicketSelect.Attachment5FileName neq "">
													<a class="downloadablefile" href="/assets/img/upload/#qTicketSelect.Attachment5FileName#" target="_blank">Download file 5</a>
												</cfif>
												<cfif qTicketSelect.Attachment6FileName neq "">
													<a class="downloadablefile" href="/assets/img/upload/#qTicketSelect.Attachment6FileName#" target="_blank">Download file 6</a>
												</cfif>
												
										</div>
									</div>


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



