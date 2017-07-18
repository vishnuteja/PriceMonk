<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import = "java.sql.*" session = "true"
    pageEncoding="ISO-8859-1" import="java.util.ArrayList"%>
<%@ include file="mainPage.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/table.css" />
</head>
	<style type="text/css">
		.blinkytext 
		{
		     font-family: Arial, Helvetica, sans-serif;
		     font-size: 1.2em;
		     text-decoration: blink;
		     font-style: normal;
		}
	</style>
<body>
<h2><center>
<%
String reqUrl = request.getRequestURL().toString();

String url=request.getParameter("IDD");

System.out.println(url);

ArrayList al = (ArrayList)session.getAttribute("KART_LIST"); 

//out.println("ArrayList " + al);
if(al == null)  
{  
al = new ArrayList(); 
System.out.println("Created new arraylisy");
al.add(url);
session.setAttribute("KART_LIST", al);
}

else
{
	if(!al.contains(url))
	{	out.println("<br><br>");
		out.println("Added to your cart<br><br>");
		al.add(url);
		session.setAttribute("KART_LIST", al);
	}
	else
	{
		//out.println("<br><br><br><h1 class='blinkytext'>Hurray, this item already exists in cart</h1>");
	}
}

out.println("<br>");

Connection conn = null;
String URL = "jdbc:mysql://localhost:3306/";
String DBName = "pricemonk";
String Driver = "com.mysql.jdbc.Driver";
try
{
			Class.forName(Driver).newInstance();
			conn = DriverManager.getConnection(URL+DBName,"root","");
			System.out.println("Connected to the database");
			Statement smt=  conn.createStatement();
			ResultSet rs;
					
					int n = al.size();
					out.println("<br><br><font color='#000'>Items in your CART</font>");
					out.println("<table align='center'>");
					for(int i = 0; i < n ; i++)
					{
					  	String query = "select * from Products where productID ='"+al.get(i)+"'";
					
						rs = smt.executeQuery(query);
						while(rs.next())
						{
									if(rs.getString("imgURL").equals(""))
									{
										out.println("<tr></td><td><img src = './images/err.jpg' width = '100' height = '150' alt= '"+rs.getString("title")+"' title='" +rs.getString("title")+"'></img></td>");	
									}
									else
									{
										out.println("<tr></td><td><img src = '"+rs.getString("imgURL")+"' width = '100' height = '150' onerror=\"this.src='./images/err.jpg'\" alt= '"+rs.getString("title")+"' title='" +rs.getString("title")+"'></img></td>");
									}
									out.println("<td width='35'></td>");
									if(rs.getString("category").equalsIgnoreCase("book"))
										out.println("<td valign='top'><a href = 'books.jsp?ID=" + rs.getString("productID") + "'>"+rs.getString("title")+"</a> </td></tr><br>");
									else if(rs.getString("category").equalsIgnoreCase("media"))
										out.println("<td valign='top'><a href = 'media.jsp?ID=" + rs.getString("productID") + "'>"+rs.getString("title")+"</a> </td></tr><br>");
									else if(rs.getString("category").equalsIgnoreCase("mobile"))
										out.println("<td valign='top'><a href = 'mobiles.jsp?ID=" + rs.getString("productID") + "'>"+rs.getString("title")+"</a> </td></tr><br>");
						}
						rs.close();
					}

					out.println("</table>");
					out.println("<br><br><br><br><br><br><br>");
					smt.close();
					conn.close();
}

catch(Exception e)
{
	e.printStackTrace();
}

%>
</center></h2>
</body>
</html>