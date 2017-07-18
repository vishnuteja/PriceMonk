<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="java.sql.*"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<LINK REL="SHORTCUT ICON" HREF="./images/site-icon.ico">
<link rel="stylesheet" href="./css/login.css" />

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>PriceMonk - Main</title>
</head>
<body>
<%@ include file="header.jsp" %>

<center>
<table>
<td>
<%
	Connection conn = null;
	String URL = "jdbc:mysql://localhost:3306/";
	String DBName = "pricemonk";
	String Driver = "com.mysql.jdbc.Driver";
	session.setAttribute("category", "title");
	try
	{
				Class.forName(Driver).newInstance();
				conn = DriverManager.getConnection(URL+DBName,"root","");
				System.out.println("Connected to the database");
				String query = " select * from Products P,Books B where P.productID = B.productID;";
				Statement smt=  conn.createStatement();
				ResultSet rs = smt.executeQuery(query);
				out.println("<table cellpadding='10'>");
				int i=0;
				while(rs.next())
				{
					if(i>=6)
					{
						break;
					}
					i++;
					out.println("<td width='150'>");
						out.println("<a href = 'books.jsp?value=" + rs.getString("productID") + "'><table id='print_table'>");
						out.println("<tr><td align = \"left\"><img src = '"+rs.getString("imgURL")+"' width = '100' height = '150'></td></tr>");
	    					out.println("<tr><td> ID: " + rs.getString("productID") + "</td></tr>");
	    					out.println("<tr><td> Title: "+rs.getString("title")+"</td> </tr>");
	    					//out.println("<tr><td> Price: " + rs.getFloat("price") + "</td></tr>");
	    					out.println("<tr><td> Author: " + rs.getString("Author") + "</td></tr>");
	    					out.println("<tr><td> Edition: " + rs.getString("Edition") + "</td></tr>");
	    					out.println("<tr><td> Publisher: " + rs.getString("publisher") + "</td></tr>");
	    					//out.println("<tr><td> Rank: " + rs.getInt("rank") + "</td></tr>");
	    				out.println("</table></a>");
	    			out.println("</td><td width='20'></td>");
	    		}
				out.println("</table>");
				rs.close();
				smt.close();
				conn.close();
		
		}
		catch (Exception e){
			System.out.println(e);
		}
%>
</td>
</center>	

</body>
</html>