package admin.JcbPocWork;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;
import utility.RequireData;
import utility.SysDate;

/**
 * Servlet implementation class JcbPocPaymentReceived
 */
public class JcbPocPaymentReceived extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		GenericDAO dao = new GenericDAO();
		String query = "";
		int result=0;
		List details = null;
		RequireData rd =new RequireData();
		String contactno="";
		
		String custId = request.getParameter("custId");
		String custUpdateId = request.getParameter("custUpdateId");
		String updateselect = request.getParameter("updateselect");
		
		String payDate = request.getParameter("payDate");
		String payAmount = request.getParameter("payAmount");
		String radios = request.getParameter("radios");
		String payBank = request.getParameter("payBank");
		String payCheque =request.getParameter("payCheque");
		String payDescription=request.getParameter("payDescription");
		
		if (custId != null) {
			String payMode="";
			String particular="";
			String debtorId ="";
			if (radios.equals("1")) {
				payMode="cash";
				payBank="null";
				payCheque="";
			}
			if (radios.equals("2")) {
				payMode="Cheque";
				particular="Cheque No-"+payCheque;
			}
			if (radios.equals("3")) {
				payMode="Transfer";
				payCheque="";
				particular="Transfer";
			}
			
			if (payAmount != "" && radios.equals("1")) {
				query="SELECT `contactno` FROM `customer_master` WHERE `intcustid`="+custId;
				details=dao.getData(query);
				contactno="CUST_"+details.get(0).toString();
				
				String transactionDate=payDate;
				int debit = 0;
				int credit = Integer.parseInt(payAmount);
				debtorId = String.valueOf(rd.getDebtorId(contactno));;
				rd.pCashEntry(transactionDate, debit, credit, debtorId);
			}
			if (payAmount != "" && radios.equals("2") || radios.equals("3")) {
				query="SELECT `contactno` FROM `customer_master` WHERE `intcustid`="+custId;
				details=dao.getData(query);
				contactno="CUST_"+details.get(0).toString();
				
				String transactionDate=payDate;
				int debit = 0;
				int credit = Integer.parseInt(payAmount);
				debtorId = String.valueOf(rd.getDebtorId(contactno));;
				rd.badEntry(payBank, transactionDate, debit, credit, particular, debtorId);
			}
		
			query = "INSERT INTO `jcbpoc_payment`( `description`, `amount`, `date`, `pay_mode`, `bank_id`, `cheque_no`, `debtorId`) VALUES "
					+ "('"+payDescription+"','"+payAmount+"','"+payDate+"','"+payMode+"',"+payBank+",'"+payCheque+"',"+debtorId+")";

			result = dao.executeCommand(query);

			if (result == 1) {
				response.sendRedirect("jsp/admin/jcb-poc-work/jcb-pocPaymentReceived.jsp");
			} else {
				out.print("something wrong");
			}
		}
//	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@	UPDATE @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		if (custUpdateId != null) {
			String payMode="";
			String particular="";
			String debtorId =request.getParameter("debtorId");
			
			query = "SELECT `amount` FROM `jcbpoc_payment` WHERE `id`=" + custUpdateId;
			details = dao.getData(query);
			Iterator itr = details.iterator();
			String updateDeposit = "";
			while (itr.hasNext()) {
				updateDeposit = (String) itr.next();

			}
			
			if (payAmount != "" && radios.equals("1")) {
				payMode = "cash";
				payBank = "null";
				payCheque = "";

				

				if (!payAmount.equals(updateDeposit)) {
					if (updateDeposit.equals("")) {
						updateDeposit = "0";
					}
					if (payAmount.equals("")) {
						payAmount = "0";
					}
					int newDeposit = Integer.parseInt(payAmount);
					int oldDeposit = Integer.parseInt(updateDeposit);

					SysDate sd = new SysDate();
					String[] todate = sd.todayDate().split("-");
					String transactionDate = todate[2] + "-" + todate[1] + "-" + todate[0];

					int debit = oldDeposit;
					int credit = 0;
					String tempdebtorId = "1";

					rd.pCashEntry(transactionDate, debit, credit, tempdebtorId);

					

					debit = 0;
					credit = newDeposit;
					rd.pCashEntry(transactionDate, debit, credit, debtorId);
				}
			}
			if (payAmount != "" && radios.equals("2") || radios.equals("3")) {
				if (radios.equals("2")) {
					particular="Cheque No-"+payCheque;
				}
				if (radios.equals("3")) {
					payCheque="";
					particular="Transfer";
				}
				if (updateDeposit.equals("")) {
					updateDeposit = "0";
				}
				if (payAmount.equals("")) {
					payAmount = "0";
				}
				int newDeposit = Integer.parseInt(payAmount);
				int oldDeposit = Integer.parseInt(updateDeposit);
				
				String transactionDate=payDate;
				int debit = oldDeposit;
				int credit = 0;
				String tempdebtorId = "1";
				
				rd.badEntry(payBank, transactionDate, debit, credit, particular, tempdebtorId);
				
				debit = 0;
				credit = newDeposit;
				rd.badEntry(payBank, transactionDate, debit, credit, particular, debtorId);
			}
			query = "UPDATE `jcbpoc_payment` SET `description`='"+payDescription+"',`amount`='"+payAmount+"',`date`='"+payDate+"',`bank_id`='"+payBank+"',`cheque_no`='"+payCheque+"' WHERE `id`="+custUpdateId;

			result = dao.executeCommand(query);

			if (result == 1) {
				response.sendRedirect("jsp/admin/jcb-poc-work/jcb-pocPaymentReceived.jsp");
			} else {
				out.print("something wrong");
			}
		}
		if (updateselect != null) {
			query="SELECT `id`, `description`, `amount`, `date`, `pay_mode`, `bank_id`, `cheque_no`, `debtorId` FROM `jcbpoc_payment` WHERE `id`="+updateselect;
			details=dao.getData(query);
			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + "~");

			}
		}
	}

}
