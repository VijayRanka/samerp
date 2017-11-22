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
import utility.SysDate;

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
		if (searchVehicle != null)
		{ 
			String query="SELECT vehicle_id, vehicle_number FROM vehicle_details WHERE vehicle_number LIKE '%"+searchVehicle+"%' AND vehicle_type='TRANSPORT';";
			System.out.println("Query ===>  "+query);
			List list = gd.getData(query);	
			System.out.println("List ===>  "+list);
			Iterator itr = list.iterator();
			while (itr.hasNext()) 
			{
				out.print(itr.next() + ",");
			}
		}
		
		// ajax to search product
		if(request.getParameter("q")!=null)
		{
			
			String query="SELECT `id`,`name`,`gstper` FROM `product_master` WHERE `name` LIKE '"+request.getParameter("q")+"%'";
			List details = gd.getData(query);

			Iterator itr = details.iterator();
			while (itr.hasNext()) 
			{
				out.print(itr.next() + ",");
			}
		}
		
		
		//ajax for geting update data
		if(request.getParameter("getUpdateData")!=null){
			
			String id=request.getParameter("id");
			String getUpdDetails="SELECT sale_master.date, client_details.client_organization_name,sale_master.chalan_no, "
					+ "sale_master.debtor_id,sale_master.vehicle_details,sale_master.vehicle_deposit FROM `sale_master`,client_details WHERE "
					+ "client_details.client_id=sale_master.client_id AND sale_master.id="+id;
			if(!gd.getData(getUpdDetails).isEmpty())
			{
				out.print("1,");
				List demoList=gd.getData(getUpdDetails);
				Iterator itr=demoList.iterator();
				while(itr.hasNext())
				{
					Object date=itr.next();
					Object orgName=itr.next();
					Object chalanNo=itr.next();
					Object debtorId=itr.next();
					Object vehDetails=itr.next();
					Object vehDeposit=itr.next();
					out.print(date+","+orgName+","+chalanNo+",");
					
					if(debtorId.toString().equals("0"))
					{					
						out.print(vehDetails);
					}
					else
					{
						String getDebtorType="SELECT debtor_master.type FROM debtor_master WHERE debtor_master.id="+debtorId;
						out.print(gd.getData(getDebtorType).get(0).toString().split("_")[1]);	
					}
					out.print(","+vehDeposit);	
				}	
			}			
		}
		if(request.getParameter("UpdateData")!=null)
		{
			int getstatus=0;
			boolean status=false;
			String uId=request.getParameter("uId");
			String uChalan=request.getParameter("uSelfChalan");
			String oldAmount=request.getParameter("oldAmount");
			String uAmount=request.getParameter("uAmount");
			String vehicleNo=request.getParameter("uVehDetails");
			
			boolean amountStatusClear=false;
			RequireData rd=new RequireData();
			SysDate sd=new SysDate();
			String todDate=sd.todayDate().split("-")[2]+"-"+sd.todayDate().split("-")[1]+"-"+sd.todayDate().split("-")[0];
			
			
			//update the data
				//int demoId=Integer.parseInt(gd.getData(expUpdId).get(0).toString());
				String query2="";
				if(!oldAmount.equals("0"))
				{
					if(Integer.parseInt(uAmount)-Integer.parseInt(oldAmount)<0)
						{
							boolean successFirst=rd.pCashEntry(todDate, 0, Integer.parseInt(oldAmount), "1");
							if(successFirst)
							{
								String getDebtorId="SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type="
										+ "(SELECT vehicle_details.vehicle_aliasname FROM vehicle_details WHERE "
										+ "vehicle_details.vehicle_number='"+vehicleNo+"')";
								String debtorId=gd.getData(getDebtorId).get(0).toString();
								boolean successSecond=rd.pCashEntry(todDate, Integer.parseInt(uAmount), 0, debtorId);
								if(successSecond)
								{
									request.setAttribute("status", "Updated Petty Cash And Expense");
								}
							query2="UPDATE `sale_master` SET `chalan_no`='"+uChalan+"',`vehicle_deposit`="+uAmount+" WHERE sale_master.id="+uId;
							}
							
						}
					else if(Integer.parseInt(uAmount)-Integer.parseInt(oldAmount)>0)
						{
							
								int pcStatus=rd.checkPCStatus(Integer.parseInt(uAmount));
								if(pcStatus==0)
								{
									request.setAttribute("status", "You don't have enough balance in your Peti Cash");
								
								}
								else if(pcStatus==-1)
								{
									request.setAttribute("status", "You don't have enough balance in your Peti Cash");
								}
								else if(pcStatus==1)
								{
									amountStatusClear=true;
								}
								
							if(amountStatusClear)
							{
								boolean successFirst=rd.pCashEntry(todDate, 0, Integer.parseInt(oldAmount), "1");
								if(successFirst)
								{
									String getDebtorId="SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type="
											+ "(SELECT vehicle_details.vehicle_aliasname FROM vehicle_details WHERE "
											+ "vehicle_details.vehicle_number='"+vehicleNo+"')";
									String debtorId=gd.getData(getDebtorId).get(0).toString();
									boolean successSecond=rd.pCashEntry(todDate, Integer.parseInt(uAmount), 0, debtorId);
									if(successSecond)
									{
										request.setAttribute("status", "Updated Petty Cash And Expense");
									}
								}
								query2="UPDATE `sale_master` SET `chalan_no`='"+uChalan+"',`vehicle_deposit`="+uAmount+" WHERE sale_master.id="+uId;

								
							}
							
						}
				}
				else{
					
					query2="UPDATE `sale_master` SET `chalan_no`='"+uChalan+"' WHERE sale_master.id="+uId;
					System.out.println(query2);
				}
				
				getstatus=gd.executeCommand(query2);
				System.out.println("after upd");
				if(getstatus!=0)
				{
					status=true;
					System.out.println("Successfully Updated In Sale");
					request.setAttribute("status", "Data Updated Successfully");
				}

				if(status)
				{
					request.setAttribute("status", "Updated Successfully");
					RequestDispatcher reqDis=request.getRequestDispatcher("jsp/admin/sale/sale.jsp");
					reqDis.forward(request, response);
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
							+ " `debtor_id`,`vehicle_deposit`, `po_no`, `product_count`) VALUES ("+clientId+","+loading_team_id+", "
									+ "'"+date+"','"+chalan_no+"',"+loading_charges+","+debtorId.get(0)+","+vehicleDeposit+",'"+po_no+"',"+count+");";
				}
				else{
					insertQuery="INSERT INTO `sale_master`(`client_id`, `loading_by_id`, `date`, `chalan_no`, `loading_charges`, "
							+ " `vehicle_details`, `vehicle_deposit`, `po_no`, `product_count`) VALUES ("+clientId+","+loading_team_id+", "
									+ "'"+date+"','"+chalan_no+"',"+loading_charges+",'"+vehicleDetails+"',"+vehicleDeposit+",'"+po_no+"',"+count+");";
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
						
						String insertExp_masterForDeposit="INSERT INTO `expenses_master`(`expenses_type_id`, `debtor_id`, `name`, `amount`, `payment_mode`, `date`, `reason`, "
								+ " `other_details`) VALUES (1,"+debtorId.get(0)+",'-',"+vehicleDeposit+",'CASH','"+date+"','-','-')";
						System.out.println(insertExp_masterForDeposit);
				
						gd.executeCommand(insertExp_masterForDeposit);
					
						String insertExp_masterForDiesel="INSERT INTO `expenses_master`(`expenses_type_id`, `debtor_id`, `name`, `amount`, `payment_mode`, `date`, `reason`, "
								+ " `other_details`) VALUES (2,"+debtorId.get(0)+",'-',"+vehicleAmount+",'CASH','"+date+"','-','-')";
						System.out.println(insertExp_masterForDiesel);
				
						gd.executeCommand(insertExp_masterForDiesel);
						
						
					
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
					String gst = request.getParameter("gst1"+count);
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
					
					String insertProduct="INSERT INTO `sale_details_master`(`sale_master_id`, `product_name`, `qty`, `rate`, `gst`, `supplier_name`, "
							+ " `third_party_chalan`) VALUES ("+max_sale_id+",'"+productName+"',"+qty+","+rate+","+gst+",'"+supplierName+"','"+chalanNo_third+"');";
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
		
		
		//Ajax for finding client name
		if(request.getParameter("findSaleClient")!=null){
			String query = "SELECT `client_organization_name` FROM `client_details`";
			List details = gd.getData(query);
			if(!details.isEmpty())
			{
				Iterator itr = details.iterator();
				while (itr.hasNext()) {
					out.print("<option>"+itr.next()+"</option>");
	
					}
			}
		}
		
		if(request.getParameter("getDateData")!=null){
			
			RequireData requireData=new RequireData();
			
			String indName=request.getParameter("individualName");
			String firstDate=request.getParameter("fromDate");
			String lastDate=request.getParameter("toDate");
			
			String saleData=null;
			
			if(indName==null){
				saleData="SELECT sale_master.id, sale_master.product_count, client_details.client_organization_name, sale_master.chalan_no, "
						+ "sale_master.date, sale_master.vehicle_details,sale_master.debtor_id, sale_master.vehicle_deposit FROM sale_master, "
						+ "client_details WHERE sale_master.client_id = client_details.client_id AND (sale_master.date between '"+firstDate+"' AND '"+lastDate+"')";
			}else {
				
				String getClientID="SELECT `client_id` FROM `client_details` WHERE `client_organization_name`='"+indName+"'";
				
				String clientId=gd.getData(getClientID).get(0).toString();
				
				System.out.println(clientId);
				
				saleData="SELECT sale_master.id, sale_master.product_count, client_details.client_organization_name, sale_master.chalan_no, "
						+ "sale_master.date, sale_master.vehicle_details,sale_master.debtor_id, sale_master.vehicle_deposit FROM sale_master, "
						+ "client_details WHERE sale_master.client_id = client_details.client_id AND (sale_master.date between '"+firstDate+"' AND '"+lastDate+"') AND sale_master.client_id="+clientId;
			}
			
			
			
			List saleDataList= gd.getData(saleData);
			Iterator itr=saleDataList.iterator();

			while (itr.hasNext()) {
				
				String sid = itr.next().toString();
				String productCount = itr.next().toString();
				String clientOrgName = itr.next().toString();
				String chalanNo = itr.next().toString();
				String date = itr.next().toString();
				String vehicleDetail = itr.next().toString();
				String debtorid = itr.next().toString();
				String deposit = itr.next().toString();
				
				String vehicleNumber="";
				
				if(vehicleDetail.equals("")){

					vehicleNumber=requireData.getVehicleNumber(Integer.parseInt(debtorid));

				}else {
					vehicleNumber=vehicleDetail;
				}
				
				out.println(productCount+","+clientOrgName+","+chalanNo+","+date+","+vehicleNumber+","+deposit+",");
				
				String saleMasterData="SELECT sale_details_master.product_name, sale_details_master.qty, sale_details_master.rate, "
						+ "sale_details_master.supplier_name, sale_details_master.third_party_chalan FROM sale_details_master, sale_master "
						+ "WHERE sale_details_master.sale_master_id=sale_master.id AND sale_master.id="+sid;
				
				List saleMasterDataList=gd.getData(saleMasterData);
				Iterator itr1=saleMasterDataList.iterator();
				
				while (itr1.hasNext()) {
					
					String productName=itr1.next().toString();
					String qty=itr1.next().toString();
					String rate=itr1.next().toString();
					String supplierName=itr1.next().toString();
					String chalanNoTP=itr1.next().toString();
					
					out.println(productName+","+qty+","+rate+","+supplierName+","+chalanNoTP+",");
				}
			}	
		}		
	}
}