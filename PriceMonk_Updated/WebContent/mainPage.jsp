<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import = "java.sql.*" session = "true" 
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	System.out.println("IN MAIN");
	if (session.isNew())
	{
		session.setAttribute("login", "");
	}
	String dpt = ""; 
	if (session.getAttribute("Department") != null)
	{	
		dpt = session.getAttribute("Department").toString();
		System.out.println("Dept: "+dpt);
	}
	
%>
<html>

<head>
	<LINK REL="SHORTCUT ICON" HREF="./images/site-icon.ico">
    <title>PriceMonk</title>
    
	<link rel="stylesheet" href="./css/login.css" />
	<script type="text/javascript">
	function selValue()
	{
		var mytext = document.searchForm.dpt.options[document.searchForm.dpt.selectedIndex].text;
		//alert(mytext);
		window.location.replace("mainPage.jsp?value="+mytext);
	}
	</script> 

</head>

<body>

<%@ include file="header.jsp" %>
<center>
		  <form name = "searchForm" id="searchForm" action = "search.jsp" method = "GET">
			<br> 
			
			<select name = "dpt" onchange=selValue()>
				<option value = "Dept"> Department </option>
				<option value = "All"> All </option>
				<option value = "Book"> Books </option>
				<option value = "MM"> MultiMedia </option>
				<option value = "Comp"> Mobiles </option>
			</select>&nbsp;&nbsp;
			<%
				if(dpt.equals("")){
					session.setAttribute("Department", "Department");
				}
				else
				{
					session.setAttribute("Department", dpt);
				}
			
			%>
			<input type ="text" x-webkit-speech name = "searchWord" id="searchWord" size="55" autofocus="autofocus"/>&nbsp; &nbsp;
			
			<script>
				$(this.form.searchWord).autocomplete("searchsuggestions.jsp");
			</script>

			
			<input type = "submit" value = "Search"><br>
			
			
		
</form>

</center>

<div>
	<center>
		<%
				String dept = "";
				dept = request.getParameter("value");
				
				
				
				try
				{
					if(dept.equals("Department")){
						session.setAttribute("Department", dpt);
						System.out.println("Departmenttttttttttttt: "+session.getAttribute("Department"));
					}
					else{
						session.setAttribute("Department", dept);
						System.out.println("Department: "+session.getAttribute("Department"));
					}
					
					if(dept.equals("All")){
						%>
						<%@ include file="department.jsp" %>
						<%
					}
					else if(dept.equals("Books")){
							
			%>
			<%@ include file="bookSearch.jsp" %>
			<%
				
					}
					else if(dept.equals("MultiMedia")){
						
			%>
			<%@ include file="mediaSearch.jsp" %>
			
			<%
					}
					else if(dept.equals("Mobiles")){
			%>
			<%@ include file="mobileSearch.jsp" %>
			
			<%
					}
					
				}
					catch(Exception e)
					{
						
					}
			%>

       
	</center>
</div>
<div  id='foot'>
	<center>
   <%@ include file="Footer.jsp" %>
   </center>
</div>

</body>

		

</html>
