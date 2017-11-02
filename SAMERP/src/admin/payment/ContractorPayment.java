package admin.payment;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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



public class ContractorPayment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		
		GenericDAO gd=new GenericDAO();
		
		//paymentDataEntry
		if(request.getParameter("paymentSubmit")!=null)
		{
			String contId=request.getParameter("contId");
			String prevRemAmount=request.getParameter("prevRemAmount");
			String currentAmount=request.getParameter("currentAmount");
			String totalBillAmt=request.getParameter("totalPayAmt");
			String paidAmt=request.getParameter("paidAmount");
			String paidDate=request.getParameter("paidDate");
			String payMode=request.getParameter("payMode");
			String dateFromTo=request.getParameter("dateFromTo");
			String deposit=request.getParameter("deposit");
			String loadingCharges=request.getParameter("loadingCharges");
			String chequeNo = request.getParameter("chequeNo");
			String bankInfo = request.getParameter("bankInfo");
			int updatedAmount=0;
			boolean flag=false;
			
			
			if(!gd.getData("SELECT `total_balance` FROM `contractor_payment_details` WHERE contractor_id="+contId).isEmpty())
			{
				List getTotalBalance=gd.getData("SELECT `total_balance` FROM `contractor_payment_details` WHERE contractor_id="+contId);
				
				int x=Integer.parseInt(getTotalBalance.get(getTotalBalance.size()-1).toString());
				
				updatedAmount=x+Integer.parseInt(totalBillAmt)-Integer.parseInt(paidAmt);
				
			}
			else
				updatedAmount=Integer.parseInt(totalBillAmt)-Integer.parseInt(paidAmt);
			
			if(payMode.equals("Cash")){
				String insertPayment = "INSERT INTO `contractor_payment_details`( `contractor_id`,`date`, `from_date`, `to_date`, `loading_charges`,"
						+ " `deposit`, `total_bill_amt`, `paid_amount`, `mode`,`total_balance`) VALUES "
						+ "("+contId+",'"+paidDate+"','"+dateFromTo.split(",")[0]+"','"+dateFromTo.split(",")[1]+"',"+loadingCharges+","+deposit+","+totalBillAmt+","+paidAmt+",'CASH',"+updatedAmount+")";
				int insertPaymentStatus = gd.executeCommand(insertPayment);
				
				if(insertPaymentStatus==1){
					flag=true;
					request.setAttribute("status", "Payment of "+paidAmt+" Rs. done Successfully");
				}
			}
			else  if(payMode.equals("Cheque")){
				String insertPayment = "INSERT INTO `contractor_payment_details`( `contractor_id`,`date`, `from_date`, `to_date`, `loading_charges`,"
						+ " `deposit`, `total_bill_amt`, `paid_amount`, `mode`, `particular`, `description`,`total_balance`) VALUES "
						+ "("+contId+",'"+paidDate+"','"+dateFromTo.split(",")[0]+"','"+dateFromTo.split(",")[1]+"',"+loadingCharges+","+deposit+","+totalBillAmt+","+paidAmt+",'CHEQUE','"+chequeNo+"','"+bankInfo+"',"+updatedAmount+")";
				int insertPaymentStatus = gd.executeCommand(insertPayment);
				
				if(insertPaymentStatus==1){
					flag=true;
					request.setAttribute("status", "Payment of "+paidAmt+" Rs. done Successfully");
				}
			}
			else{
				
				String insertPayment = "INSERT INTO `contractor_payment_details`( `contractor_id`,`date`, `from_date`, `to_date`, `loading_charges`,"
						+ " `deposit`, `total_bill_amt`, `paid_amount`, `mode`, `particular`, `description`,`total_balance`) VALUES "
						+ "("+contId+","+paidDate+"','"+dateFromTo.split(",")[0]+"','"+dateFromTo.split(",")[1]+"',"+loadingCharges+","+deposit+","+totalBillAmt+","+paidAmt+",'TRANSFER',"+bankInfo+"',"+updatedAmount+")";
				int insertPaymentStatus = gd.executeCommand(insertPayment);
				
				if(insertPaymentStatus==1){
					flag=true;
					
					request.setAttribute("status", "Payment of "+paidAmt+" Rs. done Successfully");
				}
			}
			if(flag)
			{
				String updateDailyStock="UPDATE daily_stock_details SET status=1 "
						+ "WHERE id=(SELECT daily_stock_details.id from contractor_master,product_master WHERE "
						+ "product_master.id=daily_stock_details.product_id and date BETWEEN '"+dateFromTo.split(",")[0]+"' and '"+dateFromTo.split(",")[1]+"' "
						+ "AND product_master.contractor_id=contractor_master.id AND contractor_master.id="+contId+" )";
				int xx=gd.executeCommand(updateDailyStock);
				if(xx>0)
				{
					String updateExp="UPDATE expenses_master SET expenses_master.cp_status=1 WHERE expenses_master.exp_id="
							+ "(SELECT expenses_master.exp_id from debtor_master,contractor_master,expenses_type "
							+ "WHERE expenses_type.expenses_type_id=expenses_master.expenses_type_id and debtor_master.id"
							+ "=expenses_master.debtor_id and debtor_master.type=contractor_master.aliasname AND "
							+ "expenses_master.date BETWEEN '"+dateFromTo.split(",")[0]+"' AND '"+dateFromTo.split(",")[1]+"' AND cp_status=0 AND "
							+ "expenses_type.expenses_type_name='DEPOSIT' AND contractor_master.id="+contId+")";
					int updDS=gd.executeCommand(updateDailyStock);
			
					String updateSaleMaster="UPDATE sale_master SET sale_master.cp_status=1 WHERE sale_master.id="
							+ "(SELECT sale_master.id FROM contractor_master WHERE contractor_master.id=sale_master.loading_by_id "
							+ "and sale_master.date BETWEEN '"+dateFromTo.split(",")[0]+"' AND '"+dateFromTo.split(",")[1]+"' and contractor_master.id="+contId+")";
					
					/*String expEntry="";
					gd.executeCommand(expEntry);*/
					int updSM=gd.executeCommand(updateSaleMaster);
					
					RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/payment/contractorPayment.jsp?ppid="+contId);
					rd.forward(request, response);
					
				}
				else{
					request.setAttribute("status", "Daily Stock Not Updated");
					RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/payment/contractorPayment.jsp?ppid="+contId);
					rd.forward(request, response);
				}
				
			}
			else{
				request.setAttribute("status", "Something's Wrong");
				RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/payment/contractorPayment.jsp?ppid="+contId);
				rd.forward(request, response);
			}
		}
		//remaing amount for ajax
		if(request.getParameter("contId")!=null)
		{
			String contId=request.getParameter("contId");
			if(!gd.getData("SELECT `total_balance` FROM `contractor_payment_details` WHERE contractor_id="+contId).isEmpty())
			{
				List getTotalBalance=gd.getData("SELECT `total_balance` FROM `contractor_payment_details` WHERE contractor_id="+contId);
				
				out.print(Integer.parseInt(getTotalBalance.get(getTotalBalance.size()-1).toString()));
				
			}
			else
			{
				out.print("0");
			}
			
		}
		
		
		//dataList for ajax
		if(request.getParameter("getAmountList")!=null)
		{
			String contId=request.getParameter("contrId");
			String startDate=request.getParameter("startDate");
			String lastDate=request.getParameter("lastDate");
			int totalLoadingCharges=0;
			int totalContCharges=0;
			List data=new ArrayList();
			
			String getLoadingCharges="SELECT expenses_master.amount FROM expenses_type,debtor_master,expenses_master "
				+ "WHERE expenses_master.expenses_type_id=expenses_type.expenses_type_id "
				+ "AND expenses_master.debtor_id=debtor_master.id "
					+ "AND expenses_master.date BETWEEN '"+startDate+"' AND '"+lastDate+"' 	AND expenses_master.cp_status=0 AND "
					+ "debtor_master.type=(SELECT contractor_master.aliasname FROM contractor_master"
					+ " WHERE contractor_master.id="+contId+")";
			List loadingCharges=gd.getData(getLoadingCharges);
			System.out.println(loadingCharges);
			if(!loadingCharges.isEmpty())
			{
			out.println("1,"+loadingCharges.size());
			Iterator itr1=loadingCharges.iterator();
			while(itr1.hasNext())
			{
				totalLoadingCharges+=Integer.parseInt(itr1.next().toString());
			}
			out.print(","+totalLoadingCharges);
			}
			else
			{
				String getContractorDeposit="SELECT sale_master.loading_charges FROM"
						+ " sale_master,contractor_master WHERE contractor_master.id=sale_master.loading_by_id "
						+ "and sale_master.date BETWEEN '"+startDate+"' AND '"+lastDate+"' and sale_master.cp_status=0 and contractor_master.id="+contId;
				List contCharges=gd.getData(getContractorDeposit);
				System.out.println(contCharges);
				if(!contCharges.isEmpty())
				{
					out.print("1,0,0,"+contCharges.size());
					Iterator itr2=contCharges.iterator();
					while(itr2.hasNext())
					{
						totalContCharges+=Integer.parseInt(itr2.next().toString());
					}
					out.print(","+totalContCharges);
				}
				else
					out.print("0,");
			}
			
			
		}
		
		
		
		/*if(request.getParameter("pay")!=null)
		{

			RequireData rq=new RequireData();
			List list=rq.getContractorId();
			String id=list.get(0).toString();
			
			System.out.println("id is:"+id);
			
			String dd=request.getParameter("to_date");
			System.out.println("to_date:"+dd);	
			
			String from_date=request.getParameter("to_date");
			System.out.println("form_date:"+from_date);
			
			String total_bill_amount=request.getParameter("total");
			String loading=request.getParameter("loading_charges");
			String deposit=request.getParameter("contractor_deposite");
			
			String count="SELECT COUNT(id) FROM product_master WHERE contractor_id="+id+"";
			String product_count=gd.getData(count).toString();
			
			
			String insertdata="insert into contractor_payment_details(contractor_id,to_date,from_date,total_bill_amt,loading_charges,deposit) values('"+id+"','"+dd+"','"+from_date+"','"+total_bill_amount+"','"+loading+"','"+deposit+"')";
			System.out.println("insertData is :"+insertdata);
			int i=gd.executeCommand(insertdata);
			if(i>0)
			{
				System.out.println("inserted Successfully");
				request.setAttribute("status", "Inserted Successfully");
				
			}
			else
			{
				System.out.println("Try Again");
				request.setAttribute("status", "Try Again");
			}
			request.setAttribute("pay", "3");
			RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/payment/contractorPayment.jsp");
			rd.forward(request, response);
			
		}
		
		if(request.getParameter("payment")!=null)
		{
			String current_date=request.getParameter("current_date");
			String paidamout=request.getParameter("paidAmt");
			String payMode=request.getParameter("payMode");
			String chequeNo = request.getParameter("chequeNo");
			String bankInfo = request.getParameter("bankInfo");

		
				if(payMode.equals("Cash"))
				{
					String insertCashDetails="insert into contractor_payment_master(date,paid_amt,mode) values('"+current_date+"','"+paidamout+"','"+payMode+"')";
					
					System.out.println("inserted :"+insertCashDetails);
					
					int i=gd.executeCommand(insertCashDetails);
					if(i>0)
					{
						System.out.println("inserted Successfully");
						request.setAttribute("status", "Inserted Successfully");
					}
					else
					{
						System.out.println("Try Again");
						
					}
					RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/payment/contractorPayment.jsp");
					rd.forward(request, response);
				}
				else if(payMode.equals("Cheque"))
				{
					String insertChequeDetails="insert into contractor_payment_master(date,paid_amt,mode,cheque_no,particular) values('"+current_date+"','"+paidamout+"','"+payMode+"','"+chequeNo+"','"+bankInfo+"')";
					System.out.println("insert :"+insertChequeDetails);
					int i=gd.executeCommand(insertChequeDetails);
					if(i>0)
					{
						System.out.println("inserted Successfully");
						request.setAttribute("status", "Inserted Successfully");
					}
					else
					{
						System.out.println("Try Again");
						
					}
					RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/payment/contractorPayment.jsp");
					rd.forward(request, response);
				}
				else if(payMode.equals("Transfer"))
				{
					String transfer="insert into contractor_payment_master(date,paid_amt,mode,particular) values('"+current_date+"','"+paidamout+"','"+payMode+"','"+bankInfo+"'";
					
					System.out.println("insert :"+transfer);
					
					int i=gd.executeCommand(transfer);
					if(i>0)
					{
						System.out.println("inserted Successfully");
						request.setAttribute("status", "Inserted Successfully");
					}
					else
					{
						System.out.println("Try Again");
						
					}
					RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/payment/contractorPayment.jsp");
					rd.forward(request, response);
				}
			
			
		}*/
	}

}
