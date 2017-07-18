import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Registration
 */
@WebServlet("/ProfileUpdate")
public class ProfileUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileUpdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
        HttpSession ss = request.getSession(true);
        
        String sessUser = ss.getAttribute("USER").toString();
		String sessEmail = ss.getAttribute("Email").toString();
	    String sessPass = ss.getAttribute("pass").toString();

	    String username=request.getParameter("username");
	    String password=request.getParameter("password");
	    String email = sessEmail; 
	 
        if(username == "" && password != "")
        {
        	System.out.println("First IF");
        	username = sessUser;
        }
        
        else if(username != "" && password == "")
        {
        	System.out.println("Second IF");
        	password = sessPass;
        }
        
        else if(username == "" && password == "")
        {
        	System.out.println("Third IF");
        	username = sessUser;
        	password = sessPass;
        }
        
        System.out.println(username+"  "+email+"  "+password);
        
       
        
        try
        {
        	Connection conn1 = null;
     		String URL = "jdbc:mysql://localhost:3306/";
     		String DBName = "pricemonk";
     		String Driver = "com.mysql.jdbc.Driver";
     		
        	System.out.println("IN TRY!!");
            Class.forName(Driver).newInstance();
            conn1 = DriverManager.getConnection(URL+DBName,"root","");
            System.out.println("connected");
            String query="update login SET name = '"+username+"', password ='"+password+"'"+"where email ='"+email+"'";
            Statement statement1=conn1.createStatement();
            statement1.executeUpdate(query);
            System.out.println("Updated");
            HttpSession s = request.getSession(true);
            s.setAttribute("ProfileUpdate", "true");
            conn1.close();
            
            
            ss.setAttribute("USER",username);
    		ss.setAttribute("Email",email);
    	    ss.setAttribute("pass",password);

            
            response.sendRedirect("profile.jsp");
         }
        
        catch(Exception e)
        {
            System.out.println("Error : "+e);
        }

	}

}
