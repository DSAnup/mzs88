<cfoutput>

<cfif currentStep eq 1>
<div class="arrow-steps clearfix">
  <div class="step current"> <span> Package Selection</span> </div>
  <div class="step"> <span>Client Information</span> </div>
  <div class="step"> <span> Payment Method</span> </div>
  <div class="step"> <span>Order Review</span> </div>
  <div class="step"> <span>Order Confirmation</span> </div>
</div>
</cfif>

<cfif currentStep eq 2>
<div class="arrow-steps clearfix">
  <div class="step done"> <span> Package Selection</span> </div>
  <div class="step current"> <span>Client Information</span> </div>
  <div class="step"> <span> Payment Method </span> </div>
  <div class="step"> <span>Order Review</span> </div>
  <div class="step"> <span>Order Confirmation</span> </div>
</div>
</cfif>

<cfif currentStep eq 3>
<div class="arrow-steps clearfix">
  <div class="step done"> <span> Package Selection</span> </div>
  <div class="step done"> <span>Client Information</span> </div>
  <div class="step current"> <span> Payment Method</span> </div>
  <div class="step"> <span>Order Review</span> </div>
  <div class="step"> <span>Order Confirmation</span> </div>
</div>
</cfif>

<cfif currentStep eq 4>
<div class="arrow-steps clearfix">
  <div class="step done"> <span> Package Selection</span> </div>
  <div class="step done"> <span>Client Information</span> </div>
  <div class="step done"> <span> Payment Method </span> </div>
  <div class="step current"> <span>Order Review</span> </div>
  <div class="step"> <span>Order Confirmation</span> </div>
</div>
</cfif>
<cfif currentStep eq 5>
<div class="arrow-steps clearfix">
  <div class="step done"> <span> Package Selection</span> </div>
  <div class="step done"> <span>Client Information</span> </div>
  <div class="step done"> <span> Payment Method</span> </div>
  <div class="step done"> <span>Order Review</span> </div>
  <div class="step done current-last"> <span>Order Confirmation</span> </div>
</div>
</cfif>
</cfoutput>


