component extends="mvcbase"
//component 
output="false"
hint="mvclite router"
{

    array function initRequest(struct itask, string action) {

    	// Define the event value in the request. The event determines
		// how the incoming request will be routed to the various 
		// controllers and sub-routes. By default, it will have no 
		// values so that they can be overridden with defaults as the
		// request is processed.

        local.task = [];

		// Check to see if the event value has been defined in the URL
		// scope. If so, we may override the default values. Assuming 
		// that it will be dot-delimited, we can break it up into an
        // array for quick reference.
        if (structKeyExists(itask,action)) {
            local.ax = itask[action];
            if (!isNull( local.ax ) &&	len( trim( local.ax ) )){
                // This will contain at least one routable value (since 
                // we wouldn't parse it if it was empty).
                local.task = listToArray( trim( local.ax), "." );
            }
        }
        return local.task;
    }

    function isRequestAction(array aAction) {
        
        action = false;
        if (ArrayIsDefined(aAction, 2) && !isNull(aAction[ 2 ])){
            action = true;
        }
        return action;
    } 

    function isCtlExist(rc) {

        vfile = ExpandPath("#rc.cfg.fld_Ctl#/#rc.ctlfile#");
        if (left(vfile,1)!="_" and FileExists(vfile)) {
            return true;
        }else {
            return false;
        }
    }

    function prepRc4Mvc(rc) {

        param name="rc.defctl" type="string" default="main";
        param name="rc.action" type="string" default="default";
        param name="rc.layout" type="string" default="default";

        local.me = "";
        local.bDir = mvcBasePath();
        if (!isNull(local.bDir) and len(local.bDir)>0) {
            local.me = "/"&mvcBasePath()&"/index.cfm";
        }
        
        if (isRequestAction(request.cfm)) {
            rc.loginUrl = "?cfm=#rc.cfg.loginAction#";
            param name="request.cfm[ 1 ]" type="string" default="#rc.defctl#";
            param name="request.cfm[ 2 ]" type="string" default="default";
            rc.ctl = request.cfm[ 1 ];
            rc.ctlfile = "#rc.ctl#.cfm"; 
            rc.action = request.cfm[2];
        } else if (isRequestAction(request.cfc) 
            or local.me=="" or CGI.SCRIPT_NAME == local.me) 
        { 
            
            rc.loginUrl = "?cfc=#rc.cfg.loginAction#";
            param name="request.cfc[ 1 ]" type="string" default="#rc.defctl#";
            param name="request.cfc[ 2 ]" type="string" default="default";
            rc.ctl = request.cfc[ 1 ];
            rc.ctlfile = "#rc.ctl#.cfc"; 
            rc.action = request.cfc[2];
        }
        return rc;
    }

    function mvc(rc) {

        rc = prepRc4Mvc(rc);
        try {
            if (isCtlExist(rc)) {
                if (isRequestAction(request.cfm)) { 
                    // get the cfm controller file path
                    vfolder = folder2RelpathNotApps(rc.cfg.fld_Ctl, rc);
                    vfile = "/#vfolder#/#rc.ctlfile#"; // use slash to start from site root
                    // show cfm controller
                    writeOutput( captureContents( vfile, rc) );
                } else if (isRequestAction(request.cfc)) { 
                    // get the cfc controller component dotted path
                    local.ctl = "rc.mvc.#rc.cfg.fld_Ctl#.#rc.ctl#";
                    // start cfc controller
                    Evaluate(local.ctl&".startmvc(rc)");	
                } else {
                    // forward to subsite if it is not the current site such as sub site in the apps folder
                    return true;
                }
            } 
            else {
                rc.errMessage = "#rc.ctlfile# is not found!";
                doErrorView(rc);
            }
        } catch( Unauthorized error ){
            // If the user is not authorized to access the given module, redirect them to the login.
            location( url="#rc.loginUrl#", addToken=false );
        }  
    }  
}