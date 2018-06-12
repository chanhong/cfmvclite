// this cfc only work with datasource that is defined in administration
component 
	output="false"
	hint="database for mvc"
{
  /*
    queryObj = new Query(); or queryObj = createObject("component","query");
    queryObj.addParam(name="mediaId",value="1",cfsqltype="numeric");
    result = queryObj.execute(sql="select ArtName from art where mediaId = :mediaId");

    queryObj.clearParams();
    queryObj = new query();
    queryObj.setDatasource("cfartgallery");
    queryObj.setName("qListOfArts");
    queryObj.addParam(name="price",value="32000",cfsqltype="NUMERIC");
    queryObj.addParam(name="mediaid",value="1",cfsqltype="NUMERIC");
    queryObj.addParam(name="isSold",value="0",cfsqltype="SMALLINT");
    result = queryObj.execute(sql="SELECT artname,description,price FROM Art WHERE mediaId = :mediaid and isSold = :isSold and price > :price");
    qListOfArts = result.getResult();
    metaInfo = result.getPrefix();
    queryObj.clearParams();
    writeDump(qListOfArts);
    writeDump(metaInfo);

    myQry = new Query(); // new query object     
    myQry.setSQL("select bookid, title, genre from app.books where bookid = :bookid"); //set query
    myQry.addParam(name="bookid",value="5",CFSQLTYPE="CF_SQL_INTEGER"); // add query param
    qryRes = myQry.execute(); // execute query
    writedump(qryRes.getResult().recordcount, true); // get resultcount
    writedump(qryRes.getResult(), false); // dump result
    writeoutput('<BR>');

exampleData = queryNew("id,title","integer,varchar",[{"id":1,"title":"Dewey defeats Truman"},{"id":2,"title":"Man walks on Moon"}]);

result = queryExecute(
  "SELECT title FROM exampleData WHERE id = ?", 
  [
    { value=2, cfsqltype="cf_sql_varchar" }
  ],
  { dbtype="query" }
);
writeOutput( result.title[1] );

result = queryExecute(
  "SELECT title FROM exampleData WHERE id = :id", 
  { id = 2 },
  { dbtype="query" }
);
writeOutput( result.title[1] );

cfquery(name = "friends",datasource = "testing",
sql = "SELECT * FROM friend WHERE id > 1 ORDER BY id ASC"
);
writeDump( var = friends, label = "Friends" );

friends = queryExecute("SELECT * FROM friend WHERE id > :id ORDER BY id ASC",
{id: {value: 1, cfSqlType: "cf_sql_integer"}},
{datasource: "testing"}
);
writeDump( var = friends, label = "Friends" );

q = new com.adobe.coldfusion.query(); 
q.setDatasource("cfartgallery"); 
q.setSQL("select * from art where artname like :search or description like :search"); 
q.addParam(name="search",value="%e%",cfsqltype="cf_sql_varchar");
r = q.execute();
writeDump(r);

*/

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
/*    
    function getKeyVal(iValue, key, default="") {

        if (len(iValue[key]>0)) {
            return iValue[key];
        } elseif (len(default)>0) {
            return default;
        }
        else {
            return;
        }
    }

    function fieldsKey(table, filter="id") {

        try {
            $row = (array) query("select * from ".table);
            // remove array element base on filter if _none_ no filter
            if (strtolower(filter)!="_none_") {
                // default is to filter id field
                unset(row[filter]);
            }
            return array_keys(row);
        } catch (any error) {
            dError(sql);
        }
    } 

    function dbFetch(qhandle, atype = "assoc") {

        try {
            if (is_object(qhandle)) {
                type = getPDOFetchType(atype);
                return qhandle->fetch(type);
            }
        } catch (any error) {
            dError(sql);
        }
            
        } catch (PDOException $e) {
            dbError(getFunctionCalledName());
        }
    }    

    public static function findRow(sql, atype = "obj") {

        return dbFetch(query(sql), atype);
    }
       
    function schema($table, $filter="id") {

        try {    
            return array_flip(self::fieldsKey($table, $filter));
        } catch (Exception $e) {
            echo $e->getTraceAsString();
        }        
    }    

    public static function filterBySchema(tname, iArray) {

        try {    
            $fields = self::schema($tname,"_none_");
            // diff in array with schma fields
            $diffs = array_diff_key($iArray, $fields);
            // remove unwanted fields
            foreach ($diffs as $k=>$v) {
                unset($iArray[$k]);
            }
            return $iArray;    
        } catch (Exception $e) {
            echo $e->getTraceAsString();
        }        
                    
    }

    function getSUDIOptions(opr, tname, options={}) {
    
        try {
            fldList = "";
            
            iFldList = getKeyVal(options, 'fl');
            where = getKeyVal(options, 'where');
            otype = getKeyVal(options, 'type');
            defaultArray = getKeyVal(options, 'default');
            
            switch (lcase(opr)) {
                case "update":
                    if (len(iFldList)>0 and is_array($iFldList)) {
                        $fldList = self::a2sUpdate(self::filterBySchema($tname, $iFldList), $defaultArray);
                    }
                    break;
                case "insert":
                    if (!empty($iFldList) and is_string($iFldList)) {
                        // fields list then flip the array to key
                        $iFldList = array_flip(explode(",", str_replace(' ','',$iFldList)));
                    } 
                    if (!empty($iFldList) and is_array($iFldList)) {
                        $fldList = self::a2sInsert(self::filterBySchema($tname, $iFldList), $defaultArray);
                    }
                    break;
                case "select":
                defailt :
                    if (!empty($iFldList) and is_string($iFldList)) {
                        // fields list then flip the array to key
                        $iFldList = array_flip(explode(",", str_replace(' ','',$iFldList)));
                    } 
                    
                    if (!empty($iFldList) and is_array($iFldList)) {
                        $fldList = self::a2sSelect(self::filterBySchema($tname, $iFldList));
                    }
            }
            return ['fl'=>fldList, 'where'=>where, 'type'=>otype];
        } catch (any error) {
            dError(sql);
        }
    }
    

    public static function qbSelect(tname, options=[]) {

        if (isNull(tname)) return;
        
        $one = self::getSUDIOptions("select", $tname, $options);        
        
        (!empty($one['where']))
            ? $where = " WHERE " & $one['where']
            : $where = "";
            
        (empty($one['fl'])) 
            ? $iFldList = "*"
            : $iFldList = $one['fl']
        ;
        
        return "SELECT " . $iFldList
            . " FROM ". $tname 
            . $where . ";"
        ;
    }
*/
}