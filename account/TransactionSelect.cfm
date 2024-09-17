<cfif session.profile.isLoggedIn eq false AND url.area neq "login">			
		<cflocation url="/?area=home&action=loginorSignin" addtoken="false" >			
</cfif>
	
	<cfquery datasource="#request.dsnameReader#" name="qTransactionSelect"> 
		SELECT TD.*, A.ACCOUNTNAME	   
		FROM TransactionDetails AS TD
			LEFT JOIN Account AS A ON A.AccountID = TD.AccountID;
	</cfquery>
	
<!-- main-container start -->
<!-- ================ -->
<section class="main-container">

	<div class="container">
		<div class="row">

			<!-- main start -->
			<!-- ================ -->
			<div class="main col-md-12">
				
				<!---title and description of the main section title --->

				<!-- page-title start -->
				<!-- ================ -->
				<div class="row">
					<div class="col-md-8">
						<h2 class="page-title">Transaction List</h2>
					</div>
					<div class="col-md-2">
						<a id="formOption" class="btn btn-success btn-signup" href="index.cfm?area=account&action=CreditInsert">Add Fund</a>
					</div>
					<div class="col-md-2">
						<a id="formOption" class="btn btn-success btn-signup" href="index.cfm?area=account&action=DebitInsert">Add Expense</a> 
					</div>
				</div>
				<!-- page-title end -->
				
				<table id="applicant" class="display table table-hover table-striped" style="width:100%">
					<thead>
						<tr>
							<th>Account Name</th>
							<th>Expense</th>
							<th>Funding</th>
							<th>Transaction Date</th>
							<th>Note</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
					
					<cfoutput query="qTransactionSelect">
						<tr>
							<td>#qTransactionSelect.ACCOUNTNAME#</td>
							<td>#qTransactionSelect.Debit#</td>
							<td>#qTransactionSelect.Credit#</td>
							<td>#DateFormat(qTransactionSelect.TransactionDate, "yyyy-mm-dd")#</td>
							<td>#qTransactionSelect.Note#</td>
							<td>
								<cfif qTransactionSelect.Debit gt 0>
									<a href="index.cfm?area=account&action=DebitInsert&TransactionID=#qTransactionSelect.TransactionID#">Update</a>
								<cfelse>
									<a href="index.cfm?area=account&action=CreditInsert&TransactionID=#qTransactionSelect.TransactionID#">Update</a>
								</cfif>
							</td>
						</tr>
					</cfoutput>	
				
					</tbody>
				</table>

			<div class="clearfix"></div>

				

			</div>
			<!-- main end -->

		</div>
	</div>
</section>
<!-- main-container end -->

<script language="javascript">
	$(document).ready(function() {
			$('#applicant').DataTable();
		} );
</script>
