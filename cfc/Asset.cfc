<cfcomponent hint="CRUD for the Asset Table" output="false" rest="true" restpath="asset">

	<cffunction name="downloadFile" access="remote" returntype="void">
		
			<cfargument name="id" type="numeric" required="true">
			
			<cfset local.qrec = get(id=arguments.id)>
			<cfset local.filespec = application.uploaddir & local.qrec.filename>
			
			<cflog file="downloader" 
			   text="Filespec: #local.qrec.filename#, #local.qrec.recordcount#" 
			   type="information">
			
			<cfheader name="Content-Disposition" value="attachment; filename=#local.qrec.filename#">
			<cfcontent file="#local.filespec#">
			
		
	</cffunction>



	<cffunction name="get" access="remote" returntype="query" httpMethod="GET" >
		<cfargument name="searchterm" required="false" type="string" default="" restargsource="query">
		<cfargument name="id" type="numeric" required="false" default="-1" restargsource="query">
		
		<cfif isdefined("url.init") or trim(arguments.searchterm) is not "" or arguments.id gt 0>
			<cfset local.timespan = createtimespan(0,0,0,0)>
		<cfelse>
			<cfset local.timespan = createTimeSpan(0,0,5,0)>
		</cfif>
	<cfset qry=""/>
	<cfset qwhere0=""/>
	<cfset qwhere1=""/>
	<cfset qorder=""/>
		<cfset qry="
			select 	asset.id, 
					asset.title,
					asset.updatedate,
					company.companyName,
					asset.filename,
					assetType.text as assetType,
					asset.idAssetType,
					asset.idCompany,
					asset.description,
					asset.contentUrl,
					asset.fullContent
			from	asset join company
						on asset.idCompany = company.id
					join assetType
						on asset.idAssetType = AssetType.id	
			where 	asset.endtime is null"/>

			<cfset qorder = " order by updatedate desc"/>
		<cfquery name="local.q" cachedwithin="#local.timespan#">
			#qry# 
			<cfif arguments.searchterm is not "">
				and (
				title like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.searchterm#%">
				or description like	<cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.searchterm#%">
				or fullContent like	<cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.searchterm#%">
				)
		  </cfif>
		  
		  <cfif arguments.id gt -1>
			  and asset.id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.id#">
		  </cfif>			
		#qorder#
		</cfquery>
		<cfreturn local.q>
		
	</cffunction>
	
	<cffunction name="downloadBioPDFFile" access="remote" returntype="void">
		
			<cfargument name="id" type="numeric" required="true">
			<!--- Grab content to use in generating PDF--->
			<cfset local.qrec = get(id=arguments.id)>
			<cfdump var="#application#">
			<cfdump var="#this#">
			<!--- 
			<cfabort>
			--->
				
			<!--- Create a filename for the PDF --->
			<cfset local.filespec = application.PDFGenDir & replacenocase(local.qrec.title," ","_","all") & ".pdf">
			<!--- Create a structure to hold data to be passed into cfdocumentitem --->
			<cfset local.stqRec = StructNew()>
			<cfset local.stqRec.Title = local.qrec.title>
			
			<cfdump var="#local.qrec#">
		<cfdump var="#local.filespec#">

			<!--- Log each created PDF --->
			<cflog file="biopdfdownloader" 
			   text="Filespec: #local.filespec#" 
			   type="information">
			   
			<!--- Walk 6-1 Part 1 (Generate the tag) --->   
			<!--- Walk 6-1 Part 2 (Add a header and footer)  --->
			<cfdocument format="PDF" filename="#local.filespec#" overwrite="true">
				<cfdocumentitem type="header" attributecollection="#local.stqRec#">
				<cfoutput><b>#attributes.title#</b></cfoutput>
				</cfdocumentitem>
				<cfdocumentitem type="footer">
					Copyright &copy; Fig Leaf Software
				</cfdocumentitem>
				<cfoutput>fullcontent: #local.qrec.fullContent#</cfoutput>
			</cfdocument> <!--- ---> 
			
			<!--- Walk 6-1 Part 3 (Create the PDF using CFHTMLTOPDF)  
			<cfhtmltopdf destination="#local.filespec#" margintop="1" marginleft=".5" marginright=".5" overwrite="true">
				<cfhtmltopdfitem type="header" marginleft=".6" marginbottom=".5" align="Left" attributecollection="#local.stqRec#">
				  <cfoutput><b>#attributes.title#</b></cfoutput>
				</cfhtmltopdfitem>
				<cfhtmltopdfitem type="footer" marginleft=".5" align="Left">
				    Copyright Fig Leaf Software
				</cfhtmltopdfitem>
				<cfoutput>#local.qrec.fullContent#</cfoutput>
			</cfhtmltopdf>
			--->  
			<!--- Return the newly created PDF --->
			<cfheader name="Content-Disposition" value="attachment; filename=#local.filespec#">
			<cfcontent file="#local.filespec#">
			
		
	</cffunction>

	<cffunction name="downloadspreadsheet" access="remote" returntype="void">
		<cfargument name="searchterm" type="string" required="false" default="">

		<cfset local.q = get(arguments.searchterm)>
		<cfset local.sObj = spreadsheetNew()>
		<cfset local.colNum = 1>

		<!--- define header row --->
		<cfset SpreadsheetAddRow(sObj, local.q.columnlist, 1)>
		<cfloop from="1" to="#listlen(local.q.columnlist)#" index="local.i">
			<cfset spreadsheetFormatCell(
				local.sObj,
				{
					bold="true",
					alignment="center"
				},
				1,
				local.i
			)>
		</cfloop>

		<cfloop from="1" to="#local.q.recordcount#" index="local.i">
			<cfset local.colNum = 1>
			<cfloop list="#local.q.columnlist#" index="thisCol">
				<cfset spreadsheetSetCellValue(
					local.sObj,
					local.q[thisCol][local.i],
					local.i + 1,
					local.colNum
				)>
				<cfset local.colNum++>
			</cfloop>
		</cfloop>

		<cfset local.filename = application.pdfGenDir & "/" & createUUID() & ".xls">
		<cfdump var="#local.filename#">
		<cfspreadsheet
			 action="write"
			 filename = "#local.filename#"
			 name = "local.sobj" 
			 overwrite = "true"
			 sheetname = "Assets" >

		<cfheader name="Content-Disposition" value="attachment; filename=Assets.xls">
		<cfcontent file="#local.filename#" deletefile="true">

	</cffunction>

	
	<cffunction name="getdetail" 
            access="remote"
            returntype="query"
            httpMethod="get"
            restpath="{id}">
  
 		<cfargument name="id" type="string" required="true" restargsource="Path">

 		<cfset local.q = get(id=arguments.id)>

 		<cfreturn local.q>

 	</cffunction>

</cfcomponent>

