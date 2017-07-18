<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import = "java.sql.*" session = "true"
    pageEncoding="ISO-8859-1"%>
    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" >
<title>Books</title>

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
			session.setAttribute("Department", "Mobiles");
			System.out.println("Department1: "+session.getAttribute("Department").toString());
			Connection conn = null;
			String URL = "jdbc:mysql://localhost:3306/";
			String DBName = "pricemonk";
			String Driver = "com.mysql.jdbc.Driver";
			try
			{
				Class.forName(Driver).newInstance();
				conn = DriverManager.getConnection(URL+DBName,"root","");
				System.out.println("Connected to the database");
				String query = " select * from Products P,Mobiles M, Sellers S where P.productID = M.productID and P.productID = S.productID;";
				Statement smt=  conn.createStatement();
				ResultSet rs = smt.executeQuery(query);
				out.println("<table cellpadding='10'>");
				int i=0;
				while(rs.next())
      			{
					if(i==6)
					{
						out.println("</table><table cellpadding='10'>");
					}
					if(i==12)
					{
						break;
					}
					i++;
					out.println("<td width='150' valign='top'>");
      						out.println("<a href = 'mobile.jsp?Dpt="+session.getAttribute("Department")+"&ID=" + rs.getString("productID") + "'><table id='print_table'>");
      						
       						if(rs.getString("imgURL").equals(""))
   							{
   								out.println("<tr><td align = \"left\"><img src = './images/err.jpg' width = '100' height = '150' alt= '"+rs.getString("title")+"' title='" +rs.getString("title")+"'></img></td></tr>");	
   							}
   							else
   							{
   								out.println("<tr><td align = \"left\"><img src = '"+rs.getString("imgURL")+"' width = '100' height = '150' onerror=\"this.src='./images/err.jpg'\" alt= '"+rs.getString("title")+"' title='" +rs.getString("title")+"'></img></td></tr>");
   							}
      						
        					out.println("<tr><td> Title: "+rs.getString("title")+"</td> </tr>");
        					out.println("<tr><td> Starts at <b><span  style='color:red'>&#8377;&nbsp" + rs.getFloat("price") + "0 /-</span></b></td></tr>");
        					//out.println("<tr><td> Color: " + rs.getString("color") + "</td></tr>");
        					//out.println("<tr><td> Operating System: " + rs.getString("OS") + "</td></tr>");
        					out.println("</table></a>");
        			out.println("</td><td width='20'></td>");
        		}
      				out.println("</table>");
      				out.println("<br><br><br><br>");
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