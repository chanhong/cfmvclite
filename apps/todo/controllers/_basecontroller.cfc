// put this file in the controllers folder of the main site or apps site
component {
    // request.scfcPath is defined in Application.cfc
    // include the basecontroller.cfc from scfcs  
    bfile = request.scfcPath & "/basecontroller.cfc";
    include bfile;
}