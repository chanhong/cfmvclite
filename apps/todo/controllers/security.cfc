component extends="_basecontroller" {
    // cfc as a controller, extends scfcs/base.cfc

    function before(rc) {
        rc.layout = "security";
      }    
  
    function default(rc) {
        rc.title = "Default Page";
        rc.action = "login";
      }
    
    function login(rc) {
        rc.title = "Please Login";
        request.viewData.activeNavItem = "signIn";
        // Param the form values.
        param name="form.submitted" type="boolean" default="false";

        // Check to see if the form has been submitted.
        if (form.submitted){

            // Now that the user is authenticated, forward the user to
            // the homepage.
            location( url="./index.cfm", addToken="false" );

        }
    }

    function createAccount(rc) {
        rc.title = "Create An Account";
        request.viewData.activeNavItem = "createAccount";
        
        // Param the form values.
        param name="form.submitted" type="boolean" default="false";

        // Check to see if the form has been submitted.
        if (form.submitted){

            // Now that the user has created an account, log the user into
            // the system and then forward them to the homepage.
            location( url="./index.cfm", addToken="false" );
        }
    }

    function forgotPassword(rc) {
        rc.title = "Forgot Your Password";

        // Param the form values.
        param name="form.submitted" type="boolean" default="false";

        // Check to see if the form has been submitted.
        if (form.submitted){

            // The user will be sent a "password reset" email with a link
            // to a page that will collection a new password.
            location( url="./index.cfm?cfm=security.login", addToken="false" );

        }
      }

    function logout(rc) {
        // Because we don't have an active security system, explicitly 
        // forward the user to the login form.
        location( url="./index.cfm?cfm=security.login", addToken="false" );			
    }

    function passwordResetSent(rc) {
        rc.title = "Your Password Reset Email Has Been Sent";
    }

    function resetPassword(rc) {
        rc.title = "Choose A New Password";

        // Param the form values.
        param name="form.submitted" type="boolean" default="false";

        // Check to see if the form has been submitted.
        if (form.submitted){

            // Now that the user has chosen a new password, redirect them
            // back to the login screen where they can make use of it.
            location( url="./index.cfm?cfm=security.login", addToken="false" );

        }
    } 
    
}
    