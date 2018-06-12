component accessors=true hint="Shared utilities" output="false" {

    // debug helper
    function showErrorStack(){

        try {
            throw( type = "any" ); // Raise an exception so we can access the call stack.
        } catch ( any error ){
            writeDump( var = error, label = "Error" );
        }
    };

    function showCallStack(){

        aerr = callstackGet();   
        buff = "";
        for (one in aerr) {
            buff = buff & " #one.Function#(#one.LineNumber#) ";
        }         
        return " [*: #buff# *] ";
    };

    array function struct2Array(struct iVar) {

        aArr = [];
        for (d in iVar) {  // for-in loop for array
            aArr.append(d & ":" & Evaluate("iVar.#d#"));
        }
        return aArr;
    }

    array function query2Array(query iVar) {

        aArr = [];
        for (d in iVar) { // for-in loop for array
            for (key in d) {  // for-in loop for struct
                aArr.append(key & ":" & d[key]);
            }
        }
        return aArr;
    }

    void function pdg(any iVar, string iStr = "", string iFormat = "") {

        writeOutput(getDebugMsg(iVar, iStr, iFormat));
    }

    void function pln(any iVar, string iStr = "", string iFormat = "br") {
    
        writeOutput(getDebugMsg(iVar, iStr, iFormat));
    }     
    
    string function getDebugMsg(any iVar, string iStr = "", string iFormat = "") {
        
        dTrace = (len(iStr)>0 and lcase(iStr) == "dtrace") ? "dtrace" : "";
        preText = (len(iStr)>0 and lcase(iStr) != "dtrace") ?  "[-" & ucase(iStr) & "-] " : "";

        str = preText & ' Var is empty!';
        if (!isNull(iVar)) {
            if (isStruct(iVar)) {
                iVar = struct2Array(iVar);
            } else if (isQuery(iVar)) {
                iVar = query2Array(iVar);
            } 

            if (isArray(iVar)) {
                iVar = ArrayToList(iVar);            
            }
            if (len(dTrace)>0) {
                dTrace = showCallStack();
            }
            str = (!isDefined(iFormat)) ? preText & iVar : "<pre>" & preText & iVar & "</pre>";
        }
        ret = str & dTrace & " ";        
        request.dmsg = (isDefined("request.dmsg")) ?  request.dmsg &ret : ret;
        // use this on each debug to get the getFunctionCalledName();
        return ret;
    }

    // debug helper

    // general utiltity
    string function trimC(string istring, string trimchar) {

        return trimLeft(trimRight(istring, trimchar), trimchar);
    }
    
    string function trimLeft(string istring, string trimchar) {

        if (left(istring,1)==trimchar) {
            if (len(istring)>1) {
                istring = right(istring,len(istring)-1); // trim first char
            } else {
                istring = "";
            }
        } 
        return istring;
    }

    string function trimRight(string istring, string trimchar) {
        
        if (right(istring,1)==trimchar) {
            if (len(istring)>1) {
                istring = left(istring,len(istring)-1); // trim last char
            } else {
                istring = "";
            }
        } 
        return istring;
    }

    string function baseHref() {

        return getDirectoryFromPath( CGI.SCRIPT_NAME );
    }

    string function baseHrefFirst() {

        return listFirst(baseHref(), "/");
    }
        
    string function mvcBasePath() {

        // folder of rootsite or folder of subsite or null if not in a web folder
        return trimC(baseHref(),"/");
    }

    string function baseDir(string dirPath) {
        
        bseDir = '';
        if (len(mvcBasePath())>0 ) { // make sure the site is in a folder not at root
            local.envCheck = REReplaceNoCase(expandPath( dirPath ), "\\", '/', 'ALL'); 
            llast = listlast(local.envCheck,'/');
            if (len(llast)>0) {
                bseDir = llast;
            }
        }
        return bseDir;
    }

    string function isEnv(string dirPath, string mstr) {

        ret = false;
        if (len(dirPath)>0 and len(mstr)>0) {
            rstr = lcase(right(dirPath,len(mstr))); // extract the match string
            if (rstr == lcase(mstr)) {
                ret = true; 
            }
        } 
        return ret;
    }

    function whichEnv(string cDir, string alist) {

		envCheck = baseDir(cDir);
		env = "";
		pos = ListFindNoCase(alist, envCheck);
		if (pos>0) {
			env = ListGetAt(alist, pos);
		} 
		return env;
    }
    
    string function getScfcsPath(struct args) {
        
        local.baseHref = baseHrefFirst();
        // in case main site is at root
        if (len(local.baseHref)>0 and (local.baseHref != args.fld_Apps )) {
            local.baseHref = "/"&local.baseHref&"/";
        } else {
            // if in apps folder, load from site root
            local.baseHref = "/";
        }
        return local.baseHref&args.fld_Scfc;
    }
    
    string function absAppRoot() {
        local.AppRoot = REReplaceNoCase(expandPath( "./" ), "\\", '/', 'ALL'); 
        // this cause the apps/example /scfcs load fail,?
        local.AppRoot = trimright(local.AppRoot, "/");
        // C:/ColdFusion2016/cfusion/wwwroot/app/
        return local.AppRoot;
    }

    string function absWwwroot() {

        local.bseDir = mvcBasePath();
        local.aFullPath = absAppRoot();
        if (len(local.bseDir)>0 and local.bseDir != "/") { // make sure, it is not just /
            local.bdir = findNoCase(local.bseDir, local.aFullPath);
            if (local.bdir>0) {
                local.aFullPath = left(local.aFullPath,local.bdir-1); // root folder only minus baseHref
            }
        } 
        local.aFullPath = trimRight(local.aFullPath, "/");
        // E:/inetpub/wwwroot or C:/ColdFusion2016/cfusion/wwwroot
        return local.aFullPath; 
    }

    string function getAbsBaseNotApps(string path2folder, struct args) {
    
        local.baseHref = baseHrefFirst();
        // case like main site not in folder but at webroot
        local.bsePath = "";
        if (len(local.baseHref)>0 and local.baseHref != args.cfg.fld_Apps) {
            // case like /scfcs and mainsite is in a folder
            local.bsePath = local.baseHref & "/";  
        } 
//        pln(local.bsePath,getFunctionCalledName());
        return local.bsePath;
    }

    string function getAbsRelBaseNotApps(string path2folder, struct args) {
    
        local.basePathDir = mvcBasePath();
        local.bsePath = "";
        if (left(path2folder,1)=="/") {
            local.bsePath = getAbsBaseNotApps(path2folder, args);
        } else if (len(local.basePathDir)>0) {
            // case load relative folder
            local.bsePath = local.basePathDir &"/";            
        }
        return local.bsePath;
    }

    string function folder2fullpathNotApps(string path2folder, struct args) {

        // convert a folder to full path including root
        if (len(path2folder) >0) {
            local.basePathDir = getAbsRelBaseNotApps(path2folder, args);
            fullPath = absWwwroot() & "/" & local.basePathDir & trimLeft(path2folder,"/");
            // E:/inetpub/www/views/main or E:/inetpub/www/scfcs or E:/inetpub/www/site/scfcs
            return fullPath;
        }
    }

    string function folder2RelpathNotApps(string path2folder, struct args) {

        // convert a folder to full path including root
        if (len(path2folder) >0) {
            local.basePath = getAbsRelBaseNotApps(path2folder, args);
            rPath = local.basePath & trimLeft(path2folder,"/");
            // apps/examples/cfc or site/scfcs or scfcs
            return rPath;
        }
    }

    any function folder2dirlistNotApps(string path2folder, struct args) {

        param name="args.ext" type="string" default="*.cfc";
        param name="args.excl" type="string" default="";

        local.aFullPath = folder2fullpathNotApps(path2folder, args);
        local.alist = ArrayToList(directorylist(local.aFullPath, false, "name", args.ext));
        if (isDefined(args.excl) and Len(args.excl)>0) {
            local.estr = "^"&args.excl;
            // false is to return the pos
            pos = REFindNoCase(local.estr, local.alist, 1, "false");       
            if (pos>0) {
                // remove item from list that match excl param
                local.alist = ListDeleteAt( local.alist, pos);
            }
        }
        return local.alist;
    }
    // general utiltity
    
    function isLogon( string name ) {
        if (!isNull(CGI.LOGON_USER)) {
            name = CGI.LOGON_USER;
//            name = "mylogon";
        }
        return name;
    }
    
    function checkAuthorization( string name ) {
        ret = false;
        if (name == CGI.LOGON_USER) {
            ret = true;
        }
        return ret;
    }  

    boolean function splogin(string username, string password) access="remote" hint="Authenticate User" {

        spService.setProcedure("authenticate"); 
        spService.addParam(cfsqltype="cf_sql_varchar", type="in", value=username); 
        spService.addParam(cfsqltype="cf_sql_varchar",type="in",value=password); 
        spService.addProcResult(name="local.q",resultset=1); 
        result = spService.execute();
  		if (local.q.recordCount is 1) {
            cfloginuser(name=arguments.username, password=arguments.password, roles=local.q.roleName);               
        }
 	
        if (getAuthUser() is "") {
            return false;
        } else {
            return true;
        }
    }  	
  
    boolean function logout() access="public" hint="Log out user" {
        
        cflogout();
        return true;
    }

    boolean function sendPassword(string email) access="public" hint="password reminder" {

        local.q = QueryExecute("select password from appuser where endtime is null and email = :email",{email=email});
        if (local.q.recordcount ge 1) {
            savecontent variable="mailBody"{ 
                WriteOutput("This message was sent by an automatic mailer built with cfmail:= = = = = = = = = = = = = = = = = = = = = = = = = = =" & "<br><br>" & form.body); 
            }             
            mailerService = new mail(); 
            mailerService.setTo(local.q.email); 
            mailerService.setFrom("admin"); 
            mailerService.setSubject("Password Reminder"); 
            mailerService.setType("html"); 
//            mailerService.addParam(file=expandpath(form.attachment),type="text/plain",remove=false); 
            mailerService.send(body=mailBody); 
            writeOutput("<p>Your password is #local.q.password#</p>");
            return true;
        } else {
            return false;
        }
    }

    function hi(string name) {
        return "ut: hi " & name;
    }  
    /*
    function qsValue() {

        if (empty(_SERVER['QUERY_STRING']))
            return;

        // qs: ?t=users&a=login (key paired) or ?p=/users/login (path)
        arr = array();
        retUrl = "";
        qs = _SERVER['QUERY_STRING'];
        // if not login, set return url to redirect to login screen and this code works, don't change
        retArr = explode("&r=", qs, 2); // if r= in qs then ensure rs= is in the last element
        if (count(retArr) > 1) { // if r= is found then set return url
            retUrl = array_pop(retArr); // save retURL
            qs = array_pop(retArr); // change qs to exclude retURL
        }
        // if not login, set return url to redirect to login screen and this code works, don't change
        taskArr = explode("t=", qs); // ensure at least there is t=
        if (count(taskArr) > 1) {
            parse_str(qs, arr);
            arr = array_map('strtolower', arr);
            arr = array_map('trim', arr);
        } else {
            arr = array('t' => qs); // if no t then it is from front controller, patch in t
            if (!empty(retUrl))
                arr['r'] = retUrl;
        }
        return arr;
    }
    */
         
}
