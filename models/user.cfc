component accessors=true extends="_basemodel" hint="User Model" output="false" {

    
    public query function get(rc) {

        return read("appuser",rc);
    }
}