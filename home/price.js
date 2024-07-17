//this function needs to calcualate the price and enable the submit button

function to5DaysWeek(days) {
    let week = days / 5;
    
    if(week == 1){
      return res = week + " week";
    }else if( week > 1){
      return res = week + " weeks";
    }else{
      return days;
    }
}

function calculatePrice(){

    var orderQuantity = Number($('#orderQuantity').val());
	var orderDuration = $('#orderDuration').val();
	var priceOption = $('#priceOption').val();
	var LeadPrice = Number($('#LeadPrice').val());
	var leadFieldID =  Number($('#leadFieldID').val());
	// var minimumOrderQuantity = Number($('#minimumOrderQuantity').val());
	var minimumOrderQuantityAged =  Number($('#minimumOrderQuantityAged').val());
	var minimumOrderQuantityExclusive =  Number($('#minimumOrderQuantity').val());

	var SpecialOfferPercentage =  Number($('#SpecialOfferPercentage').val());
	var MinSpecialOfferDuration =  Number($('#MinSpecialOfferDuration').val());	
	var MaxSpecialOfferDuration =  Number($('#MaxSpecialOfferDuration').val());	
	
	
	
	var $SpecialPriceMsg = $('#specialPriceMsg');
	var $totalMain = $('#totalMain');
	var $savedAmount = $('#savedAmount');

    var searchParams = new URLSearchParams(window.location.search);
    var leadType = searchParams.get('leadtype');

	var priceReduced = 0;
	var regularPrice = 0;
    var specialOfferMessage = "";

    var isValidationFailed = false;


	// Order Quantity Validation
    if(isNaN(orderQuantity)){
        $('#errmsg').css('display', 'block');
    }else{
        $('#errmsg').css('display', 'none');
    }

    // fspecific Bank
    if ($("#fspecificbank").is(':checked') ) {
        $(".specificbanks").css("display", "block");
        $(".selectLabel").css("display", "block");
    }else{
        $(".specificbanks").css("display", "none");
        $(".selectLabel").css("display", "none");   
    }

    // Specific Bank
    if ($('#fspecificbank').is(':checked')) {
        if (parseInt($('#specificBank').find("option:selected").length) < 3) {
            // $('#nextButton').prop('disabled', true);
            isValidationFailed = true;
            $('#national').css('display', 'block');
        }else{
            $('#national').css('display', 'none');
        }
    }
    
    if(     orderQuantity != null && orderQuantity != "" &&  orderDuration != "" 
        && ( minimumOrderQuantityExclusive || minimumOrderQuantityAged ) 
        && leadType != null
        ){
		// If Exclusive or Aged

        var Exclusive = 0;
        var pricemax = '';		
		
        $(".form-group input[type=checkbox]:checked").each(function () {
            Exclusive += Number($('#LeadFieldID_'+this.value+'_price').val());
        });
        
        result = orderQuantity * orderDuration * (Number(LeadPrice) + Exclusive);
		    regularPrice = result;
		//Check Special Offer Price
		/*
		if(!isNaN(SpecialOfferPercentage)){
			if( SpecialOfferPercentage > 0 && !isNaN(MinSpecialOfferDuration) && !isNaN(MaxSpecialOfferDuration)){			
				if( orderDuration >= MinSpecialOfferDuration && orderDuration <= MaxSpecialOfferDuration){
					// e.g. if 30%, it means special price = original price * 0.70
					// 30% => 30 / 100 => 0.3 
					// 1 - 0.3 => 0.7
					let regularPrice = result;
					result = result * ( 1 - (SpecialOfferPercentage / 100) );
					$SpecialPriceMsg
						.html(' <br><small style="font-weight: normal;"><i>( ' +SpecialOfferPercentage+ '% discount from regular price $' +regularPrice.toFixed(2)+ ' ) </i></small>')
						.css('display', 'block');
				}
			}
		}
		*/
		// Special Offer validation
		if( !isNaN(SpecialOfferPercentage) && SpecialOfferPercentage > 0 && !isNaN(MinSpecialOfferDuration) && !isNaN(MaxSpecialOfferDuration)){
			if( orderDuration < MinSpecialOfferDuration ){
				
				$('#specialOfferWarning')
					.removeClass('alert-success')
					.addClass('alert-warning');
				
			}else if( orderDuration > MaxSpecialOfferDuration ){
				
				$('#specialOfferWarning')
					.removeClass('alert-success')
					.addClass('alert-warning');
			
			}else{
				//regularPrice = result;
				result = result * ( 1 - (SpecialOfferPercentage / 100) );				
				priceReduced = regularPrice - result;
						
				$('#specialOfferWarning')
					.removeClass('alert-warning')
					.addClass('alert-success');
			}
			
			$SpecialPriceMsg
				.html(
					   priceReduced==0?
					   	'':[
							'<br><small style="font-weight: normal;">',
								'<i>', 
									'saved <span style="font-size: x-large;"<strong>$'+priceReduced.toFixed(2)+'</strong></span> (' + 
									SpecialOfferPercentage + '% discount from regular price $' + regularPrice.toFixed(2) + ')', 
								'</i>',
							'</small>'
						].join('')
				)
				.css('display', 'block');
			 $totalMain
				.html(
					   '$' + [regularPrice.toFixed(2)].join('')
				)
				.css('display', 'block');
			 $savedAmount
				.html(
					   priceReduced==0?
					   	'$0':[
							
								'<i>', 
									'(@' + SpecialOfferPercentage + '%) <span><strong>$' + priceReduced.toFixed(2)+ '</strong></span>', 
								'</i>'
						].join('')
				)
				.css('display', 'block');
			
		}	

		
        price.innerHTML = result.toFixed(2);
		
		// Usual validation
        if( leadType == 'Exclusive' || leadType == 'Hour24'){
            if( orderQuantity >= minimumOrderQuantityExclusive ){
                $('#quntityerror').css('display', 'none');
            }else{
                $('#quntityerror').css('display', 'block');
                isValidationFailed = true;
            }
        }else if( leadType == 'Aged' ){            
            if( result >= minimumOrderQuantityAged ){            
                $('#pricemin').css('display', 'none');
                price.innerHTML = result.toFixed(2) + specialOfferMessage;
            }else {
                $('#pricemin').css('display', 'block');
                pricemax.innerHTML = 'You have to order minimum amount <strong>$'+minimumOrderQuantityAged+'</strong> per day';
                isValidationFailed = true;
            }
        }		
				


		

        $('#priceInstruction').css('display', 'none');
        $('#priceDisplay').css('display', 'block');

    } else {        

        if( leadType == 'Exclusive' || leadType == 'Hour24'){
            if(orderQuantity >= minimumOrderQuantityExclusive){
                $('#quntityerror').css('display', 'none');
            }else{
                $('#quntityerror').css('display', 'block');
            }
        }else if( leadType == 'Aged' ){
            $('#pricemin').css('display', 'block');
        }

        $('#priceInstruction').css('display', 'block');
        $('#priceDisplay').css('display', 'none');
        // $('#nextButton').prop('disabled', true);
        isValidationFailed = true;
    }

    if (isValidationFailed) {
        $('#nextButton').prop('disabled', true);
    } else {
        $('#nextButton').prop('disabled', false);
    }

    $('#totalPrice').val(regularPrice);
    $('#DiscountedPrice').val($('#price').html());

    return true;
}

//orderQuantity orderDuration orderDuration

//price = no of leads (price of lead + any optional items selected) number of weeks

