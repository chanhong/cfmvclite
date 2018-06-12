// put this file in the models folder of the main site or apps site
component {
    // request.scfcPath is defined in Application.cfc
    // include the basemodel.cfc from scfcs  
    bfile = request.scfcPath & "/basemodel.cfc";
    include bfile;
}