<cfscript>
    /*
    if (structKeyExists(variables, "scfcs")) {
        rc.scfcs = variables.scfcs;
    } 
    */   
if (getAuthUser() is not "" or (structKeyExists( session, "auth" ) and session.auth.isLoggedIn)) {
//    if (session.auth.user.getRoleId() is 1) {
        variables.adminUrl = [
    		{
            url="./index.cfm?cfc=company.asset",
            target="", 
            title='',
            label="Add Asset",
            roles = "admin,superadmin"
            },
            {
            url="./index.cfm?cfc=company.list",            
            target="", 
            title='',
            label="Companies",
            roles = "superadmin"
            },
            {
            url="./index.cfm?cfc=company.index",            
            target="", 
            title='',
            label="Proposal List",
            roles = "superadmin"
            },                
            {
            url="./index.cfm?cfc=user.list",            
            target="", 
            title='View the list of users',
            label="Users",
            roles = "superadmin"
            },
            {
            url="./index.cfm?cfc=user.edit",            
            target="", 
            title='Fill out form to add new user',
            label="Add/Edit User",
            roles = "superadmin"
            }
        ];
        writeOutput(rc.core.scfcs.helper.links2ali(adminUrl));
//    }
    id = "";
    if (getAuthUser() is not "" or 
    (structKeyExists( session, "auth" ) and session.auth.isLoggedIn) ) {
        if (structKeyExists(session,"auth.userid")) {
            id = "&id=" &session.auth.userid;
          }        
    } 
    variables.loggedinUrl = [
            {
            url="./index.cfm?cfc=main.password"&id,            
            target="", 
            title="Fill out form to change your password",
            label='Change Password',
            roles = "user,admin,superadmin"
            },
            {
            url="./index.cfm?cfc=login.logout",            
            target="", 
            title='Logout',
            label="Logout",
            roles = "user,admin,superadmin"
            }
    ];
    writeOutput(rc.core.scfcs.helper.links2ali(loggedinUrl));
} 
</cfscript>

