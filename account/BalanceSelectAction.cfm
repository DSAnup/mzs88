
<cfset session.AccountID = form.AccountID>
<cfset session.isClosed = form.isClosed>



<cfquery datasource="#request.dsnameReader#" name="qBalanceReport"> 
    SELECT A.AccountID, A.AccountName,
    ROUND(SUM(TD.Debit), 2) AS Debit,
    ROUND(SUM(TD.Credit), 2) AS Credit
    FROM TransactionDetails AS TD
        LEFT JOIN Account AS A ON A.AccountID = TD.AccountID	
    
    WHERE 1=1
    <cfif trim(form.AccountID) neq "">
        AND TD.AccountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.AccountID#">
    </cfif>

    <cfif trim(form.isClosed) neq "">
        AND A.isClosed = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.isClosed#">
    </cfif>

    <cfif trim(form.dateFrom) neq "" and trim(form.dateTo) neq "">
        AND TD.TransactionDate BETWEEN 
                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.dateFrom# 00:00:00">
            AND <cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.dateTo# 23:59:59">
    </cfif>
    GROUP BY A.AccountID, A.AccountName
    ORDER BY A.AccountID
</cfquery>



<cfoutput>
	<div id="searchResult">
        <div class="row">
            <div class="col-12">
                <cfoutput>
                    <div class="container table-responsive">
                        <table id="datatable" class="table table-striped table-bordered" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>SL.</th>
                                    <th>Account Name</th>
                                    <th>Funding</th>
                                    <th>Expense</th>
                                    <th>Balance</th>
                                </tr>
                            </thead>
                
                            <tbody>
                            <cfset index = 0>
                            <cfset grandTotalBalance = 0>
                            <cfset grandTotalDeposit = 0>
                            <cfset grandTotalSpend = 0>
                            <cfloop query="qBalanceReport">
                                <cfset index = index + 1>
                                <tr>
                                    <td>
                                        #index#
                                    </td>
                                    
                                    <td>
                                        #qBalanceReport.ACCOUNTNAME#
                                    </td>
                                    <td>
                                        #dollarFormat(qBalanceReport.Credit)#
                                        <cfset grandTotalDeposit = grandTotalDeposit + qBalanceReport.Credit>
                                    </td>
                                    <td>
                                        #dollarFormat(qBalanceReport.Debit)#
                                        <cfset grandTotalSpend = grandTotalSpend + qBalanceReport.Debit>
                                    </td>
                                    <td>
                                        #dollarFormat(qBalanceReport.Credit - qBalanceReport.Debit)#
                                        <cfset grandTotalBalance = grandTotalBalance + (qBalanceReport.Credit-qBalanceReport.Debit)>
                                    </td>
                                </tr>
                            </cfloop>

                            
                            
                            </tbody>
                            <th>
                                
                                <td>Total</td>
                                <td>#dollarFormat(grandTotalDeposit)#</td>
                                <td>#dollarFormat(grandTotalSpend)#</td>
                                <td>#dollarFormat(grandTotalBalance)#</td>

                            </th>
                        </table>
                    </div>		
                </cfoutput>

           </div>
        </div>
    </div>
</cfoutput>

<script lang="javascript">  
    window.parent.document.getElementById('alert').innerHTML  = '' ;
    window.parent.document.getElementById('searchResultContainer').innerHTML  = document.getElementById('searchResult').innerHTML ;  	
    window.parent.loadTable();  
    document.getElementById('searchResult').innerHTML  = ''; 
    
    var grandTotalPrice = '<cfoutput>#grandTotalBalance#</cfoutput>';
 

    
    
</script>


