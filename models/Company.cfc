component accessors=true extends="_basemodel" hint="Company Table CRUD" output="false" {
        
    query function get(struct rc) {
        local.id = "0";
        local.one = "";
        if ( structKeyExists( rc, "id" ) && len( rc.id ) ) {
            local.id = rc.id;  
            local.one = " and id=?"; 
            rc.param =  {id=local.id};
        }
        rc.where = "endtime is null#local.one#";
        rc.orderby = "companyName";
        return read("company", rc);
    }
}
