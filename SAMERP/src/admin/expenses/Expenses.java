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
import utility.SysDate;

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
		//get data between two dates
		if(request.getParameter("getDateData")!=null)
		{
			GenericDAO gd=new GenericDAO();
			RequireData rd=new RequireData();
			String firstDate=request.getParameter("fromDate");
			String lastDate=request.getParameter("toDate");
			String demo="SELECT `exp_id`, `date`, `name`, `amount`, `payment_mode`,"
					+ "`expenses_type`.`expenses_type_name`,`debtor_master`.`type`, `other_details`,bankId, `reason` FROM "
					+ "`expenses_master`,`debtor_master`,`expenses_type` WHERE expenses_type.expenses_type_id=expenses_master.expenses_type_id "
					+ "and expenses_master.debtor_id=debtor_master.id and date BETWEEN '"+firstDate+"' and '"+lastDate+"' order by date";
			if(!gd.getData(demo).isEmpty())
			{
				List demoList=gd.getData(demo);
				Iterator itr=demoList.iterator();
				while(itr.hasNext())
				{
					Object id=itr.next();
					Object date=itr.next();
					Object name=itr.next();
					Object amount=itr.next();
					Object payMode=itr.next();
					Object expType=itr.next();
					Object debtorType=itr.next();
					String cDetails=itr.next().toString();
					String bankInfo=itr.next().toString();
					String description=itr.next().toString();
					
					out.print(id+","+date+","+name+","+amount+","+payMode+",");
					
					String vrmData=rd.getVRM(id.toString());
					if(vrmData!=null)
					{
						out.print(vrmData.split(",")[0]+","+vrmData.split(",")[1]+",");
					}
					else{
						out.print("-,-,");
					}
					
					out.print(expType+","+debtorType+",");
					if(!cDetails.equals(""))
						out.print(cDetails+",");
					else
						out.print("-,");
					if(!bankInfo.equals("0"))
						out.print(rd.getBankById(bankInfo)+",");
					else
						out.print("-,");
					if(!description.equals(""))
					out.print(description+",");
					else
						out.print("-,");
				}
			}
			
		}
		
		//get exp data for ajax table
		if(request.getParameter("getTableData")!=null)
		{
			GenericDAO gd=new GenericDAO();
			RequireData rd=new RequireData();
			String singleDate=request.getParameter("getTableData");
			String getDataExp="SELECT exp_id,`date`, `name`, `amount`, `payment_mode`,"
					+ "`expenses_type`.`expenses_type_name`,`debtor_master`.`type`, `other_details`, `reason` FROM "
					+ "`expenses_master`,`debtor_master`,`expenses_type` WHERE expenses_type.expenses_type_id=expenses_master.expenses_type_id "
					+ "and expenses_master.debtor_id=debtor_master.id and "
					+ "expenses_master.date='"+singleDate+"'";
		
		if(!gd.getData(getDataExp).isEmpty())
		{
			List demoList=gd.getData(getDataExp);
			Iterator itr=demoList.iterator();
			while(itr.hasNext())
			{
				Object id=itr.next();
				Object date=itr.next();
				Object name=itr.next();
				Object amount=itr.next();
				Object payMode=itr.next();
				Object expType=itr.next();
				Object debtorType=itr.next();
				Object cDetails=itr.next();
				Object description=itr.next();
				
				out.print(date+","+name+","+amount+","+payMode+",");
				
				String vrmData=rd.getVRM(id.toString());
				if(vrmData!=null)
				{
					out.print(vrmData.split(",")[0]+","+vrmData.split(",")[1]+",");
				}
				else{
					out.print("-,-,");
				}
				
				out.print(expType+","+debtorType+",");
				if(cDetails!=null)
					out.print(cDetails+",");
				else
					out.print("-,");
				out.print(description+",");
				
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
		
		//insert cash deposite to bank
		if(request.getParameter("Bank_Deposite")!=null)
		{
			int bankstatus=0;
			GenericDAO gd=new GenericDAO();
			
			String Bank_Id=request.getParameter("bank_name");
			String Date=request.getParameter("date");
			String Amount=request.getParameter("amount");
			String particulars="cash";
			
			String query="insert into bank_account_details(bid,date,debit,particulars) values('"+Bank_Id+"','"+Date+"','"+Amount+"','"+particulars+"')";
		  
			System.out.println("cash deposite:"+query);
			
			bankstatus=gd.executeCommand(query);
		   
		     if(bankstatus!=0)
		    {
		    	System.out.println("Inserted Successfully");
		    	request.setAttribute("status", "Inserted Successfully");
		    }
		    RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/expenses/expenses.jsp");
			rd.forward(request, response);
			
			
		}
		//updating Data
		if(request.getParameter("UpdateData")!=null)
		{
			GenericDAO gd=new GenericDAO();
			int getstatus=0;
			boolean status=false;
			String uId=request.getParameter("uId");
			String uName=request.getParameter("uName");
			String oldAmount=request.getParameter("oldAmount");
			String uAmount=request.getParameter("uAmount");
			String vehicleLtrQt=request.getParameter("uDieselQty");
			
			String uDebtorType=request.getParameter("uDebtorType");
			String payMode=request.getParameter("uPayMode");
			
			String uVehReading=request.getParameter("uVehReading");
			String uReason=request.getParameter("uReason");
			String uOtherDetails=request.getParameter("uOtherDetails");
			boolean amountStatusClear=false;
			RequireData rd=new RequireData();
			SysDate sd=new SysDate();
			String todDate=sd.todayDate().split("-")[2]+"-"+sd.todayDate().split("-")[1]+"-"+sd.todayDate().split("-")[0];
			
			
			//update the data
			String expUpdId="SELECT expenses_type.expenses_type_id FROM expenses_type,expenses_master WHERE expenses_type.expenses_type_id="
					+ "expenses_master.expenses_type_id and expenses_master.exp_id="+uId;
			if(!gd.getData(expUpdId).isEmpty())
			{
				int demoId=Integer.parseInt(gd.getData(expUpdId).get(0).toString());
				String query2="";
				if(!oldAmount.equals("0"))
				{
					if(Integer.parseInt(uAmount)-Integer.parseInt(oldAmount)<0)
						{
							if(payMode.equalsIgnoreCase("Cash")){
							boolean successFirst=rd.pCashEntry(todDate, 0, Integer.parseInt(oldAmount), "1");
							if(successFirst)
							{
								String debtorId=gd.getData("SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type='"+uDebtorType+"'").get(0).toString();
								boolean successSecond=rd.pCashEntry(todDate, Integer.parseInt(uAmount), 0, debtorId);
								if(successSecond)
								{
									request.setAttribute("status", "Updated Petty Cash And Expense");
								}
							}
							query2="UPDATE `expenses_master` SET `name`='"+uName+"',amount="+uAmount+",`reason`='"+uReason+"',`other_details`='"+uOtherDetails+"' WHERE expenses_master.exp_id="+uId;
							}
							else if(payMode.equalsIgnoreCase("cheque"))
							{
								String bankId=gd.getData("SELECT account_details.acc_id FROM account_details WHERE account_details.acc_aliasname='"+uDebtorType+"'").get(0).toString();
								boolean successFirst=rd.badEntry(bankId, todDate, 0, Integer.parseInt(oldAmount), "", "1");
								if(successFirst)
								{
									String debtorId=gd.getData("SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type='"+uDebtorType).get(0).toString();
									boolean successSecond=rd.badEntry(bankId, todDate, Integer.parseInt(uAmount), 0, "CHEQUE_"+uOtherDetails, debtorId);
									if(successSecond)
									{
										request.setAttribute("status", "Updated Bank Amount And Expense");
									}
								}
								query2="UPDATE `expenses_master` SET `name`='"+uName+"',amount="+uAmount+",`reason`='"+uReason+"',`other_details`='"+uOtherDetails+"' WHERE expenses_master.exp_id="+uId;
								
							}
							else
							{
								String bankId=gd.getData("SELECT account_details.acc_id FROM account_details WHERE account_details.acc_aliasname='"+uDebtorType+"'").get(0).toString();
								boolean successFirst=rd.badEntry(bankId, todDate, 0, Integer.parseInt(oldAmount), "", "1");
								if(successFirst)
								{
									String debtorId=gd.getData("SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type='"+uDebtorType).get(0).toString();
									boolean successSecond=rd.badEntry(bankId, todDate, Integer.parseInt(uAmount), 0, payMode, debtorId);
									if(successSecond)
									{
										request.setAttribute("status", "Updated Bank Amount And Expense");
									}
								}
								query2="UPDATE `expenses_master` SET `name`='"+uName+"',amount="+uAmount+",`reason`='"+uReason+"',`other_details`='"+uOtherDetails+"' WHERE expenses_master.exp_id="+uId;
								
							}
							
						}
					else if(Integer.parseInt(uAmount)-Integer.parseInt(oldAmount)>0)
						{
							if(payMode.equalsIgnoreCase("Cash"))
							{
								int pcStatus=rd.checkPCStatus(Integer.parseInt(uAmount));
								if(pcStatus==0)
								{
									request.setAttribute("payError", "YOU DON'T HAVE ENOUGH BALANCE IN YOUR PETI CASH_c_0");
								
								}
								else if(pcStatus==-1)
								{
									request.setAttribute("payError", "YOU DON'T HAVE ENOUGH BALANCE IN YOUR PETI CASH_c_-1");
								}
								else if(pcStatus==1)
								{
									amountStatusClear=true;
								}
								else if(pcStatus==2)
								{
									request.setAttribute("payError", "YOU HAVE NOT ADDED YOUR PETI CASH_c_-1");
								}
								
							}
							else
							{
								int badStatus=rd.checkBankBalance(Integer.parseInt(uAmount),uDebtorType);
								if(badStatus==0)
										{
											request.setAttribute("payError", "YOU HAVE INSUFFICIENT BALANCE IN YOUR BANK_b_0");
										}
								else if(badStatus==-1)
								{
									request.setAttribute("payError", "YOU HAVE INSUFFICIENT BALANCE IN YOUR BANK_b_-1");
								}
								else if(badStatus==1)
								{
									amountStatusClear=true;
								}
								else if(badStatus==2)
								{
									request.setAttribute("payError", "YOU HAVE NOT ADD MONEY IN YOUR BANK_b_2");
								}
								
							}
							if(amountStatusClear)
							{
								if(payMode.equalsIgnoreCase("Cash")){
								boolean successFirst=rd.pCashEntry(todDate, 0, Integer.parseInt(oldAmount), "1");
								if(successFirst)
								{
									String debtorId=gd.getData("SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type='"+uDebtorType+"'").get(0).toString();
									boolean successSecond=rd.pCashEntry(todDate, Integer.parseInt(uAmount), 0, debtorId);
									if(successSecond)
									{
										request.setAttribute("status", "Updated Petty Cash And Expense");
									}
								}
								query2="UPDATE `expenses_master` SET `name`='"+uName+"',amount="+uAmount+",`reason`='"+uReason+"',`other_details`='"+uOtherDetails+"' WHERE expenses_master.exp_id="+uId;
								}
								else if(payMode.equalsIgnoreCase("cheque"))
								{
									String bankId=gd.getData("SELECT account_details.acc_id FROM account_details WHERE account_details.acc_aliasname='"+uDebtorType+"'").get(0).toString();
									boolean successFirst=rd.badEntry(bankId, todDate, 0, Integer.parseInt(oldAmount), "", "1");
									if(successFirst)
									{
										String debtorId=gd.getData("SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type='"+uDebtorType).get(0).toString();
										boolean successSecond=rd.badEntry(bankId, todDate, Integer.parseInt(uAmount), 0, "CHEQUE_"+uOtherDetails, debtorId);
										if(successSecond)
										{
											request.setAttribute("status", "Updated Bank Amount And Expense");
										}
									}
									query2="UPDATE `expenses_master` SET `name`='"+uName+"',amount="+uAmount+",`reason`='"+uReason+"',`other_details`='"+uOtherDetails+"' WHERE expenses_master.exp_id="+uId;
									
								}
								else
								{
									String bankId=gd.getData("SELECT account_details.acc_id FROM account_details WHERE account_details.acc_aliasname='"+uDebtorType+"'").get(0).toString();
									boolean successFirst=rd.badEntry(bankId, todDate, 0, Integer.parseInt(oldAmount), "", "1");
									if(successFirst)
									{
										String debtorId=gd.getData("SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type='"+uDebtorType).get(0).toString();
										boolean successSecond=rd.badEntry(bankId, todDate, Integer.parseInt(uAmount), 0, payMode, debtorId);
										if(successSecond)
										{
											request.setAttribute("status", "Updated Bank Amount And Expense");
										}
									}
									query2="UPDATE `expenses_master` SET `name`='"+uName+"',amount="+uAmount+",`reason`='"+uReason+"',`other_details`='"+uOtherDetails+"' WHERE expenses_master.exp_id="+uId;
									
								}
								
							}
							
						}
				}
				else
				query2="UPDATE `expenses_master` SET `name`='"+uName+"',`reason`='"+uReason+"',`other_details`='"+uOtherDetails+"' WHERE expenses_master.exp_id="+uId;
				
				getstatus=gd.executeCommand(query2);
				System.out.println("after upd");
				if(getstatus!=0)
				{
					status=true;
					System.out.println("Successfully Updated In Expenses");
					request.setAttribute("status", "Data Updated Successfully");
				}

				if(!request.getParameter("uVehReading").isEmpty())
				{
					
					String getExpIdVRM="SELECT vehicle_reading_master.id FROM vehicle_reading_master WHERE vehicle_reading_master.expenses_master_id="+uId;
					
					if(!gd.getData(getExpIdVRM).isEmpty())
					{
						
						String vId="SELECT vehicle_details.vehicle_id FROM vehicle_details,debtor_master "
								+ "WHERE debtor_master.type=vehicle_details.vehicle_aliasname and vehicle_details."
								+ "vehicle_aliasname='"+uDebtorType+"'";
						if(!gd.getData(vId).isEmpty())
						{
							String updateVRM="UPDATE `vehicle_reading_master` SET `vehicle_reading`="+uVehReading+",`vehicle_diesel_qty`="+vehicleLtrQt+" WHERE vehicle_reading_master.id="+gd.getData(getExpIdVRM).get(0);
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
							RequestDispatcher reqDis=request.getRequestDispatcher("jsp/admin/expenses/expenses.jsp");
							reqDis.forward(request, response);
						}
					}
				}
				if(status)
				{
					request.setAttribute("status", "Updated Successfully");
					RequestDispatcher reqDis=request.getRequestDispatcher("jsp/admin/expenses/expenses.jsp");
					reqDis.forward(request, response);
				}
				
			}
			else{
				request.setAttribute("status","Expense Type Not Selected Properly");
				RequestDispatcher reqDis=request.getRequestDispatcher("jsp/admin/expenses/expenses.jsp");
				reqDis.forward(request, response);
				
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
				boolean status=false;
				String expType=request.getParameter("expType");
				String name=request.getParameter("name");
				int amount=Integer.parseInt(request.getParameter("amount").toString());
				String payMode=request.getParameter("type");
				String chequeNo=request.getParameter("chequeNo");
				String bankInfo=request.getParameter("bankInfo");
				String date=request.getParameter("date");
				String debtType=request.getParameter("debtorType");
				String vehicleLtrQt=request.getParameter("vehicleLtrQty");
				String vehicleReading=request.getParameter("vehicleReading");
				String[] arrayOfString = date.split("-");
				
				//fetching the query
				String getExpId="";
				boolean amountStatusClear=false;
				RequireData rd=new RequireData();
				
				if(payMode.equalsIgnoreCase("Cash"))
				{
					int pcStatus=rd.checkPCStatus(amount);
					if(pcStatus==0)
					{
						request.setAttribute("payError", "YOU DON'T HAVE ENOUGH BALANCE IN YOUR PETI CASH_c_0");
					
					}
					else if(pcStatus==-1)
					{
						request.setAttribute("payError", "YOU DON'T HAVE ENOUGH BALANCE IN YOUR PETI CASH_c_-1");
					}
					else if(pcStatus==1)
					{
						amountStatusClear=true;
					}
					else if(pcStatus==2)
					{
						request.setAttribute("payError", "YOU HAVEN'T ADDED PETI-CASH YET_c_-2");
					}
					
				}
				else
				{
					
					int badStatus=rd.checkBankBalance(amount,bankInfo);
					if(badStatus==0)
							{
						
								request.setAttribute("payError", "YOU HAVE INSUFFICIENT BALANCE IN YOUR BANk_b_0");
							}
					else if(badStatus==-1)
					{
						request.setAttribute("payError", "YOU HAVE INSUFFICIENT BALANCE IN YOUR BANK_b_-1");
					}
					else if(badStatus==2)
					{
						request.setAttribute("payError", "YOU HAVEN'T ADDED ADDED AMOUNT IN BANK YET_b_-2");
					}
					else if(badStatus==1)
					{
						amountStatusClear=true;
					}
					
				}
				if(amountStatusClear)
				{
					getExpId=gd.getData("select expenses_type_id from expenses_type where expenses_type_name='"+expType+"'").get(0).toString();
					rd.commonExpEntry(getExpId, Integer.parseInt(debtType), name, Integer.toString(amount), payMode, bankInfo, chequeNo, arrayOfString[0]+"-"+arrayOfString[1]+"-"+arrayOfString[2]);
					request.setAttribute("status", "Data Inserted Successfully");
					
					if(payMode.equalsIgnoreCase("cash"))
					rd.pCashEntry(arrayOfString[0]+"-"+arrayOfString[1]+"-"+arrayOfString[2], amount, 0, debtType);
					else if(payMode.equalsIgnoreCase("cheque"))
						rd.badEntry(bankInfo, arrayOfString[0]+"-"+arrayOfString[1]+"-"+arrayOfString[2], amount, 0, payMode+"_"+chequeNo, debtType);
					else
						rd.badEntry(bankInfo, arrayOfString[0]+"-"+arrayOfString[1]+"-"+arrayOfString[2], amount, 0, payMode, debtType);
					
					if(!request.getParameter("vehicleReading").isEmpty())
					{
						String getMax="SELECT MAX(expenses_master.exp_id) FROM expenses_master";
						if(!gd.getData(getMax).isEmpty()){
							String getVehicleId="SELECT vehicle_details.vehicle_id FROM vehicle_details,debtor_master WHERE debtor_master.type=vehicle_details.vehicle_aliasname and debtor_master.id="+debtType;
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
						RequestDispatcher reqDisp=request.getRequestDispatcher("jsp/admin/expenses/expenses.jsp");
						reqDisp.forward(request, response);
					}
					else{
						RequestDispatcher reqDisp=request.getRequestDispatcher("jsp/admin/expenses/expenses.jsp");
						reqDisp.forward(request, response);
					}
						
				}
				else
				{
					RequestDispatcher reqDisp=request.getRequestDispatcher("jsp/admin/expenses/expenses.jsp");
					reqDisp.forward(request, response);
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
