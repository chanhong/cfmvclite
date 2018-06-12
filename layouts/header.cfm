<cfscript>
        /*
        if (structKeyExists(variables, "scfcs")) {
                rc.scfcs = variables.scfcs;
            } 
            */
variables.links = [
        {
        url="./index.cfm?cfm=main.contacts",            
        target="", 
        title='',
        label="Contacts",
        roles = ""
        },
        {
        url="./index.cfm?cfm=main.useful_links",            
        target="", 
        title='',
        label="Useful Links",
        roles = ""
        },
        {
        url="./index.cfm?cfc=main.contacts",            
        target="", 
        title='',
        label="aContacts",
        roles = ""
        },
        {
        url="./index.cfm?cfc=main.useful_links",            
        target="", 
        title='',
        label="aUseful",
        roles = ""
        },
        {
        url="./apps",            
        target="_blank", 
        title='',
        label="Apps",
        roles = ""
        },
        {
        url="./index.cfm?cfm=main.default&init",            
        target="", 
        title='',
        label="Home",
        roles = ""
        }
];
writeOutput(rc.core.scfcs.helper.links2ali(links));

variables.logouturl = 
        {
        url="./index.cfm?cfc=login.logout",            
        target="", 
        title='Logout',
        label="Logout",
        roles = ""
        };

variables.loginurl = 
        {
        url="./index.cfm?cfc=login.index",            
        target="", 
        title='Login',
        label="Login",
        roles = ""
        };

if (getAuthUser() is not "" or (structKeyExists( session, "auth" ) and session.auth.isLoggedIn)) {
        writeOutput("<li>"&rc.core.scfcs.helper.link2aNav(logouturl)&"</li>");
}else{        
    writeOutput("<li>"&rc.core.scfcs.helper.link2aNav(loginurl)&"</li>");
}
</cfscript>

