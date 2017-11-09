package admin.settings;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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


public class AddVehicles extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			doPost(request,response);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		
		PrintWriter out = response.getWriter();
		GenericDAO gd = new GenericDAO();
		
		if(request.getParameter("insertSubmitBtn")!=null)
		{
			
			String vehicleType = request.getParameter("vehicle_type");	
			System.out.println(vehicleType);
			
			String vehicleNo1 = request.getParameter("vehicleno1");
			String vehicleNo2 = request.getParameter("vehicleno2");
			String vehicleNo3 = request.getParameter("vehicleno3");
			String vehicleNo4 = request.getParameter("vehicleno4");
			
			String vehicleNo = vehicleNo1+"-"+vehicleNo2+"-"+vehicleNo3+"-"+vehicleNo4;
			String vehicleAlias = vehicleType +"_"+vehicleNo1+"-"+vehicleNo2+"-"+vehicleNo3+"-"+vehicleNo4;
			
			String insertVehicleQuery = "insert into vehicle_details(vehicle_type, vehicle_number, vehicle_aliasname) values ('"+vehicleType+"', '"+vehicleNo+"', '"+vehicleAlias+"');";
			
			String insertDebt="INSERT INTO `debtor_master`(`type`) VALUES ('"+vehicleAlias+"')";
			int xx=gd.executeCommand(insertDebt);
			if(xx>0)
			{
				System.out.println("debtor added successfully");
			}
			
			int insertStatus = gd.executeCommand(insertVehicleQuery);
			
			if(insertStatus==1){
				System.out.println("insert successful");
				request.setAttribute("status", "Vehicle added Successfully");
			}else{
				System.out.println("insert fail");
				request.setAttribute("status", "Vehicle add Fail");
			}
			
			RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addVehicles.jsp");
			rd.forward(request, response);
		}
		
		if(request.getParameter("deleteid")!=null)
		{
			String deleteId = request.getParameter("deleteid");	
			String deleteVehicleQuery= "delete from vehicle_details where vehicle_id="+deleteId;
			int deletestatus = gd.executeCommand(deleteVehicleQuery);
			
			if(deletestatus==1){
				System.out.println("delete vehicle successful");
				request.setAttribute("status", "Vehicle Deleted Successfully");
			}else{
				System.out.println("delete vehicle fail");
				request.setAttribute("status", "Vehicle Delete Fail");
			}
			
			RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addVehicles.jsp");
			rd.forward(request, response);
		}
		
		
		if(request.getParameter("updateid")!=null)
		{
			String RowId=request.getParameter("updateid");
			RequireData rd=new RequireData();
			List demoList=rd.getVehicleRowData(RowId);
			Iterator itr=demoList.iterator();
			while(itr.hasNext())
			{
				out.print(itr.next()+",");
			}
		}
		
		if(request.getParameter("updateSubmitBtn")!=null)
		{
			
			String oldVehicleType = request.getParameter("oldvehicle_type");
			String oldVehicleAlias = request.getParameter("oldvehicle_alias");
			
			String vehicleId = request.getParameter("Updatevehicle_id");
			String vehicleType = request.getParameter("Updatevehicle_type");
			
			String Updatevehicleno1 = request.getParameter("Updatevehicleno1");
			String Updatevehicleno2 = request.getParameter("Updatevehicleno2");
			String Updatevehicleno3 = request.getParameter("Updatevehicleno3");
			String Updatevehicleno4 = request.getParameter("Updatevehicleno4");
			
			String vehicleNum = Updatevehicleno1+"-"+Updatevehicleno2+"-"+Updatevehicleno3+"-"+Updatevehicleno4;
			String updateVehicleAlias = vehicleType +"_"+Updatevehicleno1+"-"+Updatevehicleno2+"-"+Updatevehicleno3+"-"+Updatevehicleno4;
			
			String updateVehicleQuery1 = "update vehicle_details set vehicle_number='"+vehicleNum+"', vehicle_type='"+vehicleType+"', `vehicle_aliasname`='"+updateVehicleAlias+"'  where vehicle_id='"+vehicleId+"';";
			int updatestatus1 = gd.executeCommand(updateVehicleQuery1);
			
			if(updatestatus1>=1){
				System.out.println("update vehicle successful");
				
				String updateVehicleQuery2 = "UPDATE `debtor_master` SET `type`='"+updateVehicleAlias+"' WHERE debtor_master.type='"+oldVehicleAlias+"';";
				int updatestatus2 = gd.executeCommand(updateVehicleQuery2);
				
				request.setAttribute("status", "Vehicle Updated Successfully");
			}else{
				
				System.out.println("Vehicle Update fail");
				request.setAttribute("status", "Vehicle Update Fail");
			}
			
			
			RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addVehicles.jsp");
			rd.forward(request, response);
			
		}
		
		
		if(request.getParameter("vno")!="")
		{
			String vno = request.getParameter("vno");
			String sdate = request.getParameter("sdate");
			String edate = request.getParameter("edate");
			List l2 = new ArrayList();
			
			System.out.println("vno "+ vno);
			
			if(vno!=null){
				String q2="SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type=(SELECT `vehicle_aliasname` FROM `vehicle_details` WHERE vehicle_id="+vno+")";
				l2 = gd.getData(q2);
			}
			
			
			if(!l2.isEmpty()){
				String q = "SELECT `expenses_type_id`, `amount` FROM `expenses_master` WHERE debtor_id='"+l2.get(0)+"' AND date BETWEEN '"+sdate+"' AND '"+edate+"' AND expenses_master.exp_id NOT IN (SELECT vehicles_ride_details.exp_master_id FROM vehicles_ride_details)";
				List l = gd.getData(q);
				
				Iterator itr=l.iterator();
				int DieselTotal=0, total=0;
				
				while(itr.hasNext())
				{
					String et = itr.next().toString();
					if(et.equals("2")){
						DieselTotal += Integer.parseInt(itr.next().toString());
					}
					else{
						total += Integer.parseInt(itr.next().toString());
					}
				}
				
				out.print(DieselTotal+ "," + total);
				System.out.println("vdata "+l);
			}
		}
		
	}

}
