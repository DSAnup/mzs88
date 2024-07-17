/*
 * custom.js
 *
 * Place your code here that you need on all your pages.
 */

"use strict";

$(document).ready(function(){

	//===== Sidebar Search (Demo Only) =====//
	$('.sidebar-search').submit(function (e) {
		//e.preventDefault(); // Prevent form submitting (browser redirect)

		$('.sidebar-search-results').slideDown(200);
		return false;
	});

	$('.sidebar-search-results .close').click(function() {
		$('.sidebar-search-results').slideUp(200);
	});

	//===== .row .row-bg Toggler =====//
	$('.row-bg-toggle').click(function (e) {
		e.preventDefault(); // prevent redirect to #

		$('.row.row-bg').each(function () {
			$(this).slideToggle(200);
		});
	});

	//===== Sparklines =====//

	$("#sparkline-bar").sparkline('html', {
		type: 'bar',
		height: '35px',
		zeroAxis: false,
		barColor: App.getLayoutColorCode('red')
	});

	$("#sparkline-bar2").sparkline('html', {
		type: 'bar',
		height: '35px',
		zeroAxis: false,
		barColor: App.getLayoutColorCode('green')
	});

	//===== Refresh-Button on Widgets =====//

	$('.widget .toolbar .widget-refresh').click(function() {
		var el = $(this).parents('.widget');

		App.blockUI(el);
		window.setTimeout(function () {
			App.unblockUI(el);
			noty({
				text: '<strong>Widget updated.</strong>',
				type: 'success',
				timeout: 1000
			});
		}, 1000);
	});

	//===== Fade In Notification (Demo Only) =====//
	setTimeout(function() {
		$('#sidebar .notifications.demo-slide-in > li:eq(1)').slideDown(500);
	}, 3500);

	setTimeout(function() {
		$('#sidebar .notifications.demo-slide-in > li:eq(0)').slideDown(500);
	}, 7000);
	
	//=========== Hide the loader ================//
	$(".loader").hide();
	
	
	//========== Make all main nav to ajax links ============//
	 $(".ajaxNav").click(function(e){
    	$(".loader").fadeIn(0);
        e.preventDefault(); //To prevent the default anchor tag behaviour
        var url = this.href;
        $("#mainContent").load(url, function( response, status, xhr ) {
			  if ( status == "error" ) {			    
			    $( "#mainContent" ).html( response );
			  }
			}
			        
        
        );
        $(".loader").fadeOut(1000);
    });
	
	
	
});


function showError(errorMessage){
		document.getElementById("errorMessage").innerHTML = errorMessage;
		document.getElementById("errorDiv").style.display = 'block';
	}
	
	
function showSuccess(successMessage){
	
		noty({
					text: successMessage,
					type: 'success',
					timeout: 2000
				});
	
	}
	
	

	
function hideError(){
	document.getElementById("errorMessage").innerHTML = '';
	document.getElementById("errorDiv").style.display = 'none';
}



//loads the modal window (primariliy for forms)
function loadModal(url, target) {
		
	target.load(url);
	
}

function closeModalForm(){
	$('#formModal').modal('toggle');
}


function showResult(data){
		document.getElementById("result").innerHTML = data;
		
	}


// Search form related ajax call for loading just the result	
function loadSearchResult (objForm, objTarget){
	
	$(".loader").fadeIn(0);
	
	$.ajax({
				data: objForm.serialize(),
				type: objForm.attr('method'),
				url: objForm.attr('action'),				
				success: function(response) {
					
					objTarget.html(response);
					$('#example').addClass( "table-tabletools" );
					$('#example').addClass( "table-columnfilter" );
					$('#example').addClass( "table-checkable" );
					$('#example').addClass( "table-colvis" );
					//$('#example').DataTable();
					
					App.init(); // Init layout and core plugins
					Plugins.init(); // Init all plugins
					FormComponents.init(); // Init all form-specific plugins
				},
				error: function (request, status, error) {			        
			        objTarget.html(request.responseText);
			    }
			}); 
			
	 $(".loader").fadeOut(1000);
		
}
//end of ajax call for form load...


// Load search result - but based on URL only

function loadSearchResultByURL(url){
	
	$('#searchResult').load(url, function( response, status, xhr ) {
			  if ( status == "error" ) {			    
			    $('#searchResult').html( response );
			  }
			  else {
			  	
			  	 $('#example').addClass( "table-tabletools" );
					$('#example').addClass( "table-columnfilter" );
					$('#example').addClass( "table-checkable" );
					$('#example').addClass( "table-colvis" );
					
					
					App.init(); // Init layout and core plugins
					Plugins.init(); // Init all plugins
					FormComponents.init(); // Init all form-specific plugins  
			  	
			  	
			  }
			}
        );		
}


//end of loading by id



// Reload the search result

function reloadSearchResult(){
	
	$('#searchForm').submit();
}


//end of reload the search result


//load content to the main section of the page

function loadMain(url){
	
    	$(".loader").fadeIn(0);
    
        $("#mainContent").load(url, function( response, status, xhr ) {
			  if ( status == "error" ) {			    
			    $( "#mainContent" ).html( response );
			  }
			}			     
        );
        $(".loader").fadeOut(1000);
		
		return false;
	
}

//end of load content for the main section of the page



//this is to refresh the data table - add and edit
function refreshTableRow( dataObject, rowID, action  ){
	
	var oTable = $('#example').dataTable();
	
	if (action == 'Update'){
		
		oTable.fnUpdate( dataObject, document.getElementById(rowID).parentNode.parentNode, undefined , false, false );
		
	}
	
	if (action == 'Create'){
		
		oTable.fnAddData( dataObject, true );
		oTable.fnPageChange( 0 );
		
	}
	
	if (action == 'Delete'){
		
		//make the row as struck off
		document.getElementById(rowID).parentNode.parentNode.style.textDecoration = 'line-through';
		
		//remove the tools and say deleted		
		document.getElementById(rowID).innerHTML = dataObject;
		
		
		
	}
	
	
	
	
}




	