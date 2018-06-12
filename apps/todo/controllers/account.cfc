component extends="_basecontroller" {
    // cfc as a controller, extends scfcs/base.cfc

    function before(rc) {
      rc.layout = "standard";
      request.viewData.activeNavItem = "profile";
    }    
    function default(rc) {
        rc.title = "Default Page";
        rc.action = "edit";
      }

    function changepassword(rc) {
        rc.title = "Change Password";
        // Param the form values.
        param name="form.submitted" type="boolean" default="false";
        // Check to see if the form has been submitted.
        if (form.submitted){
            // Now that the user has updated their password, redirect them back to the 
            // default page.
            location( url="./index.cfm", addToken="false" );
        }
      }
    
      function edit(rc) {
        rc.title = "Your Profile";
        // Param the form values.
        param name="form.submitted" type="boolean" default="false";
        // Check to see if the form has been submitted.
        if (form.submitted){
            // Now that the user has updated their account, redirect them back to the 
            // default page.
            location( url="./index.cfm", addToken="false" );

        }
      }

    function delete(rc) {
      // Now that the user has deleted the task, redirect the user back to 
      // the list of tasks.
      location( url="./index.cfm?cfm=tasks", addToken="false" );		
    }

    
}
    