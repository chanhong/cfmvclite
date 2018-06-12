
// sample Application.cfc for the main site
component 
output="false"
hint="I define the application settings and event handlers."
{
// shared stuff for the subsite in apps
// for bootstraps mvclite, for root site and subsite
string function mvclite_scfcsPath(struct args) {

	local.baseHref = listFirst(getDirectoryFromPath( CGI.SCRIPT_NAME ), "/");
	// in case main site is at root
	if (len(local.baseHref)>0 and (local.baseHref != args.fld_Apps )) {
		local.baseHref = "/"&local.baseHref&"/";
	} else {
		// if in apps folder, load from site root
		local.baseHref = "/";
	}
	return local.baseHref&args.fld_Scfc;
}

string function mvclite_scfcsPath4Cfc(struct args) {

	// baseHref is null if run at rootsite 
	local.baseHref = listFirst(getDirectoryFromPath( CGI.SCRIPT_NAME ), "/");
	if (len(local.baseHref)>0 and local.baseHref != args.fld_Apps) {
		local.baseHref = local.baseHref&".";
	} else if (len(local.baseHref)>0 and local.baseHref == args.fld_Apps) {			
		local.baseHref = "";
	} 
	return local.baseHref&args.fld_Scfc;
}
// for bootstraps mvclite, for root site and subsite
this.cfg = {
	fld_Ctl = "controllers",
	fld_Model = "models",
	fld_View = "views",
	fld_Layout = "layouts",
	fld_Scfc = "scfcs",
	fld_Apps = "apps",
	loginAction = "security.login",		
	baseHref = getDirectoryFromPath( CGI.SCRIPT_NAME ),
	baseAppDir =  expandPath( "./" )
};

this.cfg.baseHrefFirst = listFirst(this.cfg.baseHref, "/");
loader = createObject("component", "#mvclite_scfcsPath4Cfc(this.cfg)#.loader"); 	// load shared cfc
this.core =  loader.cfc_loader(["/#this.cfg.fld_Scfc#"], this);
// alias to the long version 
this.b = this.core.scfcs.mvcbase;
this.ld = this.core.scfcs.loader;
this.rt = this.core.scfcs.router;
this.ut = this.core.scfcs.util;
this.hlp = this.core.scfcs.helper;
this.db = this.core.scfcs.dao;
// alias to the long version 

request.scfcPath = mvclite_scfcsPath(this.cfg); // must be here before loading controolers
// shared stuff for the subsite in apps

// Site specific stuff
// Calculate the base path of the application. This will be used
// to create a unique name as well as defined several of the 
// application mappings.
this.baseDirectory = getDirectoryFromPath( getCurrentTemplatePath() );
// Define the application settings. 
this.name = hash( this.baseDirectory );
this.applicationTimeout = createTimeSpan( 0, 1, 0, 0 );

// Enable session management.
this.sessionManagement = true;
this.sessionTimeout = createTimeSpan( 0, 0, 10, 0 );

// Map our various MVC folder paths. 
this.mappings[ "/#this.cfg.fld_Model#" ] = (this.baseDirectory & "#this.cfg.fld_Model#/");
// must have this for the captureContents to work
this.mappings[ "/#this.cfg.fld_View#" ] = (this.baseDirectory & "#this.cfg.fld_View#/");
this.mappings[ "/#this.cfg.fld_Layout#" ] = (this.baseDirectory & "#this.cfg.fld_Layout#/");
// must have this for the captureContents to work

// include cfc if you have your own cfc stuff
this.mvc =  this.ld.cfc_loader(["cfc",this.cfg.fld_Ctl,this.cfg.fld_Model],this);
this.dsn = "yourdatasource";
// set default datasource
this.datasource = this.dsn;
this.daoPm = this.dao.init(this);
// Site specific stuff

function hi(string name) {
	return "hi "&name;
}

// I initialize the application.
function onApplicationStart(){

	// Return true so the application can be processed.
	return( true );
	
}

// I initialize the user's web session.
function onSessionStart(){

	// ....

}

// I initiliaze the incoming request.
function onRequestStart(){

	// Check to see if the application needs to be refreshed.
	if (structKeyExists( url, "init" )){
		// Manually invoke the application and session reset.
		this.onApplicationStart();
		this.onSessionStart();
	}
	request.cfc = this.rt.initRequest(url, "cfc");
	request.cfm = this.rt.initRequest(url, "cfm");
	// Define the collection that will be populated specifically
	// for use within the Views and Layouts. The Controller will
	// put data in here to be used in the views. The views will
	// put data in here to be used in the layouts.
	request.viewData = {};
	if (!isDefined("request.debug")) { // do not override subsite setting on debug
		request.debug = "y"; // to show permDbg msg or not
	}
	
	this.b.permDbg(this.cfg, "cfg");
	this.b.permDbg(request.debug, "dbg");
		
	// Return true so the page can be processed.
	return( true );
}

// I process the actual request. 
function onRequest( String scriptName ){
	
//		buff = this.daoPm.read("SELECT firstname, lastname FROM appuser",{returnType="array"});
	buff = this.daoPm.read("SELECT firstname, lastname FROM appuser");
	// No matter what page is requested, include script if not use mvc controller.
	if (FileExists(ExpandPath(scriptName)) and listLast(scriptName, "/")!="index.cfm") {
		include #scriptName#; 
	} else {
		this.rt.mvc(this);
	}
}     

// I process any errors that have bubbled upto the root of the 
// application without being caught by the controller or model.
function onError( Any error, String eventName ){
	
	// Debug....
	writeDump( error );
	abort;
}
}
