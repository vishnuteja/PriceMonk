<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	
	<link rel="stylesheet" href="./css/feedback.css" />
	<link type="text/css" href="./css/footer.css" rel="stylesheet" />
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
	<script type="text/javascript" src="./js/popup.js"></script>

<script type="text/javascript">
function success()
{
alert("Thank You for your valuable feedback !");
}
</script>

</head>
<body>

<div class="footer">
<table>
	<tr>
		<td><a href="AboutUs.jsp">About Us</a></td>
		<td>&nbsp;|&nbsp;</td>
		<td><a href="ContactUs.jsp">Contact Us</a></td>
		<td>&nbsp;|&nbsp;</td>
		<td><a href="#feedback-box" class="feedback-window">Feedback</a></td>
		<td>&nbsp;|&nbsp;</td>
		<td>© 2012 PriceMonk.com</td>
	</tr>
	<iframe align = "right" src="https://www.facebook.com/plugins/like.php?href=http://www.facebook.com/PriceMonk"
        scrolling="no" frameborder="0"
        style="border:none; width:450px; height:80px">
    </iframe>
</table>
</div>

<!-- --------------------------------------Feedback PopUp-------------------------------------------------  -->
		<div id="feedback-box" class="feedback-popup">
		
        <a href="#" class="close"><img src="./images/close_png.png" height="25" width="25" class="btn_close" title="Close Window" alt="Close" /></a>
          <form class="feedback" action="feedback.jsp" method = "POST">
                <fieldset class="textbox">
            	
            	
	                <span>Please give your valuable suggestions to improve the site.<br> Your feedback is always appreciated</span>
	                 <textarea name="feedback" rows="3" cols="50" autocomplete="off"></textarea>
                                
                <span>
                <br><center><input type="submit" id="submit" value="Submit Feedback" onclick="success()"></center>
				</span>
				
                </fieldset>
          </form>
</div>
<!-- --------------------------------------Feedback PopUp-------------------------------------------------  -->

</body>
</html>