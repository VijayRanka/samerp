package admin.productPurchase;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;

public class ProductPurchase extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doPost(request, response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out = response.getWriter();
		GenericDAO gd = new GenericDAO();
		String supplierId = request.getParameter("supplierid");
		String clientId = request.getParameter("clientid");
		String ChalanNo = request.getParameter("chalanno");
		String vehicleNo = request.getParameter("vehicleno1")+"-"+request.getParameter("vehicleno2")+"-"+request.getParameter("vehicleno3")+"-"+request.getParameter("vehicleno4");
		String date = request.getParameter("date");
		
		String counter =request.getParameter("counter");
		
		// ajax to search product
		if(request.getParameter("q")!=null){
			
			String query="SELECT `id`,`name` FROM `product_master` WHERE `name` LIKE '"+request.getParameter("q")+"%'";
			List details = gd.getData(query);

			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + ",");
			}
		}
	
		//insert data part
		if(request.getParameter("insertSubmitBtn")!=null)
		{
			String insertQuery = "INSERT INTO `product_purchase_master`( `material_supply_master_id`, `client_details_id`, `chalan_no`, `vehicle_no`, `date`, `product_count`) values ('"+supplierId+"', '"+clientId+"', '"+ChalanNo+"', '"+vehicleNo+"', '"+date+"', '"+counter+"'  ); ";
			//System.out.println(insertQuery);
			int insertStatus = gd.executeCommand(insertQuery); 
			
			String q = "select max(id) from product_purchase_master";
			List l = gd.getData(q);
			String ppmid = l.get(0).toString(); 
			
			if(insertStatus==1){
				int count = Integer.parseInt(counter);
				for(int j=1; j<=count; j++){
					
					String productName = request.getParameter("productName"+j);
					String qty = request.getParameter("qty"+j);
					String rate = request.getParameter("rate"+j);
					
					String insertQuery1 = "INSERT INTO `purchased_product_details`(`product_purchase_master_id`, `product_name`, `qty`, `rate`) VALUES ( '"+ppmid+"', '"+productName.replace(" ", "_")+"', '"+qty+"', '"+rate+"')";
					int insertStatus1 = gd.executeCommand(insertQuery1); 
				}
				request.setAttribute("status", "Products Purchased Successfully ");
			}
			
			RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/productPurchase/productPurchase.jsp");
			rd.forward(request, response);
		}
		
		// update ajax to set values
		if(request.getParameter("updateid")!=null)
		{
			List finalData = new ArrayList();
			
			String purchaseQuery = "SELECT product_purchase_master.bill_check_status, product_purchase_master.id, `product_count`, material_supply_master.supplier_business_name , "
					+ "client_details.client_organization_name , `chalan_no`, `vehicle_no`, `date` FROM `product_purchase_master`, "
					+ "material_supply_master, client_details "
					+ "WHERE product_purchase_master.id="+request.getParameter("updateid")+" AND material_supply_master.supplier_business_id=product_purchase_master.material_supply_master_id  "
					+ "AND client_details.client_id=product_purchase_master.client_details_id";
			List purchaseList = gd.getData(purchaseQuery);

			String s ="";
			Iterator itr = purchaseList.iterator();
			
			Iterator itr2 = null;

			
			while(itr.hasNext()){
				String billCheck = itr.next().toString();
				String id = itr.next().toString();
				
				String pquery = "SELECT `id`, `product_name`, `qty`, `rate` FROM `purchased_product_details` WHERE purchased_product_details.product_purchase_master_id="+id;
				List pList = gd.getData(pquery);
				
				/*finalData.add(itr.next());
				finalData.add(itr.next());
				finalData.add(itr.next());
				finalData.add(itr.next());
				finalData.add(itr.next());
				finalData.add(itr.next());*/
				
				s+=","+billCheck+","+id+","+itr.next()+","+itr.next()+","+itr.next()+","+itr.next()+","+itr.next()+","+itr.next();
				
				itr2 = pList.iterator();
				
				while(itr2.hasNext()){
					/*finalData.add(itr2.next());
					finalData.add(itr2.next());
					finalData.add(itr2.next());*/
					
					s+=","+itr2.next()+","+itr2.next()+","+itr2.next()+","+itr2.next();
				}
				
			}
			
			Object a[] = finalData.toArray();
			out.println(s);
			
		}
		
		// actual update data part
		if(request.getParameter("updateSubmitBtn")!=null){
			
			String updateSupplierId = request.getParameter("updateSupplierid");
			String updateClientId = request.getParameter("updateClientid");
			String updateChalanNo = request.getParameter("updateChalanno");
			String updateVehicleNo = request.getParameter("updateVehicleno1")+"-"+request.getParameter("updateVehicleno2")+"-"+request.getParameter("updateVehicleno3")+"-"+request.getParameter("updateVehicleno4");
			String updateDate = request.getParameter("updateDate");
			String updateQty = request.getParameter("updateQty");
			String updatepid = request.getParameter("updatepid");
			String newCount = request.getParameter("newCount");
			
			

			int count = Integer.parseInt(newCount);
			
			String productName[] = new String[count+1];
			String productQty[] = new String[count+1];
			String productRate[] = new String[count+1];
			String productPId[] = new String[count+1];
			
			String proList = request.getParameter("proList");
			String proList1[] = proList.split(",");
			
			for(int i=1; i<=count; i++){
				productPId[i] = request.getParameter("productPId"+i);
				productName[i] = request.getParameter("productName"+i);
				productQty[i] = request.getParameter("productQty"+i);
				productRate[i] = request.getParameter("productRate"+i);
				
			}
			
			
			int flag=0, updateQuery1Status=0, deleteQueryStatus=0, duQueryStatus=0, textCount=Integer.parseInt(updateQty);
			
			String updateQuery = "UPDATE `product_purchase_master` SET `material_supply_master_id`="+updateSupplierId+",`client_details_id`="+updateClientId+",`chalan_no`='"+updateChalanNo+"',`vehicle_no`='"+updateVehicleNo+"',`date`='"+updateDate+"',`product_count`="+updateQty+" WHERE product_purchase_master.id="+updatepid;
			int pupdateStatus = gd.executeCommand(updateQuery); 
			
			
			if(pupdateStatus==1){
				String updateQuery1="",  deleteQuery="", duQuery="";
				
				for(int i=1; i<=count; i++){
					
					if(productName[i]!=null){
						
						if(i<proList1.length){
							updateQuery1 = "UPDATE `purchased_product_details` SET `product_name`='"+productName[i].replace(" ", "_")+"', `qty`="+productQty[i]+", `rate`= "+productRate[i]+" WHERE id="+productPId[i];
							updateQuery1Status = gd.executeCommand(updateQuery1);
						}
						else{
							
							String insertQuery1 = "INSERT INTO `purchased_product_details`(`product_purchase_master_id`, `product_name`, `qty`, `rate`) VALUES ( '"+updatepid+"', '"+productName[i].replace(" ", "_")+"', '"+productQty[i]+"', '"+productRate[i]+"')";
							int insertStatus1 = gd.executeCommand(insertQuery1);
							textCount++;
							
							duQuery = "UPDATE `product_purchase_master` SET `product_count`="+(textCount)+" WHERE product_purchase_master.id="+updatepid;
							duQueryStatus = gd.executeCommand(duQuery);
						}
					}
					else if(productName[i]==null){	 
						if(i<proList1.length){
							deleteQuery = " delete from `purchased_product_details` WHERE id="+proList1[i];
							deleteQueryStatus = gd.executeCommand(deleteQuery);
							if(deleteQueryStatus==1){
								textCount = textCount-1;
								duQuery = "UPDATE `product_purchase_master` SET `product_count`="+(textCount)+" WHERE product_purchase_master.id="+updatepid;
								duQueryStatus = gd.executeCommand(duQuery);
							/*	
								if(duQueryStatus==1){
									System.out.println("success");
								}else{
									System.out.println("fail");
								}*/
							}
						}
						
					}
					if(updateQuery1Status==1){
						flag=1;
					}else{
						flag=0;
					}
				}
			}
			
			if(flag==1){
				request.setAttribute("status", " Products Updated Successfully ");
			}
			
			RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/productPurchase/productPurchase.jsp");
			rd.forward(request, response);
		}
		
		
		// delete data part
		if(request.getParameter("deleteId")!=null){
			
			String deleteId = request.getParameter("deleteId");
			String deleteCheckQuery = "SELECT `id`,  `bill_check_status` FROM `product_purchase_master` WHERE  bill_check_status=1 AND id="+deleteId;
			List deleteCheckQueryStatus = gd.getData(deleteCheckQuery); 
			
			
			if(deleteCheckQueryStatus.isEmpty()){
				String deleteQuery = "DELETE FROM `purchased_product_details` WHERE purchased_product_details.product_purchase_master_id="+deleteId;
				int deleteStatus = gd.executeCommand(deleteQuery); 
				if(deleteStatus>0){
					System.out.println("in purchased");
					String pdeleteQuery = "DELETE FROM `product_purchase_master` WHERE product_purchase_master.id="+deleteId;
					int pdeleteStatus = gd.executeCommand(pdeleteQuery); 
					
					if(pdeleteStatus==1){
						System.out.println("delete sc");
						request.setAttribute("status", "Products Deleted Successfully");
					}else{
						System.out.println("delete fail");
					}
				}
			}
			else
			{
				request.setAttribute("error", "3");
			}
			RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/productPurchase/productPurchase.jsp");
			rd.forward(request, response);
		}
		
		
		
	}

}
