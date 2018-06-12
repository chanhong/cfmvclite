component extends="_basecontroller" {
// cfc as a controller, extends scfcs/base.cfc

function before(rc) {
  rc.layout = "standard";
  request.viewData.activeNavItem = "tasks";
}  

function default(rc) {
  
  rc.title = "Default Page";
  rc.action = "list";
}


function list(rc) {
    rc.title = "Your Current Tasks";
  }

  function edit(rc) {
    rc.title = "Task Details";

    // Param the form values.
    param name="form.submitted" type="boolean" default="false";

    // Check to see if the form has been submitted.
    if (form.submitted){
        // Now that the user has updated the task, redirect them back to the 
        // list of tasks.
        location( url="./index.cfm?cfc=tasks", addToken="false" );
    }

  }

}
