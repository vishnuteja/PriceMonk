<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import = "java.sql.*"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sign Up</title>
</head>
<body>
<%
		String name = request.getParameter("User");
		String email = request.getParameter("UEmail");
		String pwd = request.getParameter("pswd");
		Connection con = null;
		String url = "jdbc:mysql://localhost:3306/";
		String dbName = "pricemonk";
		String driver = "com.mysql.jdbc.Driver";
		boolean flag = false;
		try
		{
			Class.forName(driver).newInstance();
			con = DriverManager.getConnection(url+dbName,"root","");
			System.out.println("Connected to the database");
			String query = "insert into login values('"+name+"','"+email+"','"+pwd+"')";
			Statement smt=  con.createStatement();
			smt.executeUpdate(query);
			HttpSession s=request.getSession(true);
				s.setAttribute("Email",new String(email));
			    s.setAttribute("pass",new String(pwd));
			    //s.setAttribute("login", "true");
			    System.out.println("Before redirect");
			    response.sendRedirect(request.getHeader("referer").toString());
			    System.out.println("After redirect");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
%>

</body>
</html>