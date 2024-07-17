


<cfoutput>

	<table class="table table-striped">
		<thead>
			<tr>
				<th colspan="2">Client Information </th>
			</tr>
		</thead>
		<tbody>
			<cfif trim(session.profile.client.BusinessName) gt "">
				<tr>
					<td>Business Name</td>
					<td class="information">#session.profile.client.BusinessName#</td>
				</tr>
			</cfif>
			<tr>
				<td>Full Name</td>
				<td class="information">#session.profile.client.FirstName# 
						#session.profile.client.LastName#</td>
			</tr>
			<tr>
				<td>Email</td>
				<td class="information">#session.profile.client.Email#</td>
			</tr>
			<tr>
				<td>Skype ID</td>
				<td class="information">#session.profile.client.SkypeID#</td>
			</tr>
			<tr>
				<td>Phone</td>
				<td class="information">#session.profile.client.Phone#</td>
			</tr>
			<tr>
				<td>Address</td>
				<td class="information">
					#session.profile.client.Address1#,
					<cfif session.profile.client.Address2 gt ''>
						#session.profile.client.Address2#,
					</cfif>
					#session.profile.client.City#, #session.profile.client.State#
					#session.profile.client.ZipCode#, #session.profile.client.CountryName#
					
					
				</td>
			</tr>
		</tbody>
	</table>
	
	<table class="table table-striped">
		<thead>
			<tr>
				<th colspan="2">Shipping Information </th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>Delivery Email</td>
				<td class="information">#session.profile.client.DeliveryEmail#</td>
			</tr>
			
		</tbody>
	</table>
</cfoutput>