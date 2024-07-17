
<!---- 
// Author: Fakir Hossain
// Create date: 26 Feb 2017
// Description: PRODUCT SERVICES ---->
	
<cfcomponent output="false">
	
	
	<!---- Read Product ---->
	<cffunction name="readLeadProduct" returntype="any">		
		<cfargument name="LeadProductID" type="numeric" required="true" />
		<cfargument name="leadtype" type="string" required="yes">
		
		<cfset arguments.callerWebSite = '#application.domain#'>
		<cfwddx action="cfml2wddx" input="#arguments#" output="apiinput">

		<cfhttp url="#application.apiRoot#/productlist.cfm" method="post">
			<cfhttpparam type="formfield" name="arguments" value="#apiinput#">
		</cfhttp>
		

		<cfwddx action="wddx2cfml" input="#cfhttp.FileContent#" output="local.response">
		
		
		
		<cfreturn local.response/>
	</cffunction>
	
	
	<!---- Starting Multi Record Services ---->
	

	<!---- Get All Product ---->
	<cffunction name="getAllLeadProduct" returntype="any">
		<cfargument name="leadtype" default="ALL">
		
		<cfset LeadProduct = readLeadProduct(LeadProductID = 0, leadtype = arguments.leadtype)>
		
		<cfreturn LeadProduct>
		
		
	</cffunction>


</cfcomponent> 

