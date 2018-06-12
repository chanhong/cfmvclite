component extends="_basecontroller" {

    function before(rc) {
        request.viewData.activeNavItem = rc.action;
        rc.layout = "default";  
        rc.title = rc.b.initCap(rc.action);
        rc.model = rc.mvc.models.company.init(rc.datasources.pmdsn); 
      }
      
    function edit( rc ) {
        rc.data = rc.model.get(rc);  
    }

    function asset( rc ) {
        if (getAuthUser() is "" or (structKeyExists( session, "auth" ) and session.auth.isLoggedIn == false)) {
            rc.b.redirect( "login.index", "message" );
		} 
        rc.title = "Asset Edit";
    }    

    function index( rc ) {
        rc.title = "Proposal List";
        rc.cfcFolder = "cfc";
    }    
    
    function list( rc ) {
        rc.data = rc.model.get(rc);  
        rc.title = "Company List";
    }    
}