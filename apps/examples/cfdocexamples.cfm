<!--- The following query extracts employee data from the cfdocexamples 
database. ---> 
<cfquery name="GetSalaryDetails" datasource="cfdocexamples"> 
SELECT Departmt.Dept_Name, 
Employee.FirstName, 
Employee.LastName, 
Employee.StartDate, 
Employee.Salary, 
Employee.Contract 
From Departmt, Employee 
Where Departmt.Dept_ID = Employee.Dept_ID 
ORDER BY Employee.LastName, Employee.Firstname 
</cfquery> 

<!--- The following code creates a presentation with three presenters. ---> 
<cfpresentation title="Employee Satisfaction" primaryColor="##0000FF" glowColor="##FF00FF" lightColor="##FFFF00" showoutline="no"> 
<cfpresenter name="Jeff" title="CFO" email="jeff@company.com" 
 
> 
<cfpresenter name="Lori" title="VP Marketing" email="lori@company.com" 
> 
<cfpresenter name="Paul" title="VP Sales" email="paul@company.com" 
> 

<!--- The following code creates the first slide in the presentation 
from HTML. ---> 
<cfpresentationslide title="Introduction" presenter="Jeff" 
 duration="5"> 
<h3>Introduction</h3> 
<table> 
<tr><td> 
<ul> 
<li>Company Overview</li> 
<li>Salary by Department</li> 
<li>Employee Salary Details</li> 
</ul> 
</td></tr> 
</table> 
</cfpresentationslide> 

<!--- The following code creates the second slide in the presentation. 
The chart is populated with data from the database query. ---> 
<cfpresentationslide title="Salary by Department" presenter="Lori" 
duration="5" > 
<h3>Salary by Department</h3> 
<cfchart format="jpg" xaxistitle="Department" yaxistitle="Salary"> 
<cfchartseries type="bar" query="GetSalaryDetails" 
itemcolumn="Dept_Name" valuecolumn="salary"> 
</cfchartseries> 
</cfchart> 
</cfpresentationslide> 

<!--- The following code creates the third slide in the presentation. The table is populated with data from the query. The table also contains an image located relative to the CFM page on the server. ---> 
<cfpresentationslide title="Salary Details" presenter="Paul" 
duration="10" > 
<h3>Employee Salary Details</h3> 
<table border cellspacing=0 cellpadding=5 valign="top"> 
<tr> 
<td> 
<table border cellspacing=0 cellpadding=5 valign="top"> 
<tr> 
<th>Employee Name</th> 
<th>Start Date</th> 
<th>Salary</th> 
<th>Department</th> 
<th>Contract?</th> 
</tr> 
<cfoutput query="GetSalaryDetails"> 
<tr> 
<td>#FirstName# #LastName#</td> 
<td>#dateFormat(StartDate, "mm/dd/yyyy")#</td> 
<td>#numberFormat(Salary, "$9999,9999")#</td> 
<td>#dept_name#</td> 
<td>#Contract#</td> 
</tr></cfoutput> 
</table> 
</td> 
<td width="200" > 

</td> 
</table> 
</cfpresentationslide> 
</cfpresentation>