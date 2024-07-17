

<div class="topbar-menu">
    <div class="container-fluid">
        <div id="navigation">
            <!-- Navigation Menu-->
            <ul class="navigation-menu">
            	
            	
            	<cfif session.Profile.isLoggedIn eq true>
	


		                
						<li>
	                        <a href="index.cfm?area=dashboard&action=index">
	                            <i class="mdi mdi-home"></i> Dashboard </a>
	                
                		</li>
			              
	                	
		                <li>
	                        <a href="index.cfm?area=message&action=sendMessage">
	                            <i class="fa fa-paper-plane"></i> Send Message </a>
	                
                		</li>
						
						<!--- Manage settings --->
		                <li class="has-submenu">
	                        <a href="#">
	                            <i class="mdi mdi-cogs"></i> Settings </a>
	                        <ul class="submenu">
	                        	<li><a href="index.cfm?area=links&action=updateLinks&SettingID=1"> <i class="mdi mdi-link-box-variant"></i> Links</a></li>
	                        </ul>
	                    </li>
		                <li>
	                        <a href="index.cfm?area=log&action=showLogs">
	                            <i class="mdi mdi-message"></i> Show Logs </a>
	                
                		</li>	
		                <li class="has-submenu">
	                        <a href="index.cfm?area=leads&action=showAllLeads">
	                            <i class="mdi mdi-account-cash"></i> Leads </a>
	                        <ul class="submenu">
	                        	<li><a href="index.cfm?area=leads&action=addNewLead"> <i class="mdi mdi-account-multiple-plus"></i> Upload Leads</a></li>
	                        </ul>
	                    </li>	
						
						
			                <li class="has-submenu">
	                        <a href="index.cfm?area=SMSTemplates&action=showAllSMSTemplates">
	                            <i class="mdi mdi-message-text-outline"></i> SMS Templates </a>
	                        <ul class="submenu">
	                        	<li><a href="index.cfm?area=SMSTemplates&action=addNewSMSTemplates"> <i class="mdi mdi-message-draw"></i> Add New Template</a></li>
	                        </ul>
	                    </li>
	                    
	                    <li>
	                        <a href="index.cfm?area=message&action=setupSchedule">
	                            <i class="mdi mdi-calendar-clock"></i> Schedule </a>
	                
                		</li>				
						
										
                <cfelse>
                
                
	                <li class="has-submenu">
	                    <a href="index.cfm?area=login&action=login"> <i class="mdi mdi-lock"></i> Log In </a>
	                    
	                </li>
                
                </cfif>
                

            </ul>
            <!-- End navigation menu -->

            <div class="clearfix"></div>
        </div>
        <!-- end #navigation -->
    </div>
    <!-- end container -->
</div>
<!-- end navbar-custom -->