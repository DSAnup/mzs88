

<cffunction name="SHOWERRORMESSAGEUDF" >
 	
 	<cfargument name="Message" required="true" >
 	<cfargument name="errorDiv" required="false" default="" >
 	<cfargument name="errorMessage" required="false" default="" >
 	
 	
 	<cfoutput>
 	<script>
	
 		parent.toastr.error('#arguments.Message#');
 		parent.showErrorMessage ('#arguments.Message#', '#arguments.errorDiv#', '#arguments.errorMessage#');
 	</script>
 	</cfoutput>
 	
 </cffunction>
 
 <cfset cffile.SHOWERRORMESSAGE = SHOWERRORMESSAGEUDF>
 
 
 
 
 <cffunction name="SHOWERRORMESSAGEUDFRESET" >
 	
 	<cfargument name="Message" required="true" >
 	<cfargument name="errorDivReset" required="false" default="" >
 	<cfargument name="errorMessageReset" required="false" default="" >
 	
 	
 	<cfoutput>
 	<script>
	
 		parent.toastr.error('#arguments.Message#');
 		parent.showErrorMessageReset ('#arguments.Message#', '#arguments.errorDivReset#', '#arguments.errorMessageReset#');
 	</script>
 	</cfoutput>
 	
 </cffunction>
 
 <cfset cffile.SHOWERRORMESSAGERESET = SHOWERRORMESSAGEUDFRESET>
 
  <cffunction name="SHOWSUCCESSMESSAGEUDF" >
 	
 	<cfargument name="Message" required="true" >
 	<cfargument name="successDiv" required="false" default="" >
 	<cfargument name="successMessage" required="false" default="" >
 	
 	
 	<cfoutput>
 	<script> 
 		parent.toastr.success('#arguments.Message#');	
 		parent.showSuccessMessage ('#arguments.Message#', '#arguments.successDiv#', '#arguments.successMessage#');
 	</script>
 	</cfoutput>
 	
 </cffunction>
 
 <cfset cffile.SHOWSUCCESSMESSAGE = SHOWSUCCESSMESSAGEUDF>

 
  <cffunction name="RelocateUDF" >
 	
 	<cfargument name="area" required="false" default="" >
 	<cfargument name="action" required="false" default="" >
 	<cfargument name="urlParams" required="false" default="" >
 	
 	<cfoutput>
 	<cfif arguments.urlParams gt "">
 		<script>
	 		window.top.relocateMainPage ('#arguments.area#', '#arguments.action#', '#arguments.urlParams#');
	 	</script>
	 <cfelse>
	 	<script>
	 		window.top.relocateMainPage ('#arguments.area#', '#arguments.action#');
	 	</script>
 	</cfif>
 	</cfoutput>
 	
 </cffunction>
 
  <cfset cffile.Relocate = RelocateUDF>
  
 

<cffunction name="specialNumFormat" returntype="string" output="false">
		<cfargument name="numberToFormat" required="yes">
	
			<cfset fractionPart =  arguments.numberToFormat - Int(arguments.numberToFormat)>
			
			<cfif len("#fractionPart#") lt 4>
				<cfreturn numberFormat(arguments.numberToFormat, "0.00")>			
			<cfelse>
				<cfreturn numberFormat(arguments.numberToFormat, "0.0000")>
			</cfif>
		
		
</cffunction>
<cfset cffile.specialNumFormat = specialNumFormat>

