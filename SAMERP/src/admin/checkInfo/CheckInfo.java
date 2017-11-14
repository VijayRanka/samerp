package admin.checkInfo;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.General.GenericDAO;
import utility.RequireData;

/**
 * Servlet implementation class CheckInfo
 */
@WebServlet("/CheckInfo")
public class CheckInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckInfo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		response.setContentType("Text/HTML");
		
		if(request.getParameter("fullyCheck")!=null)
		{
			GenericDAO gd=new GenericDAO();
			if(!gd.getData("SELECT activation_key FROM user_master WHERE roll=1").isEmpty())
			{
				String key=gd.getData("SELECT activation_key FROM user_master WHERE roll=1").get(0).toString();
				if(key.charAt(3)=='4' && key.charAt(8)=='V')
				{
					String name=request.getParameter("username").trim();
					HttpSession session= request.getSession();
					System.out.println("*****Login Here Normal Admin Model******");
					session.setAttribute("username", name);
		    		RequestDispatcher rd= request.getRequestDispatcher("/dashboard.jsp");
			    	rd.forward(request, response);	
				}
				else
				{
					RequestDispatcher rd= request.getRequestDispatcher("/SAMERP");
			    	rd.forward(request, response);	
				}
			}
			else
			{
				
			}
			
		}
		
		
		if(request.getParameter("checkDetails")!=null)
		{
			String name=request.getParameter("uName").trim();
			String pass=request.getParameter("uPass").trim();
			
			
			RequireData rq=new RequireData();
			if(rq.checkUser())
			{
				GenericDAO gd = new GenericDAO();
				
			  	String checkPerson="SELECT `username`, `userpass`, `roll`, `status`,`activation_key` FROM `user_master` WHERE roll=1";
			  	List allList=gd.getData(checkPerson);
			  	boolean status=false;
			  	boolean wholeStatus = false;
			  	boolean missingKey=false;
			  		Iterator itr=allList.iterator();
			  		while(itr.hasNext())
				  	{
			  			System.out.println(name+","+pass+",");
			  			String uname=itr.next().toString();
			  			String upass=itr.next().toString();
			  			int roll=Integer.parseInt(itr.next().toString());
			  			int intStatus=Integer.parseInt(itr.next().toString());
			  			String act=itr.next().toString();
				  		if(name.equals(uname) && pass.equals(upass))
				  		{
				  			System.out.println("name is true "+name);
				  			if(intStatus==1)
				  			{
				  				if(act.charAt(3)=='4' && act.charAt(8)=='V')
				  				{
				  					status=true;
					  				wholeStatus=true;
				  				}
				  				else{
				  					status=true;
				  					missingKey=true;
				  				}
				  			}
				  			else
				  			{
			  					status=true;
			  					break;
				  			}
				  		}
				  			
				  	}
			  		
			  		if(status)
			  		{
			  			if(wholeStatus)
			  			{
			  				out.print("success");
			  			}
			  			else if(missingKey)
			  			{
			  				out.print("missingKey");
			  			}
			  			else
			  				out.print("activation");
			  		}
			  		else
			  		{
			  			out.print("wUser");
			  		}
			}
			else{
				
				out.print("dnp");
			}
			 
		}
		if(request.getParameter("Activate")!=null)
		{
			String key=request.getParameter("activationKey");
			GenericDAO gd=new GenericDAO();
			if(key.charAt(3)=='4' && key.charAt(8)=='V')
			{
				String statusChange="UPDATE `user_master` SET status=1 WHERE roll=1";
				int status=gd.executeCommand(statusChange);
				if(status==1)
				{
					out.print("1");
				}
			}
			else
			{
				out.print("0");
				
			}
		}
	}

}
