// it can't extends due to using include in _basemodel.cfc
component 
    accessors=true hint="Base Model" output="false" {

        if (isNull(ut)) {
            ut = new util();
        }

        function init(String dsn){

            this.dsn = dsn;    
            return( this );
        }

        string function getDsn(struct rc) {

            if (StructKeyExists(this, "dsn") and isDefined(this.dsn)) { // if init
                local.dsn = this.dsn;
            } else if (isDefined("rc.dsn")) {
                local.dsn = rc.dsn;
            } else {
                local.dsn = rc.datasource;
            }
            return local.dsn;
        }

        numeric function getNextId(string tname, string fldname) {
            local.qa = QueryExecute("select max(#fldname#) as cnt from #tname#");
            local.newid = local.qa.cnt +1;
            return local.newid;
        }

        query function read(string tname, struct rc) {

            if (isNull(tname)) return;

            param name="rc.param" type="struct" default={};

            local.fl = "*";
            local.orderby = "";
            local.param = {};
            local.filter = " where 1=1";            
            local.dsn = getDsn(rc);
            if (isDefined("rc.fl") and len(rc.fl)>0) {
                local.fl = rc.fl;
            } 
            if (isDefined("rc.where") and len(rc.where)>0) {
                local.filter = " where " & rc.where;
            } 
            if (isDefined("rc.orderby") and len(rc.orderby)>0) {
                local.orderby = " order by " & rc.orderby;
            } 
            if (StructKeyExists(rc, "param")) { // if init
                local.param = rc.param;
            }
            local.sql = "select " & local.fl & " from "& tname & local.filter & local.orderby;
            // clear rc variables
            rc.fl = rc.where = rc.orderby = "";
            rc.param = {};
//		    ut.pln(local.sql, "sql");
            return QueryExecute(local.sql, local.param, {datasource = local.dsn} );
        }            
}