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

public class Sales extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter out = response.getWriter();
		GenericDAO gd = new GenericDAO();
		RequireData rd11=new RequireData();
		
		String searchVehicle = request.getParameter("searchVehicle");		

		// ajax to search vehicle		
		if (searchVehicle != null){ 
			String query="SELECT vehicle_id, vehicle_number FROM vehicle_details WHERE vehicle_number LIKE '%"+searchVehicle+"%' AND vehicle_type='TRANSPORT'";
			List list = gd.getData(query);			
			Iterator itr = list.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + ",");
			}
		}
		
		// ajax to search product
		if(request.getParameter("q")!=null){
			
			String query="SELECT `id`,`name`,`gstper` FROM `product_master` WHERE `name` LIKE '"+request.getParameter("q")+"%'";
			List details = gd.getData(query);

			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + ",");
			}
		}
		
		if(request.getParameter("insertSaleDataSubmitBtn")!=null){
			
			String clientId=request.getParameter("clientid");
			String date=request.getParameter("saleDate");
			String chalan_no=request.getParameter("chalanNo");
			String loading_team_id=request.getParameter("organizationid");
			String loading_charges=request.getParameter("Chrages");
			String vehicleNo=request.getParameter("vehicleNo");
			String vehicleDeposit=request.getParameter("deposit");
			String po_no=request.getParameter("poNo");
			String helperChargers=request.getParameter("helperChargers");
			String vehicleReading=request.getParameter("reading");
			String vehicleAmount=request.getParameter("amount");
			String counter =request.getParameter("counter");
			String dieselInLiter=request.getParameter("diesel");
			int count = Integer.parseInt(counter);
			String vehicleDetails=vehicleNo.toUpperCase();
			int flag=1;
			
			if(loading_team_id.equals("")){
				loading_team_id=null;
			}
			if(loading_charges.equals("")){
				loading_charges="0";	
			}
			if(vehicleDeposit.equals("")){
				vehicleDeposit="0";
			}
			if(helperChargers.equals("")){
				helperChargers="0";
			}
			if(vehicleReading.equals("")){
				vehicleReading="0";
			}
			if(vehicleAmount.equals("")){
				vehicleAmount="0";
			}
			if(dieselInLiter.equals("")){
				dieselInLiter="0";
			}
			
			Object vehicle_id = null;
			String q="SELECT vehicle_details.vehicle_id FROM vehicle_details WHERE vehicle_number='"+vehicleNo+"'";
			List vehicle_id_temp=gd.getData(q);
			
			Iterator itr=vehicle_id_temp.iterator();
			while (itr.hasNext()) {
				vehicle_id=itr.next();
			}
			
			String getDebtorId="SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type="
					+ "(SELECT vehicle_details.vehicle_aliasname FROM vehicle_details WHERE "
					+ "vehicle_details.vehicle_number='"+vehicleNo+"')";
			
			List debtorId=gd.getData(getDebtorId);

			if(vehicle_id!=null && !debtorId.isEmpty()){
			
				if(rd11.checkPCStatus(Integer.parseInt(vehicleDeposit))==1){
					String pcStatusString="SELECT balance FROM petty_cash_details WHERE id=(SELECT MAX(id) FROM petty_cash_details)";
					String pettyCash=gd.getData(pcStatusString).get(0).toString();		
					int remaining=Integer.parseInt(pettyCash)-Integer.parseInt(vehicleDeposit);
					String insertPettyCash="INSERT INTO `petty_cash_details`(`date`, `debit`, `balance`, `debtor_id`) VALUES ('"+date+"',"+Integer.parseInt(vehicleDeposit)+","+remaining+","+debtorId.get(0)+")";
					int s=gd.executeCommand(insertPettyCash);
					flag=1;
				}
				else
					flag=0;
			}
			
			if(flag==1)
			{
				String insertQuery=null;
				if(!debtorId.isEmpty()){
					System.out.println(debtorId.get(0));
					insertQuery="INSERT INTO `sale_master`(`client_id`, `loading_by_id`, `date`, `chalan_no`, `loading_charges`, "
							+ " `debtor_id`,`vehicle_deposit`, `po_no`, `helper_charges`, `product_count`) VALUES ("+clientId+","+loading_team_id+", "
									+ "'"+date+"','"+chalan_no+"',"+loading_charges+","+debtorId.get(0)+","+vehicleDeposit+",'"+po_no+"',"+helperChargers+","+count+");";
				}
				else{
					insertQuery="INSERT INTO `sale_master`(`client_id`, `loading_by_id`, `date`, `chalan_no`, `loading_charges`, "
							+ " `vehicle_details`, `vehicle_deposit`, `po_no`, `helper_charges`, `product_count`) VALUES ("+clientId+","+loading_team_id+", "
									+ "'"+date+"','"+chalan_no+"',"+loading_charges+",'"+vehicleDetails+"',"+vehicleDeposit+",'"+po_no+"',"+helperChargers+","+count+");";
				}
				
				gd.executeCommand(insertQuery);
				String max_id="select max(id) from sale_master";
				List l = gd.getData(max_id);
				String max_sale_id = l.get(0).toString();
				
				if(vehicle_id!=null)
				{
	
					System.out.println("hi");
					if(!debtorId.isEmpty())
					{
					
						String insertExp_master="INSERT INTO `expenses_master`(`expenses_type_id`, `debtor_id`, `name`, `amount`, `payment_mode`, `date`, `reason`, "
								+ " `other_details`) VALUES (1,"+debtorId.get(0)+",'-',"+vehicleAmount+",'CASH','"+date+"','-','-')";
						System.out.println(insertExp_master);
				
						gd.executeCommand(insertExp_master);
					
						if(vehicleAmount!=null||vehicleReading!=null||dieselInLiter!=null)
						{
						
							String exp_id="SELECT max(exp_id) FROM expenses_master";
							List l1 = gd.getData(exp_id);
							String max_exp_id = l1.get(0).toString();
							
							if(!gd.getData("SELECT MAX(id) FROM sale_master").isEmpty())
							{
								String max_sales_id=gd.getData("SELECT MAX(id) FROM sale_master").get(0).toString();
								String sales_id="INSERT INTO `vehicles_ride_details`(`exp_master_id`, `sales_id`) VALUES ("+max_exp_id+","+max_sales_id+")";
								
								int xx=gd.executeCommand(sales_id);
								if(xx==1)
								{
									System.out.println("done Successfully in Vehicles rides details");
								
									String insertVRM ="INSERT INTO vehicle_reading_master(expenses_master_id, vehicle_id, vehicle_diesel_qty, vehicle_reading) "
											+ " VALUES ("+max_exp_id+","+vehicle_id+","+dieselInLiter+","+vehicleReading+")";
									gd.executeCommand(insertVRM);
								}
							}
						}
					}
				}
	
				while(count>0){
					
					/*UPDATE FINAL STOCK...
					 * SELECT  final_stock.qty FROM final_stock WHERE final_stock.product_id=(SELECT product_master.id FROM product_master WHERE product_master.name='PIPE_6')
					 * UPDATE final_stock SET qty=40 WHERE final_stock.product_id=(SELECT product_master.id FROM product_master WHERE product_master.name='PIPE_6')
					 */
					
					String productName = request.getParameter("productName1"+count);
					String qty = request.getParameter("qty1"+count);
					String rate = request.getParameter("rate1"+count);
					String supplierName = request.getParameter("supplierName1"+count);
					String chalanNo_third = request.getParameter("chalanNo_third1"+count);
					if(supplierName.equals("SARTHAK")){
						int p_qty = Integer.parseInt(qty);
						q="SELECT  final_stock.qty FROM final_stock WHERE final_stock.product_id=(SELECT product_master.id FROM product_master WHERE product_master.name='"+productName+"')";
						int product_qty=0;
						List qty_product=gd.getData(q);
						if(!qty_product.isEmpty()){
							product_qty= Integer.parseInt(qty_product.get(0).toString());
						}
						String updateQuery="UPDATE final_stock SET qty="+(product_qty-p_qty)+" WHERE final_stock.product_id=(SELECT product_master.id FROM product_master WHERE product_master.name='"+productName+"')";
						gd.executeCommand(updateQuery);
					}
					
					String insertProduct="INSERT INTO `sale_details_master`(`sale_master_id`, `product_name`, `qty`, `rate`, `supplier_name`, "
							+ " `third_party_chalan`) VALUES ("+max_sale_id+",'"+productName+"',"+qty+","+rate+",'"+supplierName+"','"+chalanNo_third+"');";
					gd.executeCommand(insertProduct);				
					count--;
				}	
	
				RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/sale/sale.jsp");
				rd.forward(request, response);
			}
			else {
				request.setAttribute("error", "1");
				RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/sale/sale.jsp");
				rd.forward(request, response);				
			}
		}
		
		
		if(request.getParameter("deleteId")!=null){
			
			String sale_master_id=request.getParameter("deleteId");
			String query="SELECT id FROM `sale_details_master` WHERE sale_master_id="+sale_master_id;
			
			List sale_details_id=gd.getData(query);
			
			Iterator itr=sale_details_id.iterator();
			while (itr.hasNext()) {
				gd.executeCommand("DELETE FROM `sale_details_master` WHERE id="+itr.next());
			}
			gd.executeCommand("DELETE FROM `sale_master` WHERE id="+sale_master_id);
			request.setAttribute("status", "Record Deleted Successfully");
			RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/sale/sale.jsp");
			rd.forward(request, response);
		}		

		
	}
}