component accessors=true hint="MVCLite Core" output="false" {

    if (isNull(ut)) {
        ut = new util();
    }

    if (isNull(hlp)) {
        hlp = new helper();
    }

    function hi(string name) {
        return ut.hi(name);
    }       

    // usage: permDbg(somevar, getFunctionCalledName());
    function permDbg(iVar, iStr = "", iFormat = "") {
        
        debugon = (isDefined("request.debug") and lcase(request.debug) == "y") ? true : false;
        if (debugon == true
//          and hadGroup("admin") 
          ) {
            return ut.getDebugMsg(iVar, iStr, iFormat);
        }
    }
    
    void function pdg(any iVar, string iStr = "", string iFormat = "") {

        ut.pdg(iVar, iStr, iFormat);
    }

    void function pln(any iVar, string iStr = "", string iFormat = "br") {
    
        ut.pln(iVar, iStr, iFormat);
    }     
    
    string function mvcBasePath() {
        
        return ut.mvcBasePath();
    }

    string function folder2RelpathNotApps(string path2folder, struct args) {

        return ut.folder2RelpathNotApps(path2folder, args);
    }

    any function folder2dirlistNotApps(string path2folder, struct args) {

        return ut.folder2dirlistNotApps(path2folder, args);
    }

    string function filepath2Cfcpath(string path2folder, struct rc) {

        // convert file path to component path
        if (len(path2folder) >0) {
            local.cfcFilePath = ut.folder2RelpathNotApps(path2folder, rc);
            rpath = REReplaceNoCase(local.cfcFilePath, "/", '.', 'ALL'); 
            rpath = ut.trimLeft(rpath, ".") & ".";
            return rpath;
        }
    }

    // use in dao.cfc
	string function rootPath4Cfc(struct args) {

		// baseHref is null if run at rootsite 
        local.baseHref = ut.baseHrefFirst();
        // cfg is set in application to point to apps folder
		if (len(local.baseHref)>0 and local.baseHref != args.cfg.fld_Apps) {
			local.baseHref = local.baseHref&".";
		} else if (len(local.baseHref)>0 and local.baseHref == args.cfg.fld_Apps) {			
			local.baseHref = "";
		} 
		return local.baseHref;
    }

    string function captureContents( any fspecOrBuff, struct args = { } ) {

        if (isDefined(args.action) and len(args.action>0)) {
            param name="args.activeNavItem" type="string" default=args.action;
            param name="request.viewData.activeNavItem" type="string" default=args.activeNavItem;
        }
       
        savecontent variable="buffer"{
            // pass variable this from cfm into rc to be the same as cfc to be used by view or layout
            rc = args;
            vfile = ExpandPath(fspecOrBuff);
            if (FileExists(vfile)) {
                include fspecOrBuff;
            } else {
                writeOutput(fspecOrBuff);
            }
        }
        return buffer;
    }

    function doErrorView(rc) {

        request.failedAction = rc.ctl;
        rc.body = captureContents( "/#rc.cfg.fld_View#/error.cfm", rc);
        doLayout(rc); 
    }

    // view helper to show other view or use as partial view
    function view(string vfile, struct rc) {

        rc.action = vfile;
        // parsing ctl.action into respective variable to show other controller view in the view
        pos = REFindNoCase(".", vfile, 1, "false");       
        if (pos>0) {
            mya = ListToArray(vfile,'.');
            rc.ctl = mya[1];
            rc.action = mya[2];
        }
        return doView(rc);
    }    
    
    function doView(rc) {
        // in case the need to show share view in the views folder not belong to any controller
        if (left(rc.action,1)=="/") {
            rc.action = right(rc.action,len(rc.action)-1); // no front slash
            vfile0 = "#rc.cfg.fld_View#/#rc.action#.cfm";
        } else {
            vfile0 = "#rc.cfg.fld_View#/#rc.ctl#/#rc.action#.cfm";
        }
        if (!FileExists(ExpandPath(vfile0))) {
            vfile0 = "#rc.cfg.fld_View#/error.cfm";
        }
        // use slash to start from site root defined in the mapping to find file
        return captureContents( "/#vfile0#", rc);
    }    

    function doLayout(rc) {

        vfile0 = "#rc.cfg.fld_Layout#/#rc.layout#.cfm";
        if (FileExists(ExpandPath(vfile0))) {
            buff = captureContents("/#vfile0#", rc);
            request.dmsg = "";			
            writeOutput(buff);
        } else {
            rc.errMessage = "FATAL: #rc.layout# is not found!";
            writeOutput(captureContents( "#rc.errMessage#", rc));
        }
    }
    
    function renderFullView(rc) {

        rc.body = doView(rc);
        doLayout(rc);    
    }    
       
    function initCap(string text){
        return rereplace(lcase(arguments.text), "(\b\w)", "\u\1", "all");
    }

    void function redirect(string action, string message="") {
        local.targetUrl="./index.cfm?cfc=#action#";
        location( url="#local.targetUrl#", addToken=false );
    }
    
}