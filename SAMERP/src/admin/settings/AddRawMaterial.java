package admin.settings;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
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

public class AddRawMaterial extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doPost(request,response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		GenericDAO gd=new GenericDAO();
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		
		if(request.getParameter("insert")!=null)
		{
			String materialname=request.getParameter("material_name");
			
			String material_name=materialname.replace(' ', '_');
			
			String unit=request.getParameter("unit");
			
			String insert_query="insert into `raw_material_master` (`name`,`unit`) values ('"+material_name+"','"+unit+"')";
			
			int i=gd.executeCommand(insert_query);
			
			if(i>0)
			{
				request.setAttribute("status", "Inserted Successfully");
			
			}
			RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/AddRawMaterial.jsp");
			rd.forward(request, response);
			
		}
		
		
		
		if(request.getParameter("deleteId")!=null)
		{
			String id=request.getParameter("deleteId");
			String delete_query="delete from `raw_material_master` where `id`='"+id+"'";
			
			int i=gd.executeCommand(delete_query);
			
			if(i>0)
			{
				request.setAttribute("status", "Deleted Successfully");
			}
			RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/AddRawMaterial.jsp");
			rd.forward(request, response);
			
		}
		
		if(request.getParameter("Updateid")!=null)
		{
			String RowId=request.getParameter("Updateid");
			System.out.println("id 1:"+RowId);
			RequireData rd=new RequireData();
			List demoList=rd.getRawMaterials(RowId);
			Iterator itr=demoList.iterator();
			while(itr.hasNext())
			{
				out.print(itr.next()+",");
			}
	
		}
		
		if(request.getParameter("save")!=null)
		{
			String rawid=request.getParameter("Updateid");
			String materialname=request.getParameter("mname");
			String unit=request.getParameter("unit");
			
			String update="update `raw_material_master` set `name`='"+materialname+"',`unit`='"+unit+"' where `id`="+rawid+"";
			int i=gd.executeCommand(update);
			if(i>0)
			{
				request.setAttribute("status", "Updated Successfully");
			}
			RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/AddRawMaterial.jsp");
			rd.forward(request, response);
			
		}
		
		//purchaseRawMaterial modal
		/*if(request.getParameter("modalSubmit")!=null)
		{
			response.setContentType("text/html");
			PrintWriter out=response.getWriter();
			GenericDAO gd=new GenericDAO();
			String rawMaterial=request.getParameter("raw");
			String unit=request.getParameter("unit");
			
			String query="INSERT INTO `raw_material_master`(`name`, `unit`) VALUES ('"+rawMaterial+"','"+unit+"')";
			int status=gd.executeCommand(query);
			if(status!=0)
			{
				System.out.println("successfully inserted in raw material");
				//request.setAttribute("status", "Inserted Successfully");
				RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/manufacture/purchaseRawMaterial.jsp");
				rd.forward(request, response);
			}
			out.print("working");
		}*/
		
		if(request.getParameter("rName")!=null)
		{
			
			//GenericDAO gd=new GenericDAO();
			
			String rName=request.getParameter("rName");
			String unit=request.getParameter("unit");
			
			String checkQuery="SELECT * FROM raw_material_master WHERE name='"+rName+"'";
			List check=gd.getData(checkQuery);
			if(!check.isEmpty())
			{
				out.print("0");
			}
			else
			{
				String query="INSERT INTO `raw_material_master`(`name`, `unit`) VALUES ('"+rName+"','"+unit+"')";
				int status=gd.executeCommand(query);
				if(status!=0)
				{
					System.out.println("successfully inserted in raw material");
					//request.setAttribute("status", "Inserted Successfully");
					
					String getCurrentData="SELECT id,name,unit FROM raw_material_master WHERE name='"+rName+"'";
					List currentData=gd.getData(getCurrentData);
					Iterator itr=currentData.iterator();
					while(itr.hasNext())
					{
						Object getId=itr.next();
						Object getRaw=itr.next();
						Object getUnit=itr.next();
						out.print(getId+","+getRaw+","+getUnit);
					}
					
				}
			}
			
			
			
			
			
			
			//out.print("working");
		}
		if(request.getParameter("changeUnit")!=null)
		{
			
			//GenericDAO gd=new GenericDAO();
			
			String id=request.getParameter("changeUnit");
			String getUnit="SELECT id FROM raw_material_master WHERE id='"+id+"'";
			List unit=gd.getData(getUnit);
			out.print(unit.get(0));
			
			
		}
		
	}

}
