
	<cfscript>
	// cfm as a controller with object this from the application.cfc
	// if this exist then assign to rc to be consistent between cfc and cfm
	if (StructKeyExists(this, "core")) {
		rc = this;
	} 
	/*
	// Check to see if the user is logged-in - only an authorized 
	// user can access this controller.
	if (!session.user.isLoggedIn()){

	// Stop processing this route.
	throw( type="Unauthorized" );

	}
	*/
	// Param the second-level event. This will determine which action
	// is being performed in this controller.
	param name="request.cfm[ 2 ]" type="string" default="default";
	// Route the request based on the current event.
	action = request.cfm[ 2 ];
	rc.title = rc.b.initCap(rc.action);
	switch (action){
		case "useful_links":
			rc.title = "Useful Links";
			break;
		default:
	}

	rc.ext = "*.cfm"; // look for all cfm files
	rc.excl = "_"; // exclude prefixed _ file
    vList = rc.ut.folder2dirlistNotApps("#rc.cfg.fld_View#/#rc.ctl#", rc);
	
	if (listContainsNoCase(vList, action)) {
		rc.b.renderFullView(rc);    
	} else {
		rc.errMessage = "#action# is not found!";
		rc.b.doErrorView(rc);
	}
</cfscript>;