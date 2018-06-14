// it can't extends due to using include in _basemodel.cfc
component accessors=true hint="Base Model" output="false" {

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
    void function dError(msg = "", error) {
       
        if (len(msg)>0) {
            writeoutput('<pre>' & msg & '</pre><br />');
        }
        writeDump( var = error, label = "db Error" );
    }    
    function escapeQuote(string iStr) {

        // clean \' into single quote before double it
        ret = (len(iStr)>0) 
//        ? REReplaceNoCase(REReplaceNoCase(iStr,"\\'", "'", 'ALL'), "'", "''", 'ALL') 
            ? REReplaceNoCase(iStr,"\\'", "'", 'ALL')
            : "";
        return ret;
    }


    function clean(struct param) {

        out = {};
        structKeys = structKeyArray(param);
        for (onekey in structKeys) {
            out[onekey] = escapeQuote(EncodeForHTML(param[onekey]));
        }
        return out;
    }


    numeric function getNextId(string tname, string fldname) {
        local.qa = QueryExecute("select max(#fldname#) as cnt from #tname#");
        local.newid = local.qa.cnt +1;
        return local.newid;
    }

    query function read(string tname, struct rc) {

        if (isNull(tname)) return;

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
            local.param = clean(rc.param);
        }
        local.sql = "select " & local.fl & " from "& tname & local.filter & local.orderby;
        // clear rc variables
        rc.fl = rc.where = rc.orderby = "";
        rc.param = {};
//		    ut.pln(local.sql, "sql");
        try {
            return QueryExecute(local.sql, local.param, {datasource = local.dsn} );
        } catch (any error) {
            dError(sql, error);
        }
    }            

    any function delete(string tname, struct rc) {

        if (isNull(tname) or !isDefined("rc.where")) return;

        local.fl = "*";
        local.param = {};
        local.filter = "";            
        local.dsn = getDsn(rc);
        if (isDefined("rc.where") and len(rc.where)>0) {
            local.filter = " where " & rc.where;
        } 
        if (StructKeyExists(rc, "param")) { // if init
            local.param = clean(rc.param);
        }
        local.sql = "delete from "& tname & local.filter;
        // clear rc variables
        rc.fl = rc.where ;
        rc.param = {};
        try {
            return QueryExecute(local.sql, local.param, {datasource = local.dsn} );
        } catch (any error) {
            dError(sql, error);
        }
    }            

    any function update(string tname, struct rc) {

        if (isNull(tname) or !isDefined("rc.fl") or !isDefined("rc.where")) return;

        local.fl = "";
        local.param = {};
        local.filter = "";            
        local.dsn = getDsn(rc);
        if (isDefined("rc.fl") and len(rc.fl)>0) {
            // fld1=:fld1,fld2=:fld2
            local.fl = rc.fl;
        } 
        if (isDefined("rc.where") and len(rc.where)>0) {
            // id=:id
            local.filter = " where " & rc.where;
        } 
        if (StructKeyExists(rc, "param")) { // if init
            local.param = clean(rc.param);
        }
        local.sql = "update #tname# set #local.fl# #local.filter#";
        // clear rc variables
        rc.fl = rc.where = "";
        rc.param = {};
        try {
            return QueryExecute(local.sql, local.param, {datasource = local.dsn} );
        } catch (any error) {
            dError(sql, error);
        }
    }            

    any function create(string tname, struct rc) {

        if (isNull(tname) or !isDefined("rc.fl")) return;

        local.fl = "";
        local.param = {};
        local.dsn = getDsn(rc);
        if (isDefined("rc.fl") and len(rc.fl)>0) {
            // (id, title, filename) values (?, ?, ?)            
            local.fl = rc.fl;
        } 
        if (StructKeyExists(rc, "param")) { // if init
            local.param = clean(rc.param);
        }
        local.sql = "insert into #tname# #local.fl#";
        // clear rc variables
        rc.fl = rc.where = "";
        rc.param = {};
        try {
            return QueryExecute(local.sql, local.param, {datasource = local.dsn} );
        } catch (any error) {
            dError(sql, error);
        }
    }            

}