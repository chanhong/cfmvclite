<cfcomponent extends="_basecontroller" output="false">
<!--- --->
  <cffunction name="before" access="public" hint="before" returntype="void">
  	<cfargument name="rc" type="struct" required="true">
    <cfset rc.layout = "default" />
  </cffunction>
  
  <cffunction name="index" access="public" hint="Log in user" returntype="boolean">
    <cfargument name="rc" type="struct" required="true">
    <cfreturn true>
  </cffunction>

  <cffunction name="login" access="remote" hint="Authenticate User" returntype="boolean" >
  	<cfargument name="username" type="string" required="true">
  	<cfargument name="password" type="string" required="true">
  	
  	<cflogin>
  		<!--- do database authentication here --->
  		<cfstoredproc procedure="authenticate">
        <cfprocparam type="in" cfsqltype="cf_sql_varchar" value="#arguments.username#">
        <cfprocparam type="in" cfsqltype="cf_sql_varchar" value="#arguments.password#">
        <cfprocresult name="local.q" resultset="1">
      </cfstoredproc>
      
      <!---
  		<cfquery name="local.q">
  			select Appuser.*, UserRole.label as roleName 
  			from AppUser inner join UserRole
  			 on AppUser.idRole = UserRole.id
  			where AppUser.endtime is null
  			and 
  			  username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.username#">
  			and 
  			  password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.password#">
  		</cfquery>
      --->
  		<cfif local.q.recordCount is 1>
	  		<cfloginuser 
	  			name="#arguments.username#" password="#arguments.password#" roles="#local.q.roleName#">
          <cfset variables.user = #local.q# />
          <cfdump var="#local.q#" />
          <cfdump var="#variables.user#" />
        </cfif>
  	</cflogin>
  	<cfif getAuthUser() is "">
  		<cfreturn false>
    <cfelse>
      <cfdump var="#variables.user#" />
      <cfoutput>
        #variables.user.username#
      </cfoutput>
      <!--- --- >
      <cfabort />
      < !--- --->
      <cfset session.auth.isLoggedIn = true />
      <cfset session.auth.fullname = #variables.user.firstname# & " " & #variables.user.lastname#/>
      <cfset session.auth.username = #variables.user.username#/>
      <cfset session.auth.userid = #variables.user.id# />
      <!--- --->
  		<cfreturn true>
  	</cfif>
  	
  </cffunction>
  
  <cffunction name="logout" access="public" hint="Log out user" returntype="boolean">
  	
    <cflogout>
    <cfset session.auth.isLoggedIn = false />
    <cfset session.auth.fullname = "Guest" />
    <cfset rc.message = ["You have safely logged out"] />
		<cflocation url="./index.cfm">    
  	<cfreturn true>
  	
  </cffunction>

  <cffunction name="sendPassword" access="public" hint="password reminder" returntype="boolean">
    <cfargument name="email" type="string" required="true">
    
    <cfquery name="local.q">
      select password
      from appuser
      where email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">
      and endtime is null
    </cfquery>
    
    <cfif local.q.recordcount ge 1>
      <cfmail 
         from="info@figleaf.com"
         to="sdrucker@figleaf.com"
         subject="Password Reminder"
         type="html">
         
         <p>Your password is #local.q.password#</p>
         
      </cfmail>
      <cfreturn true>
    <cfelse>
      <cfreturn false>
    </cfif>
    
    
  </cffunction>
  

</cfcomponent>