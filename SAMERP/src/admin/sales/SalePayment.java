package admin.sales;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;
import utility.RequireData;

public class SalePayment extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		GenericDAO gd = new GenericDAO();
		RequireData rd = new RequireData();
		PrintWriter out=response.getWriter();
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String requiredDate = df.format(new Date()).toString();
		

		if(request.getParameter("billSubmit")!=null){
			
			String clientid = request.getParameter("clientID1");
			String chalanList = request.getParameter("checkedChalan");
			String sale_id[] = chalanList.split(",");
			String bill_ID = request.getParameter("billNo");
			String billAmt = request.getParameter("billAmt");
			String billDate = request.getParameter("billDate");
			
			String query="SELECT po_no FROM sale_master WHERE id="+sale_id[0]+" AND client_id="+clientid;
			List l=gd.getData(query);
			String po_no=l.get(0).toString();
			
			String insertBill="INSERT INTO client_bill_master(`client_id`, `bill_amt`, `date`, `po_details`) VALUES ("+clientid+","+billAmt+",'"+billDate+"','"+po_no+"')";
			int insertBillStatus=gd.executeCommand(insertBill);
			System.out.println(insertBill);
			
			String totalRemaining="SELECT total_remaining_amt FROM client_payment_master WHERE id=(SELECT MAX(id) from client_payment_master WHERE client_id="+clientid+")";
			List tR = gd.getData(totalRemaining);
			
			int total_rmg_amt= Integer.parseInt(tR.get(0).toString())+Integer.parseInt(billAmt);
			System.out.println("Total R "+total_rmg_amt);
			
			String insertPayment="INSERT INTO `client_payment_master`( `client_id`, `bill_id`, `date`, `bill_amt`, `total_remaining_amt`) VALUES ("+clientid+","+bill_ID+",'"+billDate+"',"+billAmt+","+total_rmg_amt+")";
			gd.executeCommand(insertPayment);
			System.out.println(insertPayment);
			
			if(insertBillStatus==1){
				for (int i = 0; i < sale_id.length; i++) {
					
					String updateSaleEntry="UPDATE sale_master SET status=1, bill_id="+bill_ID+" WHERE id="+sale_id[i];
					int updateStaus=gd.executeCommand(updateSaleEntry);
					System.out.println(updateSaleEntry);
				}
				request.setAttribute("status", "Bill Checked Successfully");
			}
			
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("jsp/admin/sale/salePayment.jsp");
			requestDispatcher.forward(request, response);
			
			
		}
		
		
		if(request.getParameter("paymentSubmitbtn")!=null){
			
			String clientid = request.getParameter("clientID2");
			String paidDate = request.getParameter("paidDate");
			String paidAmt = request.getParameter("paidAmt");
			String payMode = request.getParameter("payMode");
			String chequeNo = request.getParameter("chequeNo");
			String bankid = request.getParameter("bankInfo");
			String remaminAmt = request.getParameter("remaminAmt");
			String insertPayment;
			int flag=0;
			
			
			int tatalRemaining=Integer.parseInt(remaminAmt)-Integer.parseInt(paidAmt);
			
			
			if(payMode.equals("Cash")){
				insertPayment="INSERT INTO `client_payment_master`(`client_id`, `date`, `paid_amt`, `mode`, `total_remaining_amt`) "
						+ " VALUES ("+clientid+",'"+paidDate+"',"+paidAmt+",'"+payMode+"',"+tatalRemaining+")";
				gd.executeCommand(insertPayment);
				
				List pettyDetails=gd.getData("SELECT payment_received,balance,id FROM petty_cash_details WHERE id=(SELECT MAX(id) FROM petty_cash_details)");
				
				int payment_received= Integer.parseInt( pettyDetails.get(0).toString());
				int balance= Integer.parseInt( pettyDetails.get(1).toString());
				int petty_cash_id= Integer.parseInt( pettyDetails.get(2).toString());
				payment_received+=Integer.parseInt(paidAmt);
				balance+=Integer.parseInt(paidAmt);
				System.out.println(payment_received+" "+balance+" "+petty_cash_id);
				
				String updatepetty="UPDATE `petty_cash_details` SET payment_received="+payment_received+" , balance="+balance+" WHERE id="+petty_cash_id;
				gd.executeCommand(updatepetty);
				flag=1;
			}
			else if(payMode.equals("Cheque")){
				
				insertPayment="INSERT INTO `client_payment_master`(`client_id`, `date`, `paid_amt`, `mode`, `bank_id`, `cheque_no`, `total_remaining_amt`)"
						+ " VALUES ("+clientid+",'"+paidDate+"',"+paidAmt+",'"+payMode+"',"+bankid+","+chequeNo+","+tatalRemaining+")";
				gd.executeCommand(insertPayment);
				flag=1;
			}
			else{
				insertPayment="INSERT INTO `client_payment_master`(`client_id`, `date`, `paid_amt`, `mode`, `bank_id`, `total_remaining_amt`)"
						+ " VALUES ("+clientid+",'"+paidDate+"',"+paidAmt+",'"+payMode+"',"+bankid+","+tatalRemaining+")";
				gd.executeCommand(insertPayment);
				flag=1;
			}
			
			if(flag==1){
				request.setAttribute("status", "Payment Done....");
			}
			
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("jsp/admin/sale/salePayment.jsp");
			requestDispatcher.forward(request, response);
		}
	}
}