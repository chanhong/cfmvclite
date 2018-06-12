	<h1>Companies List</h1>
<cfoutput>
<table border="0" cellspacing="0">
	<col width="40" />
	<thead>
		<tr>
			<th>Id</th>
			<th>Name</th>
			<th>Delete</th>
		</tr>
	</thead>
	<tbody>
		<cfif rc.data.RecordCount EQ 0>
			<tr><td colspan="5">No Company exist but <a href="index.cfm?cfc=proposal.form">new ones can be added</a>.</td></tr>
		</cfif>
		<cfloop query="#rc.data#">
			<cfset local.cr = rc.data.currentRow>
			<cfset local.id = rc.data.id[local.cr]>
			<cfset local.name = rc.data.companyName[local.cr]>
			<tr>
				<td><a href="index.cfm?cfc=company.edit&id=#local.id#">#local.id#</a></td> 			
				<td><a href="index.cfm?cfc=company.edit&id=#local.id#">#local.name#</a></td> 			
				<td><a href="index.cfm?cfc=company.delete&id=#local.id#">DELETE</a></td> 			
			</tr>
		</cfloop>
	</tbody>
</table>
</cfoutput>