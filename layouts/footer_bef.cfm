<cfscript>
        /*
        if (structKeyExists(variables, "scfcs")) {
                rc.scfcs = variables.scfcs;
            } 
            */
variables.links = [
        {
        url="http://msn.com",
        target="_blank", 
        title='',
        label="MSN"
        },
        {
        url="http://bing.com",
        target="_blank", 
        title='',
        label="Bing"
        },
        {
        url="http://google.com",
        target="_blank", 
        title='',
        label="Google"
        }
];
writeOutput(rc.core.scfcs.helper.links2ali(links));
</cfscript>