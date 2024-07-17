

			
							
<div class="row">
	<div class="col-12">
		<div class="page-title-box">
			<h4 class="page-title">Show All Logs</h4>
			<div class="page-title-right">
				<ol class="breadcrumb p-0 m-0">
					<li class="breadcrumb-item"><a href="index.cfm?&area=dashboard&action=index">Dashboard
</a></li>
					<li class="breadcrumb-item active">Show All Logs</li>
				</ol>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
</div>

<div class="modal-body">
        	
        <div class="form">
                    <form target="formpost" method="post" action="partialIndex.cfm?area=log&action=showLogsAction" novalidate="novalidate" enctype="multipart/form-data">
                        
         
		                         
		                 <div class="row">
                        	
                        	<!--- Address --->
                        	<div class="col-lg-5">
		                        <div class="form-group row">
		                            <label for="ToPhoneNumber" class="col-form-label col-lg-3 sholwlog-label">Phone Number</label>
		                            <div class="col-lg-9">
		                                <input class="form-control" id="ToPhoneNumber" placeholder="Phone Number" name="ToPhoneNumber" type="text" Value="" aria-required="true">
		                            </div>
		                        </div>
		                    </div>
		                    
		                      <!--- Association Name --->
                        	<div class="col-lg-5">
		                        <div class="form-group row">
		                            <label for="DateSent" class="col-form-label col-lg-3 sholwlog-label datasent">Date Sent</label>
		                            <div class="col-lg-9">
		                                <input class="form-control DateSent" placeholder="mm/dd/yyyy" data-provide="datepicker" id="DateSent" name="DateSent" type="text" Value="" aria-required="true">
		                            </div>
		                        </div>
		                    </div>
		                    
		                    <!--- search --->
		                    <div class="col-lg-2">
		                        <div class="form-group row">
		                            <div class="col-lg-12">
		                                <button class="btn btn-success waves-effect waves-light logsearchbtn"  type="submit">Search</button>
		                            </div>		                            
		                        </div>
		                    </div>
		                    
		                    
		                    
		                    
		                    
		                </div>          
		                       
                        
                        
                        
                    </form>
                </div>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
                <!-- .form -->
                
                
                <!--- alert goes here --->
                <div id="alert"></div>
                
                
                <script>

                	function loadTable(){
						 $('#Resultdatatable').dataTable();
                	}
                </script>
                
                
                <!---start search result here --->
                <div class="row" id="searchResultContainer">
                	
                	              
                	
				                	
                	
                </div>
				<!-- End Row -->
				<!--- end search result here --->
           
        </div>



