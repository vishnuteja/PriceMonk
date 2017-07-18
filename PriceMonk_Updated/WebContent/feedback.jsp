<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import = "java.sql.*"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>PriceMonk|Feedback</title>
</head>
<body>
<%

String feedback = request.getParameter("feedback");

Connection conn=null;
String driver="com.mysql.jdbc.Driver";
String url="jdbc:mysql://localhost:3306/pricemonk";
Statement statement=null;

try
{
    Class.forName(driver);
    conn=DriverManager.getConnection(url,"root","");
    System.out.println("connected");
    String query="insert into feedback values('"+feedback+"')";
    statement=conn.createStatement();
    statement.executeUpdate(query);
    System.out.println("INSERTED INTO FEEDBACK TABLE");
	statement.close();
	conn.close();
	
    response.sendRedirect("mainPage.jsp");
 }

catch(Exception e)
{
    System.out.println("Error : "+e);
}
%>

</body>
</html>