<cfscript>
	/*
	if (structKeyExists(variables, "scfcs")) {
		rc.scfcs = variables.scfcs; // from application.cfc when call from cfm
	} 
	*/	
	rc.basehref = iif( CGI.HTTPS eq "on", de("https"), de("http") ) & "://" & CGI.HTTP_HOST & getDirectoryFromPath( CGI.SCRIPT_NAME );
</cfscript>
<cfoutput>
<cfparam name="rc.title" default="Plain Layout">
<html>
	<head>
        <meta http-equiv="X-UA-Compatible" content="IE=9" />	
		<title>#rc.title#</title>
		<base href="#rc.basehref#" />
		<link rel="stylesheet" type="text/css" href="../vendor/bootstrap/dist/css/bootstrap.css" />
		<link rel="stylesheet" type="text/css" href="#rc.basehref#assets/css/bootstrap-custom.css" />
	</head>
	<body>
		<div id="wrap">
			<div class="page">
				#rc.body#				
			</div>
		</div>
	</body>
</html>
</cfoutput>