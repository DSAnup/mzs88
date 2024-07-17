
<style>
	.textoverimage {
  position: absolute;
  bottom: 75px;
  left: 90px;
  
 
  }
  .priceoverimage {
  position: absolute;
  bottom: 50px;
  left: 130px;
  font-size:18px;
}
.specialOfferProduct {
    margin-bottom: 30px;
    border: 1px solid #ccc;
    border-radius: 12px;
    overflow: hidden;
}

</style>

<cfquery datasource="#request.dsnameReader#" name="qLeadProductSelect">

		
	SELECT [LeadProduct].[LeadProductID]

	,[LeadProduct].SpecialOfferBanner

	,CASE 
		WHEN [LeadProduct].[ExclusiveLeadPrice] > 0
			THEN 'Exclusive'
		WHEN [LeadProduct].[SharedLeadPrice] > 0
			THEN 'Shared'
		WHEN [LeadProduct].[Hour24LeadPrice] > 0
			THEN 'Hour24'
		WHEN [LeadProduct].[AgedLeadPrice] > 0
			THEN 'Aged'
		END AS LeadType

FROM [LeadProductField]
JOIN [LeadProduct] ON [LeadProductField].LeadProductID = [LeadProduct].LeadProductID
JOIN LeadField ON LeadField.LeadFieldID = LeadProductField.LeadFieldID
JOIN WebSiteLeadProduct ON WebSiteLeadProduct.LeadProductID = [LeadProduct].LeadProductID
JOIN WebSite ON WebSite.WebSiteID = WebSiteLeadProduct.WebSiteID
JOIN LoanType ON LoanType.LoanTypeID = LeadProduct.LoanTypeID
WHERE WebSite.WebSiteName = '#trim(request.callerWebSite)#'
	AND LeadProduct.SpecialOfferPercentage > 0
ORDER BY LeadProduct.[Priority]
	,LeadProduct.[LeadProductID]
	,LeadField.[Priority]


</cfquery>


  <cfquery datasource="#request.dsnameReader#" name="qSpecialOfferSelect"> 
	SELECT *
  	FROM SpecialOffer 
	WHERE getdate() between SpecialOfferFrom and SpecialOfferTo 
	and DiscountPercentage > 0
  </cfquery>
  
  
  

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
						<h1 class="page-title">Special Offer Product</h1>
					</div>
					<div class="col-md-4">
						<cfinclude template="help-button.cfm">
					</div>
				</div>
				<div class="separator-2"></div>
				
				
				<cfif qLeadProductSelect.RecordCount gt 0 and qLeadProductSelect.PerticipateInGlobalSpecialOffer eq 1 or qSpecialOfferSelect.RecordCount gt 0 and qSpecialOfferSelect.DiscountPercentage gt 0>
					
					<p class="lead">Please select from any of the product below to to view details.</p>
					<!-- page-title end -->
					
				<cfelse>
					<p class="lead">Currently there is not special offer available.</p>
				<!-- page-title end -->
					
				</cfif>
				
				

				<!-- shop items start -->
				<div class="row grid-space-20">
					
				<cfif qLeadProductSelect.RecordCount gt 0 and qLeadProductSelect.PerticipateInGlobalSpecialOffer eq 1 or qSpecialOfferSelect.RecordCount gt 0 and qSpecialOfferSelect.DiscountPercentage gt 0>
							
					
					<cfloop query="qSpecialOfferSelect">
					
						<cfif listContains(qSpecialOfferSelect.AppliesTo, 'Exclusive')>
							<cfoutput> 
								<div class="specialOfferProduct">
							
									<a href="index.cfm?area=home&action=productlist&leadtype=Exclusive">
												
										<img src="assets/img/upload/#qSpecialOfferSelect.SpecialOfferBannerFileName#" alt="">
						
									</a>
								</div>
							</cfoutput>
						
						<cfelseif listContains(qSpecialOfferSelect.AppliesTo, 'Hour24')>
							<cfoutput> 
								<div class="specialOfferProduct">
							
									<a href="index.cfm?area=home&action=productlist&leadtype=Hour24">
												
										<img src="assets/img/upload/#qSpecialOfferSelect.SpecialOfferBannerFileName#" alt="">
						
									</a>
								</div>
							</cfoutput>
						<cfelse>
							
							<cfoutput> 
								<div class="specialOfferProduct">
							
									<a href="index.cfm?area=home&action=productlist&leadtype=Aged">
												
										<img src="assets/img/upload/#qSpecialOfferSelect.SpecialOfferBannerFileName#" alt="">
						
									</a>
								</div>
							</cfoutput>
						</cfif>
					
					</cfloop>
				</cfif>
				
				<!--- sub catagory intro --->
<!---				<cfoutput query="qLeadProductSelect" group="LeadProductID">
					
					<div class="specialOfferProduct">
				
						<a href="index.cfm?area=home&action=product&leadproductid=#qLeadProductSelect.LeadProductID#&leadtype=#leadtype#">
									
							<img src="assets/uploads/#qLeadProductSelect.SpecialOfferBanner#" alt="">
			
						</a>
					</div>
					
					</cfoutput>--->
					
					
				
				
				</div>
				<!-- shop items end -->
				
				<div class="clearfix"></div>

				

			</div>
			<!-- main end -->

		</div>
	</div>
</section>
<!-- main-container end -->


