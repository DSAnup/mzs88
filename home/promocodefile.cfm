

<cfoutput>

<table class="table cart table-hover table-striped">
	<thead>
		<tr>
			<th>Promo Code </th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
		</tr>
	</thead>
	<tbody>
	
		<tr class="remove-data">
			
			<cfif isDefined ("session.Cart.PromoCode") and session.Cart.PromoCode gt "">
				
				<td class="promocodetext" colspan="5" style="width: 50%;">
					Promo Code <b>#session.Cart.PromoCode#</b> has been applied to this purchase. 
				</td>
				 
					
				
			
			
			<!---this is when a special offer is already applied --->
			<cfelseif session.Cart.DiscountPercentage gt 0 and findNoCase ('PromoCode', session.Cart.DiscountNote) eq 0 >
				<td class="promocodetext" colspan="3" style="width: 50%;">
					Promo Code can not be applied together with a special offer.
				</td>
				 
					<td class="promocode" style="width: 30%;">
						<input class="form-control required"  type="text" placeholder="Promo Code" disabled=""  />									
					</td>
					
					<td class="promocodebtn" style="width: 10%;">
						<input type="hidden" name="leadtype" value="#url.leadtype#" />
						<button type="submit" class="btn btn-promocde" style="margin: 0; background: ##666;color: ##fff;" disabled="">Apply Code</button>
					</td>
					
			<cfelse>
				<td class="promocodetext" colspan="3" style="width: 50%;">
					If you have a promo code, please provide it in the box and click "Apply Code".
					</td>
					
					<form action="partialIndex.cfm?area=home&action=promoCodeAction"  method="post"  target="formpost" >   
						<td class="promocode" style="width: 30%;">
							<input class="form-control required" id="promocode" name="promocode" type="text" placeholder="Promo Code"  />									
						</td>
						
						<td class="promocodebtn" style="width: 10%;">
							<input type="hidden" name="leadtype" value="#url.leadtype#" />
							<button type="submit" class="btn btn-promocde" style="margin: 0; background: ##666;color: ##fff;">Apply Code</button>
						</td>
					</form>			
			</cfif>		
		</tr>						
	</tbody>
</table>
</cfoutput>
	