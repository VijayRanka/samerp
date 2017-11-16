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

/**
 * Servlet implementation class JcbPocBill
 */
public class JcbPocBill extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		GenericDAO dao = new GenericDAO();
		RequireData rd=new RequireData();

		String query = "";
		int result=0;

		List details = null;
		
		String CustomerPoject = request.getParameter("CustomerPoject");
		String projectId = request.getParameter("projectId");
		String invoiceId = request.getParameter("invoiceId");
		String autoIncrement=request.getParameter("autoIncrement");
		
		//Update
		String getBillId = request.getParameter("getBillId");
		String getInvoiceDataUpdate = request.getParameter("getInvoiceDataUpdate");
		
		if (CustomerPoject != null) {
			query="SELECT `id`, `project_name` FROM `jcbpoc_project` WHERE `status` =0 AND `cust_id`="+CustomerPoject;
			details=dao.getData(query);
			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + "~");

			}
		}
		
		if (projectId != null) {
			query="SELECT `intjcbpocid`, `data`, `chalanno`,"
					+ " `bucket_hr`, `breaker_hr`,`deposit`, `diesel`,"
					+ "  `bucket_rate`, `breaker_rate` FROM `jcbpoc_master` WHERE `status`=0 AND `project_id` ="+projectId;
			details=dao.getData(query);
			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + "~");

			}
		}
		
		//Update
		if (getBillId != null) {
			query="SELECT `gst` FROM `jcbpoc_invoice` WHERE `id`="+getBillId;
			details=dao.getData(query);
			Iterator itr1 = details.iterator();
			while (itr1.hasNext()) {
				out.print(itr1.next() + "~");

			}
			
			query="SELECT `intjcbpocid`, `data`, `chalanno`,"
					+ " `bucket_hr`, `breaker_hr`,`deposit`, `diesel`,"
					+ "  `bucket_rate`, `breaker_rate` FROM `jcbpoc_master` WHERE jcbpoc_master.invoice_id="+getBillId;
			details=dao.getData(query);
			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + "~");

			}
		}
		
		
//	======================================	BILL FORM=========================================================================
		if (autoIncrement != null) {
			query="SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA='samerp' AND TABLE_NAME='jcbpoc_invoice'";
			details=dao.getData(query);
			out.println(details.get(0).toString());
			
			query="SELECT `gstin` FROM `customer_master` WHERE `intcustid`="+autoIncrement;
			details=dao.getData(query);
			out.println("~"+details.get(0).toString());
		}
		if (getInvoiceDataUpdate != null) {
			query="SELECT jcbpoc_invoice.date,customer_master.intcustid,customer_master.custname,customer_master.gstin "
					+ "FROM `jcbpoc_invoice`,customer_master "
					+ "WHERE jcbpoc_invoice.cust_id=customer_master.intcustid AND jcbpoc_invoice.id="+getInvoiceDataUpdate;
			details=dao.getData(query);
			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + "~");

			}
		}
		if (invoiceId != null) {
			query="SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA='samerp' AND TABLE_NAME='jcbpoc_invoice'";
			details=dao.getData(query);
			int insertId = Integer.parseInt((String) details.get(0));
			int getId = Integer.parseInt(invoiceId.trim());
			if (insertId == getId) {
				String customerInvoice = request.getParameter("customerInvoice");
				String invoiceDate=request.getParameter("invoiceDate");
				String payAmtPrintTxt=request.getParameter("payAmtPrintTxt");
				String gst=request.getParameter("gstPrint");
				int gstPrint=Integer.parseInt(gst.trim());
				if (gstPrint == 0) {
					query = "INSERT INTO `jcbpoc_invoice`(`id`, `cust_id`, `date`, `bill_amount`) VALUES ("+invoiceId+",'"+customerInvoice+"','"+invoiceDate+"','"+payAmtPrintTxt+"')";

					result = dao.executeCommand(query);
				}else {
					query="SELECT MAX(`bill_id`) FROM `jcbpoc_invoice`";
					details=dao.getData(query);
					int billId = (int) details.get(0);
					billId=billId + 1;
					query = "INSERT INTO `jcbpoc_invoice`(`id`, `bill_id`, `cust_id`, `date`, `bill_amount`, `gst`) VALUES "
							+ "("+invoiceId+","+billId+",'"+customerInvoice+"','"+invoiceDate+"','"+payAmtPrintTxt+"','"+gst+"')";

					result = dao.executeCommand(query);
				}
				

				if (result == 1) {
					int str=Integer.parseInt(request.getParameter("rowCounterPrint"));
					for (int i = 1; i < str; i++) {
						String jcbpocIdPrint=request.getParameter("jcbpocIdPrint"+i);
						
						query="UPDATE `jcbpoc_master` SET `status`='1',`invoice_id`="+invoiceId+" WHERE `intjcbpocid`="+jcbpocIdPrint;
						dao.executeCommand(query);
					}
//		============================Payment Entry=========================================================
					String amt="";
					String balance=rd.getTotalRemainingBalance(customerInvoice, payAmtPrintTxt, amt);
					
					query = "INSERT INTO `jcbpoc_payment`(`cust_id`, `bill_id`, `description`, `bill_amount`, `total_balance`, `date`) VALUES "
							+ "("+customerInvoice+","+invoiceId+",'Invoice No-"+invoiceId+"','"+payAmtPrintTxt+"','"+balance+"','"+invoiceDate+"')";
					System.out.println(">>>"+query);
					result = dao.executeCommand(query);
					
					if (result == 1) {
						response.sendRedirect("jsp/admin/jcb-poc-work/jcb-pocBill.jsp");
					}else{
						out.print("something wrong IN Inserting");
					}
				} else {
					out.print("something wrong IN Inserting");
				}
			}else {
				
				query = "UPDATE `jcbpoc_master` SET `status`='0',`invoice_id`=null WHERE `invoice_id`='"+invoiceId+"'";
				dao.executeCommand(query);
						
				String payAmtPrintTxt=request.getParameter("payAmtPrintTxt");
				
				String gst=request.getParameter("gstPrint");
				int gstPrint=Integer.parseInt(gst.trim());
				
				query="SELECT `bill_id` FROM `jcbpoc_invoice` WHERE `id`="+invoiceId;
				details=dao.getData(query);
				int billId = (int) details.get(0);
				
				if (gstPrint != 0 && billId == 0) {
					query="SELECT MAX(`bill_id`) FROM `jcbpoc_invoice`";
					details=dao.getData(query);
					billId = (int) details.get(0);
					billId=billId + 1;
					query = "UPDATE `jcbpoc_invoice` SET `bill_id`="+billId+",`bill_amount`='"+payAmtPrintTxt+"',`gst`='"+gst+"' WHERE `id`="+invoiceId;
				}else {
					query = "UPDATE `jcbpoc_invoice` SET `bill_amount`='"+payAmtPrintTxt+"',`gst`='"+gst+"' WHERE `id`="+invoiceId;
				}
				result = dao.executeCommand(query);
				if (result == 1) {
					int str=Integer.parseInt(request.getParameter("rowCounterPrint"));
					for (int i = 1; i < str; i++) {
						String jcbpocIdPrint=request.getParameter("jcbpocIdPrint"+i);
						
						query="UPDATE `jcbpoc_master` SET `status`='1',`invoice_id`="+invoiceId+" WHERE `intjcbpocid`="+jcbpocIdPrint;
						result = dao.executeCommand(query);
					}
					response.sendRedirect("jsp/admin/jcb-poc-work/jcb-pocBill.jsp");
				} else {
					out.print("something wrong in Update");
				}

			}
			

		}
//	======================================	END BILL FORM=========================================================================
	}

}
