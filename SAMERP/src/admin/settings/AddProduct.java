package admin.settings;

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
import utility.RequireData;
import utility.SysDate;


public class AddProduct extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		
		GenericDAO gd=new GenericDAO();
		RequireData rq=new RequireData();
		
		if(request.getParameter("submit")!=null)
		{

			String contractor_id=request.getParameter("contractor_name");	
			
			String product_name=request.getParameter("productname");
			String replacepname=product_name.replace(' ','_');			
			String hsn_code=request.getParameter("hsn_code");
			String gstper=request.getParameter("gst_per");
			
			String query="insert into product_master(`name`,`contractor_id`,`hsncode`,`gstper`) values('"+replacepname+"','"+contractor_id+"','"+hsn_code+"','"+gstper+"')";
			int i=gd.executeCommand(query);
			
			if(i>0)
			{
				if(!gd.getData("SELECT MAX(id) FROM `product_master`").get(0).toString().isEmpty()){
				int getMaxId=Integer.parseInt(gd.getData("SELECT MAX(id) FROM `product_master`").get(0).toString());
				SysDate sd=new SysDate();
				String dateObj[]=sd.todayDate().split("-");
				String insertRateMaster="INSERT INTO `rate_master`(`product_id`, `production_rate`, `querying_rate`, `date`) VALUES ("+getMaxId+",0,0,'"+dateObj[2]+"-"+dateObj[1]+"-"+dateObj[0]+"')";
				int x=gd.executeCommand(insertRateMaster);
				if(x==1)
					{
						String insertFinalStock="INSERT INTO `final_stock`(`product_id`, `qty`) VALUES ("+getMaxId+",0)";
						int xx=gd.executeCommand(insertFinalStock);
						if(xx>0)
						{
							System.out.println("inserted Successfully");
							request.setAttribute("status", "Inserted Successfully");
						}
					}
				}
			}
			else
			{
				System.out.println("please try Again");
			}
			RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addProduct.jsp");
			rd.forward(request, response);
		}
		
		if(request.getParameter("deleteId")!=null)
		{
			String id=request.getParameter("deleteId");
			String query1="DELETE FROM product_master WHERE id="+id+"";
			int i=gd.executeCommand(query1);
			
			if(i>0)
			{
				System.out.println("deleted Successfully");
				request.setAttribute("status", "Deleted Successfully");
				
			}
			else
			{
				System.out.println("please try Again");
			}
			RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addProduct.jsp");
			rd.forward(request, response);
		}
		
		if(request.getParameter("Updateid")!=null)
		{
			String RowId=request.getParameter("Updateid");
			RequireData rd=new RequireData();
			List demoList=rd.updateProductDetails(RowId);
			Iterator itr=demoList.iterator();
			while(itr.hasNext())
			{
				out.print(itr.next()+",");
			}
	
		}
		if(request.getParameter("save")!=null)
		{
			
			String id=request.getParameter("Updateid");
			
			String update_cname=request.getParameter("contractor_name");
			String aliasname=rq.getAliasName(update_cname);
			
			String update_pname=request.getParameter("name");
			String updatepname=update_pname.replace(' ','_');
			
			String update_hsncode=request.getParameter("hsn_code");
			
			String update_gstper=request.getParameter("gst_per");
						
			String query="UPDATE contractor_master,product_master SET product_master.name='"+updatepname+"', product_master.hsncode='"+update_hsncode+"',product_master.gstper='"+update_gstper+"', contractor_master.aliasname='"+aliasname+"' WHERE product_master.contractor_id=contractor_master.id AND product_master.id="+id+"";
			int i=gd.executeCommand(query);
			
			if(i>0)
			{
				System.out.println("updated Successfully");
				request.setAttribute("status", "update Successfully");
				
			}
			else
			{
				System.out.println("Please try again");
				
			}
			RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addProduct.jsp");
			rd.forward(request, response);
			
		}
		
		
	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}


