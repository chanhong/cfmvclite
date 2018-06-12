// this cfc only work with datasource that is defined in administration
component 
	output="false"
	hint="create dao in mvc"
{
    
    function init(struct args) {
        param name="args.dsn" type="string" default="";
        param name="args.dbtype" type="string" default="";
        param name="args.user" type="string" default="";
        param name="args.password" type="string" default="";
        param name="args.writeTransactionLog" type="boolean" default=false;
        param name="args.transactionLogFile" type="string" default="";
        param name="args.useCFQueryParams" type="boolean" default=true;
        param name="args.autoParameterize" type="boolean" default=false;
        param name="args.nullValue" type="string" default="$null";
        
        local.baseHref = args.b.rootPath4Cfc(args);
        dao = createObject("component", "#local.baseHref#vendor.dao.database.dao");

        return dao.init(    
            dsn = args.dsn,
            dbtype = args.dbtype,
            user = args.user,
            password = args.password,
            writeTransactionLog = args.writeTransactionLog,
            transactionLogFile = args.transactionLogFile,
            useCFQueryParams = args.useCFQueryParams,
            autoParameterize = args.autoParameterize,
            nullValue = args.nullValue);

    }
}