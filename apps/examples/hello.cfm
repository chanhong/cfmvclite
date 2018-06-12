<!--- Please insert your code here --->
<cfset mystruct=structnew()>
<cfset mystruct.hello="world">
<cfset mystruct.myArray=arrayNew(1)>
<cfset mystruct.myArray[1]="Hello World">
<cfset this.rootDir = getDirectoryFromPath(getCurrentTemplatePath()) />
<cfset this.mappings[ "/view" ] = "#this.rootDir#templates/" />
<cfoutput>hello</cfoutput>
<cfdump var="#mystruct#">                                 