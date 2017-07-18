<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import = "java.sql.*" session = "true" 
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/div/html4/loose.dtd">
 <%@ include file="header.jsp" %>
<%
if (session.isNew())
	{
		response.sendRedirect("mainPage.jsp");
	}

else if(session.getAttribute("ProfileUpdate").equals("true")){
		session.setAttribute("ProfileUpdate","false");
		 %>
<html>

 <head>
 <title>PriceMonk|UpdateProfile</title>

<script type='text/javascript' src="./JavaScript/registration.js"></script>
<link rel="stylesheet" type="text/css" href="./css/registration.css"/>

 </head>

 <body>
	
	<br><br><br><br><h1> <center> Profile Updated </center> </h1>
	
<%
}
else
{
	
			String email = session.getAttribute("Email").toString();
			Connection conn = null;
			String URL = "jdbc:mysql://localhost:3306/";
			String DBName = "pricemonk";
			String Driver = "com.mysql.jdbc.Driver";
			try
			{
						Class.forName(Driver).newInstance();
						conn = DriverManager.getConnection(URL+DBName,"root","");
						System.out.println("Connected to the database");
						String query = " select * from login where  email = '"+email+"'";
						Statement smt=  conn.createStatement();
						ResultSet rs = smt.executeQuery(query);
						String user = "";
						String password = "";
						while(rs.next())
						{
							user = rs.getString(1);
							email = rs.getString(2);
							password = rs.getString(3);
							
							System.out.println(user+email+password);
						}
%>
<br><br><br><br><br><br><br>
					<center>
						<table border='15'>
						<td><form name="form1" method="post" action="ProfileUpdate">
						
						<fieldset>
								<div>
									<center><div><h3><u>Email: </u></h3><h2><%=email%></h2></div></center>
								</div>
								<div>
									<center><div><h3><u>User Name: </u></h3><h2><%=user%></h2></div></center>
									<input type="text" name="username" id="textarea" size="20" autocomplete="off"></div>
								</div>		
								<div>
									<center><div><h3><u>Password</u></h3></div></center>
									<div><input type="password" name="password" id="textarea" autocomplete="off"></div>
								</div>	
								
								
								<div>
									<div></div>
									<center><div><input type="submit" value="Save Changes" id="textarea"></div></center>
								</div>
					
							
							</fieldset>
							
						</form></td>
						</table>
					</center>
											
						<%
						rs.close();
						smt.close();
						conn.close();
				
				}
				catch (Exception e){
					System.out.println(e);
				}
	}
%>

 </body>
</html>