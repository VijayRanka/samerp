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
import utility.RequireData;
import utility.SysDate;

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

		String query = "";
		int result=0;

		List details = null;
		
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
		String projectList=request.getParameter("projectList");
		String getProjectUpdate=request.getParameter("getProjectUpdate");
		String custid_projectUpdate=request.getParameter("custid_projectUpdate");
		
		//checkContactNo
		String checkContactNo=request.getParameter("checkContactNo");
		String checkContactNoUpdate=request.getParameter("checkContactNoUpdate");

		if (custid==null && custName != null) {
			
			String Customer_query = "INSERT INTO `customer_master`(`intcustid`, `custname`, `address`, `contactno`, `gstin`, `bucket_rate`, `breaker_rate`) VALUES (DEFAULT,'"
					+ custName + "','" + address + "','" + contactno + "','" + gstin + "','" + bucket_rate + "','" + breaker_rate + "')";

			int Customer_result = dao.executeCommand(Customer_query);
			
			String aliasName="CUST_"+contactno;
			String insertAlias="INSERT INTO `debtor_master`(`type`) VALUES ('"+aliasName+"')";
			int Alias_result = dao.executeCommand(insertAlias);

			if (Customer_result == 1 && Alias_result == 1) {
				if (path!=null) {
					response.sendRedirect("jsp/admin/jcb-poc-work/jcb-pocDetails.jsp");
				}else {
					response.sendRedirect("jsp/admin/settings/addCustomer.jsp");
				}
			} else {
				out.print("something wrong");
			}
		} else if (custid != null) {
			query="SELECT `contactno` FROM `customer_master` WHERE `intcustid`="+custid;
			details=dao.getData(query);
			String updateAliasContact="CUST_"+details.get(0).toString();
			
			String insertAliasContact="CUST_"+contactno;
			query="UPDATE `debtor_master` SET `type`='"+insertAliasContact+"' WHERE `type`='"+updateAliasContact+"'";
			int aliasContact_result = dao.executeCommand(query);
			
			String Customer_query = "UPDATE `customer_master` SET `custname`='"+custName+"',`address`='"+address+"',`contactno`='"+contactno+"',`gstin`='"+gstin+"',`bucket_rate`='"+bucket_rate+"',`breaker_rate`='"+breaker_rate+"' WHERE `intcustid`="+custid;

			int Customer_result = dao.executeCommand(Customer_query);

			if (Customer_result == 1 && aliasContact_result == 1) {
				response.sendRedirect("jsp/admin/settings/addCustomer.jsp");
			} else {
				out.print("something wrong");
			}
		}
		
		if (custid_project != null) {
			String projectname = request.getParameter("projectname");
			String openingBal = request.getParameter("openingBal");
			int project_result=0;
			String project_query="INSERT INTO `jcbpoc_project`(`cust_id`, `project_name`, `opening_balance`) VALUES"
					+ "("+custid_project+",'"+projectname+"','"+openingBal+"')";
			project_result = dao.executeCommand(project_query);

			if (openingBal != "") {
				query="SELECT `contactno` FROM `customer_master` WHERE `intcustid`="+custid_project;
				details=dao.getData(query);
				contactno="CUST_"+details.get(0).toString();
				
				RequireData rd =new RequireData();
				SysDate sd=new SysDate();
				String[] todate= sd.todayDate().split("-");
				String transactionDate=todate[2]+"-"+todate[1]+"-"+todate[0];
				int debit = 0;
				int credit = Integer.parseInt(openingBal);
				String debtorId = String.valueOf(rd.getDebtorId(contactno));;
				
				rd.pCashEntry(transactionDate, debit, credit, debtorId);
			}
			if (project_result == 1) {
				out.println("Project Inserted Successfully");
			} else {
				out.println("Something Wrong!");
			}
		}
		
		if (checkContactNo != null) {
			query="SELECT `contactno` FROM `customer_master` WHERE `contactno`="+checkContactNo;
			details=dao.getData(query);
			System.out.println(details+"<<<<<<<<<<");
			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + "~");
			}
		}
		if (checkContactNoUpdate != null) {
			String checkCustid = request.getParameter("checkCustid");
			query="SELECT `contactno` FROM `customer_master` WHERE `contactno`="+checkContactNoUpdate+" AND `intcustid`<>"+checkCustid;
			details=dao.getData(query);
			System.out.println(details+"<<<<<<<<<<");
			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + "~");
			}
		}
		if (projectList != null) {
			query="SELECT `id`, `project_name`, `opening_balance` FROM `jcbpoc_project` WHERE `status`=0 AND cust_id="+projectList+" ORDER BY `id` DESC";
			details=dao.getData(query);
			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + "~");
			}
		}
		if (getProjectUpdate != null) {
			query="SELECT `id`, `project_name`, `opening_balance` FROM `jcbpoc_project` WHERE id="+getProjectUpdate;
			details=dao.getData(query);
			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + "~");
			}
		}
		if (custid_projectUpdate != null) {
			String projectnameUpdate = request.getParameter("project_name1Update");
			String openingBalUpdate = request.getParameter("openingBalUpdate");
			query="SELECT `opening_balance` FROM `jcbpoc_project` WHERE id="+custid_projectUpdate;
			details=dao.getData(query);
			Iterator itr = details.iterator();
			String updateDeposit="";
			while (itr.hasNext()) {
				updateDeposit=(String) itr.next();

			}
			
			if (!openingBalUpdate.equals(updateDeposit)) {
				if (updateDeposit.equals("")) {
					updateDeposit="0";
				}
				if (openingBalUpdate.equals("")) {
					openingBalUpdate="0";
				}
				int newDeposit=Integer.parseInt(openingBalUpdate);
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
					
					query="SELECT `contactno` FROM `customer_master`,jcbpoc_project WHERE `intcustid`=jcbpoc_project.cust_id AND jcbpoc_project.id="+custid_projectUpdate;
					details=dao.getData(query);
					contactno="CUST_"+details.get(0).toString();
					
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
					
					query="SELECT `customer_master`.`contactno` FROM `customer_master`,jcbpoc_project WHERE `customer_master`.`intcustid`=`jcbpoc_project`.`cust_id` AND `jcbpoc_project`.`id`="+custid_projectUpdate;
					details=dao.getData(query);
					contactno="CUST_"+details.get(0).toString();
					
					query="SELECT `id` FROM `debtor_master` WHERE `type`='"+contactno+"'";
					details=dao.getData(query);
					
					debit = 0;
					credit = newDeposit;
					debtorId = details.get(0).toString();
					rd.pCashEntry(transactionDate, debit, credit, debtorId);
				}
			}
			query = "UPDATE `jcbpoc_project` SET `project_name`='"+projectnameUpdate+"',`opening_balance`='"+openingBalUpdate+"' WHERE `id`="+custid_projectUpdate;

			result = dao.executeCommand(query);

			if (result == 1) {
				out.println("Project Update Successfully");
			} else {
				out.print("something wrong");
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
