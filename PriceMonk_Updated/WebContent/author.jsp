<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import = "java.sql.*"
    pageEncoding="ISO-8859-1"%>
<%@ include file="mainPage.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" >
<title>Author</title>
<style type='text/css'>
				#print_table
				{
					word-wrap:break-word;
				}
				#print_table:hover
				{
					/*border:1px solid black;*/
					/*border-style:groove;*/
					/*background-image : url("./images/table.jpg");*/
					/*color:'white';*/
				}
			</style>
</head>
<body>
			<br> <br>
			<%
			session.setAttribute("Department", "Books");
			System.out.println("Departmentsss: "+session.getAttribute("Department").toString());
			Connection conn = null;
			String URL = "jdbc:mysql://localhost:3306/";
			String DBName = "pricemonk";
			String Driver = "com.mysql.jdbc.Driver";
			String author = request.getParameter("Author");
			System.out.println("Author: "+author);
			try
			{
						Class.forName(Driver).newInstance();
						conn = DriverManager.getConnection(URL+DBName,"root","");
						System.out.println("Connected to the database");
						String query = " select * from Products P,Books B where P.productID = B.productID and P.imgURL != '' and B.author = '"+author+"'";
						Statement smt=  conn.createStatement();
						ResultSet rs = smt.executeQuery(query);
						int i =0;
						out.println("<table cellpadding='10'>");
						while(rs.next())
        				{
							if(i>=6)
							{
								break;
							}
							i++;
							out.println("<td width='150'>");
        						out.println("<a href = 'books.jsp?Dpt="+session.getAttribute("Department")+"&ID=" + rs.getString("productID") + "'><table id='print_table'>");
        						
	        						if(rs.getString("imgURL").equals(""))
	    							{
	    								out.println("<tr><td align = \"left\"><img src = './images/err.jpg' width = '100' height = '150' alt= '"+rs.getString("title")+"' title='" +rs.getString("title")+"'></img></td></tr>");	
	    							}
	    							else
	    							{
	    								out.println("<tr><td align = \"left\"><img src = '"+rs.getString("imgURL")+"' width = '100' height = '150' onerror=\"this.src='./images/err.jpg'\" alt= '"+rs.getString("title")+"' title='" +rs.getString("title")+"'></img></td></tr>");
	    							}
        						
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
</body>
</html>