package admin.productPurchase;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
			String paidAmt = request.getParameter("paidAmt");
			String payMode = request.getParameter("payMode");
			String chequeNo = request.getParameter("chequeNo");
			String bankInfo = request.getParameter("bankInfo");
			int flag=0, exit=0;
			
			if(payMode.equals("Cash")){
				
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
			
			
			if(payMode.equals("Cheque")){
				String q1 = "SELECT `supplier_alias` FROM `material_supply_master` WHERE supplier_business_id="+supid;
				List l1 = gd.getData(q1);
				
				int debtorId = rd.getDebtorId(l1.get(0).toString());
				System.out.println("debid "+debtorId);
				
				int balStatus = rd.checkBankBalance(Integer.parseInt(paidAmt));
				System.out.println("balStatus : "+balStatus);
				
				if(balStatus==1){
					
					String insertPayment = "INSERT INTO `supplier_payment_master`(`material_supply_master_id`, `date`, `paid_amt`, `mode`, `cheque_no`, `description`)"
							+ " VALUES ("+supid+", '"+paidDate+"', '"+paidAmt+"', '"+payMode+"', '"+chequeNo+"', '"+bankInfo+"')";
					int insertPaymentStatus = gd.executeCommand(insertPayment);
					
					if(insertPaymentStatus==1){
						flag=1;
						
						String selectsup = "select `supplier_business_name`  FROM `material_supply_master` WHERE supplier_business_id="+supid;
						List l = gd.getData(selectsup);
						
						request.setAttribute("status", "Payment of "+paidAmt+" Rs. done Successfully to "+l.get(0));
					}
					
					rd.badEntry(bankInfo, paidDate, Integer.parseInt(paidAmt), 0, payMode, String.valueOf(debtorId));		
				}
				else{
					exit=1;
					request.setAttribute("exit", exit);
				}
			}
			
			if(exit==0 && flag==1){
				
				String q = "SELECT `total_remaining` FROM `total_supplier_payment_master` WHERE id=(SELECT MAX(id) from total_supplier_payment_master WHERE supplier_id="+supid+")";
				List l = gd.getData(q);
				
				int total = Integer.parseInt(l.get(0).toString()) - Integer.parseInt(paidAmt);
				
				String insertQuery1="INSERT INTO `total_supplier_payment_master`(`supplier_id`, `payment_id`, `paid_amt`, `date`, `total_remaining`) VALUES ("+supid+", (select max(id) from supplier_payment_master), (SELECT `paid_amt` FROM `supplier_payment_master` WHERE id=(SELECT MAX(id) from supplier_payment_master)), '"+requiredDate+"' , "+total+")";
				int status1=gd.executeCommand(insertQuery1);
				
			}
			
			System.out.println("exit : "+exit);
			RequestDispatcher rdd = request.getRequestDispatcher("jsp/admin/productPurchase/productSupplierPayment.jsp?ppid="+supid);
			rdd.forward(request, response);
		}
		
	}

}
