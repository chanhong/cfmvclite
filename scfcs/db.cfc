// this cfc only work with datasource that is defined in administration
component 
	output="false"
	hint="database for mvc"
{
    void function dError(msg = "") {
       
        if (len(msg)>0) {
            writeoutput('<pre>' & msg & '</pre><br />');
        }
        writeDump( var = error, label = "db Error" );
    }
    
    query function query(string sql, struct param, struct options) {
        
        param name="param" type="struct" default={};
        param name="options.datasource" type="string" default="datasource";
        
        try {
            return QueryExecute(sql, param, options);
        } catch (any error) {
            dError(sql);
        }
    }

    function escapeQuote(string iStr) {

        // clean \' into single quote before double it
        ret = (len(iStr)>0) 
            ? REReplaceNoCase(REReplaceNoCase(iStr,"\\'", "'", 'ALL'), "'", "''", 'ALL') 
            : "";
        return ret;
    }
}