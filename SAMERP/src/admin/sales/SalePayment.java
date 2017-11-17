package admin.sales;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
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
		
		//ajax for Bill format
		if(request.getParameter("dataByChalan")!=null)
		{
			String[] chalanNos=request.getParameter("chalanNos").split(",");
			for(int i=0;i<chalanNos.length;i++)
			{
				String getDataByChalan="SELECT sale_master.id,sale_master.product_count,sale_master.date,sale_master.chalan_no FROM `sale_master` WHERE chalan_no='"+chalanNos[i]+"';";
				List chalanData=gd.getData(getDataByChalan);
				Iterator itr=chalanData.iterator();
				while(itr.hasNext())
				{
					Object id=itr.next();
					Object prodCount=itr.next();
					Object date=itr.next();
					Object chalanNo=itr.next();
					out.print(prodCount+","+date+","+chalanNo+",");
					
					String getSaleDetails="SELECT sale_details_master.product_name,product_master.hsncode,"
							+ "sale_details_master.gst,sale_details_master.qty,sale_details_master.rate FROM "
							+ "sale_details_master,product_master WHERE sale_details_master.sale_master_id="+id
							+ " AND sale_details_master.product_name=product_master.name";
					List saleDetails=gd.getData(getSaleDetails);
					Iterator itr2=saleDetails.iterator();
					double totalAmount=0.0;
					while(itr2.hasNext())
					{
						Object prodName=itr2.next();
						Object hsnCode=itr2.next();
						double gst=Double.parseDouble(itr2.next().toString());
						double qty=Double.parseDouble(itr2.next().toString());
						double rate=Double.parseDouble(itr2.next().toString());
						
						out.print(prodName+","+hsnCode+","+gst+","+qty+","+rate+","+qty*rate+","+(qty*rate*gst/100)/2+","+(qty*rate*gst/100)/2+",");
						totalAmount+=(qty*rate)+((qty*rate*gst)/100);
					}
					out.print(totalAmount+",");		
				}
			}
		}
				

		if(request.getParameter("generateBillData")!=null){
			
			String clientid = request.getParameter("clientID1");
			String chalanList = request.getParameter("checkedChalan");
			String chalanNumber[] = chalanList.split(",");
			String billNumber = request.getParameter("billNumber");
			String billAmt = request.getParameter("totalBillAmount");
			String billDate = request.getParameter("billDate");
			
//			int i=0;
//			out.println("Client ID   :"+clientid);
//			out.println("Chalan List :"+chalanList);
//			for(String a:chalanNumber)
//				out.println(++i +"  "+a);
//			out.println("Bill Number :"+billNumber);
//			out.println("Bill Amount :"+billAmt);
//			out.println("Bill Date   :"+billDate);
//			out.println("Size        :"+chalanNumber.length);
			
			String poList="";
			for (int j = 0; j < chalanNumber.length; j++) {
				
				String query="SELECT po_no FROM sale_master WHERE chalan_no='"+chalanNumber[j]+"'";
				List l=gd.getData(query);
				if(l.get(0)==null){
					poList+="-";
				}
				else
					poList+=l.get(0).toString();
				if(!(j==chalanNumber.length-1)){
					poList+=",";
				}
			}
			
			//out.println("PO_List     :"+poList);
	
			
			
			String insertBill="INSERT INTO client_bill_master(`client_id`, `bill_amt`, `date`, `po_details`) VALUES ("+clientid+","+billAmt+",'"+billDate+"','"+poList+"')";
			int insertBillStatus=gd.executeCommand(insertBill);
			
			String totalRemaining="SELECT total_remaining_amt FROM client_payment_master WHERE id=(SELECT MAX(id) from client_payment_master WHERE client_id="+clientid+")";
			List tR = gd.getData(totalRemaining);
			
			int total_rmg_amt= Integer.parseInt(tR.get(0).toString())+Integer.parseInt(billAmt);
			
			String insertPayment="INSERT INTO `client_payment_master`( `client_id`, `bill_id`, `date`, `bill_amt`, `total_remaining_amt`) VALUES ("+clientid+","+billNumber+",'"+billDate+"',"+billAmt+","+total_rmg_amt+")";
			gd.executeCommand(insertPayment);
			
			if(insertBillStatus==1){
				for (int i = 0; i < chalanNumber.length; i++) {
					
					String updateSaleEntry="UPDATE sale_master SET status=1, bill_id="+billNumber+" WHERE chalan_no='"+chalanNumber[i]+"'";
					gd.executeCommand(updateSaleEntry);
				}
				request.setAttribute("status", "Bill Checked Successfully");
			}
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("jsp/admin/sale/salePayment.jsp?ppid="+clientid);
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
				
				List pettyDetails=gd.getData("SELECT balance FROM petty_cash_details WHERE id=(SELECT MAX(id) FROM petty_cash_details)");
				
				int balance= Integer.parseInt( pettyDetails.get(0).toString());
				
				balance+=Integer.parseInt(paidAmt);
				
				String debtorId=gd.getData("SELECT id FROM debtor_master WHERE type='CL_"+gd.getData("SELECT client_details.client_organization_name FROM client_details WHERE client_details.client_id="+clientid).get(0).toString()+"'").get(0).toString();

				String updatepetty="INSERT INTO `petty_cash_details`(`date`, `credit`, `debtor_id`, `balance`) VALUES ('"+paidDate+"',"+paidAmt+","+debtorId+","+balance+")";
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
			
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("jsp/admin/sale/salePayment.jsp?ppid="+clientid);
			requestDispatcher.forward(request, response);
		}
	}
}