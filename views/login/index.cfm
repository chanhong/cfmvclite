
<cfif isdefined("form.username")>
	<cfif rc.mvc.controllers.login.login(form.username, form.password)>
		<cflocation url="./index.cfm">
	<cfelse>
		Authentication failed - Please Try Again!
	</cfif>
</cfif>
<h1>
	Please Login
</h1>

<cfform>

	<label for="username">
		User Name:
	</label>
	<cfinput type="text" name="username" required="true" message="You must enter a user name">
	<br/>
	<label for="password">
		Password:
	</label>
	<cfinput type="text" name="password" required="true" message="You must enter a password">
	<br/>

	<cfinput type="submit" name="btnSubmit" value="Authenticate!">
	<input type="button" value="Forgot Password" onclick="forgotPassword()">
	
</cfform>

