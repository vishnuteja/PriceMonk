<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import = "java.sql.*"%>
<%
/*	DummyDB db = new DummyDB();
	List<String> countries = db.getData(query);
*/
	String key = request.getParameter("q");

	System.out.println(key);
	
	String query = "select title from products where title LIKE '%"+key+"%'";

	Connection con = null;
	String url = "jdbc:mysql://localhost:3306/";
	String dbName = "pricemonk";
	String driver = "com.mysql.jdbc.Driver";
	
	List<String> sugges = new ArrayList<String>();
	
	try
	{
		Class.forName(driver).newInstance();
		con = DriverManager.getConnection(url+dbName,"root","");
		System.out.println("Connected to the database");
		Statement smt=  con.createStatement();
		ResultSet rs = smt.executeQuery(query);
		String user = "";
		while(rs.next())
		{
			sugges.add(rs.getString("title"));
		}
	}
	
	
	catch(Exception e){
		e.printStackTrace();
		
	}
	
	List<String> title = new ArrayList<String>();
	
	for(int i=0; i<sugges.size(); i++)
	{
			title.add(sugges.get(i));
	}
	
	for(int i=0;i<title.size();i++)
	{
		String country = title.get(i);
		out.println(country);
	}
%>