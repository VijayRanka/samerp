package admin.JcbPocWork;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;

/**
 * Servlet implementation class JcbPocDetails
 */
@WebServlet("/JcbPocDetails")
public class JcbPocDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public JcbPocDetails() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		GenericDAO dao = new GenericDAO();
		
		String CustomerSearch = request.getParameter("q");
		String CustomerPrint = request.getParameter("CustomerPrint");
		String custid=request.getParameter("custid");
		String vehicleid=request.getParameter("vehicle");
		String chalanno=request.getParameter("chalanno");
		String chalandate=request.getParameter("chalandate");
		String workhrs=request.getParameter("workhrs");
		String vehiclerate=request.getParameter("vehiclerate");

		String query = "";
		int result=0;

		List details = null;
		if (custid != null) {
			String[] arrayOfString = chalandate.split("-");
			
			out.println(custid+"<custid>");
			out.println(vehicleid+"<videhicle id>");
			out.println(chalanno+"id<chalanno>");
			out.println(chalandate+"<date>");
			out.println(workhrs+"<work hr>");
			out.println(vehiclerate+"<rate>");
			query = "INSERT INTO `jcbpoc_master`(`intjcbpocid`, `intcustid`, `intvehicleid`, `chalanno`, `data`, `workhr`, `rate`) VALUES (DEFAULT,'"+custid+"','"+vehicleid+"','"+chalanno+"','"+arrayOfString[2]+"-"+arrayOfString[1]+"-"+arrayOfString[0]+"','"+workhrs+"','"+vehiclerate+"')";

			result = dao.executeCommand(query);

			if (result == 1) {
				response.sendRedirect("jsp/admin/jcb-poc work/jcb-pocDetails.jsp");
			} else {
				out.print("something wrong");
			}
		}
		if (CustomerPrint != null) {
			query="SELECT * FROM `customer_master` where `intcustid`="+CustomerPrint;
			details=dao.getData(query);
			
			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + "~");

			}
		}
		if (CustomerSearch != null){
			query="SELECT `intcustid`,`custname` FROM `customer_master` WHERE `custname` LIKE '"+CustomerSearch+"%' UNION SELECT `intcustid`,`contactno` FROM customer_master WHERE `contactno` LIKE '"+CustomerSearch+"%'";
			System.out.println("query 1====" + query);
			details = dao.getData(query);
			System.out.println("Query===" + details);

			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + ",");

			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
