component extends="_basecontroller" {
// cfc as a controller, extends scfcs/basecontroller.cfc

function before(rc) {
  request.viewData.activeNavItem = rc.action;
  rc.layout = "default";  
  rc.title = rc.b.initCap(rc.action);
  rc.model = rc.mvc.models.user.init(rc.datasources.pmdsn); 
}

  function password( rc ) {
    if (structKeyExists(session,"auth.userid")) {
      rc.id = session.auth.userid;
    }
  }

  function change( rc ) {
//      rc.user = variables.userService.get( rc.id );
//      rc.message = variables.userService.checkPassword( argumentCollection = rc );
      if ( !arrayIsEmpty( rc.message ) ) {
          rc.b.redirect( "main.password", rc.message );      
      }
      var newPasswordHash = variables.userService.hashPassword( rc.newPassword );
      rc.passwordHash = newPasswordHash.hash;
      rc.passwordSalt = newPasswordHash.salt;
      // this will update any user fields from RC so it's a bit overkill here
//      variables.mvc.populate( cfc = rc.user, trim = true );
//      variables.userService.save( rc.user );
      rc.message = ["Your password was changed"];
      rc.b.redirect( "main", rc.message );      
  }

}
