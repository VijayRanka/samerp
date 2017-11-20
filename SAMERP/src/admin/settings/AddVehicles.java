package admin.settings;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

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
		String deleteId = request.getParameter("delete");
		RequireData rdd = new RequireData();
		
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
			
			
			String trip_allowance=request.getParameter("trip_allowance");
			String helper_charges=request.getParameter("helper_charges");
			String driver_charges=request.getParameter("driver_charges");
			
			String insertVehicleQuery = "insert into vehicle_details(vehicle_type, vehicle_number,trip_allowance,helper_charges,driver_charges,vehicle_aliasname) values ('"+vehicleType+"', '"+vehicleNo+"','"+trip_allowance+"','"+helper_charges+"','"+driver_charges+"','"+vehicleAlias+"');";
			
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
		
		
		if(deleteId==null)
		{
						
			String deleteVehicleQuery= "DELETE FROM vehicle_details WHERE vehicle_details.vehicle_id='"+deleteId+"'";
			int deletestatus = gd.executeCommand(deleteVehicleQuery);
			
			if(deletestatus==1)
			{
				System.out.println("delete vehicle successful");
				
			}		
		}
		else
		{
			request.setAttribute("error", "2");
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
			
			String update_trip_allowance=request.getParameter("trip_allowance");
			String update_helper_charges=request.getParameter("helper_charges");
			String update_driver_charges=request.getParameter("driver_charges");
			
			String updateVehicleQuery1 = "update vehicle_details set vehicle_number='"+vehicleNum+"', vehicle_type='"+vehicleType+"',trip_allowance='"+update_trip_allowance+"',helper_charges='"+update_helper_charges+"',driver_charges='"+update_driver_charges+"', `vehicle_aliasname`='"+updateVehicleAlias+"'  where vehicle_id='"+vehicleId+"';";
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
			List l2 = new ArrayList(), l3 = new ArrayList();
			
			System.out.println("vno "+ vno);
			
			if(vno!=null){
				String q2="SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type=(SELECT `vehicle_aliasname` FROM `vehicle_details` WHERE vehicle_id="+vno+")";
				l2 = gd.getData(q2);
				
				String q3="SELECT `driver_charges`, `helper_charges`, `trip_allowance` FROM `vehicle_details` WHERE vehicle_id="+vno;
				l3 = gd.getData(q3);
			}
			
			
			if(!l2.isEmpty()){
				String q = "SELECT `expenses_type_id`, `amount` FROM `expenses_master` WHERE debtor_id='"+l2.get(0)+"' AND date BETWEEN '"+sdate+"' AND '"+edate+"' AND expenses_master.exp_id NOT IN (SELECT vehicles_ride_details.exp_master_id FROM vehicles_ride_details )";
				List l = gd.getData(q);
				
				
				String did = rdd.getDriverDebterIdFromVid(vno);
				String qq = "SELECT driver_helper_payment_master.balance FROM driver_helper_payment_master WHERE driver_helper_payment_master.id=(SELECT MAX(driver_helper_payment_master.id) FROM driver_helper_payment_master WHERE driver_helper_payment_master.debter_id="+did+")";
				List ll = gd.getData(qq);
				
				
				String hdid = rdd.getHelperDebterIdFromVid(vno);
				String hq = "SELECT driver_helper_payment_master.balance FROM driver_helper_payment_master WHERE driver_helper_payment_master.id=(SELECT MAX(driver_helper_payment_master.id) FROM driver_helper_payment_master WHERE driver_helper_payment_master.debter_id="+hdid+")";
				List hl = gd.getData(hq);
				
				
				Iterator itr=l.iterator();
				int DieselTotal=0, maintananceTotal=0, depositTotal=0;
				
				while(itr.hasNext())
				{
					String et = itr.next().toString();
					if(et.equals("1"))
					{
						depositTotal += Integer.parseInt(itr.next().toString());
					}
					else if(et.equals("2"))
					{
						DieselTotal += Integer.parseInt(itr.next().toString());
					}
					else if(et.equals("3")){
						maintananceTotal += Integer.parseInt(itr.next().toString());
					}
				} 
				System.out.println(DieselTotal+ "," + maintananceTotal);
				out.print(l3.get(0) + "," + l3.get(1) + "," + l3.get(2) + "," + DieselTotal+ "," + maintananceTotal+"-"+depositTotal + "," + hl.get(0)+ "," + ll.get(0));
				System.out.println("vdata "+l);
			}
		}
		
		
		if(request.getParameter("vDate")!=null)
		{
			RequireData rd = new RequireData();
			List vehicleDetailsData1 =rd.getVehicleDetails1(request.getParameter("vDate"));
            int i1=1;
            
            if(vehicleDetailsData1!=null)
            {
               Iterator itr = vehicleDetailsData1.iterator();	 
               int k=1;
               String s="";
               while(itr.hasNext())
               {
               	String saleId = itr.next().toString();
               	List saleSup =rd.getSaleSup(saleId);
               	Iterator itr2 = saleSup.iterator();	
               	
               	List saleProductDetails =rd.getSaleProductDetails(saleId);
               	Iterator itr3 = saleProductDetails.iterator();	
               	
               	
               	Set set = new LinkedHashSet();
               	
              	s += ","+itr.next()+",";
              	s += itr.next()+",";
              	s += itr.next()+",";
                
            	while(itr2.hasNext()){ 
                	set.add(" "+itr2.next());
                }
            	
            	 for (Object j : set) {
            		 s +=j+"~";   
                 } 
                
            	 s+=",";
                while(itr3.hasNext()){
                	s += itr3.next() + " ( " + itr3.next()+ " ) "+"~";
                } 
                
//	            out.print(","+itr.next());
          	
               	i1++; 
               }
               out.print(s);
            }
            
		}
		
		
		if(request.getParameter("role")!=null)
		{
			if(request.getParameter("role").equals("driver"))
			{
				String totalDPayment = request.getParameter("totalDPayment");
				String vid = request.getParameter("veid");
				String extraCharge = request.getParameter("extraCharge");
				String sdate = request.getParameter("sdate");
				String edate = request.getParameter("edate");
				int tBalance = 0;
				
				
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				String requiredDate = df.format(new Date()).toString();
				
				String did = rdd.getDriverDebterIdFromVid(vid);
				
				String qq = "SELECT driver_helper_payment_master.balance FROM driver_helper_payment_master WHERE driver_helper_payment_master.id=(SELECT MAX(driver_helper_payment_master.id) FROM driver_helper_payment_master WHERE driver_helper_payment_master.debter_id="+did+")";
				List ll = gd.getData(qq);
				
				tBalance += Integer.parseInt(ll.get(0).toString()) + Integer.parseInt(totalDPayment);
				
				String q = "INSERT INTO `driver_helper_payment_master`(`debter_id`, `date`, `credit`, `extra_charges`, `particular`, `type`, `balance`) VALUES "
						+ "( "+did+", '"+requiredDate+"', "+totalDPayment+", "+extraCharge+", 'payment "+sdate+" to "+edate+"','D', "+tBalance+")";
	
				gd.executeCommand(q);
			}
			
			else if(request.getParameter("role").equals("helper"))
			{
				String hc = request.getParameter("hc");
				String vid = request.getParameter("veid");
				String sdate = request.getParameter("sdate");
				String edate = request.getParameter("edate");
				int tBalance = 0;
				
				
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				String requiredDate = df.format(new Date()).toString();
				
				String did = rdd.getHelperDebterIdFromVid(vid);
				
				String qq = "SELECT driver_helper_payment_master.balance FROM driver_helper_payment_master WHERE driver_helper_payment_master.id=(SELECT MAX(driver_helper_payment_master.id) FROM driver_helper_payment_master WHERE driver_helper_payment_master.debter_id="+did+")";
				List ll = gd.getData(qq);

				tBalance += Integer.parseInt(ll.get(0).toString()) + Integer.parseInt(hc);
				
				String q = "INSERT INTO `driver_helper_payment_master`(`debter_id`, `date`, `credit`, `particular`, `type`, `balance`) VALUES "
						+ "( "+did+", '"+requiredDate+"', "+hc+", 'payment "+sdate+" to "+edate+"','H', "+tBalance+")";

				gd.executeCommand(q);
			}
			
			
		}
		
	}

}
