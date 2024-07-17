<cfset x = getCountry()>

<cfdump var="#x#" >

<cffunction name="getCountry" >
	<cfhttp url="https://freegeoip.app/json/#cgi.REMOTE_ADDR#" ></cfhttp>
	<cfset data = DeserializeJSON (cfhttp.filecontent)>
	<cfset iso2 = data.country_code>
	<cfquery datasource="#request.dsnameReader#" name="qCountrySelect">
		select countryid from country where iso2 = '#iso2#'
	</cfquery>
	<cfreturn qCountrySelect.countryid>
</cffunction>


