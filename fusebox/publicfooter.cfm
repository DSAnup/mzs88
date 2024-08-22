
<!--- <cfif session.isDebugMode eq true>
	<iframe id="formpost" name="formpost" height="800" style="width:100%; display: block; margin-top:20px; visibility: visible;"></iframe> 
<cfelse>
	<iframe id="formpost" name="formpost" height="800" style="width:100%; display: block; margin-top:20px; visibility: visible;"></iframe> 
</cfif> --->

<cfif session.isDebugMode eq true>
	<iframe id="formpost" name="formpost" height="800" style="width:100%; display: block; margin-top:20px;"></iframe> 
<cfelse>
	<iframe id="formpost" name="formpost" style="width:1px; height:1px; display: none; margin-top:0px;"></iframe> 	
</cfif>
<!-- footer start (Add "light" class to #footer in order to enable light footer) -->
			<!-- ================ -->
			<footer id="footer">

				<!-- .footer start -->
				<!-- ================ -->
				<div class="footer">
					<div class="container">
						<div class="row">
							<div class="col-md-7">
								<div class="footer-content">
									<div class="logo-footer"><img id="logo-footer" src="assets/logo.png" alt=""></div>
									
								</div>
							</div>
							<div class="space-bottom hidden-lg hidden-xs"></div>
							
							
							
							<!---our flicker --->
							<div class="col-sm-10 col-md-5">
								<div class="footer-content">
								
											<h2>MYMENSINGH ZILLA SCHOOL 88 ALUMNI</h2>
											<ul class="list-icons">
												<li><i class="fa fa-map-marker pr-10"></i> Zilla School Field, Zilla School Rd, Mymensingh</li>
												<li><i class="fa fa-envelope-o pr-10"></i> reunion@mzs88alumni.com</li>
											</ul>
											

								</div>
							</div>
						</div>
						<div class="space-bottom hidden-lg hidden-xs"></div>
					</div>
				</div>
				<!-- .footer end -->

				<!-- .subfooter start -->
				<!-- ================ -->
				<div class="subfooter">
					<div class="container">
						<div class="row">
							<div class="col-md-6">
								<p>Copyright &copy; mzs88alumni. All Rights Reserved</p>
							</div>
							<div class="col-md-6">
								<nav class="navbar navbar-default" role="navigation">
									<!-- Toggle get grouped for better mobile display -->
									<div class="navbar-header">
										<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse-2">
											<span class="sr-only">Toggle navigation</span>
											<span class="icon-bar"></span>
											<span class="icon-bar"></span>
											<span class="icon-bar"></span>
										</button>
									</div>   
									<div class="collapse navbar-collapse" id="navbar-collapse-2">
										
												
										<ul class="nav navbar-nav">
											<li><a href="/">Home</a></li>
											<li><a href="index.cfm?area=home&action=contactus">Contact</a></li>
										</ul>
										
									</div>
								</nav>
							</div>
						</div>
					</div>
				</div>
				<!-- .subfooter end -->

			</footer>
			<!-- footer end -->

		</div>
		<!-- page-wrapper end -->

		<!-- JavaScript files placed at the end of the document so the pages load faster
		================================================== -->
		

		<!-- Modernizr javascript -->
		<script type="text/javascript" src="assets/publicsite/plugins/modernizr.js"></script>

		<!-- jQuery REVOLUTION Slider  -->
		<script type="text/javascript" src="assets/publicsite/plugins/rs-plugin/js/jquery.themepunch.tools.min.js"></script>
		<script type="text/javascript" src="assets/publicsite/plugins/rs-plugin/js/jquery.themepunch.revolution.min.js"></script>

		<!-- Isotope javascript -->
		<script type="text/javascript" src="assets/publicsite/plugins/isotope/isotope.pkgd.min.js"></script>

		<!-- Owl carousel javascript -->
		<script type="text/javascript" src="assets/publicsite/plugins/owl-carousel/owl.carousel.js"></script>

		<!-- Magnific Popup javascript -->
		<script type="text/javascript" src="assets/publicsite/plugins/magnific-popup/jquery.magnific-popup.min.js"></script>

		<!-- Appear javascript -->
		<script type="text/javascript" src="assets/publicsite/plugins/jquery.appear.js"></script>

		<!-- Count To javascript -->
		<script type="text/javascript" src="assets/publicsite/plugins/jquery.countTo.js"></script>

		<!-- Parallax javascript -->
		<script src="assets/publicsite/plugins/jquery.parallax-1.1.3.js"></script>

		<!-- Contact form -->
		<script src="assets/publicsite/plugins/jquery.validate.js"></script>

		<!-- Initialization of Plugins -->
		<script type="text/javascript" src="assets/publicsite/js/template.js"></script>
		<script src="/assets/publicsite/toastr/toastr.min.js"></script>
		
		<!-- Custom Scripts -->
		<script type="text/javascript" src="assets/publicsite/js/custom.js"></script>
		
		
		<script type="text/javascript" src="assets/publicsite/js/custom-notification.js"></script>
		<script type="text/javascript" src="assets/js/onepagenav.js"></script>
		<script type="text/javascript" src="assets/js/datatables.min.js"></script>

<!---     <script src='https://www.google.com/recaptcha/api.js'></script> --->
	
	
	
	
	<script>
			<!--- notification message --->
	<cfif isDefined("session.OnLoadMessage") and session.OnLoadMessage gt "">
		<cfoutput>

			window.onload = (event) => {
				toastr.#session.OnLoadMessage#;
			};
			
		
	
		</cfoutput>
		
		<cfset session.OnLoadMessage = "">
		
	</cfif>
		$(document).ready(function() {
			$('#alumni').DataTable();
		} );
	/*  ==========================================
		SHOW UPLOADED IMAGE
	* ========================================== */
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
	
			reader.onload = function (e) {
				$('#imageResult')
					.attr('src', e.target.result);
			};
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	$(function () {
		$('#Picture').on('change', function () {
			readURL(input);
		});
	});
	
	/*  ==========================================
		SHOW UPLOADED IMAGE NAME
	* ========================================== */
	var input = document.getElementById( 'Picture' );
	var infoArea = document.getElementById( 'upload-label' );
	
	input.addEventListener( 'change', showFileName );
	function showFileName( event ) {
	  var input = event.srcElement;
	  var fileName = input.files[0].name;
	  infoArea.textContent = 'File name: ' + fileName;
	}
	
	
	
	
		function verifyCaptcha() {
			document.getElementById('g-recaptcha-error').innerHTML = '';
			$('.btn-disabled').prop("disabled", false);
		}
		

		$('#confirmButton').prop('disabled', true);
		
		$(".disabled").hover(function () {
			$('.checkterms').toggleClass("checktermshover");
		});
			
		function check() {
			var checkBox = document.getElementById("termsconfirm");
			if (checkBox.checked) {
				$('#confirmButton').prop('disabled', false);
				$("#checkterms").removeClass("checkterms");
			} else {
				$('#confirmButton').prop('disabled', true);
				$("#checkterms").addClass("checkterms");
			}
		}
		//window.onload = check;
     function resetPass() {
        // Hide login elements
        $("#loginarea").slideUp(250);
        // Show signup elements
        $("#forgetpass").slideDown(250);  

	}	
	function goBack() {
		// Hide login elements
		$("#forgetpass").slideUp(250);
		// Show signup elements
		$("#loginarea").slideDown(250);  

	}	

	


	
	
	
	
	
	
	
	</script>		
	
	
<!---	<script>
		jQuery(function($) { 
			$('#privaceytext').on('scroll', function() { 
				if ($(this).scrollTop() + 
					$(this).innerHeight() >=  
					$(this)[0].scrollHeight) { 
					
					$( "#termsconfirm" ).prop( "disabled", false );
				} 
			}); 
		});
	</script>--->

	</body>
</html>


