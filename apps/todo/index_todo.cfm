
<cfscript>


	// Param the default, top-level route. This will determine the
	// controller that is invoked if no other event is defined.
	param name="request.cfm[ 1 ]" type="string" default="tasks";


	// When processing the request, wrap the controller routing in a 
	// Try/Catch since the internal controllers may raise exceptions
	// that require us to redirect the user.
	try {

		// Route the request based on the current event.
		switch (request.cfm[ 1 ]){

			case "account":
				include "/controllers/account/index.cfm";
			break;

			case "security":
				include "/controllers/security/index.cfm";
			break;

			case "tasks":
				include "/controllers/tasks/index.cfm";
			break;

			// The provided event could not be matched.
			default:
				throw( type="InvalidEvent" );
			break;

		}

	// Catch any unauthorized exceptions.
	} catch( Unauthorized error ){

		// If the user is not authorized to access the given module,
		// redirect them to the login.
		location( url="./index.cfm?cfm=security.login", addToken=false );

	}


</cfscript>

