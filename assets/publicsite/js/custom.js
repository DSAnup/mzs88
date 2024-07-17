/* Theme Name:iDea - Clean & Powerful Bootstrap Theme
 * Author:HtmlCoder
 * Author URI:http://www.htmlcoder.me
 * Author e-mail:htmlcoder.me@gmail.com
 * Version: 1.2.1
 * Created:October 2014
 * License URI:http://support.wrapbootstrap.com/
 * File Description: Place here your custom scripts
 */
 
 
 
 /*
 * form_validation.js
 *
 * Demo JavaScript used on Validation-pages.
 */

"use strict";

$(document).ready(function(){

	//===== Validation =====//
	// @see: for default options, see assets/js/plugins.form-components.js (initValidation())

	$.extend( $.validator.defaults, {
			
			 
		invalidHandler: function(form, validator) {
			var errors = validator.numberOfInvalids();
			if (errors) {
				var message = errors == 1
				? 'You missed 1 field. It has been highlighted.'
				: 'You missed ' + errors + ' fields. They have been highlighted.';
				
			}
		},
		errorPlacement: function(error, element) {
			 if (element.attr('type') === "file" && element.data('style') === "fileinput"){
				 error.appendTo(element.closest("div.fileinput-holder").parent('div'));
			 } else {
				 error.insertAfter(element)
			 }			 
		},
		
		errorElement: "span",
		
		highlight: function (element) {
					$(element).parent().removeClass("has-success").addClass("has-error");
					//$(element).siblings("label").addClass("hide"); 
				},
				
				
		success: function (element) {
			$(element).parent().removeClass("has-error").addClass("has-success");
			//$(element).siblings("label").removeClass("hide"); 
		}
						  
		
		
	});

	$("#validate-1").validate();
	$("#validate-2").validate();
	$("#validate-3").validate();
	$("#validate-4").validate();

});




/*function calculateTotal() {
	
    var updatePrice = Number($('#updatePrice').val());
	alert(updatePrice);
    var divobj = document.getElementById('promocodefields');
    divobj.style.display='none';
    divobj.innerHTML = "Estimated Transfer Fees $"+titleFees;

}*/