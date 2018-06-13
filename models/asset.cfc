component accessors=true extends="_basemodel" hint="CRUD for the Asset Table" output="false" rest="true"
{
    
        numeric function update(
            numeric id,
            string title,
            numeric idCompany,
            string description,
            string contentUrl,
            numeric idAssetType,
            string fullContent=""
        ) access="public" roles="admin,superadmin" {

            if (isdefined("form.fileUpload") and form.fileupload is not "") {
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
                title = arguments.title,
                filename = local.filename,
                idCompany = arguments.idCompany,
                description = arguments.description,
                contentUrl = 	arguments.contentUrl,
                idAssetType = arguments.idAssetType,
                fullContent = arguments.fullContent,
                updateuser = getAuthUser(),
                updatedate = local.y,
                begintime = local.y,
                id=arguments.id
            };
            local.stResult = QueryExecute(local.sql, local.param);            
            return arguments.id;
       }   

      numeric function create(string title, numeric idCompany, string description
      string contentUrl, numeric idAssetType, string  fullContent="") roles="admin,superadmin" 
      {
        local.newid = getNextId("Asset", "id");

		if (isdefined("form.fileUpload") and form.fileupload is not "") {
			local.filename = uploadFile();
        } else{
            local.filename = "";
        };
		
        local.y=LSDateFormat(now(),"mm/dd/yyyy","English (US)");
        local.sql = "insert into Asset (
            id, title, filename, idCompany, description, contentUrl, idAssetType, fullContent, updateuser, updatedate, begintime
        )
        values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ";
        local.param=[
            "#local.newid#",
            "#arguments.title#",
            "#local.filename#",
            "#arguments.idCompany#",
            "#arguments.description#",
            "#arguments.contentUrl#",
            "#arguments.idAssetType#",
            "#arguments.fullContent#",
            "#getAuthUser()#",
            "#local.y#",
            "#local.y#"
        ];
        stResult = QueryExecute(local.sql, local.param);   
        return local.newid;
    }	

	struct function delete(struct rc) roles="admin,superadmin" {
        
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
        local.stResult = QueryExecute(local.sql, local.param);            
		return {
			  id =  rc.id,
			  success = true
		}; 
    }		


}

