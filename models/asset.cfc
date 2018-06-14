component accessors=true extends="_basemodel" hint="CRUD for the Asset Table" output="false" rest="true"
{
    string function uploadFile() roles="admin,superadmin" {
		
		stData = {};
        
		stData = fileUpload(
			"#application.uploaddir#", 
			"fileupload",
			"image/jpg,image/jpeg,application/pdf",
			"makeunique"); 
		
		return stdata.serverfile;
       }

    struct function markAsDelete(any rc) roles="admin,superadmin" {

        local.y=LSDateFormat(now(),"mm/dd/yyyy","English (US)");
        structAppend(rc, {
            fl = "endtime=:endtime,updateuser=:updateuser",
            where = "id=:id",
            param ={
                endtime = local.y,
                updateuser = getAuthUser(),
                id=rc.id
            }
        });
        local.stResult = update("asset", rc);
		return {
            id =  rc.id,
            success = true
		}; 
    }		

    numeric function updateRec(struct rc, any iform
        ) access="public" roles="admin,superadmin" {

            local.dsn = getDsn(rc);
            if (isdefined("iform.fileUpload") and iform.fileupload is not "") {
                local.filename = uploadFile();
            } else {
                local.filename = "";
            };

            local.y=LSDateFormat(now(),"mm/dd/yyyy","English (US)");

            local.fl = "
            title = :title,
            filename = :filename,
            idCompany = :idCompany,
            description = :description,
            contentUrl = :contentUrl,
            idAssetType = :idAssetType,
            fullContent = :fullContent,
            updateuser = :updateuser,
            updatedate = :updatedate,
            begintime =:begintime";

            local.param ={
                title = iform.title,
                filename = local.filename,
                idCompany = iform.idCompany,
                description = iform.description,
                contentUrl = iform.contentUrl,
                idAssetType = iform.idAssetType,
                fullContent = iform.fullContent,
                updateuser = getAuthUser(),
                updatedate = local.y,
                begintime = local.y,
                id=iform.id
            };

            structAppend(rc, {
                fl = local.fl,
                where = "id=:id",
                param = local.param
            });
            local.stResult = update("asset", rc);
            return iform.id;
       }   

      numeric function createRec(struct rc, any iform
      ) roles="admin,superadmin" 
      {
        local.dsn = getDsn(rc);          
        local.newid = getNextId("Asset", "id");

        if (isdefined("iform.fileUpload") and iform.fileupload is not "") {
			local.filename = escapeQuote(uploadFile());
        } else{
            local.filename = "";
        };
		
        local.y=LSDateFormat(now(),"mm/dd/yyyy","English (US)");
        local.fl = "(id, title, filename, idCompany, description, contentUrl, idAssetType, fullContent, updateuser, updatedate, begintime)
            values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        local.param=[
            "#local.newid#",
            "#iform.title#",
            "#local.filename#",
            "#iform.idCompany#",
            "#iform.description#",
            "#iform.contentUrl#",
            "#iform.idAssetType#",
            "#iform.fullContent#",
            "#getAuthUser()#",
            "#local.y#",
            "#local.y#"
        ];
        structAppend(rc, {
            fl = local.fl,
            param = local.param
        });
        local.stResult = create("asset", rc);
        return local.newid;
    }	

}

