component extends="mvcbase"
	output="false"
	hint="mvclite loader"
	{
    /* 
    example:
    loader = createObject("component", "scfcs.loader");
	this.core = loader.cfc_loader(["/scfcs"]);
    this.mvc =  loader.cfc_loader(["controllers","models"]);
    */
    struct function cfc_loader(array afolders=["scfcs"], struct args = { } ) {
        
        local.astruct = structnew();
        for (local.path2folder in afolders) {
            // need to stay up here to ensure get the original path before removing of the plural
            args.cfcPath = local.path2folder;
            local.folderpath2cfcpath = filepath2Cfcpath(local.path2folder, args);

            local.aList = folder2dirlistNotApps(local.path2folder, args);
            local.thiscfcFolder = cfcfolder_noslash(local.path2folder);
//            pln(local.aList, getFunctionCalledName());
            for (local.fname in local.aList) {
                local.thisName = listFirst(local.fname,"."); // no extension
                // cfc group name in array should have no slash            
                local.cfcGroup = local.thiscfcFolder & "." & local.thisName;
                local.acfc = local.folderpath2cfcpath & local.thisName;
//                pln(local.acfc,"acfc");
                local.astruct[local.cfcGroup] = createObject("component", local.acfc);
            }	
        }
        return local.astruct;
    }

    string function cfcfolder_noslash(string path2folder) {
        
        local.thiscfcFolder = path2folder;
        // need to stay up here to ensure get the original path before removing of the plural
    
        /*
        // make sure cfc path has no plural to be use as cfc name in array
        if (right(lcase(local.thiscfcFolder),1)=="s"){
            local.thiscfcFolder = left(local.thiscfcFolder,len(local.thiscfcFolder)-1); // no plural
        }
        */
        if (left(local.thiscfcFolder,1)=="/") {
            local.thiscfcFolder = right(local.thiscfcFolder,len(local.thiscfcFolder)-1); // no front slash
        }   
        return local.thiscfcFolder;    
    }
    
}    
    