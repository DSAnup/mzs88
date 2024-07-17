<!--- set the sessions --->
<cfparam name="session.Cart" default="#structNew()#">

<cfparam name="session.Cart.leadProductID" default="">
<cfparam name="session.Cart.leadProductName" default="">
<cfparam name="session.Cart.orderQuantity" default="">
<cfparam name="session.Cart.orderDuration" default="">
<cfparam name="session.Cart.leadFieldID" default="">
<cfparam name="session.Cart.specificBank" default="">
<cfparam name="session.Cart.priceOption" default="">
<cfparam name="session.Cart.DiscountedPrice" default="">
<cfparam name="session.Cart.DiscountNote" default="">
<cfparam name="session.Cart.DiscountPercentage" default="">
<cfparam name="session.Cart.PromoCode" default="">


<cffunction name="to5DaysWeek" >
	<cfargument name="days" required="yes" type="numeric">
	<cfif (days / 5) EQ 1>
		<cfreturn (days / 5) & " week">	
	<cfelse>
		<cfreturn (days / 5) & " weeks">
	</cfif>	
</cffunction>


<cfquery datasource="#request.dsnameReader#" name="qBankSelect">
	select BankID, BankName, isNational, isActive
		from Bank
		where isActive = 1
		order by BankName
</cfquery>

<cfquery datasource="#request.dsnameReader#" name="qLeadProductSelect">

		
	select [LeadProduct].[LeadProductID]
		  ,[LeadProduct].[LeadProductName] 
		  ,[LeadProduct].[ProductDescription]
		  ,[LeadProduct].[ProductPeriod]
		  ,[LeadProduct].[MinimumProductAmount]
		  ,[LeadProduct].[OrderPeriod]
		  ,[LeadProduct].[MinimumOrderPeriod]
		  ,[LeadProduct].[MaximumOrderPeriod]
		  ,[LeadProduct].[PriceUnit]
		  ,[LeadProduct].[SoldOut]
		  ,[LeadProduct].SpecialOfferBanner
		  ,[LeadProduct].SpecialOfferPercentage
		  ,[LeadProduct].SpecialOfferDescription
		  ,[LeadProduct].SpecialOfferFrom
		  ,[LeadProduct].SpecialOfferTo
		  ,[LeadProduct].MinSpecialOfferDuration
		  ,[LeadProduct].MaxSpecialOfferDuration
		  ,[LeadProduct].PerticipateInGlobalSpecialOffer
		  , '#url.LeadType#' as LeadType
		  
		  <cfif isdefined("url.LeadType") and trim(url.LeadType) eq 'Exclusive'>
			,[LeadProduct].[ExclusiveLeadPrice] as 'LeadPrice'
		  </cfif>
		  <cfif isdefined("url.LeadType") and trim(url.LeadType)  eq 'Shared'>
			,[LeadProduct].[SharedLeadPrice] as 'LeadPrice'
		  </cfif>
		   <cfif isdefined("url.LeadType") and trim(url.LeadType)  eq 'Hour24'>
			,[LeadProduct].[Hour24LeadPrice] as 'LeadPrice'
		  </cfif>
		  <cfif isdefined("url.LeadType") and trim(url.LeadType)  eq 'Aged'>
			,[LeadProduct].[AgedLeadPrice] as 'LeadPrice'
		  </cfif>
		 
		  ,[LeadProductField].[LeadProductFieldID]      
		  ,[LeadProductField].[LeadFieldID]
		  
		  
		 <cfif isdefined("url.LeadType") and trim(url.LeadType)  eq 'Exclusive'>
			,[LeadProductField].[ExclusiveFieldPrice] as 'FieldPrice'
		  </cfif>
		  <cfif isdefined("url.LeadType") and trim(url.LeadType)  eq 'Shared'>
			,[LeadProductField].[SharedFieldPrice] as 'FieldPrice'
		  </cfif>
		  <cfif isdefined("url.LeadType") and trim(url.LeadType)  eq 'Hour24'>
			,[LeadProductField].[Hour24FieldPrice] as 'FieldPrice'
		  </cfif>
		  <cfif isdefined("url.LeadType") and trim(url.LeadType)  eq 'Aged'>
			,[LeadProductField].[AgedFieldPrice] as 'FieldPrice'
		  </cfif>
		
	
		  ,LeadField.LeadFieldName
		  ,LoanType.LoanTypeName
	  
	  from [LeadProductField]
		join [LeadProduct] on [LeadProductField].LeadProductID = [LeadProduct].LeadProductID
		join LeadField on LeadField.LeadFieldID = LeadProductField.LeadFieldID
		join WebSiteLeadProduct on WebSiteLeadProduct.LeadProductID = [LeadProduct].LeadProductID
		join WebSite on WebSite.WebSiteID = WebSiteLeadProduct.WebSiteID
		
		join LoanType on LoanType.LoanTypeID = LeadProduct.LoanTypeID
		
	  where WebSite.WebSiteName = '#trim(request.callerWebSite)#'
	  
	  
	  	<cfif isdefined("url.LeadProductID") and val(url.LeadProductID) gt 0>
			and LeadProduct.LeadProductID = #val(url.LeadProductID)#
		</cfif>
	  
		
		<cfif isdefined("url.LeadProductID") and val(url.LeadProductID) gt 0>
			and LeadProduct.LeadProductID = #val(url.LeadProductID)#
		</cfif>
		<cfif isdefined("url.LeadType") and trim(url.LeadType)  eq 'Exclusive'>
			 and [LeadProduct].[ExclusiveLeadPrice] > 0
		  </cfif>
		  <cfif isdefined("url.LeadType") and trim(url.LeadType)  eq 'Shared'>
			and [LeadProduct].[SharedLeadPrice] > 0
		  </cfif>
		  <cfif isdefined("url.LeadType") and trim(url.LeadType)  eq 'Hour24'>
			and [LeadProduct].[Hour24LeadPrice]> 0
		  </cfif>
		  <cfif isdefined("url.LeadType") and trim(url.LeadType)  eq 'Aged'>
			and [LeadProduct].[AgedLeadPrice] > 0
		  </cfif>
	
		order by LeadProduct.[Priority],  LeadProduct.[LeadProductID], LeadField.[Priority]


</cfquery>



<cfquery datasource="#request.dsnameReader#" name="qSpecialOfferSelect"> 
	SELECT *
	FROM SpecialOffer 
	WHERE getdate() between SpecialOfferFrom and SpecialOfferTo
		and AppliesTo like '%#url.leadtype#%'
		and DiscountPercentage > 0
</cfquery>

<cfoutput>


	<style>
		.special-offer-message{
			line-height: 3;
		}
		.special-offer-date{
			font-size: large;
			font-weight: bold;
			text-shadow: 1px 1px 1px lightgrey;
			border: 1px solid gray;
			box-shadow: 0 0 5px;
			padding: 5px;
			line-height: 2rem;
			border-radius: 6px;
			word-break: keep-all;
			display: inline-block;
		}
	</style>
	<script language="javascript">	
		function validateOrder(){			
			{
				$('##myModal').modal('show')  ;			
				//alert('Nothing is selected. Please select the quantity you wish to order'); 			
				return false;		
			}		
			return true;				
		}
		
		$(window).on('load', function () {
			calculatePrice();
		});
	
	</script>




	<!-- Modals start -->
	<!-- ============================================================================== -->
	<!-- Button trigger modal -->
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="myModalLabel">Order Selection</h4>
				</div>
				<div class="modal-body">
					<p>You have not selected any item to order.</p>
					<p>Please select at least one item to proceed with the order.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-sm btn-dark" data-dismiss="modal">Close</button>				
				</div>
			</div>
		</div>
	</div>


	<!-- main-container start -->
	<!-- ================ -->
	<section class="main-container">

		<div class="container">
			<div class="row">

				<!-- main start -->
				<!-- ================ -->
				<div class="main col-md-12">
														
					<!-- page-title end -->
					<div class="row">					
						<div class="col-md-5">				
				
							<!-- page-title start -->
							<!-- ================ -->
							<h1 class="page-title margin-top-clear">
								#qLeadProductSelect.LeadProductName#
								
								<cfset local.isSpecialOfferApplied = false>
								<cfset local.specialOfferPercentage = 0>
								<cfset local.specialOfferDescription = "">
								
								<cfif qSpecialOfferSelect.RecordCount gt 0  and qLeadProductSelect.PerticipateInGlobalSpecialOffer eq 1 and qLeadProductSelect.SoldOut gt 0>
									<div class="discount-amount-productpage">
										<h5>#qSpecialOfferSelect.DiscountPercentage#% <span class="Percentoff"> Off</span></h5>
									</div>
									
									<cfset local.isSpecialOfferApplied = true>
									<cfset local.specialOfferPercentage = qSpecialOfferSelect.DiscountPercentage>
									<cfset local.specialOfferDescription = qSpecialOfferSelect.SpecialOfferDescription>
									

								<cfelseif Now() gt qLeadProductSelect.SpecialOfferFrom and Now() lt qLeadProductSelect.SpecialOfferTo and qLeadProductSelect.SpecialOfferPercentage gt 0 and qLeadProductSelect.SoldOut gt 0>
									<div class="discount-amount-productpage">
										<h5>#qLeadProductSelect.SpecialOfferPercentage#% <span class="Percentoff"> Off</span></h5>
									</div>
									<cfset isSpecialOfferApplied = true>
									<cfset specialOfferPercentage = qLeadProductSelect.SpecialOfferPercentage>
									<cfset local.specialOfferDescription = qLeadProductSelect.SpecialOfferDescription>
									
									
								<cfelseif qLeadProductSelect.SoldOut eq 0>
									<div class="sold">
										<img src="assets/uploads/sold.png" alt="">
									</div>
								</cfif>

							</h1>				
							
							<span id="pricecalc"></span>
							<hr />
							
							
							
							<cfif local.isSpecialOfferApplied> 
								<div class="alert alert-info specialofferdes">
									<p>#local.specialOfferDescription#</p>
								</div>
							</cfif>
							
							
							<!---start desc side --->
							<p>#qLeadProductSelect.ProductDescription#</p>
							<cfset hasOptioanFields = false>
							
							<!--- included fields--->
							<p>Following details about the leads are already included in your order:</p>	
							<div class="row col-md-offset-1 col-md-11">					
								<cfloop query="qLeadProductSelect">
									
									<cfif val(#qLeadProductSelect.FieldPrice#) gt 0>
										<cfset hasOptioanFields = true>
									<cfelse>
										<span class="glyphicon glyphicon-ok"></span> #qLeadProductSelect.LeadFieldName#<br />
									</cfif>
									
								</cfloop>
								<br />								
							</div>
							
							<!--- optional fields--->
							<cfif hasOptioanFields>								
								<p>Following details are available at an addional cost:</p>	
								<div class="row col-md-offset-1 col-md-11">								
								<cfloop query="qLeadProductSelect">							
									<cfif val(#qLeadProductSelect.FieldPrice#) gt 0>
										<span class="glyphicon glyphicon-ok"></span> #qLeadProductSelect.LeadFieldName#<br />								
									</cfif>								
								</cfloop>								
								</div>						
							</cfif>
							<!---end desc side --->		
							
								
							<!---This is when global offer is valid --->
							<cfif qSpecialOfferSelect.RecordCount gt 0 and qLeadProductSelect.PerticipateInGlobalSpecialOffer eq 1>
								<div class="offer-detail">
									
									
									<h2>Special Offer</h2> 
									
									<p><strong>#qLeadProductSelect.LeadProductName#</strong> is currently on special offer since 
									<strong>#DateFormat(qSpecialOfferSelect.SpecialOfferFrom, 'mmmm dd, yyyy')#</strong>.  
									
									You will receive <strong>#qSpecialOfferSelect.DiscountPercentage#%</strong> discount if you order  
									before <strong>#DateFormat(qSpecialOfferSelect.SpecialOfferTo, 'mmmm dd, yyyy')#</strong>.</p>
									

									<cfif qSpecialOfferSelect.MinDuration eq qSpecialOfferSelect.MaxDuration>
										
										<cfset MaxDuration = (#qSpecialOfferSelect.MaxDuration# / 5) >
										<cfif MaxDuration eq 1>
											<cfset MaxDuration = MaxDuration &' week'>
										<cfelse>
											<cfset MaxDuration = MaxDuration &' weeks' >
										</cfif>
										<p>Special offer is only valid for order with duration of <strong>#MaxDuration#</strong>.</p>
									<cfelse>
										
									<cfset MinDuration = (#qSpecialOfferSelect.MinDuration# / 5) >		
										<cfif MinDuration eq 1>
											<cfset MinDuration = MinDuration &' week'>
										<cfelse>
											<cfset MinDuration = MinDuration &' weeks'>
										</cfif>
										
										<cfset MaxDuration = (#qSpecialOfferSelect.MaxDuration# / 5) >
										<cfif MaxDuration eq 1>
											<cfset MaxDuration = MaxDuration &' week'>
										<cfelse>
											<cfset MaxDuration = MaxDuration &' weeks' >
										</cfif>
										
										<p>You have to order at least for <strong>#MinDuration#</strong> duration to be eligible for this special offer.  Special offer is valid for order up to <strong>#MaxDuration#</strong> duration.</p>
										
									</cfif>							
									
								</div>
								
							
							<!--- this is when product level special offer is applicable --->
							<cfelseif Now() gt qLeadProductSelect.SpecialOfferFrom and Now() lt qLeadProductSelect.SpecialOfferTo and qLeadProductSelect.SpecialOfferPercentage gt 0>
								<div class="offer-detail">
									
									<h2>Special Offer</h2> 
									<p><strong>#qLeadProductSelect.LeadProductName#</strong> is currently on special offer since 
									<strong>#DateFormat(qLeadProductSelect.SpecialOfferFrom, 'mmmm dd, yyyy')#</strong>.  
									
									You will receive <strong>#qLeadProductSelect.SpecialOfferPercentage#%</strong> discount if you order before 
									<strong>#DateFormat(qLeadProductSelect.SpecialOfferTo, 'mmmm dd, yyyy')#</strong>.</p>
									
											 
									<cfif qLeadProductSelect.MinSpecialOfferDuration eq qLeadProductSelect.MaxSpecialOfferDuration>	 
									    <cfset MaxSpecialOfferDuration = (#qLeadProductSelect.MaxSpecialOfferDuration# / 5) >
										<cfif MaxSpecialOfferDuration eq 1>
											<cfset MaxSpecialOfferDuration = MaxSpecialOfferDuration &' week'>
										<cfelse>
											<cfset MaxSpecialOfferDuration = MaxSpecialOfferDuration &' weeks' >
										</cfif>
										<p>Special offer is only valid for order with duration of <strong>#MaxSpecialOfferDuration#</strong>.</p>
										
									<cfelse>
										<cfset MinSpecialOfferDuration = (#qLeadProductSelect.MinSpecialOfferDuration# / 5) >		
										<cfif MinSpecialOfferDuration eq 1>
											<cfset MinSpecialOfferDuration = MinSpecialOfferDuration &' week'>
										<cfelse>
											<cfset MinSpecialOfferDuration = MinSpecialOfferDuration &' weeks'>
										</cfif>
										
										<cfset MaxSpecialOfferDuration = (#qLeadProductSelect.MaxSpecialOfferDuration# / 5) >
										<cfif MaxSpecialOfferDuration eq 1>
											<cfset MaxSpecialOfferDuration = MaxSpecialOfferDuration &' week'>
										<cfelse>
											<cfset MaxSpecialOfferDuration = MaxSpecialOfferDuration &' weeks' >
										</cfif>
										
										<p>You have to order at least for <strong>#MinSpecialOfferDuration#</strong> duration to be eligible for this special offer.  
										Special offer is valid for order up to <strong>#MaxSpecialOfferDuration#</strong> duration.</p>
									</cfif>
									
									

								</div>
							</cfif>						
							
										
						</div>
						
						<!-- product side start -->
						<aside class="col-md-7">
							<cfinclude template="help-button.cfm">
							<div class="sidebar sidebarAfterHelpButton">
								<div class="side product-item vertical-divider-left">
											
										<!---start order side --->	
										<!-- Nav tabs -->
										<!---<p><strong>Select quantity and duration of your order</strong></p>--->
										<!---<hr>--->
							
									<div class="row">
										<form class="productquantity-form" role="form" action="index.cfm?area=Home&action=AddToCart" method="post">
										
											<input type="hidden" name="leadProductID" value="#qLeadProductSelect.LeadProductID#" />
											<input type="hidden" name="leadProductName" value="#qLeadProductSelect.LeadProductName#" />
										
										<cfset specialOfferPercentageValue = 0 >
										<cfset specialOfferMinDuration = 0 >
										<cfset specialOfferMaxDuration = 0 >	
										<cfif qSpecialOfferSelect.RecordCount gt 0 and qLeadProductSelect.PerticipateInGlobalSpecialOffer eq 1>
											<cfset specialOfferPercentageValue = qSpecialOfferSelect.DiscountPercentage >
											<cfset specialOfferMinDuration = qSpecialOfferSelect.MinDuration >
											<cfset specialOfferMaxDuration = qSpecialOfferSelect.MaxDuration >
											<input type="hidden" id="SpecialOfferPercentage" name="SpecialOfferPercentage" value="#qSpecialOfferSelect.DiscountPercentage#"/>
											<input type="hidden" id="MinSpecialOfferDuration" name="MinSpecialOfferDuration" value="#qSpecialOfferSelect.MinDuration#"/>
											<input type="hidden" id="MaxSpecialOfferDuration" name="MaxSpecialOfferDuration" value="#qSpecialOfferSelect.MaxDuration#"/>
										<cfelseif Now() gt qLeadProductSelect.SpecialOfferFrom and Now() lt qLeadProductSelect.SpecialOfferTo and qLeadProductSelect.SpecialOfferPercentage gt 0>
											<cfset specialOfferPercentageValue = qLeadProductSelect.SpecialOfferPercentage >
											<cfset specialOfferMinDuration = qLeadProductSelect.MinSpecialOfferDuration >
											<cfset specialOfferMaxDuration = qLeadProductSelect.MaxSpecialOfferDuration >
											<input type="hidden" id="SpecialOfferPercentage" name="SpecialOfferPercentage" value="#qLeadProductSelect.SpecialOfferPercentage#"/>
											<input type="hidden" id="MinSpecialOfferDuration" name="MinSpecialOfferDuration" value="#qLeadProductSelect.MinSpecialOfferDuration#"/>
											<input type="hidden" id="MaxSpecialOfferDuration" name="MaxSpecialOfferDuration" value="#qLeadProductSelect.MaxSpecialOfferDuration#"/>
										<cfelse>
											<input type="hidden" id="SpecialOfferPercentage" name="SpecialOfferPercentage" value="0"/>
											<input type="hidden" id="MinSpecialOfferDuration" name="MinSpecialOfferDuration" value="0"/>
											<input type="hidden" id="MaxSpecialOfferDuration" name="MaxSpecialOfferDuration" value="0"/>
										</cfif>
								

											
											<p><strong>Select order lead quantity, duration then press "Next Step"</strong></p>
										
											<fieldset style="position:relative;">
												<legend ondblclick="setTestData();">Order Quantity</legend>
													
												<cfif qLeadProductSelect.SoldOut eq 0>
													<div class="soldoutMessage">
														<p>&nbsp;</p>
														<h3>Sorry, we are currently sold out of this item. <br>Please select an available feed. <br>If you have any questions, please contact us.</h3>
													</div>
												</cfif>	
													
													
													
												<!--- Order Quantity--->									
												<!---<div class="row col-md-12">
													<div class="space-bottom">Number of leads to order per #qLeadProductSelect.ProductPeriod# (minimum is #qLeadProductSelect.MinimumProductAmount#)</div>
												</div>--->
												<div class="row col-md-12 ">												
													<div class="form-group has-error">
														<label for="orderAmount" class="col-md-4 control-label">Lead Quantity<small class="text-default">*</small></label>
														<div class="col-md-3">
															<input type="text" class="form-control required" name="orderQuantity" id="orderQuantity" value="#session.Cart.orderQuantity#" />
															<span id="errmsg" style="display: none;">Input Number Please</span>
														</div>
														<div class="col-md-5">
															<cfif qLeadProductSelect.leadtype eq "Aged">
																per day leads
																<!---<input type="hidden" id="minimumOrderQuantity" value="#qLeadProductSelect.MinimumProductAmount#"/>	--->																																
																<input type="hidden" class="minimumOrderQuantity300" id="minimumOrderQuantityAged"  name="minimumOrderQuantityAged" id="minimumOrderQuantityAged" 																																value="#qLeadProductSelect.MinimumProductAmount#"/>
															<cfelse>
																per #qLeadProductSelect.ProductPeriod#	(minimum is #qLeadProductSelect.MinimumProductAmount#)
																<input type="hidden" id="minimumOrderQuantity" value="#qLeadProductSelect.MinimumProductAmount#" />	
															</cfif>														
														</div>
													</div>
												</div>
												
												<div class="row col-md-12 ">
													<cfif qLeadProductSelect.leadtype eq "Aged">
														<div class="row alert alert-danger" id="pricemin">
															<span id="pricemax">You have to order minimum amount $#qLeadProductSelect.MinimumProductAmount#</span>
														</div>
													<cfelse>
														<div class="row alert alert-danger" id="quntityerror" style="display: none;">
															<span>You have to put minimum #qLeadProductSelect.MinimumProductAmount# leads.</span>
														</div>
													</cfif>	
													
																															
												</div>
												
												<div class="row col-md-12">
													<div class="space-bottom"></div>
												</div>													
												
												<!--- Order Duraction--->												
												<!---<div class="row col-md-12">
													<div class="space-bottom">How long do you wish to receive leads</div>
												</div>--->												
												<div class="row col-md-12">												
													<div class="form-group has-error">
														<label for="billingFirstName" class="col-md-4 control-label">Order Duration<small class="text-default">*</small></label>
														<div class="col-md-8">
															
															<select id="orderDuration" name="orderDuration" class="form-control required" >	
																<option value="">Select one...</option>
																<cfloop from="#qLeadProductSelect.MinimumOrderPeriod#" to="#qLeadProductSelect.MaximumOrderPeriod#" index="counter">
																	<cfif counter lt 5>
																		<cfset value = counter>
																		<cfset displayValue = counter>
																		<cfset unit = "day">
											
																	<cfelse>
																		<cfif counter mod 5 eq 0>
																			<cfset value = counter>
																			<cfset displayValue = counter / 5>
																			<cfset unit = "week">
																		<!---cfif counter mod 7 eq 0>
																			<cfset value = counter / 7 * 5>
																			<cfset displayValue = counter / 7>
																			<cfset unit = "week"--->
																		<cfelse>
																			<cfcontinue>
																		</cfif>
																	</cfif>																	
																	<option value="#value#" <cfif session.Cart.orderDuration eq value>selected="selected"</cfif>>#displayValue# #unit#</option>
																</cfloop>														
															</select>
														</div>
													</div>						
												</div>
												
												<!---Special Offer Order Duration Message--->
												<div class="row col-md-12 ">													
													<cfif specialOfferPercentageValue GT 0 >													
														<div class="row alert alert-warning" id="specialOfferWarning">
														<cfif to5DaysWeek(val(specialOfferMinDuration)) eq to5DaysWeek(val(specialOfferMaxDuration))>
															Special offer is only valid for order with duration of <strong>#to5DaysWeek(val(specialOfferMaxDuration))#</strong>

														<cfelse>
																Special Offer is available for the Order Duration between <strong>#to5DaysWeek(val(specialOfferMinDuration))#</strong> 
															and <strong>#to5DaysWeek(val(specialOfferMaxDuration))#</strong>
														</cfif>
														</div>
													</cfif>	
												</div>										
											</fieldset>
										
										
											<!--- Optional Details --->
											<!---show the following section if optional items are avaialble--->
											<cfif hasOptioanFields>
												<fieldset>
													<legend>Optional Details</legend>
														
													<!--- Order Amount--->									
													<div class="row col-md-12">
														<div class="space-bottom">Please select any optional item to add to the lead feed</div>
													</div>
													
													<cfloop query="qLeadProductSelect">											
														<cfif val(#qLeadProductSelect.FieldPrice#) gt 0>
															<div class="row col-md-12 ">											
																<div class="form-group optional_details">
																	<div class="col-md-1">													
																		<input type="checkbox" <cfif qLeadProductSelect.LeadFieldName eq "Bank"> class="fbank" <cfelseif qLeadProductSelect.LeadFieldName eq "Specific Institute"> class="fspecificbank" id="fspecificbank" </cfif>  name="leadFieldID" id="leadFieldID" value="#qLeadProductSelect.LeadFieldID#"  <cfif listFind(	session.Cart.leadFieldID, qLeadProductSelect.LeadFieldID)>checked="checked"</cfif>/>
																		<input type="hidden" id="LeadFieldID_#qLeadProductSelect.LeadFieldID#_price" value="#qLeadProductSelect.FieldPrice#" />														
																	</div>													
																	<label for="billingFirstName" class="col-md-3 control-label">#qLeadProductSelect.LeadFieldName#</label>
																		
																	<div class="col-md-8">
																		$#specialNumFormat(qLeadProductSelect.FieldPrice)# per lead
																		
																		<cfif qLeadProductSelect.LeadFieldName eq "Specific Institute">
																			<h3 class="selectLabel" style="display: none;">Major Financial Institutes (Select at least 3)</h3>															
																			<select class="form-control specificbanks" style="border:none;" id="specificBank" name="specificBank" multiple="multiple">
																				<cfloop query="qBankSelect">
																					<cfif qBankSelect.isNational eq 1>																			
																						<option value="#qBankSelect.BankName#" 
																							<cfif listFindNoCase(session.cart.specificBank, qBankSelect.BankName)>selected="selected"</cfif>
																							>
																							#qBankSelect.BankName#
																						</option>
																					</cfif>
																				</cfloop>
																			</select>
																			<div class="alert alert-danger" id="national" style="display: none;">
																				<span id="nationalBank">You have to select minimum 3 Major Financial Institutes</span>
																			</div>
																			<h3 class="selectLabel" style="display: none;">Other Financial Institutes (Select any number)</h3>
																			<select class="form-control specificbanks" style="border:none;" id="specificBank2" name="specificBank2" multiple="multiple">
																				<cfloop query="qBankSelect">
																					<cfif qBankSelect.isNational neq 1>																			
																						<option value="#qBankSelect.BankName#" 
																						<cfif listFindNoCase(session.cart.specificBank, qBankSelect.BankName)>selected="selected"</cfif>																		
																						>#qBankSelect.BankName#</option>																			
																					</cfif>
																				</cfloop>
																			</select>																
																		</cfif>																									
																	</div>
																</div>						
															</div>
														</cfif>
													</cfloop>										
								
													<style>
														.specificbanks {
															display: none;
														}
													</style>
										
													<div class="row col-md-12">
														<div class="space-bottom"></div>
													</div>
									
												</fieldset>							
											</cfif>
											<!---end of optional items--->
									
											<!---price--->
											<fieldset>
												<legend>Order Price</legend>
												<cfif specialOfferPercentageValue eq 0 >
												<table class="table table-hover table-striped productPage-table">
													<table class="table table-hover table-striped productPage-table">
														<thead>
															<tr>
																<th></th>
																<th></th>
																<th>
																	Price:
																	$#specialNumFormat(qLeadProductSelect.LeadPrice)# per lead
																	<input type="hidden" id="LeadPrice" name="LeadPrice" value="#qLeadProductSelect.LeadPrice#" />
																	<input type="hidden" id="priceOption" name="priceOption" value="#url.leadtype#" />
																</th>
															</tr>
														</thead>
														<tbody>

															<tr>
															<td>
																Total:
															</td>
															<td> 
																:
															</td>
															<td>	
																<div id="priceDisplay" style="display: none;">
																	$<span id="price"></span>                                    
																</div>
															</td>
														</tr>						
													</tbody>
												</table>
												<cfelse>
												<table class="table table-hover table-striped productPage-table">
													<thead>
														<tr>
															<th></th>
															<th></th>
															<th>
																Price:
																$#specialNumFormat(qLeadProductSelect.LeadPrice)# per lead
																<input type="hidden" id="LeadPrice" name="LeadPrice" value="#qLeadProductSelect.LeadPrice#" />
																<input type="hidden" id="priceOption" name="priceOption" value="#url.leadtype#" />
															</th>
														</tr>
													</thead>
													<tbody>
													
												
														<tr>
															<td>
																Sub Total
															</td>
															<td> 
																:
															</td>
															<td>
																<div id="totalMain" style="display: none;"></div>	
															</td>
														</tr>
														<tr>
															<td>
																Discount
															</td>
															<td> 
																:
															</td>
															<td>	
																<div id="savedAmount" style="display: none;"></div>
															
															</td>
														</tr>
														<tr>
															<td>
																Total:
															</td>
															<td> 
																:
															</td>
															<td>	
																<div id="priceDisplay" style="display: none;">
																	$<span id="price"></span>                                    
																</div>
															</td>
														</tr>						
													</tbody>
												</table>	
			
													</cfif>
														
											</fieldset>									
											<!---end of price--->
									
											<div class="row">
												<div class="text-left col-md-6">											
													<a href="index.cfm?area=home&action=productlist&leadtype=#url.leadtype#" class="btn btn-group btn-default btn-sm"><i class="icon-left-open-big"></i> Go Back Product List</a>	
												</div>								
												<!--- <div class="text-right col-md-6" id="whenNank" style="display: none">
													<button type="submit" class="btn btn-group btn-default btn-sm" disabled>
														Next Step<i class="icon-right-open-big"></i>
													</button>
												</div>--->
												
												
												<cfif qLeadProductSelect.SoldOut neq 0>
												
													<div class="text-right col-md-6" >
														<button id="nextButton" type="submit" class="btn btn-group btn-default btn-sm" disabled>
															Next Step <i class="icon-right-open-big"></i>
														</button>
													</div>	
													
												<cfelse>
												
													<div class="text-right col-md-6" >
														<img src="assets/uploads/sold.png" alt="">
													</div>	
												
												
												
												</cfif>							
												
												<input type="hidden" name="totalPrice" id="totalPrice" value="">
												<cfif qSpecialOfferSelect.RecordCount gt 0 and qLeadProductSelect.PerticipateInGlobalSpecialOffer eq 1>
													<input type="hidden" name="DiscountNote" id="DiscountNote" value="#qSpecialOfferSelect.SpecialOfferDescription#">
													<input type="hidden" name="DiscountPercentage" id="DiscountPercentage" value="#qSpecialOfferSelect.DiscountPercentage#">
												<cfelseif Now() gt qLeadProductSelect.SpecialOfferFrom and Now() lt qLeadProductSelect.SpecialOfferTo and qLeadProductSelect.SpecialOfferPercentage gt 0>
													<input type="hidden" name="DiscountNote" id="DiscountNote" value="#qLeadProductSelect.SpecialOfferDescription#">
													<input type="hidden" name="DiscountPercentage" id="DiscountPercentage" value="#qLeadProductSelect.SpecialOfferPercentage#">
												<cfelse>
													<input type="hidden" name="DiscountPercentage" id="DiscountPercentage" value="0">
													<input type="hidden" name="DiscountNote" id="DiscountNote" value="">
												</cfif>
																				
											</div>

		  

											
										</form>
												
										<p>* Required Information</p>																
									</div>
									
									<!---</form> --->
									<!---</div> --->
									<!---end image side  --->
								</div>
							</div>
						</aside>
						<!-- product side end -->
					</div>
				</div>
				<!-- main end -->
			</div>
		</div>
	</section>
	<!-- main-container end -->

</cfoutput>

<script language="javascript">

	function validateFormElement( $element ){
		var elementFormElement = $element.closest('.form-group');
		if( $element.val() != "" && $element.val() != null ){
			elementFormElement.toggleClass('has-error', false);
		}else{				   
			elementFormElement.toggleClass('has-error', true);
		}
	}

	function setTestData(){
		let $orderQuantity = $('#orderQuantity');
		let $orderDuration = $('#orderDuration');

		$orderQuantity.val("600");
		$orderDuration.val("10");
        
        	$("#leadFieldID").prop("checked", true);
		
		calculatePrice();

		validateFormElement($orderQuantity);
		validateFormElement($orderDuration);
	}

	$(document).ready(function() {

		$("#specificBank").select2({
			placeholder: "Click here to select major",
			allowClear: true
		});

		$("#specificBank2").select2({
			placeholder: "Click here to select other",
			allowClear: true
		});	

		// Order Quantity
		$( '#orderQuantity' ).on('keyup', function(){
			
			calculatePrice();
			validateFormElement( $(this) );
		})

		// Order Duration
		$( '#orderDuration' ).on('change', function(){

			calculatePrice();

			validateFormElement( $(this) );
		})

		// Event: fspecific Bank
		// $( '#fspecificbank' ).on('change', function( event ){			             
			//calculatePrice();
        // })
        
		// Specific Bank
        $( '#specificBank' ).on('change', function(){				
			calculatePrice();
        })

        $('.optional_details input[type=checkbox]').on('click', function() {            
            var $this = $(this);
            if ($this.is(".fbank")) {
                if ($(".fbank:checked").length > 0) {
                    $(".fspecificbank").prop({ checked: false });
                } else {
                    $('#national').css('display', 'none');
                }
            }
            if ($this.is(".fspecificbank")) {
                if ($(".fspecificbank:checked").length > 0) {
                    $(".fbank").prop({ checked: false });
                } else {
                    $('#national').css('display', 'none');
                }
            }
			calculatePrice();
        }); 
		
	});	
	
</script>

<script src="/home/price.js?v=03" type="text/javascript"></script> 





