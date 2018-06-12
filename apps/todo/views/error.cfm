<cfparam name="rc.errMessage" default="">
<h1>An Error Occurred</h1>
<p>Details of the exception:</p>
<cfoutput>
	<ul>
		<li>Failed action:
        <cfif structKeyExists( request, 'failedAction' )>
          <!--- sanitize user supplied value before displaying it --->
          #replace( request.failedAction, "<", "&lt;", "all" )#
        <cfelse>
          Unknown
        </cfif>
    </li>
  <li>Message:
    #rc.errMessage#
  </li>
</ul>
</cfoutput>
<cfdump var="#request#"/>
