<cfoutput>
<cfparam name="rc.title" default="Main Page">
<h1>
	Welcome 
	<cfif getAuthUser() is not "">
		<cfoutput>#getAuthUser()#</cfoutput>
	</cfif>
	!
</h1>
<cfinclude template="contacts.cfm">
#rc.b.view("user.me",rc)#
</cfoutput>
