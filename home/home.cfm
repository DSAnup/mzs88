<style>
    .site-notice{
        margin-top: 50px;
        color: #fff;
    }
    .site-notice p{
        margin-top: 30px;
        font-size: 18px;
        opacity: 0.75;
    }
</style>

<!---  <cfquery datasource="#request.dsnameReader#" name="qHomeMessageSelect"> 
	SELECT *
  	FROM HomeMessage 
	WHERE getdate() between HomeMessageFrom and HomeMessageTo
	ORDER BY HomeMessageFrom
  </cfquery>--->
<cfoutput>

<center>

<!--- <a href="batch88.pdf"><img src="book.jpg" /></a> --->
<a href="index.cfm?area=home&action=Scholarship"><img src="assets/banner.jpg" /></a>

</center>

<div class="home-page-banner">
    <div class="home-banner-overlay">
        <div class="container">
            <div class="banner-inner-content">
                <h1>MYMENSINGH ZILLA SCHOOL 88 ALUMNI</h1>
                <p>THIS IS AN INFORMATION PAGE OF MYMENSINGH ZILLA SCHOOL (MZS) 88 PASSED-OUT BATCH. THIS PAGE KEEPS TRACK OF ALL FRUITS OF MZS WHO FINISHED THEIR SSC IN THE YEAR 1988</p>
			<cfparam name="session.profile.IsLoggedIn" default="false" >						
			<cfif session.profile.IsLoggedIn eq true>	
                <a href="index.cfm?area=home&action=AlumniSelect" class="order-button">Alumni List</a>
			<cfelse>
				<a href="index.cfm?area=home&action=signup" class="order-button">Register Now</a>
			</cfif>
                
                                
            </div>
<!---			<cfif qHomeMessageSelect.RecordCount gt 0 >
			   <div class="site-notice">
					<div class="row">
					<cfloop query="qHomeMessageSelect">
						<cfif qHomeMessageSelect.RecordCount eq 1>
							<div class="col-md-12 text-center">
								<p>#qHomeMessageSelect.HomeMessage#</p>
							</div>
						<cfelse>
							<div class="col-md-6 text-center">
								<p>#qHomeMessageSelect.HomeMessage#</p>
							</div>
						</cfif>
					</cfloop>
					</div>
				</div>
			</cfif>--->
        </div>
    </div>
</div>

</cfoutput>
<div class="padding-100 section-call-center">
    <div class="container">
        <div class="call-center-inner text-center">
            <h2>Mymensingh Zilla School (MZS) 88 keeps track of all 1988 S.S.C passed-out batch. When you passed out from MZS, you become part of the global network of innovative people-from industry leader, Physician, Engineer, Entrepreneur, Lawyer, Government Employee, researcher and community leader.</h2>
            <div class="call-center-thumb">
                <img src="assets/alumni_pictures/Mymensingh_Zilla_School_1.jpg" alt="">
            </div>
            <h1>Innovation & Inspiration</h1>
            <p>Your success is an inspiration for others. Your innovative ideas are opportunities for your mates participation. Share your innovation and success story via info@mzs88alumni.com</p>
        </div>
    </div>
</div>


<div class="helpus-banner">
    <div class="home-banner-overlay">
        <div class="container">
            <div class="helpus-inner-content">
                <h2>Discover the Beauty of your
school-hood</h2>
            </div>
        </div>
    </div>
</div>

<div class="padding-100 section-key-success">
    <div class="container">
        <div class="key-success-inner text-center">
            <h2>SHARE YOUR JOURNEY AT MZS</h2>
            <p>Each alumnus has a story to share. It may be pleasantry or painful. When you through back now. It is always pleasant that you have a significant past life. It is exciting to share your experience with your mates, family, and the next generation. Please do share your story via email to publish <a href="mailto:info@mzs88alumni.com">info@mzs88alumni.com </a> </p>
            <div class="call-center-thumb">
                <img src="assets/alumni_pictures/Mymensingh_Zilla_School_4.jpg" alt="">
            </div>
            <h1>Keys To Our Success</h1>
            <p>When you passed out from MZS, you become part of the global network of innovative people-from industry leader, Physician, Engineer, entrepreneur , government, researcher, and community leader.</p>
			
			 <h1>Our Mission</h1>
			<p>
Your MZS journey goes beyond your studies. After you finished school, you automatically join MZS88 to access events like REUNION, Sharing your success stories, keep connected with your batch mates.Join MZS 88 if you are from 88 Batch. 
			</p>
        </div>
    </div>
</div>
