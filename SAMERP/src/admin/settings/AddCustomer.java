package admin.settings;

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

import dao.General.GenericDAO;

/**
 * Servlet implementation class AddCustomer
 */
@WebServlet("/AddCustomer")
public class AddCustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCustomer() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		GenericDAO dao = new GenericDAO();
		
		String Customer_query="SELECT `intcustid`, `custname`, `address`, `contactno`, `gstin`, `bucket_rate`, `breaker_rate` FROM `customer_master` where `intcustid`="+request.getParameter("q");
		System.out.println(Customer_query);
		List CustomerList=dao.getData(Customer_query);
		System.out.println(CustomerList);
		
		Iterator itr = CustomerList.iterator();
		while (itr.hasNext()) {
			out.print(itr.next() + ",");

		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Add Customer
		PrintWriter out = response.getWriter();
		GenericDAO dao = new GenericDAO();
		
		String path=request.getParameter("path");

		String custid = request.getParameter("custid");
		String custName = request.getParameter("custname");
		String address = request.getParameter("address");
		String contactno = request.getParameter("contactno");
		String gstin=request.getParameter("gstin");
		String bucket_rate = request.getParameter("bucket_rate");
		String breaker_rate = request.getParameter("breaker_rate");
		
		//Project Add
		String custid_project=request.getParameter("custid_project");
		String count_project=request.getParameter("count_project");

		if (custid==null && custName != null) {
			
			String Customer_query = "INSERT INTO `customer_master`(`intcustid`, `custname`, `address`, `contactno`, `gstin`, `bucket_rate`, `breaker_rate`) VALUES (DEFAULT,'"
					+ custName + "','" + address + "','" + contactno + "','" + gstin + "','" + bucket_rate + "','" + breaker_rate + "')";

			int Customer_result = dao.executeCommand(Customer_query);

			if (Customer_result == 1) {
				if (path!=null) {
					response.sendRedirect("jsp/admin/jcb-poc-work/jcb-pocDetails.jsp");
				}else {
					response.sendRedirect("jsp/admin/settings/addCustomer.jsp");
				}
			} else {
				out.print("something wrong");
			}
		} else if (custid != null) {

			String Customer_query = "UPDATE `customer_master` SET `custname`='"+custName+"',`address`='"+address+"',`contactno`='"+contactno+"',`gstin`='"+gstin+"',`bucket_rate`='"+bucket_rate+"',`breaker_rate`='"+breaker_rate+"' WHERE `intcustid`="+custid;

			int Customer_result = dao.executeCommand(Customer_query);

			if (Customer_result == 1) {
				response.sendRedirect("jsp/admin/settings/addCustomer.jsp");
			} else {
				out.print("something wrong");
			}
		}
		
		if (custid_project != null) {
			String projectname[] = new String[Integer.parseInt(count_project)];
			for (int i = 0; i < projectname.length; i++) {
				projectname[i]=request.getParameter("projectname"+(i+1));
			}
			int project_result=0;
			for (int i = 0; i < projectname.length; i++) {
				String project_query="INSERT INTO `jcbpoc_project`(`cust_id`,`project_name`) VALUES("+custid_project+",'"+projectname[i]+"')";
				project_result = dao.executeCommand(project_query);
			}
			

			if (project_result == 1) {
				if (path.equals("jcbpoc")) {
					response.sendRedirect("jsp/admin/jcb-poc-work/jcb-pocDetails.jsp");
				}else {
					response.sendRedirect("jsp/admin/settings/addCustomer.jsp");
				}
			}
		}
		
		
		
	}

	/**
	 * @see HttpServlet#doDelete(HttpServletRequest, HttpServletResponse)
	 */
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		GenericDAO dao = new GenericDAO();
		
		String Customer_query="DELETE FROM `customer_master` WHERE `intcustid`="+request.getParameter("q");
		System.out.println(Customer_query);
		int Customer_result = dao.executeCommand(Customer_query);

		if (Customer_result == 1) {
			RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addCustomer.jsp");
			rd.forward(request, response);
		} else {
			out.print("something wrong");

		}
	}

}
