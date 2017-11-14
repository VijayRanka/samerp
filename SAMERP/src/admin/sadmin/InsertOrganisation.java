package admin.sadmin;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;

/**
 * Servlet implementation class InsertOrganisation
 */
@WebServlet("/InsertOrganisation")
public class InsertOrganisation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertOrganisation() {
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
		response.setContentType("text/html");
		GenericDAO da = new GenericDAO();
		if(request.getParameter("insert")!=null)
		{
			System.out.println("in insertOrg");
			GenericDAO gd=new GenericDAO();
			if(request.getParameter("ownername")!=null)
			{
				String orgName = request.getParameter("orgname");
				String ownerName = request.getParameter("ownername");
				String orgAddress = request.getParameter("orgaddress");
				String cno1 = request.getParameter("cno1");
				String cno2 = request.getParameter("cno2");
				String email = request.getParameter("email");
				String regDate= request.getParameter("regDate").toString();
				String updateData="";
				String insertOrg="INSERT INTO `organization_details_master`(organization_id,"
						+ "`reg_date`, `org_name`, `org_address`, `owner_name`, `cno1`, `cno2`, `email`) VALUES "
						+ "(1,'"+regDate+"','"+orgName+"','"+orgAddress+"','"+ownerName+"','"+cno1+"','"+cno2+"','"+email+"')";
				int status=gd.executeCommand(insertOrg);
				if(status==1)
				{
					if(request.getParameter("UName").toString().trim()!=null && request.getParameter("UPass").toString().trim()!=null)
					{
						String UName=request.getParameter("UName").toString().trim();
						String UPass=request.getParameter("UPass").toString().trim();
						
						String insertUser="INSERT INTO `user_master`(`intuserid`,`varusername`, `varuserpass`, `introll`, `intstatus`)"
								+ " VALUES (1,'"+UName+"','"+UPass+"','1','0')";
						
						int userStatus=gd.executeCommand(insertUser);
						if(userStatus==1)
						{
							System.out.println("requestion");
							request.setAttribute("status", "User Created Successfully.Now Login As User");
							RequestDispatcher rd= request.getRequestDispatcher("jsp/common/login.jsp");
						   	rd.forward(request, response);
						}
						
					}
				}
			}
		}
		
	}

}
