component accessors=true extends="_basemodel" hint="Department Model" output="false" {
/*
    result =  new StoredProc(
    procedure        = "uspGetColours",
    datasource        = "scratch_mssql",
    result            = "anyOldShitYouLike", // seriously. It doesn't matter what value this has
    fetchclientinfo    = true,
    returncode        = true,
    parameters        = [
        {value=URL.low, cfsqltype="CF_SQL_INTEGER"},
        {value=URL.high, cfsqltype="CF_SQL_INTEGER"},
        {type="out", variable="inclusiveCount", cfsqltype="CF_SQL_INTEGER"},
        {type="out", variable="exclusiveCount", cfsqltype="CF_SQL_INTEGER"}
    ],
    procResults        = [
        {resultset=1, name="inclusive"},
        {resultset=2, name="exclusive"}
    ]
).execute();


writeDump(var=[
        result.getPrefix(),
        result.getProcResultSets(),
        result.getProcOutVariables()
]);
*/

	// Define properties for synthesized getters / setters.
	property name = "id" type = "Numeric";
	property name = "name" type = "String";


    // I return an initialized component.
    /*
	function init( 
		Numeric id,
		String name
		){

		// Set all the required properties.
		this.setID( id );
		this.setName( name );

		// Return this object reference.
		return( this );

    }
    */
    public query function get(rc) {
        return read("department", rc);
    }
            

}