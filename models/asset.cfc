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

    numeric function update(struct rc, any iform
        ) access="public" roles="admin,superadmin" {

            local.dsn = getDsn(rc);
            if (isdefined("iform.fileUpload") and iform.fileupload is not "") {
                local.filename = uploadFile();
            } else {
                local.filename = "";
            };

            local.y=LSDateFormat(now(),"mm/dd/yyyy","English (US)");
            local.sql = "
            update Asset 
            set 
            title = :title,
            filename = :filename,
            idCompany = :idCompany,
            description = :description,
            contentUrl = 	:contentUrl,
            idAssetType = :idAssetType,
            fullContent = :fullContent,
            updateuser = :updateuser,
            updatedate = :updatedate,
            begintime =:begintime
            where id=:id";
            local.param={
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
            local.stResult = QueryExecute(local.sql, local.param, {datasource = local.dsn});            
            return iform.id;
       }   

      numeric function create(struct rc, any iform
      ) roles="admin,superadmin" 
      {
        local.dsn = getDsn(rc);          
        local.newid = getNextId("Asset", "id");

        if (isdefined("iform.fileUpload") and iform.fileupload is not "") {
			local.filename = uploadFile();
        } else{
            local.filename = "";
        };
		
        local.y=LSDateFormat(now(),"mm/dd/yyyy","English (US)");
        local.sql = "insert into Asset 
        (id, title, filename, idCompany, description, contentUrl, idAssetType, fullContent, updateuser, updatedate, begintime)
        values 
        (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ";
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
        stResult = QueryExecute(local.sql, local.param, {datasource = local.dsn});   
        return local.newid;
    }	

	struct function delete(struct rc) roles="admin,superadmin" {

        local.dsn = getDsn(rc);
        local.y=LSDateFormat(now(),"mm/dd/yyyy","English (US)");
        local.sql = "
        update asset
        set 
        endtime =:endtime,
        updateuser = :updateuser
        where id=:id";

        local.param={
            endtime = local.y,
            updateuser = getAuthUser(),
            id=rc.id
        };
        local.stResult = QueryExecute(local.sql, local.param, {datasource = local.dsn});            
		return {
			  id =  rc.id,
			  success = true
		}; 
    }		


}

