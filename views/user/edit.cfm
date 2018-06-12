<cfparam name="url.id" default="0">

<cfif isdefined("url.cfc") and url.cfc is "delete">
	<cfset this.mvc.cfc.user.delete(id=url.id)>
	<cflocation url="?cfc=user.list">
</cfif>

<cfif isdefined("form.btnSubmit")>
	
	<cfif form.id is 0>
		<cfset newId = rc.mvc.cfc.Asset.createRecord(
			title = form.title,
			idDepartment = form.idDepartment,
			firstname = form.firstname,
			lastname = form.lastname,
			email = form.email,
			id=form.id
		)>
	<cfelse>
		<cfset newId = rc.mvc.cfc.Asset.updateRecord(
			title = form.title,
			idDepartment = form.idDepartment,
			firstname = form.firstname,
			lastname = form.lastname,
			email = form.email,
			id=form.id
		)>
	</cfif>
	
	<cfoutput>
		<script type="text/javascript">
			alert("Record Saved");
			location.href = "?cfc=user.edit&newId=#variables.newId#";
		</script>
	</cfoutput>
	
</cfif>


<!--- handle record load --->

<cfset qRec = QueryExecute("select * from appuser where id=:id",{id=url.id})/>
<cfdump var="#qRec#"/>
<cfif qrec.recordcount is 0>
	<!--- add empty row --->
	<cfset queryAddRow(qRec)>
</cfif>
<!---
<cfset qDepartments = rc.core.scfcs.data.getDepartment()>
--->
<cfset qDepartments = rc.mvc.models.department.get(rc)>

<!--- --- >
<cfdump var="#qDepartments#"/>
<cfdump var="#qRec#"/>
<cfabort>
< !--- --->
<h3>User Info</h3>

<cfoutput>
<cfform enctype="multipart/form-data">	

	<input type="hidden" name="id" value="#qRec.id#">
	<input type="hidden" name="title" value="edit">
	
	<div class="field">
		<label for="firstName" class="label">First Name:</label>
		<input type="text" name="firstName" id="firstName" value="#qRec.firstname#">
	</div>
	
	<div class="field">
		<label for="lastName" class="label">Last Name:</label>
		<input type="text" name="lastName" id="lastName" value="#qRec.lastname#">
	</div>
	
	<div class="field">
		<label for="email" class="label">Email:</label>
		<input type="text" name="email" id="email" value="#qRec.email#">
	</div>
	<div class="field">
		<label for="idDepartment">Department:</label>
		<cfselect 
			name="idDepartment"
			query="qDepartments"
			display="Name"
			value="id"
			queryPosition="below"
			required="true" selected="#qrec.idDepartment#">
		   <option value="">Please Select</option>
		   
		</cfselect>
	</div>

	<cfinput type="submit" name="btnSubmit" value="Save User">
		
</cfform>	
</cfoutput>