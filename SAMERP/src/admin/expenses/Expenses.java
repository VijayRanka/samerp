package admin.expenses;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;
import utility.RequireData;

public class Expenses extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Expenses() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		//get exp data for ajax table
		if(request.getParameter("getTableData")!=null)
		{
			GenericDAO gd=new GenericDAO();
			RequireData rd=new RequireData();
			String singleDate=request.getParameter("getTableData");
			String getDataExp="SELECT `exp_id`,`name`, `amount`, `payment_mode`, `reason`,"
					+ "`expenses_type`.`expenses_type_name`, "
					+ "`other_details` FROM `expenses_master`,`debtor_master`,`expenses_type` "
					+ "WHERE expenses_type.expenses_type_id=expenses_master.expenses_type_id and"
					+ " expenses_master.debtor_id=debtor_master.id and expenses_master.date='"+singleDate+"'";
			
			if(!gd.getData(getDataExp).isEmpty())
			{
				List demoList=gd.getData(getDataExp);
				Iterator itr=demoList.iterator();
				while(itr.hasNext())
				{
					Object id=itr.next();
					out.print(itr.next()+","+itr.next()+","+itr.next()+","+itr.next()+",");
					
					String vrmData=rd.getVRM(id.toString());
					if(vrmData!=null)
					{
						out.print(vrmData.split(",")[0]+","+vrmData.split(",")[1]+","+vrmData.split(",")[2]+",");
					}
					else{
						out.print("-,-,-,");
					}
					
					out.print(itr.next()+",");
					Object oDetails=itr.next();
					if(oDetails==null)
						out.print(oDetails+",");
					else
						out.print("-,");
					
				}
			}
		}
		
		if(request.getParameter("addNewExpType")!=null)
		{
			GenericDAO gd=new GenericDAO();
			String name=request.getParameter("addNewExpType");
			int getstatus=0;
			String query="INSERT INTO `expenses_type`(`expenses_type_name`) VALUES ('"+name+"')";
			getstatus=gd.executeCommand(query);
			if(getstatus!=0)
			{
				out.print("1,"+name+" Added Successfully");
			}
			
		}
		if(request.getParameter("addDebtorList")!=null)
		{
			String debtor=request.getParameter("debtor").trim();
			boolean status=false;
			GenericDAO gd=new GenericDAO();
			int i=0;
			
			String check="SELECT `type` FROM `debtor_master`";
			List checkDemo=gd.getData(check);
			Iterator itr=checkDemo.iterator();
			while(itr.hasNext())
			{
				if(itr.next().toString().equals(debtor))
					status=true;
			}
			if(status)
				out.println("0,Debtor Already Present");
			else
			{
				String insertQuery="INSERT INTO `debtor_master`(`type`) VALUES ('"+debtor+"')";
				i=gd.executeCommand(insertQuery);
				if(i>0)
				{
					System.out.println("inserted Success");
					String getDataList="SELECT `id`, `type` FROM `debtor_master` WHERE type='"+debtor+"'";
					if(!gd.getData(getDataList).isEmpty())
					{
						System.out.println("1,"+gd.getData(getDataList).get(0)+","+gd.getData(getDataList).get(1)+",Debtor Added Successfully");
					out.println("1,"+gd.getData(getDataList).get(0)+","+gd.getData(getDataList).get(1));
					}
				}
			}
		}
		//updating Data
		if(request.getParameter("UpdateData")!=null)
		{
			GenericDAO gd=new GenericDAO();
			int getstatus=0;
			boolean status=false;
			String uId=request.getParameter("uId");
			String uName=request.getParameter("uName");
			String uAmount=request.getParameter("uAmount");
			String uPayMode=request.getParameter("uPayMode");
			String uDate=request.getParameter("uDate");
			String vehicleLtrQt=request.getParameter("uDieselQty");
			String uVehDetails=request.getParameter("uVehDetails");
			String uDebtorType=request.getParameter("uDebtorType");
			String updExpType=request.getParameter("updExpType");
			String uVehReading=request.getParameter("uVehReading");
			String uReason=request.getParameter("uReason");
			String uOtherDetails=request.getParameter("uOtherDetails");
			
			
			//update the data
			String getExpIdQuery="select expenses_type_id from expenses_type where expenses_type_name='"+updExpType+"'";
			List expId=gd.getData(getExpIdQuery);
			Iterator expiditr=expId.iterator();
			String getExpId="";
			while(expiditr.hasNext())
			{
				getExpId=expiditr.next().toString();
			}
			String expUpdId="SELECT expenses_type.expenses_type_id FROM expenses_type WHERE expenses_type.expenses_type_name='"+updExpType+"'";
			if(!gd.getData(expUpdId).isEmpty())
			{
				int demoId=Integer.parseInt(gd.getData(expUpdId).get(0).toString());
				String query2="UPDATE `expenses_master` SET `expenses_type_id`="+demoId	+",`debtor_id`="+uDebtorType+",`name`='"+uName+"',`amount`="+uAmount+",`payment_mode`='"+uPayMode+"',`date`='"+uDate+"',`reason`='"+uReason+"',`other_details`='"+uOtherDetails+"' WHERE expenses_master.exp_id="+uId;
				getstatus=gd.executeCommand(query2);
				System.out.println("after upd");
				if(getstatus!=0)
				{
					status=true;
					System.out.println("Successfully Updated In Expenses");
					request.setAttribute("status", "Data Updated Successfully");
				}

				if(!request.getParameter("uVehDetails").isEmpty())
				{
					
					String getExpIdVRM="SELECT vehicle_reading_master.id FROM vehicle_reading_master WHERE vehicle_reading_master.expenses_master_id="+uId;
					
					if(!gd.getData(getExpIdVRM).isEmpty())
					{
						
						String vId="SELECT vehicle_details.vehicle_id FROM vehicle_details WHERE vehicle_details.vehicle_aliasname='"+uVehDetails+"'";
						if(!gd.getData(vId).isEmpty())
						{
							String updateVRM="UPDATE `vehicle_reading_master` SET `vehicle_id`="+gd.getData(vId).get(0)+",`vehicle_reading`="+uVehReading+",`vehicle_diesel_qty`="+vehicleLtrQt+" WHERE vehicle_reading_master.id="+gd.getData(getExpIdVRM).get(0);
							if(gd.executeCommand(updateVRM)>0)
							{
								status=true;
								System.out.println("successfully updated Vehicle reading master");
							}
						}
						else
						{
							status=false;
							request.setAttribute("status", "Vehicle Not Present");
							RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/expenses/expenses.jsp");
							rd.forward(request, response);
						}
					}
					else
					{
						String getVehicleId="SELECT vehicle_details.vehicle_id FROM vehicle_details WHERE vehicle_details.vehicle_aliasname='"+uVehDetails+"'";
						if(!gd.getData(getVehicleId).isEmpty())
						{
							String insertVRM="INSERT INTO `vehicle_reading_master`(`expenses_master_id`, `vehicle_id`, `vehicle_reading`) VALUES ("+uId+","+gd.getData(getVehicleId).get(0).toString()+","+uVehReading+")";
							int stats=gd.executeCommand(insertVRM);
							if(stats>0){
								System.out.println("Vehicle Reading Updated");
								status=true;
								request.setAttribute("status", "VRM Data Inserted Successfully");
								}
						}
					}
				}
				if(status)
				{
					request.setAttribute("status", "Updated Successfully");
					RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/expenses/expenses.jsp");
					rd.forward(request, response);
				}
				
			}
			else{
				request.setAttribute("status","Expense Type Not Selected Properly");
				RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/expenses/expenses.jsp");
				rd.forward(request, response);
				
			}
			
			
			
			
			
		}
		
		if(request.getParameter("insertName")!=null)
				{
					GenericDAO gd=new GenericDAO();
					String insertData=request.getParameter("insertName");
					String querycheck="SELECT `expenses_type_name` FROM `expenses_type` where status=0";
					//check if present
					List checkerlist=gd.getData(querycheck);
					Iterator getitr=checkerlist.iterator();
					boolean status=false;
					while(getitr.hasNext())
					{
						if(insertData.equals(getitr.next().toString()))
						{
							status=true;
						}
					}
					if(status)
					{
						out.println("1,");
					}
					else
					{
						out.println("0,"+insertData);
					}
				}
			
		
		//for finding expense type and fetch whoollllleeee list
				if(request.getParameter("findList")!=null)
				{
					GenericDAO da = new GenericDAO();
					List details = null;
					String query = "SELECT expenses_type.expenses_type_name FROM expenses_type";
					details = da.getData(query);
					if(!details.isEmpty())
					{
						Iterator itr = details.iterator();
						while (itr.hasNext()) {
							out.print("<option>"+itr.next()+"</option>");
			
							}
					}
				}
		
		
		//for finding expense type and fetch list
		if(request.getParameter("findExpType")!=null)
		{
			GenericDAO da = new GenericDAO();
			String columnName=request.getParameter("id");
			String name=request.getParameter("findExpType");
			List details = null;
			String query = "SELECT expenses_type."+columnName+" FROM expenses_type";
			details = da.getData(query);
			if(!details.isEmpty())
			{
				Iterator itr = details.iterator();
				while (itr.hasNext()) {
					out.print("<option>"+itr.next()+"</option>");
	
					}
			}
		}
		
		//for finding name and fetch list
		
				if(request.getParameter("findVehicleList")!=null)
				{
					GenericDAO da = new GenericDAO();
					String columnName=request.getParameter("id");
					String name=request.getParameter("findName");
					List details = null;
					String query="SELECT vehicle_details.vehicle_aliasname FROM `vehicle_details`";
					details = da.getData(query);
					if(!details.isEmpty())
					{
						Iterator itr = details.iterator();
						while (itr.hasNext()) {
							out.print("<option>"+itr.next()+"</option>");
			
							}
					}
					
				}
		//for finding name and fetch list
		
		if(request.getParameter("findName")!=null)
		{
			GenericDAO da = new GenericDAO();
			String columnName=request.getParameter("id");
			String name=request.getParameter("findName");
			List details = null;
			String query = "SELECT expenses_master."+columnName+" FROM expenses_master WHERE "+columnName+" LIKE '%"+name+"%' group by "+columnName+"";
			details = da.getData(query);
			if(!details.isEmpty())
			{
				Iterator itr = details.iterator();
				while (itr.hasNext()) {
					out.print("<option>"+itr.next()+"</option>");
	
					}
			}
		}
		// insert query
		if(request.getParameter("save")!=null)
		{
			try{
				GenericDAO gd=new GenericDAO();
				int getstatus=0;
				boolean status=false;
				String expType=request.getParameter("expType");
				String name=request.getParameter("name");
				double amount=Double.parseDouble(request.getParameter("amount").toString());
				String type=request.getParameter("type");
				String date=request.getParameter("date");
				String vehicleDetail=request.getParameter("vehicleDetail");
				String debtType=request.getParameter("debtorType");
				String vehicleLtrQt=request.getParameter("vehicleLtrQty");
				String vehicleReading=request.getParameter("vehicleReading");
				String[] arrayOfString = date.split("-");
				String details=request.getParameter("reason");
				String other_details=request.getParameter("other_details");
				//fetching the query
				String getExpIdQuery="select expenses_type_id from expenses_type where expenses_type_name='"+expType+"'";
				List expId=gd.getData(getExpIdQuery);
				Iterator expiditr=expId.iterator();
				String getExpId="";
				while(expiditr.hasNext())
				{
					getExpId=expiditr.next().toString();
				}
				String query2="INSERT INTO `expenses_master`(`expenses_type_id`, `debtor_id`,`name`, `amount`, `payment_mode`, `date`,`reason`, `other_details`) "
						+ "VALUES ("+getExpId+","+debtType+",'"+name+"',"+amount+",'"+type+"','"+arrayOfString[0]+"-"+arrayOfString[1]+"-"+arrayOfString[2]+"','"+details+"','"+other_details+"')";
				getstatus=gd.executeCommand(query2);
				if(getstatus!=0)
				{
					status=true;
					System.out.println("Successfully Inserted In Expenses");
					request.setAttribute("status", "Data Inserted Successfully");
				}
	
				if(!request.getParameter("vehicleDetail").isEmpty())
				{
					String getMax="SELECT MAX(expenses_master.exp_id) FROM expenses_master";
					if(!gd.getData(getMax).isEmpty()){
						String getVehicleId="SELECT vehicle_details.vehicle_id FROM vehicle_details WHERE vehicle_details.vehicle_aliasname='"+vehicleDetail+"'";
						if(!gd.getData(getVehicleId).isEmpty())
						{
							String insertVRM="INSERT INTO `vehicle_reading_master`(`expenses_master_id`, `vehicle_id`,`vehicle_diesel_qty`, `vehicle_reading`) VALUES ("+gd.getData(getMax).get(0)+","+gd.getData(getVehicleId).get(0).toString()+","+vehicleLtrQt+","+vehicleReading+")";
							int stats=gd.executeCommand(insertVRM);
							if(stats>0){
								System.out.println("Vehicle Reading Updated");
								status=true;
								request.setAttribute("status", "Reading and Data Inserted Successfully");
								}
						}
					}
				}
				if(status)
				{
					RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/expenses/expenses.jsp");
					rd.forward(request, response);
				}
			}
			catch(Exception e)
			{
				request.setAttribute("status", "Some Problem Occured");
				RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/expenses/expenses.jsp");
				rd.forward(request, response);
			}
		}
		// delete query
		if(request.getParameter("deleteId")!=null)
		{
			GenericDAO gd=new GenericDAO();
			int delstatus=0;
			String deleteQuery="Delete from `expenses_master` where exp_id="+request.getParameter("deleteId");
			delstatus=gd.executeCommand(deleteQuery);
			if(delstatus!=0)
			{
				System.out.println("successfully deleted in expenses");
				request.setAttribute("status", "Deleted Successfully");
				RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/expenses/expenses.jsp");
				rd.forward(request, response);
			}
		}
		// getUpdated data
		if(request.getParameter("getUpdate")!=null)
		{
			String expId=request.getParameter("getUpdate");
			GenericDAO gd=new GenericDAO();
			String demoData="SELECT `exp_id`, expenses_master.date, expenses_master.name, expenses_master.amount, "
					+ "expenses_master.payment_mode, expenses_master.reason, expenses_type.expenses_type_name, debtor_master.id,debtor_master.type,"
					+ " expenses_master.other_details FROM `expenses_master`,expenses_type,debtor_master WHERE "
					+ "expenses_master.expenses_type_id=expenses_type.expenses_type_id AND expenses_master.debtor_id="
					+ "debtor_master.id AND expenses_master.exp_id="+expId;
			List demoList=gd.getData(demoData);
			if(!demoList.isEmpty())
			out.println(demoList.get(0)+","+demoList.get(1)+","+demoList.get(2)+","+demoList.get(3)+""
					+ ","+demoList.get(4)+","+demoList.get(5)+","+demoList.get(6)+","+demoList.get(7)+","+demoList.get(8)+","+demoList.get(9));
			if(demoList.get(0)!=null)
			{
				String demoData2="SELECT vehicle_details.vehicle_aliasname,vehicle_reading_master.vehicle_reading,vehicle_reading_master.vehicle_diesel_qty FROM "
						+ "vehicle_reading_master, vehicle_details, expenses_master WHERE expenses_master.exp_id=vehicle_"
						+ "reading_master.expenses_master_id AND vehicle_reading_master.vehicle_id=vehicle_details.vehicle_id "
						+ "AND vehicle_reading_master.expenses_master_id="+expId;
				List demoList2=gd.getData(demoData2);
				if(!demoList2.isEmpty())
				{
					out.println(",1,"+demoList2.get(0)+","+demoList2.get(1)+","+demoList2.get(2));
				}
			}
			
		}

	}

}
