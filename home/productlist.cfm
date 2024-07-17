
<style>
	.textoverimage {
  position: absolute;
  bottom: 75px;
  left: 90px;
  
  <cfif url.leadType eq "Aged">
	font-size:24px;
  <cfelse>
    font-size:34px;
  </cfif>
  
  }
  
  .priceoverimage {
  position: absolute;
  bottom: 50px;
  left: 130px;
  font-size:18px;
}

</style>





<!-- main-container start -->
<!-- ================ -->
<section class="main-container">

	<div class="container">
		<div class="row">

			<!-- main start -->
			<!-- ================ -->
			<div class="main col-md-12">
				
				<!---title and description of the main section title --->

				<!-- page-title start -->
				<!-- ================ -->
				<div class="row">
					<div class="col-md-8">
						<h1 class="page-title"><cfoutput>#replacenocase(url.leadType, 'Hour24', '24 HOUR')#</cfoutput> Lead Product Selections</h1>
					</div>
					<div class="col-md-4">
						<cfinclude template="help-button.cfm">
					</div>
				</div>
				<div class="separator-2"></div>
				<p class="lead">Please select from any of the product below to to view details.</p>
				<!-- page-title end -->
				
				

				<!-- shop items start -->
				<div class="masonry-grid-fitrows row grid-space-20">
					
	
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

				
				<!--- sub catagory intro --->
				<cfoutput query="qLeadProductSelect" group="LeadProductID">
					
					<div class="col-md-4 col-sm-6 masonry-grid-item">
						<div class="listing-item">
				
	
						<cfif qSpecialOfferSelect.RecordCount gt 0 and qLeadProductSelect.PerticipateInGlobalSpecialOffer eq 1 and qLeadProductSelect.SoldOut gt 0>
							<div class="special-offer">
								<img src="assets/uploads/offer.png" alt="">
							</div>
						<cfelseif Now() gt qLeadProductSelect.SpecialOfferFrom and Now() lt qLeadProductSelect.SpecialOfferTo and qLeadProductSelect.SpecialOfferPercentage gt 0 and qLeadProductSelect.SoldOut gt 0>

							<div class="special-offer">
								<img src="assets/uploads/offer.png" alt="">
							</div>
						<cfelseif qLeadProductSelect.SoldOut eq 0>
							<div class="special-offer soldout">
								<img src="assets/uploads/sold.png" alt="">
							</div>
						</cfif>
				
							<!--- image...--->
							<div class="overlay-container">
								<img src="assets/img/product.jpg" alt="">
								<div class="textoverimage">#qLeadProductSelect.LeadProductName#</div>
								<div class="priceoverimage">$#specialNumFormat(qLeadProductSelect.LeadPrice)#/ lead</div>
								
								<a href="index.cfm?area=home&action=product&leadproductid=#qLeadProductSelect.LeadProductID#&leadtype=#url.leadtype#" class="overlay small">
									<i class="fa fa-plus"></i>
									<span>View Details</span>
								</a>
							</div>
							
							<div class="listing-item-body clearfix">
								
								<div class="loantype">#qLeadProductSelect.LoanTypeName#</div>
								<p>Following fields are available for these leads</p>
								<div style=" margin-left:10px;" >
									
									<cfoutput>
										<span class="glyphicon glyphicon-ok"></span> #qLeadProductSelect.LeadFieldName#
										<cfif val(#qLeadProductSelect.FieldPrice#) gt 0 >
											(Optional, $#specialNumFormat(qLeadProductSelect.FieldPrice)# per lead)
										</cfif>
										<br />
									</cfoutput>
									
								</div>
								
								<div class="elements-list pull-left">
									<a href="index.cfm?area=home&action=product&leadproductid=#qLeadProductSelect.LeadProductID#&leadtype=#url.leadtype#"><i class="fa fa-shopping-cart pr-10"></i>Order Now</a>
																	
								</div>
								<div class="elements-list pull-right">
									
									<a href="index.cfm?area=home&action=product&leadproductid=#qLeadProductSelect.LeadProductID#&leadtype=#url.leadtype#">View More Details...</a>									
								</div>
							</div>
						</div>
					</div>
					
					</cfoutput>
					
					
				
				
				</div>
				<!-- shop items end -->
				
				<div class="clearfix"></div>

				

			</div>
			<!-- main end -->

		</div>
	</div>
</section>
<!-- main-container end -->


