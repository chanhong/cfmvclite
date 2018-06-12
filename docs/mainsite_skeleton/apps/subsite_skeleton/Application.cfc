// copy this file to subsite in the apps folder
component extends="ApplicationProxy" {
	// Site specific stuff	
	// override the root site
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
	
	// use this to override the main site
	this.cfg.loginAction = "security.login";

	// Map our various MVC folder paths. 
	this.mappings[ "/#this.cfg.fld_Model#" ] = (this.baseDirectory & "#this.cfg.fld_Model#/");
	// must have this for the captureContents to work
	this.mappings[ "/#this.cfg.fld_View#" ] = (this.baseDirectory & "#this.cfg.fld_View#/");
	this.mappings[ "/#this.cfg.fld_Layout#" ] = (this.baseDirectory & "#this.cfg.fld_Layout#/");
	// must have this for the captureContents to work

	this.mvc = this.ld.cfc_loader([this.cfg.fld_Ctl,this.cfg.fld_Model],this);
	this.dsn = "ProposalManager";
	this.daoPm = this.dao.init(this);
	// use this to override the main site
	// Site specific stuff	

    function onSessionStart() {

		// use parent
		super.onSessionStart();
        session.counter = 0;
        writeOutput("#getCurrentTemplatePath()# called<br>");        
    }

	// I initiliaze the incoming request.
	function onRequestStart(){
		
		request.debug = "n"; // to show permDbg msg or not
		// use parent
		super.onRequestStart();

		// Return true so the page can be processed.
        writeoutput(" in sub ");
//        writeDump("#application#");		
		return( true );
	}
	
	// I process the actual request. 
	function onRequest( String scriptName ){

        // use parent
		super.onRequest(scriptName);
	}    
}