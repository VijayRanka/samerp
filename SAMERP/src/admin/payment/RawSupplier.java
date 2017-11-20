package admin.payment;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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

//@WebServlet("/RawSupplier")
public class RawSupplier extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		if(request.getParameter("findList")!=null)
		{
			GenericDAO da = new GenericDAO();
			List details = null;
			String query="SELECT material_supply_master.supplier_business_name FROM material_supply_master WHERE type=1";
			details = da.getData(query);
			if(!details.isEmpty())
			{
				Iterator itr = details.iterator();
				while (itr.hasNext()) {
					out.print("<option>"+itr.next()+"</option>");
				}
			}
			//out.print("<option>working</option>");
		}
		
		if(request.getParameter("getBanks")!=null)
		{
			GenericDAO da = new GenericDAO();
			List details = null;
			String query="SELECT acc_aliasname FROM account_details";
			details = da.getData(query);
			if(!details.isEmpty())
			{
				Iterator itr = details.iterator();
				while (itr.hasNext()) {
					out.print("<option>"+itr.next()+"</option>");
				}
			}
		}
		
		if(request.getParameter("findBankId")!=null)
		{
			String bName=request.getParameter("findBankId");
			GenericDAO da = new GenericDAO();
			List details = null;
			String query="SELECT account_details.acc_id FROM account_details WHERE account_details.acc_aliasname='"+bName+"'";
			details = da.getData(query);
			if(!details.isEmpty())
			{
				out.print(details.get(0));
			}
			
		}
		
		if(request.getParameter("sid")!=null)
		{
			String supId=request.getParameter("sid");
			RequireData rd=new RequireData();
			String totalR=rd.getTotalRemaining(supId);
			out.print(totalR);
		}
		
		
		if(request.getParameter("findId")!=null)
		{
			
			String bName=request.getParameter("findId");
			GenericDAO da = new GenericDAO();
			List details = null;
			String query="SELECT material_supply_master.supplier_business_id FROM material_supply_master WHERE material_supply_master.supplier_business_name='"+bName+"'";
			details = da.getData(query);
			if(!details.isEmpty())
			{
				out.print(details.get(0));
			}
		}
		
		if(request.getParameter("billEntry")!=null)
		{
			
			String pid=request.getParameter("pids");
			String msid=request.getParameter("msid");
			String bno=request.getParameter("bNo");
			String amt=request.getParameter("bAmt");
			String bdate=request.getParameter("bDate");
			GenericDAO da = new GenericDAO();
			List details = null;
			
			if(pid!="")
			{
				String []pids=pid.split(",");
				int i=0;
				int total=0;
				for(String ids:pids)
				{
					String updateQuery="UPDATE `purchase_raw_material_master` SET `status`=1 WHERE purchase_raw_material_master.id='"+ids+"'";
					i=da.executeCommand(updateQuery);
					
					String q = "SELECT `total_remaining` FROM `total_supplier_payment_master` WHERE id=(SELECT MAX(id) from total_supplier_payment_master WHERE supplier_id="+msid+")";
					List l = da.getData(q);
					
					total = Integer.parseInt(l.get(0).toString()) + Integer.parseInt(amt);
					
				}
				
				
				
				if(i>0)
				{
					System.out.println("status changed in purchase_raw_material_master and inserted in total supplier payment");
					if(msid!="")
					{
						String insertQuery="INSERT INTO `supplier_bill_details`(`material_supply_master_id`, `billno`, `bill_amt`, `date`) VALUES ('"+msid+"','"+bno+"','"+amt+"','"+bdate+"')";
						int status=da.executeCommand(insertQuery);	
						if(status!=0)
						{
							System.out.println("record inserted in supplier_bill_details");
							String insertQuery1="INSERT INTO `total_supplier_payment_master`(`supplier_id`, `bill_id`, `bill_amt`, `date`, `total_remaining`) VALUES ("+msid+", (select max(id) from supplier_bill_details), (SELECT `bill_amt` FROM `supplier_bill_details` WHERE id=(SELECT MAX(id) from supplier_bill_details)), '"+bdate+"' , "+total+")";
							System.out.println(insertQuery1);
							int status1=da.executeCommand(insertQuery1);
							request.setAttribute("status", "Inserted Successfully");
							request.setAttribute("businessName", request.getParameter("busName"));
							request.setAttribute("bid1", msid);
							
							RequestDispatcher rd=request.getRequestDispatcher("/jsp/admin/payment/rawSupplier.jsp");
							rd.forward(request, response);
						}
						else
						{
							System.out.println("record not inserted");
							request.setAttribute("status", "Something Wrong");
							RequestDispatcher rd=request.getRequestDispatcher("/jsp/admin/payment/rawSupplier.jsp");
							rd.forward(request, response);
						}
					}
					else
					{
						System.out.println("supplier id is empty");
						request.setAttribute("status", "Please Select Only Provided Supplier");
						RequestDispatcher rd=request.getRequestDispatcher("/jsp/admin/payment/rawSupplier.jsp");
						rd.forward(request, response);
					}
					
				}
			}
			else
			{
				request.setAttribute("status", "Please Select Chalan No");
				RequestDispatcher rd=request.getRequestDispatcher("/jsp/admin/payment/rawSupplier.jsp");
				rd.forward(request, response);
				//
			}
			
			//
			
			
			//out.println(pids);
			

		}
		
		if(request.getParameter("paymentSubmitbtn")!=null)
		{
			//out.print("working");
			GenericDAO gd = new GenericDAO();
			
			RequireData rdGet=new RequireData();
			String supid = request.getParameter("supid2");
			String paidDate = request.getParameter("paidDate");
			String paidAmt = request.getParameter("paidAmt");
			String payMode = request.getParameter("payMode");
			String chequeNo = request.getParameter("chequeNo");
			String bankInfo = request.getParameter("bankInfo");
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			String requiredDate = df.format(new Date()).toString();
			int flag=0, bankExit=9, pettyExit=9;
			
			String q1 = "SELECT `supplier_alias` FROM `material_supply_master` WHERE supplier_business_id="+supid;
			List l1 = gd.getData(q1);
			
			int debtorId = rdGet.getDebtorId(l1.get(0).toString());
			System.out.println("debid "+debtorId);
			
			
			if(payMode.equals("Cash"))
			{
				int pettyStatus = rdGet.checkPCStatus(Integer.parseInt(paidAmt));
				System.out.println("pettyStatus : "+pettyStatus);
				pettyExit=pettyStatus;
				
				if(pettyStatus==1){
					
					if(rdGet.pCashEntry(paidDate, Integer.parseInt(paidAmt), 0, String.valueOf(debtorId))){
						String insertPayment = "INSERT INTO `supplier_payment_master`(`material_supply_master_id`, `date`, `paid_amt`, `mode`)"
								+ " VALUES ("+supid+", '"+paidDate+"', '"+paidAmt+"', '"+payMode+"')";
						int insertPaymentStatus = gd.executeCommand(insertPayment);
						
						if(insertPaymentStatus==1){
							flag=1;
							
							String selectsup = "select `supplier_business_name`  FROM `material_supply_master` WHERE supplier_business_id="+supid;
							List l = gd.getData(selectsup);
							
							request.setAttribute("status", "Payment of "+paidAmt+" Rs. done Successfully to "+l.get(0));
						}
					}
				}
				else{
					request.setAttribute("pettyExit", pettyExit);
				}
			}
			else 
			{
				
				int balStatus = rdGet.checkBankBalance(Integer.parseInt(paidAmt), bankInfo);
				System.out.println("balStatus : "+balStatus);
				bankExit=balStatus;
				
				if(balStatus==1){
					
					if(rdGet.badEntry(bankInfo, paidDate, Integer.parseInt(paidAmt), 0, payMode, String.valueOf(debtorId))){
					
						if(payMode.equals("Cheque")){
							String insertPayment = "INSERT INTO `supplier_payment_master`(`material_supply_master_id`, `date`, `paid_amt`, `mode`, `cheque_no`, `description`)"
									+ " VALUES ("+supid+", '"+paidDate+"', '"+paidAmt+"', '"+payMode+"', '"+chequeNo+"', '"+bankInfo+"')";
							int insertPaymentStatus = gd.executeCommand(insertPayment);
							
							if(insertPaymentStatus==1){
								flag=1;
								
								String selectsup = "select `supplier_business_name`  FROM `material_supply_master` WHERE supplier_business_id="+supid;
								List l = gd.getData(selectsup);
								
								request.setAttribute("status", "Payment of "+paidAmt+" Rs. done Successfully to "+l.get(0));
							}
							
								
						}
						else if(payMode.equals("Transfer")){
							
							String insertPayment = "INSERT INTO `supplier_payment_master`(`material_supply_master_id`, `date`, `paid_amt`, `mode`, `description`)"
									+ " VALUES ("+supid+", '"+paidDate+"', '"+paidAmt+"', '"+payMode+"', '"+bankInfo+"')";
							int insertPaymentStatus = gd.executeCommand(insertPayment);
							
							if(insertPaymentStatus==1){
								flag=1;
								
								String selectsup = "select `supplier_business_name`  FROM `material_supply_master` WHERE supplier_business_id="+supid;
								List l = gd.getData(selectsup);
								
								request.setAttribute("status", "Payment of "+paidAmt+" Rs. done Successfully to "+l.get(0));
							}
								
						}
					}
				}
				else{
					request.setAttribute("bankExit", bankExit);
				}
			}
			
			if(flag==1 && (bankExit==1 || pettyExit==1)){
				
				String q = "SELECT `total_remaining` FROM `total_supplier_payment_master` WHERE id=(SELECT MAX(id) from total_supplier_payment_master WHERE supplier_id="+supid+")";
				List l = gd.getData(q);
				
				int total = Integer.parseInt(l.get(0).toString()) - Integer.parseInt(paidAmt);
				
				String insertQuery1="INSERT INTO `total_supplier_payment_master`(`supplier_id`, `payment_id`, `paid_amt`, `date`, `total_remaining`) VALUES ("+supid+", (select max(id) from supplier_payment_master), (SELECT `paid_amt` FROM `supplier_payment_master` WHERE id=(SELECT MAX(id) from supplier_payment_master)), '"+requiredDate+"' , "+total+")";
				int status1=gd.executeCommand(insertQuery1);	
				
				rdGet.commonExpEntry("4", debtorId, "", paidAmt, payMode, bankInfo, chequeNo, requiredDate);
			}
			
			System.out.println("bankExit : "+bankExit);
			System.out.println("pettyExit : "+pettyExit);
			RequestDispatcher rdd = request.getRequestDispatcher("jsp/admin/payment/rawSupplier.jsp");
			rdd.forward(request, response);
		}
			
			
			
	}

}
