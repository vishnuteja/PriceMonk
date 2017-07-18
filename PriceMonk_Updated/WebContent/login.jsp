<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import = "java.sql.*" 
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>login</title>
</head>
<body>
<%
		String email = request.getParameter("Email");
		String pwd = request.getParameter("Password");
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
			String query = " select * from login where email = '"+email+"'";
			Statement smt=  con.createStatement();
			ResultSet rs = smt.executeQuery(query);
			String user = "";
			while(rs.next())
			{
				System.out.println("IN WHILE");
				if(rs.getString("password").equals(pwd))
				{
					user = rs.getString("name");
					System.out.println("In IF");
					flag = true;
					break;
				}
			}
			if(flag == true)
			{
				HttpSession s=request.getSession(true);
				s.setAttribute("USER",new String(user));
				s.setAttribute("Email",new String(email));
			    s.setAttribute("pass",new String(pwd));
			    s.setAttribute("login", "true");
			    s.setAttribute("ProfileUpdate", "false");
			    response.sendRedirect(request.getHeader("referer").toString());
			}
			else
			{
				HttpSession s=request.getSession(true);
				s.setAttribute("login", "false");
				response.sendRedirect(request.getHeader("referer").toString());
			}
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
%>
</body>
</html>