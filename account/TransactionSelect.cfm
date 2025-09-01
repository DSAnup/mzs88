<cfif session.profile.isLoggedIn eq false AND url.area neq "login">			
		<cflocation url="/?area=home&action=loginorSignin" addtoken="false" >			
</cfif>
	<cfquery datasource="#request.dsnameReader#" name="qTransactionSelect"> 
		SELECT TD.*, A.ACCOUNTNAME, CONCAT(AU.NameInEnglish, ' (', AU.NickName, ')' ) AS SourceName,
		AU2.NameInEnglish 'CreatedByName'
		FROM TransactionDetails AS TD
			LEFT JOIN Account AS A ON A.AccountID = TD.AccountID
			LEFT JOIN AppUser AS AU ON AU.AppUserID = TD.SourceUserID

			join AppUser as au2 on au2.AppUserID = TD.CreatedBy
		WHERE TD.AccountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.AccountID#">
		ORDER BY TD.TransactionID DESC;
	</cfquery>

	<cfquery dbtype="query" name="qSummary">

		select sum(credit) Credit,  sum(debit) Debit
			from qTransactionSelect
	</cfquery>
	
<!-- main-container start -->
<!-- ================ -->
<section class="main-container">

	
	
	<div class="container">
		<div class="row">

			

			<!-- main start -->
			<!-- ================ -->
			<div class="main col-md-12">

				<h3>

				<cfif qTransactionSelect.recordCount gt 0>

				<cfoutput>
					<table width="100%">
						<tr>
							<td >In - #qSummary.credit#</td>
							<td>Out - #qSummary.debit#</td>
							<td>Balance - #qSummary.credit - qSummary.debit#</td>
						</tr>
				
					</table>
				</cfoutput>
			</cfif>

			</h3>
				
				<!---title and description of the main section title --->

				<!-- page-title start -->
				<!-- ================ -->
				<div class="row">
					<div class="col-md-8">
						<h2 class="page-title">Transaction List - 
							<cfoutput>#qTransactionSelect.ACCOUNTNAME#</cfoutput></h2>
					</div>
					<div class="col-md-2">
						<a id="formOption" class="btn btn-success btn-signup" href="index.cfm?area=account&action=CreditInsert&AccountID=<cfoutput>#url.AccountID#</cfoutput>">Add Fund</a>
					</div>
					<div class="col-md-2">
						<a id="formOption" class="btn btn-success btn-signup" href="index.cfm?area=account&action=DebitInsert&AccountID=<cfoutput>#url.AccountID#</cfoutput>">Add Expense</a> 
					</div>
				</div>
				<cfset currentDate = Now()>
				<!-- page-title end -->
				
				<table id="applicant" class="display table table-hover table-striped" style="width:100%">
					<thead>
						<tr>
							<th>Account Name</th>
							<th>Expense</th>
							<th>Funding</th>
							<th>Transaction Date</th>
							<th>Source</th>
							<th>Note</th>
							<th>Entered By</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
					
					<cfoutput query="qTransactionSelect">
						<cfset transactionDate = qTransactionSelect.TransactionDate>
						<cfset daysDifference = DateDiff("d", qTransactionSelect.DateCreated, Now())>
						<tr>
							<td>#qTransactionSelect.ACCOUNTNAME#</td>
							<td>#qTransactionSelect.Debit#</td>
							<td>#qTransactionSelect.Credit#</td>
							<td>#DateFormat(qTransactionSelect.TransactionDate, "yyyy-mm-dd")#</td>
							<td>
								<cfif qTransactionSelect.SourceUserID gt 1>
									#qTransactionSelect.SourceName#
								<cfelse>
									#qTransactionSelect.SourceFromOthers#
								</cfif>
							</td>
							<td>
								<cfif qTransactionSelect.Credit gt 1 or qTransactionSelect.Debit gt 1>
									#qTransactionSelect.Note#
								</cfif>
							</td>
							<td>
								#qTransactionSelect.CreatedByName#
							</td>
							<td>
								<cfif daysDifference lte 3>
									<cfif qTransactionSelect.Debit gt 0>
										<a href="index.cfm?area=account&action=DebitInsert&TransactionID=#qTransactionSelect.TransactionID#">Update</a>
									<cfelse>
										<a href="index.cfm?area=account&action=CreditInsert&TransactionID=#qTransactionSelect.TransactionID#">Update</a>
									</cfif>
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
