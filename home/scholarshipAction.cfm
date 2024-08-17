<cfset errorMessage = "">
<cfparam  name="session.profile.AppUser.AppUserID" default="0">
<cfparam  name="currentPicture" default="">
<cfparam  name="MeritSymbol" default="0">

<cfset ProfilePath = "#request.imagesUploadPath#\Profile">

<cfif not directoryExists(ProfilePath)>
	<cfdirectory action="create" directory="#ProfilePath#">
</cfif>

<cfif len(trim(form.Picture))>
	<cffile action="upload"
		fileField="Picture"
		nameconflict="makeunique"
		destination="#ProfilePath#">
	<cfset savedIPicture = cffile.serverfile>
<cfelse>
	<cfset savedIPicture = currentPicture>
</cfif> 

<cfset currentYear = Year(Now())>
<cfset TrackingNumber = RandRange(100000, 999999)>

<cfquery datasource="#request.dsnameReader#" name="qScholarShipSelect">	
	SELECT COUNT(*) AS NumberCount
		FROM ScholarShip		
	WHERE ApplicationTrackingNumber = <cfqueryparam cfsqltype="cf_sql_integer" value="#TrackingNumber#">	
</cfquery>

<cfif qScholarShipSelect.NumberCount GT 0>
    <cfloop condition="qScholarShipSelect.NumberCount GT 0">
        <cfset TrackingNumber = RandRange(100000, 999999)>
        <!--- Check again --->
        <cfquery datasource="#request.dsnameReader#" name="qScholarShipSelect">	
			SELECT COUNT(*) AS NumberCount
				FROM ScholarShip		
			WHERE ApplicationTrackingNumber = <cfqueryparam cfsqltype="cf_sql_integer" value="#TrackingNumber#">	
		</cfquery>
    </cfloop>
</cfif>

<!---show error message --->
<cfif errorMessage gt "">
	<cfset showErrorMessage (Message = errorMessage)>	
	<cfabort>
</cfif>



<cfquery datasource="#request.dsnameWriter#" name="qScholarShipInsert">	


INSERT INTO [dbo].[ScholarShip]
		([FullName]
		,[Dob]
		,[Picture]
		,[Class]
		,[Shift]
		,[Section]
		,[HomeTeacherName]
		,[GuardianName]
		,[GuardianPhoneNumber]
		,[Address]
		,[MeritSymbol]
		,[MeritRank]
		,[ParentIncome]
		,[TeacherOne]
		,[TeacherOnePhone]
		,[TeacherTwo]
		,[TeacherTwoPhone]
		,[Score]
		,[ApplicationTrackingNumber]
		,[SessionYear]
		,[DateCreated]
		,[CreatedBy]
		,[DateLastUpdated]
		,[UpdatedBy])
		VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.FullName#">,
			<cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.Dob#">,
			<cfif form.Picture neq ''>
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#savedIPicture#">,
			<cfelse>
				NULL,
			</cfif>
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Class#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Shift#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Section#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.HomeTeacherName#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.GuardianName#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.GuardianPhoneNumber#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Address#">,
			<cfif form.MeritSymbol neq ''>
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.MeritSymbol#">,
			<cfelse>
				NULL,
			</cfif>
			<cfif form.MeritRank2 neq ''>
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.MeritRank2#">,
			<cfelse>
				NULL,
			</cfif>
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ParentIncome#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.TeacherOne#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.TeacherOnePhone#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.TeacherTwo#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.TeacherTwoPhone#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Score#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#TrackingNumber#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#currentYear#">,
			getDate(),
			#val(session.profile.AppUser.AppUserID)#,
			getDate(),
			#val(session.profile.AppUser.AppUserID)#
			)
			
	</cfquery>

<cfset session.OnLoadMessage = "success('Submitted successfully')">
<cfset relocate (area = "home", action = "success&tracking=#TrackingNumber#" )>







