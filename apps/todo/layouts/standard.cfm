
<!--- Param the view data for the layout rendering. --->
<cfparam name="request.viewData.title" type="string" default="" />
<cfparam name="request.viewData.cssFile" type="string" default="standard.css" />
<cfparam name="request.viewData.activeNavItem" type="string" default="" />
<cfparam name="request.viewData.body" type="string" default="" />
<!--- Set up the navigation body for the master layout. --->
<cfsavecontent variable="request.viewData.navigationBody">
	<cfoutput>
		<ul class="m-siteNavigation">
			<li class="navItem <cfif (request.viewData.activeNavItem eq "tasks")>activeNavItem</cfif>">
				<a href="./index.cfm?cfc=tasks">Tasks</a>
			</li>
			<li class="navItem <cfif (request.viewData.activeNavItem eq "tasks")>activeNavItem</cfif>">
				<a href="?cfm=tasks">Tasks</a>
			</li>
			<li class="navItem <cfif (request.viewData.activeNavItem eq "profile")>activeNavItem</cfif>">
				<a href="?cfc=account">Profile</a>
			</li>
			<li class="navItem <cfif (request.viewData.activeNavItem eq "profile")>activeNavItem</cfif>">
				<a href="?cfm=account">Profile</a>
			</li>
			<li class="navItem rightNavItem">
				<a href="./index.cfm?cfc=security.logout">Logout</a>
			</li>
			<li class="navItem rightNavItem">
				<a href="./index.cfm?cfm=security.logout">Logout</a>
			</li>
		</ul>
	</cfoutput>
</cfsavecontent>
<!--- Include the master layout. --->
<cfinclude template="./master.cfm" />
