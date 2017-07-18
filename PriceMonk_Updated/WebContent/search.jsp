<%@ page language="java" contentType="text/html; charset=ISO-8859-1" session = "true"
    pageEncoding="ISO-8859-1"%>
<%@ include file="mainPage.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>search result</title>
</head>
<body>
	<%
	String searchParam = request.getParameter("searchWord");
	String DEPT = session.getAttribute("Department").toString();
	//String attribute = session.getAttribute("category").toString();
	String query = "";
	System.out.println("Search Dept: "+DEPT);
	if(DEPT.equals("dept") || DEPT.equals("Department"))
	{
		query = "select * from Products P, sellers S where title like '%"+searchParam+"%' and P.productID = S.productID";
	}
	else if(DEPT.equals("Books"))
	{
		System.out.println("IN SEARCH BOOKS");
		query = "select * from Products P, sellers S, Books B where title like '%"+searchParam+"%' and P.productID = S.productID and P.productID = B.productID";
	}
	else if(DEPT.equals("Multimedia"))
	{
		System.out.println("IN SEARCH MEDIA");
		query = "select * from Products P, sellers S, Media M where title like '%"+searchParam+"%' and P.productID = S.productID and P.productID = M.productID";
	}
	else if(DEPT.equals("Mobiles"))
	{
		System.out.println("IN SEARCH MOBILES");
		query = "select * from Products P, sellers S, Mobiles M where title like '%"+searchParam+"%' and P.productID = S.productID and P.productID = M.productID";
	}
	
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
				ResultSet rs = smt.executeQuery(query);
				int flag = 0;
				int table_count = 0;
				
				out.println("<br><center>Search Results for : <font color='blue' size='4'>"+searchParam+"</font></center>");
				
				int count = 0;
				out.println("<table><tr>");
					while(rs.next())
					{
						count++;
							if(table_count % 4 == 0 && table_count!=0)
							{
								out.println("</tr>");
								out.println("<tr>");
								//out.println("<table cellpadding='15'>");
								//out.println("<td valign='top'>");
							}
							table_count++;
								if(rs.getString("imgURL").equals(""))
								{
									out.println("<td width='150'></td><td width='350'><table><tr><img src = './images/err.jpg' width = '100' height = '150' alt= '"+rs.getString("title")+"' title='" +rs.getString("title")+"'></img></tr>");	
								}
								else
								{
									out.println("<td width='150'></td><td width='350'><table><tr><img src = '"+rs.getString("imgURL")+"' width = '100' height = '150' onerror=\"this.src='./images/err.jpg'\" alt= '"+rs.getString("title")+"' title='" +rs.getString("title")+"'></img></tr>");
								}
								out.println("<tr><br></tr>");
								if(rs.getString("category").equalsIgnoreCase("book"))
	        						out.println("<b><tr><a href = 'books.jsp?ID=" + rs.getString("productID") + "'>"+rs.getString("title")+" </tr></b>");
								else if(rs.getString("category").equalsIgnoreCase("media"))
									out.println("<b><tr><a href = 'media.jsp?ID=" + rs.getString("productID") + "'>"+rs.getString("title")+" </tr></b>");
								else if(rs.getString("category").equalsIgnoreCase("mobile"))
									out.println("<b><tr><a href = 'mobile.jsp?ID=" + rs.getString("productID") + "'>"+rs.getString("title")+" </tr></b>");
								out.println("<tr><br></tr>");
								String q = "select min(Price) from sellers where productID = '"+rs.getString("productID")+"'";
								Statement st = conn.createStatement();
								ResultSet r = st.executeQuery(q);
								r.next();
								out.println("<tr> Starts at <b><span  style='color:red'>&#8377;&nbsp" + r.getFloat(1) + "&nbsp/-</span></b></a> </tr>");
							
	        			out.println("</table></td><td width='100'></td>");
	        		}
       					out.println("</table>");
				if (count == 0)
				{
					if(DEPT.equals("Books") || DEPT.equals("dept")){
						System.out.println("IN SEARCH BOOKS - ISBN");
						query = "select * from Products P, sellers S, Books B where ISBN ='"+searchParam+"' and P.productID = S.productID and P.productID = B.productID";
						flag = 1; 	
						count = 0;
					}
				}
				if(flag == 1){
					rs = smt.executeQuery(query);
				}
				while(rs.next())
				{
					count++;
					out.println("<td>");
						out.println("<table>");
							if(rs.getString("imgURL").equals(""))
							{
								out.println("<tr><img src = './images/err.jpg' width = '100' height = '150' alt= '"+rs.getString("title")+"' title='" +rs.getString("title")+"'></img></tr>");	
							}
							else
							{
								out.println("<tr><img src = '"+rs.getString("imgURL")+"' width = '100' height = '150' onerror=\"this.src='./images/err.jpg'\" alt= '"+rs.getString("title")+"' title='" +rs.getString("title")+"'></img></tr>");
							}
							if(rs.getString("category").equalsIgnoreCase("book"))
        						out.println("<tr><br> Title: <a href = 'books.jsp?ID=" + rs.getString("productID") + "'>"+rs.getString("title")+" </tr><br>");
							else if(rs.getString("category").equalsIgnoreCase("media"))
								out.println("<tr> Title: <a href = 'media.jsp?ID=" + rs.getString("productID") + "'>"+rs.getString("title")+" </tr><br>");
							else if(rs.getString("category").equalsIgnoreCase("mobile"))
								out.println("<tr> Title: <a href = 'mobile.jsp?ID=" + rs.getString("productID") + "'>"+rs.getString("title")+" </tr><br>");
							out.println("<tr> Release Date: " + rs.getString("RelDate") + "</tr><br>");
							String q = "select min(Price) from sellers where productID = '"+rs.getString("productID")+"'";
							Statement st = conn.createStatement();
							ResultSet r = st.executeQuery(q);
							r.next();
							out.println("<tr> Starts at<span  style='color:red'>&#8377;&nbsp" + r.getFloat(1) + "&nbsp/-</span></a> </tr>");
           				out.println("</table>");
        			out.println("</td>");
				}
				out.println("</table>");
				rs.close();
				smt.close();
				conn.close();
				
				if(count==0)
				{
					out.println("<br><center><h2>No results found. Please try again</h2></center>");
				}
		}
		catch (Exception e)
		{
			System.out.println(e);
		}
	%>
</body>
</html>