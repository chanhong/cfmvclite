
<cfscript>
//rc.b.permDbg(rc.data, "data");
</cfscript>
<cfoutput>
<table border="0" cellspacing="0">
	<col width="40" />
	<thead>
		<tr>
			<th>Id</th>
			<th>Name</th>
			<th>Email</th>
			<th>Delete</th>
		</tr>
	</thead>
	<tbody>
		<cfif rc.data.RecordCount EQ 0>
			<tr><td colspan="5">No users exist but <a href="index.cfm?cfc=user.form">new ones can be added</a>.</td></tr>
		</cfif>
		<cfloop query="#rc.data#">
			<cfset local.cr = rc.data.currentRow>
			<cfset local.id = rc.data.id[local.cr]>
			<cfset local.user = rc.data.user[local.cr]>
			<cfset local.email = rc.data.email[local.cr]>
			<tr>
				<td><a href="index.cfm?cfc=user.edit&id=#local.id#">#local.id#</a></td>
				<td><a href="index.cfm?cfc=user.edit&id=#local.id#">#local.user#</a></td>
				<td>#local.email#</td>
				<td><a href="index.cfm?cfc=user.delete&id=#local.id#">DELETE</a></td>
			</tr>
		</cfloop>
	</tbody>
</table>
</cfoutput>