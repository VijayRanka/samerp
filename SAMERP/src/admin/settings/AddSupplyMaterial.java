package admin.settings;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.*;
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

public class AddSupplyMaterial extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		GenericDAO gd=new GenericDAO();
		
		//for inserting new supplier data into table
		if(request.getParameter("insertsupply")!=null)
		{
		
			String supBussName=request.getParameter("suppbusinesname");
			String supplierName=request.getParameter("suppname");
			String supplierAddress=request.getParameter("address");
			String suppContact=request.getParameter("contact");
			int openingBalance=Integer.parseInt(request.getParameter("openingbalance").toString());
			String type=request.getParameter("material_type");
			System.out.println("in servlet");
			String src = "";
			if(request.getParameter("productPurchasePage")!=null){
				src = request.getParameter("productPurchasePage");
			}
			int status=0;
			
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    		String requiredDate = df.format(new Date()).toString();
			
			String insertQuery="INSERT INTO `material_supply_master`(`supplier_business_name`,`supplier_name`, `supplier_address`, `supplier_contactno`,`supplier_opening_balance`,`type`) VALUES ('"+supBussName+"','"+supplierName+"','"+supplierAddress+"','"+suppContact+"','"+openingBalance+"','"+type+"')";
			status=gd.executeCommand(insertQuery);	
			if(status!=0)
			{
				String insertQuery1="INSERT INTO `total_supplier_payment_master`(`supplier_id`, `date`, `total_remaining`) VALUES ((select max(supplier_business_id) from material_supply_master), '"+requiredDate+"' , "+openingBalance+")";
				int status1=gd.executeCommand(insertQuery1);	
				
				String maxid="SELECT MAX(supplier_business_id) from material_supply_master";
				List max=gd.getData(maxid);
				request.setAttribute("status", " New Supplier Added Successfully");
				request.setAttribute("notify", "supplier");
				request.setAttribute("sid", max.get(0));
				request.setAttribute("sbname", supBussName);
				request.setAttribute("sname", supplierName);
				request.setAttribute("cn", suppContact);
				
				
				if(src.equals("productPurchase")){
					RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/productPurchase/productPurchase.jsp");
					rd.forward(request, response);
				}
				else if(src.equals("RawPurchase"))
				{
					RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/manufacture/purchaseRawMaterial.jsp");
					rd.forward(request, response);
				}
				else{
					RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addMaterialSuppliers.jsp");
					rd.forward(request, response);
				}
				
			}
		}
		
		if(request.getParameter("deleteId")!=null)
		{
			String id=request.getParameter("deleteId");
			String deleteQuery="Delete from `material_supply_master` where `supplier_business_id`="+id+"";
			int i=gd.executeCommand(deleteQuery);
			if(i>0)
			{
				request.setAttribute("status", "Supplier Deleted Successfully");
				
			}
			else
			{
				System.out.println("please try again");
			}
			RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addMaterialSuppliers.jsp");
			rd.forward(request, response);
			
		}
		
		//AJAX for getting enterprise name(purchaseRawMaterail)
		if(request.getParameter("findName")!=null)
		{
					String name=request.getParameter("findName");
					String query="SELECT supplier_business_name from material_supply_master where type=1";
					List bName=gd.getData(query);
					Iterator itr=bName.iterator();
					while(itr.hasNext())
					{
						out.print("<option>"+itr.next()+"</option>");
					}
		}
		
		if(request.getParameter("eName")!=null)
		{
			String eName=request.getParameter("eName");
			String query="SELECT supplier_business_id,supplier_name,supplier_contactno FROM material_supply_master WHERE supplier_business_name='"+eName+"'";
			List demo=gd.getData(query);
			Iterator itr=demo.iterator();
			while(itr.hasNext())
			{
				Object sId=itr.next();
				Object sName=itr.next();
				Object sContact=itr.next();
				out.print(sId+","+sName+","+sContact);
			}
		}
		
		

		if(request.getParameter("Updateid")!=null)
		{
			String RowId=request.getParameter("Updateid");
			System.out.println("id 1:"+RowId);
			RequireData rd=new RequireData();
			List demoList=rd.getSupplyMaterials(RowId);
			Iterator itr=demoList.iterator();
			while(itr.hasNext())
			{
				out.print(itr.next()+",");
			}
		}
		
		//for getting supplier name and contact no. after adding new supplier
		if(request.getParameter("bName")!=null)
		{
			out.print("working");
		}
		
			
		
		if(request.getParameter("save")!=null)
		{
			
			String id=request.getParameter("Updateid");
			System.out.println("id 2:"+id);
			String supbname=request.getParameter("suppbusinesname");
			String supname=request.getParameter("suppname");
			String supaddress=request.getParameter("address");
			String supcontactno=request.getParameter("contact");
			String type=request.getParameter("material_type");
					
			String query="update `material_supply_master` set `supplier_business_name`='"+supbname+"',`supplier_name`='"+supname+"',`supplier_address`='"+supaddress+"',`supplier_contactno`='"+supcontactno+"',`type`='"+type+"' where `supplier_business_id`="+id+"";
			System.out.println("update:"+query);
			int i=gd.executeCommand(query);
			
			if(i>0)
			{
				request.setAttribute("status", "Supplier Updated Successfully");
				
			}
			else
			{
				System.out.println("Please try again");
				
			}
			RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addMaterialSuppliers.jsp");
			rd.forward(request, response);
		}
	}

}
