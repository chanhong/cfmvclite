
	<cfscript>
	// cfm as a controller
	/*
	// Check to see if the user is logged-in - only an authorized 
	// user can access this controller.
	if (!session.user.isLoggedIn()){

	// Stop processing this route.
	throw( type="Unauthorized" );

	}
	*/

	// if this exist then assign to rc to be consistent between cfc and cfm
	if (StructKeyExists(this, "core")) {
		rc = this;
	} 
	
	// Param the second-level event. This will determine which action
	// is being performed in this controller.
	param name="request.cfm[ 2 ]" type="string" default="edit";
	// Route the request based on the current event.
	action = request.cfm[ 2 ];
	rc.ctl = "account";
	rc.layout = "standard";

	// cfm only know about this variable 
	switch (action){
		case "changePassword":
			// Param the form values.
			param name="form.submitted" type="boolean" default="false";
			// Check to see if the form has been submitted.
			if (form.submitted){
				// Now that the user has updated their password, redirect them back to the 
				// default page.
				location( url="./index.cfm", addToken="false" );
			}
			// Populate the view data for layout rendering.
			request.viewData.title = "Change Password";
			break;
		case "delete":
			// Now that the user has deleted the task, redirect the user back to 
			// the list of tasks.
			location( url="./index.cfm?cfm=tasks", addToken="false" );		
			break;
		default:
		case "edit":
			// Param the form values.
			param name="form.submitted" type="boolean" default="false";
			// Check to see if the form has been submitted.
			if (form.submitted){

				// Now that the user has updated their account, redirect them back to the 
				// default page.
				location( url="./index.cfm", addToken="false" );

			}
			// Populate the view data for layout rendering.
			request.viewData.title = "Your Profile";
			request.viewData.activeNavItem = "profile";
			break;
	}

	// set some param for the function
	rc.ext = "*.cfm"; // look for all cfm files
	rc.excl = "_"; // exclude prefixed _ file
    vList = rc.ut.folder2dirlistNotApps("#rc.cfg.fld_View#/#rc.ctl#", rc);
	if (listContainsNoCase(vList, action)) {
		rc.b.renderFullView(rc);    
	} else {
		rc.errMessage = "#action# is not found!";
		rc.b.doErrorView(rc);
	}
</cfscript>