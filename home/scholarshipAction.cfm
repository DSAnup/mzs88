<cfset errorMessage = "">
<cfparam  name="session.profile.AppUser.AppUserID" default="0">
<cfparam  name="currentPicture" default="">
<cfparam  name="MeritSymbol" default="0">
<cfparam  name="form.ScholarShipID" default="0">
<cfparam  name="form.SessionYear" default="#Year(Now())#">
<cfparam  name="form.ApplicationTrackingNumber" default="0">

<cfset ProfilePath = "#request.imagesUploadPath#\Profile">

<cfif not directoryExists(ProfilePath)>
	<cfdirectory action="create" directory="#ProfilePath#">
</cfif>

<cfif len(trim(form.Picture))>
	<cffile action="upload"
		fileField="Picture"
		nameconflict="makeunique"
		destination="#ProfilePath#">
	<cfset savedProfilePicture = cffile.serverfile>
<cfelse>
	<cfset savedProfilePicture = currentPicture>
</cfif> 

<cfif len(trim(form.SessionYear))>
	<cfset currentYear = form.SessionYear>
<cfelse>
	<cfset currentYear = Year(Now())>
</cfif>
<cfif len(trim(form.ApplicationTrackingNumber)) gt 1>
	<cfset TrackingNumber = form.ApplicationTrackingNumber>
<cfelse>
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
</cfif>

<!---show error message --->
<cfif errorMessage gt "">
	<cfset showErrorMessage (Message = errorMessage)>	
	<cfabort>
</cfif>


<cfif val(form.ScholarShipID) gt 0 >
	<cfquery datasource="#request.dsnameWriter#" name="qScholarShipInsert">	


		UPDATE [dbo].[ScholarShip]
		SET [FullName] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.FullName#">
			,[Dob] = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.Dob#">
			,[Picture] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#savedProfilePicture#">
			,[Class] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Class#">
			,[Shift] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Shift#">
			,[Section] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Section#">
			,[HomeTeacherName] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.HomeTeacherName#">
			,[GuardianName] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.GuardianName#">
			,[GuardianPhoneNumber] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.GuardianPhoneNumber#">
			,[Address] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Address#">
			,[MeritSymbol] = 
			<cfif form.MeritSymbol neq ''>
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.MeritSymbol#">
			<cfelse>
				NULL
			</cfif>
			,[MeritRank] = 
			<cfif form.MeritRank neq ''>
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.MeritRank#">
			<cfelse>
				NULL
			</cfif>
			,[ParentIncome] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ParentIncome#">
			,[TeacherOne] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.TeacherOne#">
			,[TeacherOnePhone] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.TeacherOnePhone#">
			,[TeacherTwo] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.TeacherTwo#">
			,[TeacherTwoPhone] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.TeacherTwoPhone#">
			,[Score] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Score#">
			,[ApplicationTrackingNumber] = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(TrackingNumber)#">
			,[SessionYear] = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(form.SessionYear)#">
			,[DateLastUpdated] = getDate()
			,[UpdatedBy] = #val(session.profile.AppUser.AppUserID)#
			
		WHERE ScholarShipID = #val(form.ScholarShipID)#	
	</cfquery>
<cfelse>
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
			,[CreatedBy])
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
			<cfif form.MeritRank neq ''>
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.MeritRank#">,
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
			<cfqueryparam cfsqltype="cf_sql_integer" value="#form.SessionYear#">,
			getDate(),
			#val(session.profile.AppUser.AppUserID)#
			)
				
	</cfquery>
</cfif>

<cfset session.OnLoadMessage = "success('Submitted successfully')">
<cfset relocate (area = "home", action = "success&tracking=#TrackingNumber#" )>







