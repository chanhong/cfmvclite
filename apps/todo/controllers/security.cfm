
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
	param name="request.cfm[ 2 ]" type="string" default="login";

	// Route the request based on the current event.
	action = request.cfm[ 2 ];
	rc.ctl = "security";
	rc.layout = "security";
	
	// cfm only know about this variable 
	switch (action){
		case "login":
			// Param the form values.
			param name="form.submitted" type="boolean" default="false";

			// Check to see if the form has been submitted.
			if (form.submitted){

				// Now that the user is authenticated, forward the user to
				// the homepage.
				location( url="./index.cfm", addToken="false" );

			}

			// Populate the view data for layout rendering.
			request.viewData.title = "Please Login";
			request.viewData.activeNavItem = "signIn";
			break;
		case "createAccount":
			// Param the form values.
			param name="form.submitted" type="boolean" default="false";

			// Check to see if the form has been submitted.
			if (form.submitted){

				// Now that the user has created an account, log the user into
				// the system and then forward them to the homepage.
				location( url="./index.cfm", addToken="false" );

			}

			// Populate the view data for layout rendering.
			request.viewData.title = "Create An Account";
			request.viewData.activeNavItem = "createAccount";
		break;

		case "forgotPassword":
			// Param the form values.
			param name="form.submitted" type="boolean" default="false";

			// Check to see if the form has been submitted.
			if (form.submitted){

				// The user will be sent a "password reset" email with a link
				// to a page that will collection a new password.
				location( url="./index.cfm?cfm=security.login", addToken="false" );

			}

			// Populate the view data for layout rendering.
			request.viewData.title = "Forgot Your Password";
		break;


		case "logout":
			// Because we don't have an active security system, explicitly 
			// forward the user to the login form.
			location( url="./index.cfm?cfm=security.login", addToken="false" );			
			break;

		case "passwordResetSent":
			// Populate the view data for rendering.
			request.viewData.title = "Your Password Reset Email Has Been Sent";
		break;

		case "resetPassword":
			// Param the form values.
			param name="form.submitted" type="boolean" default="false";

			// Check to see if the form has been submitted.
			if (form.submitted){

				// Now that the user has chosen a new password, redirect them
				// back to the login screen where they can make use of it.
				location( url="./index.cfm?cfm=security.login", addToken="false" );
			}
			// Populate the view data for layout rendering.
			request.viewData.title = "Choose A New Password";
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
	
</cfscript>