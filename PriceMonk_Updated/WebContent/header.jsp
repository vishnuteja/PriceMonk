<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<LINK REL="SHORTCUT ICON" HREF="./images/site-icon.ico">
    
    <link rel="stylesheet" type="text/css" href="./css/jquery.autocomplete.css" />
    <link rel="stylesheet" href="./css/feedback.css" />
	<link rel="stylesheet" href="./css/login.css" />
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
	<script type="text/javascript" src="./js/login.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
	<script type="text/javascript" src="./js/signup.js"></script>
	
	<script src="http://www.google.com/jsapi"></script>  
	<script>
		google.load("jquery", "1");
	</script>
	<script src="js/jquery.autocomplete.js"></script>
	
	<style>
		input
		{
			font-size: 100%;
		}
	</style>
    

	
</head>


<body>

<header class="cf">
<nav>

<a href="mainPage.jsp?value=All">
	<img src='./images/flag-black.png' height='60' width='60'>
	<img src='./images/header-001.jpg'>
</a>

	<ul>

		<li id="signup">	
		
		<%
			if(session.getAttribute("login").toString().equals("true")){
		%>
		<a href="profile.jsp">Hi, <%=session.getAttribute("USER").toString().toUpperCase() %></a>
		</li>
		<li id="signup">||</li>
		<li id="signup">
			<a href="signout.jsp">Sign Out</a>
		</li>
		<%
			}
			else{
		%>	
		
		<li id="signup">
		<a href="#signin-box" class="signin-window" title="Click here to Login">Guest</a>
		</li>
		
		<div id="signin-box" class="signin-popup">
			<a href="#" class="close"><img src="./images/close_png.png" height="25" width="25" class="btn_close" title="Close Window" alt="Close" /></a>
				<form class= "signin" action = "login.jsp" method = "POST">

					<fieldset class="textbox">
						<span>Email Address</span>
						<input id="username" type="email" name="Email" required>   
						<span>Password</span>
						<input id="password" type="password" name="Password" required>
						<span><br><center>
						<input type="submit" id="submit" value="Log in">
						</span></center>
					</fieldset>

				</form>

			</div>                     

<li id="signup">||</li>
<li id="signup">
		<a href="#login-box" class="login-window">Sign Up</a>
</li>
		<div id="login-box" class="login-popup">
		
        <a href="#" class="close"><img src="./images/close_png.png" height="25" width="25" class="btn_close" title="Close Window" alt="Close" /></a>
          <form class="signin" action="signup.jsp" method = "POST">
                <fieldset class="textbox">
            	
            	
	                <span>Username</span>
	                <input id="username" name="User" value="" type="text" autocomplete="off" onKeyUp ="check(this.value);">
                	<span><label id="usrid"></label></span>
                
                
	                <span>Email</span>
	                <input id="email" name="UEmail" value="" type="text" autocomplete="off" onKeyUp ="check_em(this.value);">
                	<span><label id="em"></label></span>
                
                
                <span>Password</span>
                <input id="password" name="pswd" value="" type="password" autocomplete="off">
                
                <span>
                <br><center><input type="submit" id="submit" value="Create Account" onclick="create_success()"></center>
				</span>
				
                </fieldset>
          </form>
</div>

	<%} %>
	<li id="signup">||</li>
	<li id="signup"><img width='20' height='20' src='./images/cart.png'/></li>
	<li id="signup"><a href='cart.jsp'>View Cart</a></li>
	</ul>

</nav>
</header>
</body>
</html>