<cfcomponent output="false">
	
	<cfset this.name = "ProposalManager72Solution">
	<cfset this.datasource = "ProposalManager">
	<cfset this.sessionManagement = true>
	<cfset this.clientManagement = false>
	<cfset this.serialization.serializeQueryAs = "struct">

	<cfset this.restsettings.autoregister="true"/>
	<cfset this.restsettings.servicemapping="proposalmanager"/>
	<cfset this.restsettings.usehost=true/>
	<cfset request.debug = "y" /> 

	<cffunction name="onApplicationStart">
		
		<cfset application.basehref =  getDirectoryFromPath( CGI.SCRIPT_NAME )>
		<cfset application.rootFolder0 =  left(application.basehref, len(application.basehref)-1)>
		<cfset application.rootFolder =  right(application.rootFolder0, len(application.rootFolder0)-1)>
		<cfset application.cfcFolder = "cfc">
		<cfset application.cfcpath = application.rootFolder & "." & application.cfcFolder>
		<cfset variables.cfcpath = application.rootFolder & "." & application.cfcFolder>
		<cfset application.cssHref = application.basehref & "assets/css/">
		<cfset application.uploadDir = "../data">
		<cfset application.PDFGenDir = application.uploadDir & "/generatedpdfs/">

		<cfset application.cfc = structnew()>
		
		<cfset local.cfcList = "Base,Login,Asset,Company,AssetType">
		
		<cfloop list="#local.cfcList#" index="local.thisCfcName">
			<cfset application.cfc[local.thisCfcName] = createObject(
				"component",
				"#application.cfcpath#.#local.thisCfcName#"
				)>
				<cfset variables.cfc[local.thisCfcName] = createObject(
					"component",
					"#variables.cfcpath#.#local.thisCfcName#"
				)>
		</cfloop>
		<cfreturn true>
	</cffunction>

	<cffunction name="onRequestStart">
		<cfargument name="targetpage" required="true" type="string">
		
		<cfif isdefined("url.init")>
			<cfset onApplicationStart()>
			<cfset onSessionStart()>
		</cfif> 
		
		<cfif not isUserInAnyRole("SuperAdmin,Admin") and
			  arguments.targetpage contains "/admin/">
			  
			  <cflocation url="#application.basehref#login/index.cfm">
			  
		</cfif>
		
	</cffunction>
	
	
	<cffunction name="onSessionStart">
		
		<cfif not isdefined("session.username")>
			<cfset session.username = "Anonymous">
		</cfif>
		
	</cffunction>

</cfcomponent>