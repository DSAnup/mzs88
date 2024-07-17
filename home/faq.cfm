
  <cfquery datasource="#request.dsnameReader#" name="qFaqSelect"> 
      SELECT *
        FROM Faq   
       WHERE IsActive = 1   
          ORDER by Priority
  </cfquery>
<!-- main-container start -->
<!-- ================ -->
<cfoutput>
<section class="main-container">

	<div class="container">
		<div class="row">

			<!-- main start -->
			<!-- ================ -->
			<div class="main col-md-12">

				<!-- page-title start -->
				<!-- ================ -->
				<h1 class="page-title">FAQ</h1>
				<!-- page-title end -->
				<div class="row">
					<div class="col-md-12">
		
						<div class="faq-area">
		
		
							<div id="page-wrap">
							
							  <h2 id="top">Questions</h2>
							  
							
								<div class="question-block">
								  <ul id="nav">
								  	<cfset counter = 0>
									<cfloop query="qFaqSelect">
										<cfset counter = counter + 1>
										<li><a href="##faq#counter -1#">#counter#. #replaceNoCase(qFaqSelect.Question, chr(13), "<br>", "all")#</a></li>
									</cfloop>
								  </ul>
								</div>
							
							
								<div  id="faq0" class="answer-block">
									<h2 >Answers</h2>
									<cfset counter = 0>
									<cfloop query="qFaqSelect">	
											<cfset counter = counter + 1>									
											<div class="single-faq" id="faq#counter#">
												<h2>#counter#. #qFaqSelect.Question#</h2>
												<p>#replaceNoCase(qFaqSelect.Answer, chr(13), "<br>", "all")#</p>
											</div>										
									</cfloop>
					

								</div>
								
								
							
							</div>
		
						</div>
					</div>

				</div>
			</div>
			<!-- main end -->
			
		</div>
	</div>
</section>
<!-- main-container end -->
</cfoutput>

<script>



jQuery( document ).ready(function() {
var nav = $('#nav');
if (nav.length) {
	var contentNav = nav.offset().top;
	$('#nav').onePageNav({
		filter: ':not(.external)'
	});
}
});

</script>