<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
       pageEncoding="ISO-8859-1" import="java.util.*"  import ="java.sql.*" import ="com.mysql.jdbc.Connection"
    import="javax.servlet.*;"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%

response.setContentType("text/html");

String User_name=request.getParameter("checkid");
String check="&uarr; &uarr; Available &uarr; &uarr;";

System.out.println("Checking user name --- "+User_name);
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/shoppingSpider","root", "");

PreparedStatement ps=(PreparedStatement) con.prepareStatement("select email from login where email=?");
ps.setString(1,User_name);

ResultSet rs=ps.executeQuery();

while(rs.next())
{
	check="&darr; &darr; Not available &darr; &darr;";
}

response.getWriter().print(check);

%>

</body>
</html>