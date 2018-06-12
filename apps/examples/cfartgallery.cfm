<!--- The following query extracts data from the cfartgallery database. ---> 
<cfquery name="artwork" datasource="cfartgallery"> 
SELECT FIRSTNAME || ' '|| LASTNAME AS FULLNAME, ARTISTS.ARTISTID, ARTNAME, PRICE, ISSOLD 
FROM ARTISTS, ART 
WHERE ARTISTS.ARTISTID = ART.ARTISTID 
ORDER BY LASTNAME 
</cfquery> 

<!--- The following query of queries determines the total dollar amount of 
sales per artist. ---> 
<cfquery dbtype="query" name="artistname"> 
SELECT FULLNAME, 
SUM(PRICE) AS totalSale 
FROM ARTWORK 
WHERE ISSOLD = 1 
GROUP BY FULLNAME 
ORDER BY totalSale 
</cfquery> 

<!--- The following code determines the look of the slide presentation. ColdFusion displays the slide presentation directly in the browser because no destination is specified. The title appears above the presenter information. ---> 
<cfpresentation title="Art Sales Presentation" primaryColor="##0000FF" glowColor="##FF00FF" lightColor="##FFFF00" showOutline="yes" showNotes="yes"> 

<!--- The following code defines the presenter information. You can assign each presenter to one or more slides. ---> 
<cfpresenter name="Aiden" title="Artist" email="Aiden@artgallery.com" > 
<cfpresenter name="Raquel" title="Artist" email="raquel@artgallery.com" > 
<cfpresenter name="Paul" title="Artist" email="paul@artgallery.com" > 

<!--- The following code defines the content for the first slide in the presentation. The duration of the slide determines how long the slide plays before proceeding to the next slide. The audio plays for the duration of the slide. ---> 
<cfpresentationslide title="Introduction" presenter="Aiden" duration="5" > 
<h3>Introduction</h3> 
<table> 
<tr><td> 
<ul> 
<li>Art Sales Overview</li> 
<li>Total Sales</li> 
<li>Total Sales by Artist</li> 
<li>Conclusion</li> 
</ul> 
</td> 
<td></td></tr> 
</table> 
</cfpresentationslide> 

<!--- The following code generates the second slide in the presentation from an HTML file located on an external website. ---> 
<cfpresentationslide title="Artwork Sales Overview" presenter="Raquel" duration="5" src="http://localhost:8500/"/> 

<!--- The following code generates the third slide in the presentation, which contains a pie chart with data extracted from the initial database query. ColdFusion runs the video defined in the cfpresentationslide tag in place of the presenter image defined in the cfpresenter tag. ---> 
<cfpresentationslide title="Total Artwork Sold" presenter="Aiden" 
duration="5" > 
<h3>Total Sales</h3> 
<cfchart format="jpg" chartwidth="500" show3d="yes"> 
<cfchartseries type="pie" query="artwork" 
colorlist="##00FFFF,##FF00FF" itemcolumn="issold" 
valuecolumn="price"/> 
</cfchart> 
</cfpresentationslide> 

<!--- The following code generates the fourth slide in the presentation with 
data extracted from the query of queries. ---> 
<cfpresentationslide title="Sales by Artist" presenter="Paul" 
duration="5" > 
<h3>Total Sales by Artist</h3> 
<table border cellspacing=10 cellpadding=0> 
<TR> 
<TD> 
<table border cellspacing=0 cellpadding=5> 
<tr> 
<th>Artist Name</th> 
<th>Total Sales</th> 
</tr> 
<tr> 
<cfoutput query="artistname"> 
<td>#FULLNAME#</td> 
<td>#dollarFormat(totalSale)#</td> 
</tr> 
</cfoutput> 
</table> 
</td> 
<td> 
<cfchart format="jpg" xaxistitle="Artist" yaxistitle="Total Sales" 
chartwidth="400"> 
<cfchartseries type="bar" query="artistname" 
itemcolumn="fullname" valuecolumn="totalSale"/> 
</cfchart> 
</td> 
</tr> 
</table> 
</cfpresentationslide> 

<!--- The following code defines the final slide in the presentation. This slide does not have a presenter assigned to it. ---> 
<cfpresentationslide title="Conclusion" duration="1" notes="Special thanks to Lori and Jeff for contributing their art and expertise."> 
<h1>Great Job Team!</h1> 
<p></p> 
</cfpresentationslide> 
</cfpresentation>