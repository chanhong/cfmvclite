<h3>Company Info</h3>

<cfoutput>
<form class="familiar medium" method="post" action="index.cfm?action=company.save">
	
	<input type="hidden" name="id" value="#rc.data.id#">
	
	<div class="field">
		<label for="companyName" class="label">Company Name:</label>
		<input type="text" name="companyName" id="companyName" value="#rc.data.companyName#">
	</div>
	
	<div class="control">
		<input type="submit" value="Save">
	</div>
	
</form>
</cfoutput>