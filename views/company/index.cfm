
<cfparam name="form.searchterm" default="">
<cfset qx = rc.mvc.cfc.Asset.get(form.searchterm)>

<cfif isdefined("url.newId")>
	<cfoutput>
	<style>
		##asset#url.newId# {
			background-color: yellow;
		}
	</style>
	</cfoutput>
</cfif>

<cfoutput>
<script type="text/javascript">
	function deleteRecord(id,label) {
		if (confirm("Delete " + label + "?")) {
			location.href='views/admin/asset.cfm?id=' + id + '&action=delete'
		}
	}
</script>
</cfoutput>

<h1>
	Welcome to Proposal Manager
	<cfif getAuthUser() is not "">
		<cfoutput>#getAuthUser()#</cfoutput>
	</cfif>
	!
</h1>

<cfoutput>
	<h2>There are #qx.recordcount# documents</h2>
</cfoutput>

<cfform >
	<label for="searchterm">Search Term:</label>
	<cfinput type="text" name="searchterm">
	<cfinput name="btnSubmit" type="submit" value="Search">
</cfform>

<table border="1">
	<tr>
		<th>Updated</th>
		<th>Title</th>
		<th>Type</th>
		<th>Company</th>
		<th>Download</th>
		<th>Edit</th>
		<th>Del</th>
	</tr>
	<cfoutput query="qx">
		<tr id="asset#qx.id#">
			<td>#dateFormat(qx.updatedate)#</td>
			<td>#qx.title#</td>
			<td>#qx.assetType#</td>
			<td>#qx.companyName#</td>
			<td>
				<cfif assetType is "Bio">
					<a href="#rc.cfcFolder#/asset.cfc?method=downloadBioPDFfile&id=#id#">
						[download Bio PDF]
					</a>
				<cfelse>
					<cfif qx.filename is not "">
						<a href="#rc.cfcFolder#/asset.cfc?method=downloadfile&id=#id#">
						[download]
						</a>
					</cfif>
				</cfif>
			</td>
			<td>
				<a href="index.cfm?cfc=company.asset&id=#qx.id#">[Edit]</a> 			
			</td>
			<td>
				<a href="javascript:deleteRecord(#qx.id#,'#jsStringFormat(qx.title)#')">[Del]</a>
			</td>
		</tr>
	</cfoutput>
</table>

<cfoutput>
<input type="button" value="Download List" onClick="location.href='#rc.cfcFolder#/asset.cfc?method=downloadspreadsheet&searchterm=#urlencodedformat(form.searchterm)#'">
</cfoutput>

