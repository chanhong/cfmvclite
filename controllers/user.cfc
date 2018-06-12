component extends="_basecontroller" {

    function before(rc) {
        request.viewData.activeNavItem = rc.action;
        rc.layout = "default";  
        rc.title = rc.b.initCap(rc.action);
        rc.model = rc.mvc.models.user.init(rc.datasources.pmdsn); 
      }
          
    function default( rc ) {
        rc.message = "Welcome user!";
    }

    function delete( rc ) {
//        variables.userService.delete( rc.id );
        rc.b.redirect( "user.list" );      
    }
	
    function edit( rc ) {
        rc.title = "User Form";        
    }

    function get( rc ) {
//        rc.data = variables.userService.get( rc.id );
    }

    function list( rc ) {
        rc.data = rc.model.get(rc);  
    }

    function save( rc ) {
        rc.deptmodel = rc.mvc.models.department.init(rc.datasources.pmdsn); 
        if ( structKeyExists( rc, "departmentId" ) && len( rc.departmentId ) ) {
  //          user.setDepartmentId( rc.departmentId );
  //          user.setDepartment( variables.departmentService.get( rc.departmentId ) );
        }
//        variables.userService.save( user );
        rc.b.redirect( "user.list" );      
        
    }

}
