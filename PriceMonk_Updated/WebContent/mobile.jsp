<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import = "java.sql.*" session = "true"
    pageEncoding="ISO-8859-1"%>
<%@ include file="mainPage.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<style type="text/css">
		
		.feature img{
		-webkit-transform:scale(0.8); /*Webkit: Scale down image to 0.8x original size*/
		-moz-transform:scale(0.8); /*Mozilla scale version*/
		-o-transform:scale(0.8); /*Opera scale version*/
		-webkit-transition-duration: 0.5s; /*Webkit: Animation duration*/
		-moz-transition-duration: 0.5s; /*Mozilla duration version*/
		-o-transition-duration: 0.5s; /*Opera duration version*/
		opacity: 0.7; /*initial opacity of images*/
		margin: 0 10px 5px 0; /*margin between images*/
		}
		
		.feature img:hover{
		-webkit-transform:scale(1.1); /*Webkit: Scale up image to 1.2x original size*/
		-moz-transform:scale(1.1); /*Mozilla scale version*/
		-o-transform:scale(1.1); /*Opera scale version*/
		box-shadow:0px 0px 30px gray; /*CSS3 shadow: 30px blurred shadow all around image*/
		-webkit-box-shadow:0px 0px 30px gray; /*Safari shadow version*/
		-moz-box-shadow:0px 0px 30px gray; /*Mozilla shadow version*/
		opacity: 1;
		}

		th.feature
		{
			color: #000000;
			width: 150px;
			text-align: left;
		}
		th.feature1
		{
			color: #000000;
			width: 120px;
			text-align: left;
		}
		td.feature
		{
			background: -webkit-gradient(linear, left top, left bottom, 
                   from(rgba(255, 255, 224, 0.58)), to(rgba(244, 164, 96, 0.58)));
                   
			border-radius: 25px; 

			-webkit-box-reflect: below 10px-webkit-gradient(linear, left top, left bottom, 
                   from(transparent), to(rgba(255, 255, 255, 0)));       
		}
		td.feature3
		{
			background: -webkit-gradient(linear, left top, left bottom, 
                   from(rgba(255, 255, 224, 0.58)), to(rgba(244, 164, 96, 0.58)));
                   
			border-radius: 25px; 

			-webkit-box-reflect: below 10px-webkit-gradient(linear, left top, left bottom, 
                   from(transparent), to(rgba(255, 255, 255, 0)));       
		}
		tr.feature
		{
			background: -webkit-gradient(linear, left top, left bottom, 
                   from(rgba(244, 164, 96, 0.58)), to(rgba(255, 255, 224, 0.58)));

			border-radius: 0px; 

			-webkit-box-reflect: below 10px-webkit-gradient(linear, left top, left bottom, 
                   from(transparent), to(rgba(255, 255, 255, 0)));
		}
		tr.feature1
		{
			background: -webkit-gradient(linear, left top, left bottom, 
                   from(rgba(160, 82, 45, 0.30)), to(rgba(210, 105, 30, 0.58)));

			border-radius: 0px; 

			-webkit-box-reflect: below 10px-webkit-gradient(linear, left top, left bottom, 
                   from(transparent), to(rgba(255, 255, 255, 0)));
		}
	</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="test.js"></script>
<title> Main Page </title>
</head>
<body>
		<%
			
			String mobileID = request.getParameter("ID");
			Connection conn = null;
			session.setAttribute("Department", "Mobiles");
			System.out.println("Department2: "+session.getAttribute("Department"));
			String url1 = "jdbc:mysql://localhost:3306/";
			String dbname = "pricemonk";
			String driver1 = "com.mysql.jdbc.Driver";
			String name = "";
			try
			{	
						Class.forName(driver1).newInstance();
						conn = DriverManager.getConnection(url1+dbname,"root","");
						System.out.println("Connected to the database");
						
						String query = "select P.title, P.RelDate, P.imgURL, M.*, min(S.price) from Products P,Mobiles M, Sellers S where P.productID = '" + mobileID +"' and M.productID = '" + mobileID +"' and S.productID = '"+mobileID+"'";
						
						Statement smt=  conn.createStatement();
						ResultSet rs = smt.executeQuery(query);
						out.println("<br><br><h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Product Details</b></h2><br>");
						out.println("<table cellpadding = '2'>");
					
						
						while(rs.next())
	    				{
								if(rs.getString("imgURL").equals(""))
								{
									out.println("<td width = '100'></td><td width = '250' class='feature' align = \"center\"><img src = './images/err.jpg' width = '175' height = '250' alt= '"+rs.getString("title")+"' title='" +rs.getString("title")+"'></img></td>");	
								}
								else
								{
									out.println("<td width = '100'></td><td width = '250' class='feature' align = \"center\"><img src = '"+rs.getString("imgURL")+"' width = '175' height = '250' onerror=\"this.src='./images/err.jpg'\" alt= '"+rs.getString("title")+"' title='" +rs.getString("title")+"'></img></td>");
								}
								out.println("<td width = '50'></td><td> <table cellpadding = '2'>");
	    						out.println("<tr><td colspan='2'><h1>" + rs.getString("title") + "</h1></td></tr><tr><td colspan='2'><hr size='1' width='100%' /></td></tr>");
	    						out.println("<tr><td>Starts at</td></tr>");
	    						out.println("<tr><td colspan='2' style='font-size:24px; color:red'><h2>&#8377;&nbsp;" + rs.getString(15) + " /-</h2></td></tr><tr><td colspan='2'><hr size='1' width='100%' /></td></tr>");
	    						out.println("<tr><th class='feature'>Operating System</th><td>" + rs.getString("OS") + "</td></tr>");
	    						out.println("<tr><th class='feature'>Camera</th><td>" + rs.getString("camera") + "</td></tr>");
	    						out.println("<tr><th class='feature'>Screen Size</th><td>" + rs.getString("screen_size") + "</td></tr>");
	    						out.println("<tr><th class='feature'>Keypad Type</th><td>" + rs.getString("keypad_type") + "</td></tr>");
	    						out.println("<tr><th class='feature'>Color</th><td>" + rs.getString("color") + "</td></tr>");
	    						out.println("<tr><th class='feature'>Bluetooth</th><td>" + rs.getString("bluetooth") + "</td></tr>");
	    						out.println("<tr><th class='feature'>Internal Memory</th><td>" + rs.getString("internal_memory") + "</td></tr>");
	    						out.println("<tr><th class='feature'>External Memory</th><td>" + rs.getString("exp_Memory") + "</td></tr>");
	    						out.println("<tr><th class='feature'>3G</th><td>" + rs.getString("3g") + "</td></tr>");
	    						out.println("<tr><th class='feature' valign='top'>Warranty</th><td>" + rs.getString("warranty") + "</td></tr>");
	    						out.println("</td></table>");
	    						name = rs.getString("title");
	    				}
						out.println("<td width='65'></td><td>");
		%>

						
						<a name="fb_share"></a> 
						<script src="http://static.ak.fbcdn.net/connect.php/js/FB.Share" 
						        type="text/javascript">
						</script>
						
						<br><br>
						
						
								<%
									    String reqUrl = request.getRequestURL().toString();
									    String queryString = request.getQueryString();   // d=789
									    if (queryString != null) {
									        reqUrl += "?"+queryString;
									    }
								%>					
								<a target="_blank" href='http://twitter.com/home?status= <%= reqUrl %> ' title='Click to share this post on Twitter'><img src="./images/twitter.png" height = "18" width="70"></img></a>
						
					<br>
					
					
    				</td>
    				<td width='100'></td>
    				<td width='150' class='feature3'>
	    				<table>
							<tr>
		 						<form method = 'POST' action="cart.jsp">
									<input type='hidden' name='IDD' value=<%= mobileID %>>
									<center><input type="image" width="150" src="./images/cart.jpg" alt="Submit button"></center>
								</form>
							</tr>
							<tr>
								<br><br>
							</tr>
							<tr>
								<embed height="200" src="http://www.clocklink.com/clocks/5025-white.swf?TimeZone=India_Chennai&"  width="180" height="180" wmode="transparent" type="application/x-shockwave-flash">
							</tr>
						</table>
					</td>	
					</table>
					<%
    				String query2 = "select * from Sellers where productID = '"+ mobileID+"' order by price ASC";
    				String query3 = "select count(seller) from Sellers where productID = '"+ mobileID+"'";
    				
    				Statement smt1=  conn.createStatement();
    				ResultSet rs1 = smt1.executeQuery(query3);
    				rs1.next();
    					out.println("<br><h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>"+rs1.getInt(1)+" Sellers Available</b></h2>");
    				
    				Statement smt2=  conn.createStatement();
    				ResultSet rs2 = smt2.executeQuery(query2);
    				
    				// Display list of Sellers Available
    				out.println("<br><center><table cellpadding = '5'>");
    				out.println("<tr class='feature1'><th class='feature1'> --- </th><th class='feature1'> Seller </th> <th class='feature1'> Price </th> <th class='feature1'> Shipping Price </th> <th class='feature1'> Total </th><th class='feature1'> Buy at </th>");
    				while(rs2.next())
    				{
    						out.println("<tr><td colspan='6'><hr noshade size='2' width='100%' /></td></tr>");
    						out.println("<tr class='feature'><td><a href='http://www."+rs2.getString("seller")+".com' target='_blank'><img src='./images/" + rs2.getString("seller") + ".png' height='36' width='80'/></a></td>");
    						out.println("<td>" + rs2.getString("seller") + "</td>");
    						out.println("<td>" + rs2.getFloat("price") + "</td>");
    						out.println("<td>" + rs2.getFloat("SPrice") + "</td>");
    						out.println("<td>" + (rs2.getFloat("price")+rs2.getFloat("SPrice")) + "</td>");
    						out.println("<td><a target='_blank' href='");
    						if(rs2.getString("seller").equals("flipkart"))
    						{
    							out.println("http://www.flipkart.com/search/a/mobiles?query="+name+"'> <input type = 'button' value = 'Flipkart'>");
    						}
    						else if(rs2.getString("seller").equals("infibeam"))
    						{
    							out.println(rs2.getString("url")+"'> <input type = 'button' value = 'Infibeam'>");
    						}
    						else if(rs2.getString("seller").equals("amazon"))
    						{
    							out.println(rs2.getString("url")+"'> <input type = 'button' value = 'Amazon'>");
    						}
    						else if(rs2.getString("seller").equals("homeshop18"))
    						{
    							out.println(rs2.getString("url")+"'> <input type = 'button' value = 'Homeshop18'>");
    						}
    						else if(rs2.getString("seller").equals("ebay"))
    						{
    							out.println(rs2.getString("url")+"'> <input type = 'button' value = 'eBay'>");
    						}
    						out.println("</a></td></tr>");
    				}
    				out.println("<td colspan='6'><hr size='1' width='100%' /></td></table></center><br><br><br><br>");
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