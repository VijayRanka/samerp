package admin.JcbPocWork;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;

/**
 * Servlet implementation class JcbPocPayment
 */
@WebServlet("/JcbPocPayment")
public class JcbPocPayment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		GenericDAO dao = new GenericDAO();
		String custid=request.getParameter("custid");
		String custIdView=request.getParameter("custIdView");
		
		if (custid != null) {
//			CustomerPaymentCalculation cp =new CustomerPaymentCalculation();
//			out.print(cp.getCustomerTotalPayment(custid));
			String query = "SELECT `total_balance` FROM `jcbpoc_payment` WHERE  cust_id="+custid+" ORDER BY jcbpoc_payment.`id` DESC LIMIT 1";
			List getCustList=dao.getData(query);
			Iterator itr = getCustList.iterator();
			while (itr.hasNext()) {
					Object x=itr.next();
					out.print(x);
			}
		}
		if (custIdView != null) {
			String thisYear=request.getParameter("thisYear");
			String thisMonthStr=request.getParameter("thisMonth");
			int thisMonth=Integer.valueOf(thisMonthStr)+1;
			String query = "SELECT date,description,bill_amount,amount,total_balance FROM `jcbpoc_payment` WHERE status=0 AND `cust_id`="+custIdView+" AND MONTH(`date`)="+thisMonth+" AND YEAR(`date`)="+thisYear+" ORDER BY id DESC";
			List getCustList=dao.getData(query);
			Iterator itr = getCustList.iterator();
			while (itr.hasNext()) {
					Object x=itr.next();
					out.print(x + "~");
			}
//			String query = "SELECT `id`, `project_name`, `opening_balance` FROM `jcbpoc_project` WHERE `status`=0 AND `cust_id`="+custIdView;
//			List getCustList=dao.getData(query);
//			Iterator custList=getCustList.iterator();
//			
//			while(custList.hasNext())
//			{
//				Object projectId=custList.next();
//				CustomerPaymentCalculation cp=new CustomerPaymentCalculation();
//				List projectList=cp.getCustomerTotalPayment(custIdView, projectId.toString());
//				Object projectName=custList.next();
//				Object openingBal=custList.next();
//				
//				out.print(projectName);
//				out.print(",");
//				out.print(openingBal);
//				out.print(",");
//				
//				Iterator custListIrt=projectList.iterator();
//				while (custListIrt.hasNext()) {
//					Object x=custListIrt.next();
//					out.print(x);
//					out.print(",");
//				}
//				out.print("~");
//			}
		}
	}

}
