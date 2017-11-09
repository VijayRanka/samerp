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
import utility.RequireData;
import utility.SysDate;

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
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		GenericDAO dao = new GenericDAO();
		
		String CustomerSearch = request.getParameter("q");
		String CustomerPrint = request.getParameter("CustomerPrint");
		String updateselect = request.getParameter("updateselect");
		String update = request.getParameter("update");
		String jcbpocid = request.getParameter("jcbpocid");
		String deleteid =request.getParameter("deleteid");
		String CustomerProjectId=request.getParameter("CustomerProjectId");
		String CustomerProjectIdUpdate=request.getParameter("CustomerProjectIdUpdate");
		
		String custid=request.getParameter("custid");
		String project_id=request.getParameter("cust_project");
		String bucketRateCustomer=request.getParameter("bucketRateCustomer");
		String breakerRateCustomer=request.getParameter("breakerRateCustomer");
		
		String vehicleid=request.getParameter("vehicle");
		String chalanno=request.getParameter("chalanno");
		String chalandate=request.getParameter("chalandate");
		String bucket_hrs=request.getParameter("bucket_hrs");
		String breaker_hrs=request.getParameter("breaker_hrs");
		String bucket_rate = request.getParameter("bucket_rate");
		String breaker_rate = request.getParameter("breaker_rate");
		String deposit = request.getParameter("deposit");
		String diesel = request.getParameter("diesel");
		

		String query = "";
		int result=0;

		List details = null;
		if (custid != null && vehicleid!= null) {
			
			String[] arrayOfString = chalandate.split("-");
			if (deposit != "") {
				String contactno="CUST_"+request.getParameter("contactno");
				query="SELECT `id` FROM `debtor_master` WHERE `type`='"+contactno+"'";
				details=dao.getData(query);
				
				String transactionDate=arrayOfString[2]+"-"+arrayOfString[1]+"-"+arrayOfString[0];
				int debit = 0;
				int credit = Integer.parseInt(deposit);
				String debtorId = details.get(0).toString();
				RequireData rd =new RequireData();
				rd.pCashEntry(transactionDate, debit, credit, debtorId);
			}
			
		
			query = "INSERT INTO `jcbpoc_master`(`intjcbpocid`, `intcustid`, `project_id`, `intvehicleid`, `chalanno`, `data`, `bucket_hr`, `breaker_hr`, `bucket_rate`, `breaker_rate`, `deposit`, `diesel`) VALUES (DEFAULT,'"+custid+"','"+project_id+"','"+vehicleid+"','"+chalanno+"','"+arrayOfString[2]+"-"+arrayOfString[1]+"-"+arrayOfString[0]+"','"+bucket_hrs+"','"+breaker_hrs+"','"+bucket_rate+"','"+breaker_rate+"','"+deposit+"','"+diesel+"')";

			result = dao.executeCommand(query);

			if (result == 1) {
				response.sendRedirect("jsp/admin/jcb-poc-work/jcb-pocDetails.jsp");
			} else {
				out.print("something wrong");
			}
		}
		if (update !=null && jcbpocid != null) {
			
			query="SELECT `deposit` FROM `jcbpoc_master` WHERE `intjcbpocid`="+jcbpocid;
			details=dao.getData(query);
			Iterator itr = details.iterator();
			String updateDeposit="";
			while (itr.hasNext()) {
				updateDeposit=(String) itr.next();

			}
			
			if (!deposit.equals(updateDeposit)) {
				if (updateDeposit.equals("")) {
					updateDeposit="0";
				}
				if (deposit.equals("")) {
					deposit="0";
				}
				int newDeposit=Integer.parseInt(deposit);
				int oldDeposit=Integer.parseInt(updateDeposit);
				
				if (newDeposit > oldDeposit) {
					
					SysDate sd=new SysDate();
					String[] todate= sd.todayDate().split("-");
					String transactionDate=todate[2]+"-"+todate[1]+"-"+todate[0];
					
					int debit = oldDeposit;
					int credit = 0;
					String debtorId = "1";
					
					RequireData rd =new RequireData();
					rd.pCashEntry(transactionDate, debit, credit, debtorId);
					
					String contactno="CUST_"+request.getParameter("contactno");
					query="SELECT `id` FROM `debtor_master` WHERE `type`='"+contactno+"'";
					details=dao.getData(query);
					
					debit = 0;
					credit = newDeposit;
					debtorId = details.get(0).toString();
					rd.pCashEntry(transactionDate, debit, credit, debtorId);
				}
				
				if (newDeposit < oldDeposit) {
					
					SysDate sd=new SysDate();
					String[] todate= sd.todayDate().split("-");
					String transactionDate=todate[2]+"-"+todate[1]+"-"+todate[0];
					
					int debit = oldDeposit;
					int credit = 0;
					String debtorId = "1";
					
					RequireData rd =new RequireData();
					rd.pCashEntry(transactionDate, debit, credit, debtorId);
					
					String contactno="CUST_"+request.getParameter("contactno");
					query="SELECT `id` FROM `debtor_master` WHERE `type`='"+contactno+"'";
					details=dao.getData(query);
					
					debit = 0;
					credit = newDeposit;
					debtorId = details.get(0).toString();
					rd.pCashEntry(transactionDate, debit, credit, debtorId);
				}
			}
			String[] arrayOfString = chalandate.split("-");
			query = "UPDATE `jcbpoc_master` SET `project_id`="+project_id+",`intvehicleid`='"+vehicleid+"',`chalanno`='"+chalanno+"',`data`='"+arrayOfString[2]+"-"+arrayOfString[1]+"-"+arrayOfString[0]+"',`bucket_hr`='"+bucket_hrs+"',`breaker_hr`='"+breaker_hrs+"',`bucket_rate`='"+bucket_rate+"',`breaker_rate`='"+breaker_rate+"',`deposit`='"+deposit+"',`diesel`='"+diesel+"' WHERE `intjcbpocid`="+jcbpocid;

			result = dao.executeCommand(query);

			if (result == 1) {
				response.sendRedirect("jsp/admin/jcb-poc-work/jcb-pocDetails.jsp");
			} else {
				out.print("something wrong");
			}
		}
		if (deleteid !=null) {
			query = "DELETE FROM `jcbpoc_master` WHERE `intjcbpocid`="+deleteid;

			result = dao.executeCommand(query);

			if (result == 1) {
				response.sendRedirect("jsp/admin/jcb-poc work/jcb-pocDetails.jsp");
			} else {
				out.print("something wrong");
			}
		}
		if (updateselect != null) {
			query="SELECT customer_master.`custname`,customer_master.address,customer_master.contactno,jcbpoc_master.bucket_rate,jcbpoc_master.breaker_rate,"
					+ "jcbpoc_master.`chalanno`,"
					+ "vehicle_details.vehicle_aliasname,jcbpoc_master.`data`,jcbpoc_master.bucket_hr,jcbpoc_master.breaker_hr,jcbpoc_master.deposit,jcbpoc_master.diesel,jcbpoc_master.intjcbpocid FROM `jcbpoc_master`,"
					+ "customer_master,vehicle_details WHERE jcbpoc_master.intcustid=customer_master.intcustid AND "
					+ "jcbpoc_master.intvehicleid=vehicle_details.vehicle_id AND jcbpoc_master.intjcbpocid="+updateselect;
			details=dao.getData(query);
			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + "~");

			}
		}
		if (CustomerPrint != null) {
			query="SELECT `intcustid`, `custname`, `address`, `contactno`, `bucket_rate`, `breaker_rate` FROM `customer_master` where `intcustid`="+CustomerPrint;
			details=dao.getData(query);
			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + "~");

			}
		}
		if (CustomerSearch != null){
			query="SELECT `intcustid`,`custname` FROM `customer_master` WHERE `custname` LIKE '"+CustomerSearch+"%' UNION SELECT `intcustid`,`contactno` FROM customer_master WHERE `contactno` LIKE '"+CustomerSearch+"%'";
			details = dao.getData(query);

			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + ",");

			}
		}
		if (custid !=null && bucketRateCustomer !=null) {
			query = "UPDATE `customer_master` SET `bucket_rate`="+bucketRateCustomer+" WHERE `intcustid`="+custid;

			result = dao.executeCommand(query);

			if (result == 1) {
				out.print("Buket Rate Update Successfully!");
			} else {
				out.print("Something Wrong!");
			}
		}
		if (custid !=null && breakerRateCustomer !=null) {
			query = "UPDATE `customer_master` SET `breaker_rate`="+breakerRateCustomer+" WHERE `intcustid`="+custid;

			result = dao.executeCommand(query);

			if (result == 1) {
				out.print("Breaker Rate Update Successfully!");
			} else {
				out.print("Something Wrong!");
			}
		}
		if (CustomerProjectId != null) {
			query="SELECT `id`, `project_name` FROM `jcbpoc_project` WHERE `status`=0 AND `cust_id`="+CustomerProjectId;
			details = dao.getData(query);

			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + ",");

			}
		}
		if (CustomerProjectIdUpdate != null) {
			query="SELECT jcbpoc_project.id,jcbpoc_project.project_name FROM `jcbpoc_master`,jcbpoc_project WHERE jcbpoc_master.intcustid=jcbpoc_project.cust_id AND jcbpoc_master.intjcbpocid="+CustomerProjectIdUpdate;
			details = dao.getData(query);

			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + ",");

			}
		}


	}

}
