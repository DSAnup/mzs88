//this function needs to calcualate the price and enable the submit button
function calculatePrice(){
		
		
		
        var orderQuantity = Number($('#orderQuantity').val());
        var minimumOrderQuantity = Number($('#minimumOrderQuantity').val());
        var orderDuration = $('#orderDuration').val();
        var priceOption = $('#priceOption').val();
        var LeadPrice = $('#LeadPrice').val();
        var leadFieldID =  Number($('#leadFieldID').val());
        var minimumOrderQuantityAged =  $('#minimumOrderQuantityAged').val();
 
		

        if(isNaN(orderQuantity)){
            $('#errmsg').css('display', 'block');
        }else{
            $('#errmsg').css('display', 'none');
        }
    
        if(orderQuantity < minimumOrderQuantity){
            $('#quntityerror').css('display', 'block');
        }else{
            $('#quntityerror').css('display', 'none');
        }

		
        if((orderQuantity != null && orderQuantity >= minimumOrderQuantity) && orderDuration != "" || (orderQuantity != null && minimumOrderQuantityAged) && orderDuration != ""){
            
            $('#priceInstruction').css('display', 'none');
            $('#priceDisplay').css('display', 'block');
            $('#nextButton').prop('disabled', false);
	
			var Exclusive = 0;
			
			$(".form-group input[type=checkbox]:checked").each(function () {
				 Exclusive += Number($('#LeadFieldID_'+this.value+'_price').val());
			});

			if ($('input#leadFieldID').is(':checked')) {
				result = orderQuantity *(Number(LeadPrice) + Exclusive) * orderDuration;
				price.innerHTML = result.toFixed(2);
			}else {	
				result = orderQuantity * LeadPrice * orderDuration;
				price.innerHTML = result.toFixed(2);
			}
            if ((orderQuantity != null )) {
			
                if (orderQuantity == "" ) {
                	$('#priceInstruction').css('display', 'block');
                    $('#priceDisplay').css('display', 'none');
                }
		
                if(orderDuration != "" ){
                    //$('#priceInstruction').css('display', 'none');
                    //$('#priceDisplay').css('display', 'block');				
                    $('#nextButton').prop('disabled', false);
                }else {
                    $('#priceInstruction').css('display', 'block');
                    $('#priceDisplay').css('display', 'none');
                }

                var Exclusive = 0;
                $(".form-group input[type=checkbox]:checked").each(function () {
                    Exclusive += Number($('#LeadFieldID_'+this.value+'_price').val());
                });

                if ($('input#leadFieldID').is(':checked')) {
					result = orderQuantity *(Number(LeadPrice) + Exclusive);
					finalResult = result * orderDuration;
                    var pricemax = '';
                     
                    if(finalResult >= minimumOrderQuantityAged){
                        $('#pricemin').css('display', 'none');
                        //finalResult = orderQuantity *(Number(LeadPrice) + Exclusive) * orderDuration;
                        price.innerHTML = finalResult.toFixed(2);
						$('#nextButton').prop('disabled', false); //new line added
						//console.log('Block upper big');
                    }else {
                        $('#pricemin').css('display', 'block');
                        $('#priceDisplay').css('display', 'none');
						//document.getElementById("pricemax").innerHTML = 'You have to order minimum amount <strong>$'+minimumOrderQuantityAged+'</strong> per day';
                        pricemax.innerHTML = 'You have to order minimum amount <strong>$'+minimumOrderQuantityAged+'</strong> per day';
                        $('#nextButton').prop('disabled', true);
                    }
                }else {	
                    result = orderQuantity * LeadPrice;
					finalResult = result * orderDuration;
                    var pricemax = '';
       
                    
                    if(finalResult >= minimumOrderQuantityAged){
                        $('#pricemin').css('display', 'none');
                        //finalResult = orderQuantity * LeadPrice * orderDuration;
                        price.innerHTML = finalResult.toFixed(2);
						//console.log('Block lower big');

                    }else {
                        $('#pricemin').css('display', 'block');
                        $('#priceDisplay').css('display', 'none');
                        pricemax.innerHTML = 'You have to order minimum amount <strong>$'+minimumOrderQuantityAged+'</strong> per day';
                        $('#nextButton').prop('disabled', true);

                    }
                }
                    
				if (orderQuantity != null && orderDuration != "" ) {
                    $('#priceInstruction').css('display', 'none');
                    $('#priceDisplay').css('display', 'block')
				}
            }

            $('.optional_details input[type=checkbox]').on('click', function() {
                var $this = $(this);
                if ($this.is(".fbank")) {
                    if ($(".fbank:checked").length > 0) {
                        $(".fspecificbank").prop({ checked: false });
                    } else {
                        $('#national').css('display', 'none');
                    }
                }
                if ($this.is(".fspecificbank")) {
                    if ($(".fspecificbank:checked").length > 0) {
                        $(".fbank").prop({ checked: false });
                    } else {
                        $('#national').css('display', 'none');
                    }
                }
                
            }); 
            
            if ($(".fspecificbank:checked").length > 0) {

                $(".specificbanks").css("display", "block");
                $(".selectLabel").css("display", "block");
                $('#nextButton').prop('disabled', true);
                    
                    $("select#specificBank[multiple]").on('change', function (e) {
                    
                        
                        if (parseInt($(this).find("option:selected").length) < 3 ) {
                            $('#nextButton').prop('disabled', true);
                            $('#national').css('display', 'block');
    
    
                        }
                        if (parseInt($(this).find("option:selected").length) >= 3 ) {
                            $('#nextButton').prop('disabled', false);
                            $('#national').css('display', 'none');
    
                        }
    
                    });		
                    
                
                
            }else{
                $(".specificbanks").css("display", "none");
                $(".selectLabel").css("display", "none");
                let searchParams = new URLSearchParams(window.location.search);
				let param = searchParams.get('leadtype');
				if(param != 'Aged'){
					$('#nextButton').prop('disabled', false);
					//console.log(param);
				}
                
            }
		//var initialValue = orderQuantity * LeadPrice * orderDuration;
		   initialValue = orderQuantity *(Number(LeadPrice) + Exclusive) * orderDuration;
			if(initialValue.toFixed(0) <= parseInt(minimumOrderQuantityAged)){
				$('#nextButton').prop('disabled', true);
			}    
        } else {

            //console.log("It's not Working");
            $('#priceInstruction').css('display', 'block');
            $('#priceDisplay').css('display', 'none');
            $('#pricemin').css('display', 'block');
            $('#nextButton').prop('disabled', true);
        }
        
        
        $('#totalPrice').val( $('#price').html() );
    
    
		return true;
	
}
	
//orderQuantity orderDuration orderDuration

//price = no of leads (price of lead + any optional items selected) number of weeks

