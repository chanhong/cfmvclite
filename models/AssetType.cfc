component accessors=true extends="_basemodel" hint="AssetType Table CRUD" output="false" {

    query function get(struct rc) {
        rc.orderby = "text";
        return select("assettype", rc);
	}
}
