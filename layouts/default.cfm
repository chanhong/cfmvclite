<cfscript>
if (isDefined("rc.body")) {
//	writeDump("rc before: "&rc.body);
}
local.basehref = iif( CGI.HTTPS eq "on", de("https"), de("http") ) & "://" & CGI.HTTP_HOST & getDirectoryFromPath( CGI.SCRIPT_NAME );
local.baseDirectory = getDirectoryFromPath( getCurrentTemplatePath() );
/*
if (structKeyExists(variables, "scfcs")) {
	rc.scfcs = variables.scfcs; // from application.cfc when call from cfm
} 
*/
</cfscript>
<cfoutput>
<cfparam name="request.dmsg" default="">
<cfparam name="rc.username" default="">
<cfparam name="rc.title" default="">
</cfoutput>
<html>
	<head>
		<cfoutput>
        <meta http-equiv="X-UA-Compatible" content="IE=9" />	
		<title>#rc.title#</title>
		<base href="#local.basehref#" />
		<link rel="stylesheet" type="text/css" href="#local.basehref#vendor/bootstrap/dist/css/bootstrap.css" />
		<link rel="stylesheet" type="text/css" href="#local.basehref#assets/css/bootstrap-custom.css" />
		<script type="text/javascript" src="#local.basehref#vendor/bootstrap/dist/js/bootstrap.js"></script>
		<script type="text/javascript" src="#local.basehref#vendor/jquery/dist/jquery.js"></script>
		<link rel="stylesheet" type="text/css" href="#local.basehref#vendor/kendo-ui-core/dist/styles/web/kendo.common.core.css" />
		<link rel="stylesheet" type="text/css" href="#local.basehref#vendor/kendo-ui-core/dist/styles/web/kendo.default.css" />
		<script type="text/javascript" src="#local.basehref#vendor/kendo-ui-core/dist/js/kendo.ui.core.js"></script>
		<script type="text/javascript" src="#local.basehref#assets/js/behaviors.js"></script>
		<script type="text/javascript" src="#local.basehref#assets/js/site.js"></script>
		</cfoutput>
	</head>
	<body>
		<div id="wrap">
			<div id="topHeader">
				<font color="LightGrey" face="helvetica, sans-serif;" size="6">
					<cfoutput>#rc.title#</cfoutput>
				</font>			
			</div>	
			<div class="header">
				<div class="navbar">
					<ul class="nav navbar-nav"><cfoutput><cfinclude template="header.cfm"></cfoutput></ul>
				</div>				
			</div>
			<div class="hmenu">
				<div class="navbar">
					<ul class="nav navbar-nav"><cfoutput><cfinclude template="body_bef.cfm"></cfoutput></ul>
				</div>
			</div>
			<div style="float:right">
				<font color="LightGrey">
					<cfoutput>#rc.username#</cfoutput>
				</font>
			</div>			
			<div id="primary" class="page">
				<input id="datepicker" />
				<script>
					$(function() {
						$("#datepicker").kendoDatePicker();
					});
				</script>				
				<!--- display any messages to the user --->
				<cfoutput>
					#request.dmsg#
					#rc.body#				
				</cfoutput>
			</div>
			<div class="footer">
				<div class="navbar">
					<ul class="nav navbar-nav"><cfoutput><cfinclude template="footer_bef.cfm"></cfoutput></ul>
				</div>
				<cfoutput><cfinclude template="footer.cfm">	</cfoutput>
			</div>
		</div>
	</body>
</html>
			
