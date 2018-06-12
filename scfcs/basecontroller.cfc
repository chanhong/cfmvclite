// it can't extends due to using include in _basecontroller.cfc
component 
    accessors=true hint="Base Controller" output="false" {
    // cfc as a controller 

    // dynamically call function
    function startmvc(rc) {
        before(rc);
        if (isDefined(rc.action)) {
            Evaluate("#rc.action#(rc)");
        }
        rc.b.renderFullView(rc);    
    }

    // set some variables before action and view
    function before(rc) {
        variables.rc = rc;
        return this;
    }
    
    function hi(string name) {
        return "hi " & name;
    }  
}