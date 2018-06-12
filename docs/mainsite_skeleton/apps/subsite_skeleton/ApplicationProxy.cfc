// copy this file to subsite in the apps folder
component {
// include the root Application.cfc
	local.baseHref = listFirst(getDirectoryFromPath( CGI.SCRIPT_NAME ), "/");
    // in case main site is at root
	if (len(local.baseHref)>0 and (local.baseHref != "apps" )) {
		local.baseHref = "/"&local.baseHref&"/";
    } else {
        // if in apps folder, load from site root
		local.baseHref = "/";
    }
    bfile = local.baseHref&"Application.cfc";
    include bfile;
}