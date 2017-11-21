package admin.productPurchase;

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


public class productSupplierPayment extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		GenericDAO gd = new GenericDAO();
		RequireData rd = new RequireData();
		PrintWriter out = response.getWriter();
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String requiredDate = df.format(new Date()).toString();
		
		if(request.getParameter("billSubmit")!=null){
			String chalanL = request.getParameter("checkedChalan");
			String billNo = request.getParameter("billNo");
			String billAmt = request.getParameter("billAmt");
			String billDate = request.getParameter("billDate");
			String supId = request.getParameter("supid1");
			int total = 0;
			
			String chalanNo[] = chalanL.split(",");
			
			String billInsert = "INSERT INTO `supplier_bill_details`(`material_supply_master_id`, `billno`, `bill_amt`, `date`) "
					+ "VALUES ('"+supId+"', '"+billNo+"', '"+billAmt+"', '"+billDate+"')";
			int billInsertStatus = gd.executeCommand(billInsert);
			
			if(billInsertStatus==1){
				
				String id = rd.getMaxId();
				
				for(int i=0; i<chalanNo.length; i++){
					String billUpdatepp = "UPDATE `product_purchase_master` SET `bill_check_status`=1,`supplier_bill_id`="+id+" WHERE id="+chalanNo[i];
					int billUpdateppStatus = gd.executeCommand(billUpdatepp);
					
					String q = "SELECT `total_remaining` FROM `total_supplier_payment_master` WHERE id=(SELECT MAX(id) from total_supplier_payment_master WHERE supplier_id="+supId+")";
					List l = gd.getData(q);
					
					total = Integer.parseInt(l.get(0).toString()) + Integer.parseInt(billAmt);
					
					if(billUpdateppStatus==1){
						request.setAttribute("status", "Bill Checked Successfully");
						
					}
				}
				
				String insertQuery1="INSERT INTO `total_supplier_payment_master`(`supplier_id`, `bill_id`, `bill_amt`, `date`, `total_remaining`) VALUES ("+supId+", (select max(id) from supplier_bill_details), (SELECT `bill_amt` FROM `supplier_bill_details` WHERE id=(SELECT MAX(id) from supplier_bill_details)), '"+requiredDate+"' , "+total+")";
				int status1=gd.executeCommand(insertQuery1);
				
			}
			
			RequestDispatcher rdd = request.getRequestDispatcher("jsp/admin/productPurchase/productSupplierPayment.jsp?ppid="+supId);
			rdd.forward(request, response);
		}
		
		
		
		
		
		if(request.getParameter("paymentSubmitbtn")!=null){
			
			String supid = request.getParameter("supid2");
			String paidDate = request.getParameter("paidDate");
			String paidAmt = request.getParameter("paidAmt").trim();
			String payMode = request.getParameter("payMode");
			String chequeNo = request.getParameter("chequeNo").trim();
			String bankInfo = request.getParameter("bankInfo");
			int flag=0, bankExit=9, pettyExit=9;
			
			String q1 = "SELECT `supplier_alias` FROM `material_supply_master` WHERE supplier_business_id="+supid;
			List l1 = gd.getData(q1);
			
			int debtorId = rd.getDebtorId(l1.get(0).toString());
			System.out.println("debid "+debtorId);
			
			
			if(payMode.equals("Cash"))
			{
				int pettyStatus = rd.checkPCStatus(Integer.parseInt(paidAmt));
				System.out.println("pettyStatus : "+pettyStatus);
				pettyExit=pettyStatus;
				
				if(pettyStatus==1){
					
					if(rd.pCashEntry(paidDate, Integer.parseInt(paidAmt), 0, String.valueOf(debtorId))){
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
				
				int balStatus = rd.checkBankBalance(Integer.parseInt(paidAmt), bankInfo);
				System.out.println("balStatus : "+balStatus);
				bankExit=balStatus;
				
				if(balStatus==1){
					
					if(rd.badEntry(bankInfo, paidDate, Integer.parseInt(paidAmt), 0, payMode+"_"+chequeNo, String.valueOf(debtorId))){
					
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
				
				rd.commonExpEntry("4", debtorId, "", paidAmt, payMode, bankInfo, chequeNo, requiredDate);
				
			}
			
			System.out.println("bankExit : "+bankExit);
			System.out.println("pettyExit : "+pettyExit);
			
			RequestDispatcher rdd = request.getRequestDispatcher("jsp/admin/productPurchase/productSupplierPayment.jsp?ppid="+supid);
			rdd.forward(request, response);
		}
		
		
		if(request.getParameter("updateid")!=null){
			String id[] = request.getParameter("updateid").split("-");
			
			List l = rd.getSupplierPaymentUpdateDetails(id[0], id[1]);
			
			String ll = "";
			
			Iterator itr = l.iterator();
			
			while(itr.hasNext()){
				ll+=itr.next()+", ";
			}
			
			out.print(ll);
			
		}
		
		
		if(request.getParameter("updateSubmitbtn")!=null){
			
			String newAmt = request.getParameter("updateDebitAmount").trim();
			String oldAmt = request.getParameter("oldupdateDebitAmount").trim();
			String tid = request.getParameter("tid").trim();
			String supid = request.getParameter("sid").trim();
			String updateMode = request.getParameter("updateMode").trim();
			String updateBank = request.getParameter("updateBank").trim();
			String updateChequeNumber = request.getParameter("updateChequeNumber").trim();
			
			boolean amountStatusClear = false;

			if(updateMode.equalsIgnoreCase("Cash")){	
				
				int pcStatus=rd.checkPCStatus(Integer.parseInt(newAmt));
				if(pcStatus==0)
				{
					request.setAttribute("status", "You don't have enough balance in your Petty Cash");
				
				}
				else if(pcStatus==-1)
				{
					request.setAttribute("status", "You don't have enough balance in your Petty Cash");
				}
				else if(pcStatus==1)
				{
					amountStatusClear=true;
				}
				
				if(amountStatusClear)
				{
					boolean successFirst=rd.pCashEntry(requiredDate, 0, Integer.parseInt(oldAmt), "1");
					if(successFirst)
					{
						
						String getDebtorId="SELECT `id` FROM `debtor_master` WHERE debtor_master.type=(SELECT material_supply_master.supplier_alias FROM material_supply_master WHERE material_supply_master.supplier_business_id="+supid+")";
						String debtorId=gd.getData(getDebtorId).get(0).toString();
						
						boolean successSecond=rd.pCashEntry(requiredDate, Integer.parseInt(newAmt), 0, debtorId);
						if(successSecond)
						{
							request.setAttribute("status", "Updated Petty Cash And Expense");
						}
					}
					
				}
			}
			else if(updateMode.equalsIgnoreCase("Cheque"))
			{
				String bankId=gd.getData("SELECT account_details.acc_id FROM account_details WHERE account_details.acc_aliasname='"+updateBank+"'").get(0).toString();
				
				int badStatus=rd.checkBankBalance(Integer.parseInt(newAmt), bankId);
				if(badStatus==0)
				{
					request.setAttribute("payError", "YOU HAVE INSUFFICIENT BALANCE IN YOUR BANK_b_0");
				}
				else if(badStatus==-1)
				{
					request.setAttribute("payError", "YOU HAVE INSUFFICIENT BALANCE IN YOUR BANK_b_-1");
				}
				else if(badStatus==1)
				{
					amountStatusClear=true;
				}
				else if(badStatus==2)
				{
					request.setAttribute("payError", "YOU HAVE NOT ADD MONEY IN YOUR BANK_b_2");
				}
				
				if(amountStatusClear)
				{
				
					boolean successFirst=rd.badEntry(bankId, requiredDate, 0, Integer.parseInt(oldAmt), "REVERT", "1");
					if(successFirst)
					{
						String debtorId=gd.getData("SELECT `id` FROM `debtor_master` WHERE debtor_master.type=(SELECT material_supply_master.supplier_alias FROM material_supply_master WHERE material_supply_master.supplier_business_id="+supid+")").get(0).toString();
						boolean successSecond=rd.badEntry(bankId, requiredDate, Integer.parseInt(newAmt), 0, "CHEQUE_"+updateChequeNumber, debtorId);
						if(successSecond)
						{
							request.setAttribute("status", "Updated Bank Amount And Expense");
						}
					}
				}
			}
			else if(updateMode.equalsIgnoreCase("Transfer"))
			{
				String bankId=gd.getData("SELECT account_details.acc_id FROM account_details WHERE account_details.acc_aliasname='"+updateBank+"'").get(0).toString();
				boolean successFirst=rd.badEntry(bankId, requiredDate, 0, Integer.parseInt(oldAmt), "REVERT", "1");
				if(successFirst)
				{
					String debtorId=gd.getData("SELECT `id` FROM `debtor_master` WHERE debtor_master.type=(SELECT material_supply_master.supplier_alias FROM material_supply_master WHERE material_supply_master.supplier_business_id="+supid+")").get(0).toString();
					boolean successSecond=rd.badEntry(bankId, requiredDate, Integer.parseInt(newAmt), 0, updateMode, debtorId);
					if(successSecond)
					{
						request.setAttribute("status", "Updated Bank Amount And Expense");
					}
				}
			}
			
			
			
			
			int diff = Integer.parseInt(newAmt)-Integer.parseInt(oldAmt);
			
			String maxIdQ = "SELECT max(id) FROM `total_supplier_payment_master`";
			List maxList = gd.getData(maxIdQ);
			String maxId = maxList.get(0).toString();
			
			
			String updateTPaymet = "UPDATE `total_supplier_payment_master` SET `paid_amt`="+newAmt+" WHERE id="+tid;
			int updateTPaymetStatus = gd.executeCommand(updateTPaymet);
			
			if(updateTPaymetStatus==1){
				
				for(int i=Integer.parseInt(tid); i<=Integer.parseInt(maxId); i++){
					rd.updateTPaymet(String.valueOf(i), String.valueOf(diff));
				}
			}
			
			
			String spid = rd.getSupPaymentIdByTid(tid);
			
			if(!spid.equals("")){
				
				String updateSPaymet = "UPDATE `supplier_payment_master` SET `paid_amt`="+newAmt+" WHERE id="+spid;
				int updateSPaymetStatus = gd.executeCommand(updateSPaymet);
				
				if(updateSPaymetStatus==1){
					
				}
			}
			
			
			
			
			
			
			RequestDispatcher rdd = request.getRequestDispatcher("jsp/admin/productPurchase/productSupplierPayment.jsp?ppid="+supid);
			rdd.forward(request, response);
		}
		
	}

}











