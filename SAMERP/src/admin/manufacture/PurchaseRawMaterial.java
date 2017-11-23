package admin.manufacture;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;

//@WebServlet("/PurchaseRawMaterial")
public class PurchaseRawMaterial extends HttpServlet {
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
{
	doPost(request, response);
}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		//System.out.println("ghjk");
		
		
		
		if(request.getParameter("getDateData")!=null)
		{
			GenericDAO da = new GenericDAO();
			String fromDate=request.getParameter("fromDate");
			String toDate=request.getParameter("toDate");
			String individualName=request.getParameter("individualName");
			
			if(individualName!=null)
			{
				String getRawPurchaseDetails="SELECT purchase_raw_material_master.date,purchase_raw_material_master.chalan_no,purchase_raw_material_master.vehicle_details,raw_material_master.name,purchase_raw_material_master.qty FROM purchase_raw_material_master,raw_material_master,material_supply_master WHERE purchase_raw_material_master.material_supply_master_id=material_supply_master.supplier_business_id AND purchase_raw_material_master.raw_material_master_id=raw_material_master.id AND purchase_raw_material_master.date BETWEEN '"+fromDate+"' AND '"+toDate+"' AND material_supply_master.supplier_alias='"+individualName+"' ORDER BY purchase_raw_material_master.date DESC";
				List rawPurchaseDetails=da.getData(getRawPurchaseDetails);
				Iterator itr=rawPurchaseDetails.iterator();
				while(itr.hasNext())
				{
					Object date=itr.next();
					Object chalanNo=itr.next();
					Object vNo=itr.next();
					Object rawMaterial=itr.next();
					Object qty=itr.next();
					
					out.print(date+","+chalanNo+","+vNo+","+rawMaterial+","+qty+",");
				}
			}
			else
			{
				String getRawPurchaseDetails="SELECT purchase_raw_material_master.date,material_supply_master.supplier_alias,purchase_raw_material_master.chalan_no,purchase_raw_material_master.vehicle_details,raw_material_master.name,purchase_raw_material_master.qty FROM purchase_raw_material_master,raw_material_master,material_supply_master WHERE purchase_raw_material_master.material_supply_master_id=material_supply_master.supplier_business_id AND purchase_raw_material_master.raw_material_master_id=raw_material_master.id AND purchase_raw_material_master.date BETWEEN '"+fromDate+"' AND '"+toDate+"' ORDER BY purchase_raw_material_master.date DESC";
				List rawPurchaseDetails=da.getData(getRawPurchaseDetails);
				Iterator itr=rawPurchaseDetails.iterator();
				while(itr.hasNext())
				{
					Object date=itr.next();
					Object supName=itr.next();
					Object chalanNo=itr.next();
					Object vNo=itr.next();
					Object rawMaterial=itr.next();
					Object qty=itr.next();
					
					out.print(date+","+supName+","+chalanNo+","+vNo+","+rawMaterial+","+qty+",");
				}
		
			}
		}
	
		if(request.getParameter("findNameByReport")!=null)
		{
			
			GenericDAO da = new GenericDAO();
			List details = null;
			String query="SELECT material_supply_master.supplier_alias FROM material_supply_master WHERE type=1";
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
		
		//inserting into purchase raw material master
		if(request.getParameter("purchase")!=null)
		{
			
			GenericDAO gd=new GenericDAO();
			//System.out.print("dsd");
			int status=0;
			String supId=request.getParameter("supId");
			String rawId=request.getParameter("rawName");
			String rawDate=request.getParameter("rawDate");
			String chalanNo=request.getParameter("chalanNo");
			String qty=request.getParameter("qty");
			
			String vn1=request.getParameter("vn1");
			String vn2=request.getParameter("vn2");
			String vn3=request.getParameter("vn3");
			String vn4=request.getParameter("vn4");
			
			String whitespace = " ";

			String vehicalNo= new StringBuilder(vn1).append(whitespace).append(vn2).append(whitespace).append(vn3).append(whitespace).append(vn4).toString();

				
			
			String insertQuery="INSERT INTO `purchase_raw_material_master`(`material_supply_master_id`, `raw_material_master_id`, `vehicle_details`, `date`, `chalan_no`, `qty`) VALUES ('"+supId+"','"+rawId+"','"+vehicalNo+"','"+rawDate+"','"+chalanNo+"','"+qty+"')";
			status=gd.executeCommand(insertQuery);	
			if(status!=0)
			{
				request.setAttribute("status", "Inserted Successfully");
				System.out.println("successfully inserted in Purchase Raw Material");
				RequestDispatcher rd=request.getRequestDispatcher("/jsp/admin/manufacture/purchaseRawMaterial.jsp");
				rd.forward(request, response);
				//out.print("inserted succesfully");
			}
			else
			{
				out.print("0");
			}
			
			
		}
		
		
		
		//for getting info for update modal
		if(request.getParameter("pId")!=null)
		{
			
			GenericDAO gd=new GenericDAO();
			
			String pid=request.getParameter("pId");
			String getData="SELECT material_supply_master.supplier_business_id ,material_supply_master.supplier_name,purchase_raw_material_master.chalan_no,purchase_raw_material_master.date,purchase_raw_material_master.vehicle_details,raw_material_master.id,raw_material_master.name,purchase_raw_material_master.qty FROM material_supply_master,purchase_raw_material_master,raw_material_master WHERE material_supply_master.supplier_business_id=purchase_raw_material_master.material_supply_master_id AND raw_material_master.id=purchase_raw_material_master.raw_material_master_id AND purchase_raw_material_master.id='"+pid+"'";
			
			List pDetails=gd.getData(getData);
			
			out.print(pDetails.get(0)+","+pDetails.get(1)+","+pDetails.get(2)+","+pDetails.get(3)+","+pDetails.get(4)+","+pDetails.get(5)+","+pDetails.get(6)+","+pDetails.get(7));
																					//date				//vno
		}
		
		
		//for getting supName in AJAX dropDown updateModal
		if(request.getParameter("findName")!=null)
		{
			GenericDAO gd=new GenericDAO();
			
			String name=request.getParameter("findName");
			String query="SELECT material_supply_master.supplier_business_id,material_supply_master.supplier_name FROM material_supply_master WHERE material_supply_master.supplier_name LIKE '%"+name+"%'";
			
			List getName=gd.getData(query);
			Iterator itr=getName.iterator();
			while(itr.hasNext())
			{
				itr.next();
				out.print("<option>"+itr.next()+"</option>");
			}	
			
		}
		
		//for getting id in updateModal
		if(request.getParameter("getId")!=null)
		{
			GenericDAO gd=new GenericDAO();
			
			String name=request.getParameter("getId");
			String query="SELECT material_supply_master.supplier_business_id,material_supply_master.supplier_name FROM material_supply_master WHERE material_supply_master.supplier_name = '"+name+"'";
			//out.print("working");
			List getId=gd.getData(query);
			out.print(getId.get(0));
		}
		
		//for getting rawMaterial in updateModal
		if(request.getParameter("findRaw")!=null)
		{
			
			GenericDAO gd=new GenericDAO();
			
			String raw=request.getParameter("findRaw");
			String rawName="SELECT name FROM raw_material_master WHERE name LIKE '%"+raw+"%'";
			List getRawName=gd.getData(rawName);
			Iterator itr=getRawName.iterator();
			while(itr.hasNext())
			{
				out.print("<option>"+itr.next()+"</option>");
			}
			
		}
		
		
		if(request.getParameter("getRawId")!=null)
		{
			
			GenericDAO gd=new GenericDAO();
			
			String raw=request.getParameter("getRawId");
			String query="SELECT raw_material_master.id FROM raw_material_master WHERE raw_material_master.name='"+raw+"'";
			//String rawid="SELECT id FROM raw_material_master WHERE name ="+raw+"";
			List getRawId=gd.getData(query);
			out.print(getRawId.get(0));
		}
		
		
		//for final updating
		if(request.getParameter("modalSubmit")!=null)
		{
			
			GenericDAO gd=new GenericDAO();
			
			String purId=request.getParameter("purId");
			String supId=request.getParameter("upSupId");
			String chalanNo=request.getParameter("upChalan");
			String newDate=request.getParameter("upDate");
			String rawId=request.getParameter("upRawId");
			String qty=request.getParameter("upQuantity");
			String vNo=request.getParameter("upVehNo");
			
			/*out.println("Purchase Id : "+purId);
			out.println("Suppler Id : "+supId);
			out.println("Chalan No : "+chalanNo);
			out.println("Date : "+newDate);
			out.println("Material Id : "+rawId);
			out.println("Quantity : "+qty);
			out.println("Vehicle : "+vNo);*/
			
			String updateQuery="UPDATE `purchase_raw_material_master` SET `material_supply_master_id`='"+supId+"',`raw_material_master_id`='"+rawId+"',`vehicle_details`='"+vNo+"',`date`='"+newDate+"',`chalan_no`='"+chalanNo+"',`qty`='"+qty+"' WHERE id='"+purId+"'";
			int i=gd.executeCommand(updateQuery);
			if(i>0)
			{
				System.out.println("updated Successfully");
				request.setAttribute("status", "Update Successfully");
				//out.println("updated successfully");
				RequestDispatcher rd=request.getRequestDispatcher("/jsp/admin/manufacture/purchaseRawMaterial.jsp");
				rd.forward(request, response);
				//response.sendRedirect("/SAMERP/jsp/admin/manufacture/purchaseRawMaterial.jsp");
			}
			else
			{
				System.out.println("not updated");
			}
			//request.getParameter("");
		}
		
		//for deleting record
		
		if(request.getParameter("DeleteRec")!=null)
		{
			
			GenericDAO gd=new GenericDAO();
			
			String purId=request.getParameter("purId");
			String deleteQuery="DELETE FROM `purchase_raw_material_master` WHERE id='"+purId+"';";
			int i=gd.executeCommand(deleteQuery);
			if(i>0)
			{
				System.out.println("Deleted SuccessFully");
				request.setAttribute("status", "Delete Successfully");
				RequestDispatcher rd=request.getRequestDispatcher("/jsp/admin/manufacture/purchaseRawMaterial.jsp");
				rd.forward(request, response);
			}
			else
			{
				System.out.println("not deleted");
			}
			
		}
		
	}

}
