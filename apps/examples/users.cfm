<cfquery 
name="selectData" 
connectstring="Provider=SQLOLEDB.1;Integrated Security=SSP;Persist Security Info=False;User ID=user;pwd=xx;Initial Catalog=dbname;Data Source=server" 
dbtype="dynamic"> 
select username from users 
</cfquery> 
