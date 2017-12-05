package admin.pettycash;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

//@WebServlet("/PTCash")
public class PTCash extends HttpServlet {
	
	public static int sum (List<Integer> list) {
	    int sum = 0;
	    for (int i: list) {
	        sum += i;
	    }
	    return sum;
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		GenericDAO gd=new GenericDAO();
		RequireData rd=new RequireData();			
		int status=0;
		
		
		
		if(request.getParameter("getDateData")!=null)
		{
			String fromDate=request.getParameter("fromDate");
			String toDate =request.getParameter("toDate");
			String individualName =request.getParameter("individualName");
			
			if(individualName!=null)
			{
				String getHandLoanDetails="SELECT handloan_details.date,handloan_details.debit,handloan_details.credit,handloan_details.mode,handloan_details.particulars,handloan_details.balance FROM handloan_master,handloan_details WHERE handloan_master.id=handloan_details.handloan_id AND handloan_details.date BETWEEN '"+fromDate+"' AND '"+toDate+"' AND handloan_master.alias_name='"+individualName+"' ORDER BY handloan_details.id";
				List handLoanDetails=gd.getData(getHandLoanDetails);
				Iterator itr= handLoanDetails.iterator();
				while(itr.hasNext())
				{
					Object date=itr.next();
					Object debit=itr.next();
					Object credit=itr.next();
					Object mode=itr.next();
					Object pariculars=itr.next();
					Object balance=itr.next();
					
					out.print(date+","+debit+","+credit+","+mode+","+pariculars+","+balance+",");
				}
			}
			else
			{
				String getHandLoanDetails="SELECT handloan_details.date,handloan_master.alias_name,handloan_details.debit,handloan_details.credit,handloan_details.mode,handloan_details.particulars,handloan_details.balance FROM handloan_master,handloan_details WHERE handloan_master.id=handloan_details.handloan_id AND handloan_details.date BETWEEN '"+fromDate+"' AND '"+toDate+"' ORDER BY handloan_details.id";
				List handLoanDetails=gd.getData(getHandLoanDetails);
				Iterator itr= handLoanDetails.iterator();
				while(itr.hasNext())
				{
					Object date=itr.next();
					Object alias=itr.next();
					Object debit=itr.next();
					Object credit=itr.next();
					Object mode=itr.next();
					Object pariculars=itr.next();
					Object balance=itr.next();
					
					out.print(date+","+alias+","+debit+","+credit+","+mode+","+pariculars+","+balance+",");
				}
			}
			
			
		}
		if(request.getParameter("findNameByReport")!=null)
		{
			String getHandLoanName="SELECT alias_name FROM handloan_master";
			List handLoanName=gd.getData(getHandLoanName);
			Iterator itr=handLoanName.iterator();
			while(itr.hasNext())
			{
				out.print("<option>"+itr.next()+"</option>");
			}
			
		}
		
		if(request.getParameter("updateHandLoan")!=null)
		{
			String date=request.getParameter("uDate");
			String alias=request.getParameter("uName");
			String handLoanId=request.getParameter("handLoanId");
			int oldDr=Integer.parseInt(request.getParameter("oldDr"));
			int newDr=Integer.parseInt(request.getParameter("dr"));
			int oldCr=Integer.parseInt(request.getParameter("oldCr"));
			int newCr=Integer.parseInt(request.getParameter("cr"));
			String mode=request.getParameter("uMode");
			String chqNo=request.getParameter("chqNo");
			int oldBalance=Integer.parseInt(request.getParameter("uBalance"));
			String handloanDetailsId=request.getParameter("detailsId");
			String particulars="";
			
			
			String detailsId=request.getParameter("detailsId");
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			String requiredDate = df.format(new Date()).toString();
			
			String getHandLoanDebtorId="SELECT id FROM debtor_master WHERE type='"+alias+"'";
			List handLoanDebtorId=gd.getData(getHandLoanDebtorId);
			
			String getRevertDebtorId="SELECT id FROM debtor_master WHERE type='REVERT_ENTRY'";
			List revertDebtorId=gd.getData(getRevertDebtorId);
			
			if(newCr!=0)
			{
					//Addition to handloan balance
					
					String getHandLoanBalance="SELECT handloan_details.balance FROM handloan_details ORDER BY handloan_details.id DESC LIMIT 1";
					List handLoanBalance=gd.getData(getHandLoanBalance);
					
					int cancelEntryBalance=(int)handLoanBalance.get(0)-oldCr;
					
					String cancelHandLoanEntry="INSERT INTO `handloan_details`(`handloan_id`, `date`, `credit`, `debit`, `mode`, `particulars`, `balance`) "
							+ "VALUES ('"+handLoanId+"','"+requiredDate+"',"+0+","+oldCr+",'"+mode+"','REVERT_ENTRY_"+date+"','"+cancelEntryBalance+"')";
					int cancelHandLoanEntryStatus=gd.executeCommand(cancelHandLoanEntry);
					if(cancelHandLoanEntryStatus>0)
					{
						int revertEntryBalance=cancelEntryBalance+newCr;
						String revertHandLoanEntry="INSERT INTO `handloan_details`(`handloan_id`, `date`, `credit`, `debit`, `mode`, `particulars`, `balance`) "
								+ "VALUES ('"+handLoanId+"','"+requiredDate+"',"+newCr+","+0+",'"+mode+"','"+chqNo+"',"+revertEntryBalance+")";
						int revertHandLoanEntryStaus=gd.executeCommand(revertHandLoanEntry);
						if(revertHandLoanEntryStaus>0)
						{
							System.out.println("handloan reverted");
							if(mode.equals("CHEQUE") || mode.equals("TRANSFER"))
							{
								System.out.println("bank enter");
								String getBankBalance="SELECT bank_account_details.balance FROM bank_account_details ORDER by bank_account_details.id DESC LIMIT 1";
								List bankBalance=gd.getData(getBankBalance);
								
								if(mode.equals("CHEQUE"))
								{
									particulars="HANDLOAN CHEQUE_"+chqNo;
								}
								else if(mode.equals("TRANSFER"))
								{
									particulars="HANDLOAN TRANSFER";
								}
									
								String getBankRecord="SELECT bank_account_details.bid,bank_account_details.date,bank_account_details.debit,bank_account_details.credit,bank_account_details.particulars,bank_account_details.debter_id,bank_account_details.balance FROM bank_account_details WHERE bank_account_details.date='"+date+"' AND bank_account_details.credit="+oldCr+" AND bank_account_details.particulars='"+particulars+"' AND bank_account_details.debter_id='"+handLoanDebtorId.get(0)+"'";
								System.out.println(getBankRecord);
								List bankRecord=gd.getData(getBankRecord);
								Object bid=bankRecord.get(0);
								Object bDate=bankRecord.get(1);
								Object debit=bankRecord.get(2);
								Object credit=bankRecord.get(3);
								Object bParticulars=bankRecord.get(4);
								Object debtId=bankRecord.get(5);
								Object bBal=bankRecord.get(6);
								
								int cancelBankEntryBalance=(int)bankBalance.get(0)-oldCr;
								String cancelBankEntry="INSERT INTO `bank_account_details`(`bid`, `date`, `debit`, `credit`, `particulars`, `debter_id`, `balance`) "
										+ "VALUES ('"+bid+"','"+requiredDate+"',"+oldCr+","+0+",'REVERT_ENTRY_"+date+"','"+debtId+"',"+cancelBankEntryBalance+")";
								int cancelBankEntryStatus=gd.executeCommand(cancelBankEntry);
								if(cancelBankEntryStatus>0)
								{
									System.out.println("bank cancel");
									int revertBankEntryBalance=cancelBankEntryBalance+newCr;
									String revertBankEntry="INSERT INTO `bank_account_details`(`bid`, `date`, `debit`, `credit`, `particulars`, `debter_id`, `balance`) "
											+ "VALUES ('"+bid+"','"+requiredDate+"',"+0+","+newCr+",'"+bParticulars+"','"+debtId+"',"+revertBankEntryBalance+")";
									int revertBankEntryStatus=gd.executeCommand(revertBankEntry);
									if(revertBankEntryStatus>0)
									{
										System.out.println("updated successfully");
										request.setAttribute("status", "Updated & Reverted Successfully in Bank");
										request.setAttribute("tab", "tab2");
										RequestDispatcher rq=request.getRequestDispatcher("jsp/admin/PTCash/ptcash.jsp");
										rq.forward(request, response);
									}
									
								}
								//out.println("bank update");
							}
							else if(mode.equals("CASH"))
							{
								System.out.println("cash enter");
								String getPettyBalance="SELECT balance FROM petty_cash_details ORDER BY petty_cash_details.id DESC LIMIT 1";
								List pettyBalance=gd.getData(getPettyBalance);
								
								String getPettyRecord="SELECT date,debit,credit,debtor_id,balance FROM petty_cash_details WHERE date='"+date+"' AND credit="+oldCr+" AND debtor_id='"+handLoanDebtorId.get(0)+"'";
								System.out.println(getPettyRecord);
								List pettyRecord=gd.getData(getPettyRecord);
								Object pDate=pettyRecord.get(0);
								Object pDebit=pettyRecord.get(1);
								Object pCredit=pettyRecord.get(2);
								Object pDebtId=pettyRecord.get(3);
								Object pBal=pettyRecord.get(4);
								
								
								
								int cancelPettyEntryBalance=(int)pettyBalance.get(0)-oldCr;
								String cancelPettyEntry="INSERT INTO `petty_cash_details`(`date`, `debit`, `credit`, `debtor_id`, `balance`) "
										+ "VALUES ('"+requiredDate+"',"+oldCr+","+0+",'"+revertDebtorId.get(0)+"',"+cancelPettyEntryBalance+")";
								int cancelPettyEntryStatus=gd.executeCommand(cancelPettyEntry);
								if(cancelPettyEntryStatus>0)
								{
									System.out.println("petty Cancel");
									int revertPettyEntryBalance=cancelPettyEntryBalance+newCr;
									String revertPettyEntry="INSERT INTO `petty_cash_details`(`date`, `debit`, `credit`, `debtor_id`, `balance`) "
											+ "VALUES ('"+requiredDate+"',"+0+","+newCr+",'"+pDebtId+"',"+revertPettyEntryBalance+")";
									int revertPettyEntryStatus=gd.executeCommand(revertPettyEntry);
									if(revertPettyEntryStatus>0)
									{
										request.setAttribute("status", "Updated & Reverted Successfully in PettyCash");
										request.setAttribute("tab", "tab2");
										RequestDispatcher rq=request.getRequestDispatcher("/jsp/admin/PTCash/ptcash.jsp");
										rq.forward(request, response);
										
										//response.sendRedirect(request.getContextPath()+"/jsp/admin/PTCash/ptcash.jsp");
										System.out.println("updated Successfully");
									}
								}
								
								
								
								//out.print("petty update");
							}
						}
					}
				
				
			}
			else if(newDr!=0)
			{
				String getHandLoanBalance="SELECT handloan_details.balance FROM handloan_details ORDER BY handloan_details.id DESC LIMIT 1";
				List handLoanBalance=gd.getData(getHandLoanBalance);
				
				int cancelEntryBalance=(int)handLoanBalance.get(0)+oldDr;
				
				String cancelHandLoanEntry="INSERT INTO `handloan_details`(`handloan_id`, `date`, `credit`, `debit`, `mode`, `particulars`, `balance`) "
						+ "VALUES ('"+handLoanId+"','"+requiredDate+"',"+oldDr+","+0+",'"+mode+"','REVERT_ENTRY_"+date+"','"+cancelEntryBalance+"')";
				int cancelHandLoanEntryStatus=gd.executeCommand(cancelHandLoanEntry);
				if(cancelHandLoanEntryStatus>0)
				{
					int revertEntryBalance=cancelEntryBalance-newDr;
					String revertHandLoanEntry="INSERT INTO `handloan_details`(`handloan_id`, `date`, `credit`, `debit`, `mode`, `particulars`, `balance`) "
							+ "VALUES ('"+handLoanId+"','"+requiredDate+"',"+0+","+newDr+",'"+mode+"','"+chqNo+"',"+revertEntryBalance+")";
					int revertHandLoanEntryStaus=gd.executeCommand(revertHandLoanEntry);
					if(revertHandLoanEntryStaus>0)
					{
						System.out.println("handloan reverted");
						if(mode.equals("CHEQUE") || mode.equals("TRANSFER"))
						{
							System.out.println("bank enter");
							String getBankBalance="SELECT bank_account_details.balance FROM bank_account_details ORDER by bank_account_details.id DESC LIMIT 1";
							List bankBalance=gd.getData(getBankBalance);
							
							if(mode.equals("CHEQUE"))
							{
								particulars="HANDLOAN CHEQUE_"+chqNo;
							}
							else if(mode.equals("TRANSFER"))
							{
								particulars="HANDLOAN TRANSFER";
							}
							
							String getBankRecord="SELECT bank_account_details.bid,bank_account_details.date,bank_account_details.debit,bank_account_details.credit,bank_account_details.particulars,bank_account_details.debter_id,bank_account_details.balance FROM bank_account_details WHERE bank_account_details.date='"+date+"' AND bank_account_details.debit="+oldDr+" AND bank_account_details.particulars='"+particulars+"' AND bank_account_details.debter_id='"+handLoanDebtorId.get(0)+"'";
							System.out.println(getBankRecord);
							List bankRecord=gd.getData(getBankRecord);
							Object bid=bankRecord.get(0);
							Object bDate=bankRecord.get(1);
							Object debit=bankRecord.get(2);
							Object credit=bankRecord.get(3);
							Object bParticulars=bankRecord.get(4);
							Object debtId=bankRecord.get(5);
							Object bBal=bankRecord.get(6);
							
							int cancelBankEntryBalance=(int)bankBalance.get(0)+oldDr;
							String cancelBankEntry="INSERT INTO `bank_account_details`(`bid`, `date`, `debit`, `credit`, `particulars`, `debter_id`, `balance`) "
									+ "VALUES ('"+bid+"','"+requiredDate+"',"+0+","+oldDr+",'REVERT_ENTRY_"+date+"','"+debtId+"',"+cancelBankEntryBalance+")";
							int cancelBankEntryStatus=gd.executeCommand(cancelBankEntry);
							if(cancelBankEntryStatus>0)
							{
								System.out.println("bank cancel");
								int revertBankEntryBalance=cancelBankEntryBalance-newDr;
								String revertBankEntry="INSERT INTO `bank_account_details`(`bid`, `date`, `debit`, `credit`, `particulars`, `debter_id`, `balance`) "
										+ "VALUES ('"+bid+"','"+requiredDate+"',"+newDr+","+0+",'"+bParticulars+"','"+debtId+"',"+revertBankEntryBalance+")";
								int revertBankEntryStatus=gd.executeCommand(revertBankEntry);
								if(revertBankEntryStatus>0)
								{
									String updateExp="UPDATE `expenses_master` SET `amount`="+newDr+" WHERE hand_loan_id='"+handloanDetailsId+"'";
									int updateExpStatus=gd.executeCommand(updateExp);
									
									System.out.println("updated successfully");
									request.setAttribute("status", "Updated & Reverted Successfully in Bank");
									request.setAttribute("tab", "tab2");
									RequestDispatcher rq=request.getRequestDispatcher("jsp/admin/PTCash/ptcash.jsp");
									rq.forward(request, response);
								}
							}
								
							
							
							
							
						}
						else if(mode.equals("CASH"))
						{
							System.out.println("cash enter");
							String getPettyBalance="SELECT balance FROM petty_cash_details ORDER BY petty_cash_details.id DESC LIMIT 1";
							List pettyBalance=gd.getData(getPettyBalance);
							
							String getPettyRecord="SELECT date,debit,credit,debtor_id,balance FROM petty_cash_details WHERE date='"+date+"' AND debit="+oldDr+" AND debtor_id='"+handLoanDebtorId.get(0)+"'";
							System.out.println(getPettyRecord);
							List pettyRecord=gd.getData(getPettyRecord);
							Object pDate=pettyRecord.get(0);
							Object pDebit=pettyRecord.get(1);
							Object pCredit=pettyRecord.get(2);
							Object pDebtId=pettyRecord.get(3);
							Object pBal=pettyRecord.get(4);
							
							int cancelPettyEntryBalance=(int)pettyBalance.get(0)+oldDr;
							String cancelPettyEntry="INSERT INTO `petty_cash_details`(`date`, `debit`, `credit`, `debtor_id`, `balance`) "
									+ "VALUES ('"+requiredDate+"',"+0+","+oldDr+",'"+revertDebtorId.get(0)+"',"+cancelPettyEntryBalance+")";
							int cancelPettyEntryStatus=gd.executeCommand(cancelPettyEntry);
							if(cancelPettyEntryStatus>0)
							{
								System.out.println("petty Cancel");
								int revertPettyEntryBalance=cancelPettyEntryBalance-newDr;
								String revertPettyEntry="INSERT INTO `petty_cash_details`(`date`, `debit`, `credit`, `debtor_id`, `balance`) "
										+ "VALUES ('"+requiredDate+"',"+newDr+","+0+",'"+pDebtId+"',"+revertPettyEntryBalance+")";
								int revertPettyEntryStatus=gd.executeCommand(revertPettyEntry);
								if(revertPettyEntryStatus>0)
								{
									String updateExp="UPDATE `expenses_master` SET `amount`="+newDr+" WHERE hand_loan_id='"+handloanDetailsId+"'";
									int updateExpStatus=gd.executeCommand(updateExp);
									
									request.setAttribute("status", "Updated & Reverted Successfully in PettyCash");
									request.setAttribute("tab", "tab2");
									RequestDispatcher rq=request.getRequestDispatcher("/jsp/admin/PTCash/ptcash.jsp");
									rq.forward(request, response);
									
									//response.sendRedirect(request.getContextPath()+"/jsp/admin/PTCash/ptcash.jsp");
									System.out.println("updated Successfully");
								}
								
							}
							
						}
						
					}
					
					
					
				}
				
				
				
				
				//out.println("Debit");
			}
			
			//out.println("working");
		}
		
		if(request.getParameter("forUpdate")!=null)
		{
			String id=request.getParameter("forUpdate");
			String query="SELECT handloan_details.date,handloan_master.alias_name,handloan_details.debit,handloan_details.credit,handloan_details.mode,handloan_details.particulars,handloan_details.balance,handloan_details.handloan_id FROM handloan_master,handloan_details WHERE handloan_details.handloan_id=handloan_master.id AND handloan_details.id="+id+"";
			List getUpdateData=gd.getData(query);
			Iterator itr=getUpdateData.iterator();
			while(itr.hasNext())
			{
				Object date=itr.next();
				Object alias=itr.next();
				Object debit=itr.next();
				Object credit=itr.next();
				Object mode=itr.next();
				Object particulars=itr.next();
				Object balance=itr.next();
				Object handLoan_id=itr.next();
				
				out.println(date+","+alias+","+debit+","+credit+","+mode+","+particulars+","+balance+","+handLoan_id+","+id);
			}
			
		}
		
		if(request.getParameter("loanDetails")!=null)
		{
			String alias=request.getParameter("loanDetails");
			String query="SELECT handloan_details.date,handloan_details.debit,handloan_details.credit,handloan_details.mode,handloan_details.particulars,handloan_details.balance FROM handloan_master,handloan_details WHERE handloan_details.handloan_id=handloan_master.id AND handloan_master.alias_name='"+alias+"'";
			List getDetails=gd.getData(query);
			Iterator itr=getDetails.iterator();
			while(itr.hasNext())
			{
				Object date=itr.next();
				Object debit=itr.next();
				Object credit=itr.next();
				Object mode=itr.next();
				Object particular=itr.next();
				Object balance=itr.next();
				
				out.print(date+","+debit+","+credit+","+mode+","+particular+","+balance+",");
			}
			
		}
		
		if(request.getParameter("findHandLoanName")!=null)
		{
			String hName=request.getParameter("findHandLoanName");
			String query="SELECT alias_name FROM handloan_master";
			List getHandLoanAlias=gd.getData(query);
			Iterator itr=getHandLoanAlias.iterator();
			while(itr.hasNext())
			{
				out.println("<option>"+itr.next()+"</option>");
			}
			
		}
		
		
		if(request.getParameter("getBankTableData")!=null)
		{
			String date=request.getParameter("getBankTableData");
			String query="SELECT bank_account_details.id,account_details.acc_aliasname,bank_account_details.debit,bank_account_details.credit,bank_account_details.particulars,debtor_master.type,bank_account_details.balance FROM bank_account_details,account_details,debtor_master WHERE bank_account_details.bid=account_details.acc_id AND bank_account_details.debter_id=debtor_master.id AND bank_account_details.date='"+date+"'";
			//out.println("working");
			List getBankDetails=gd.getData(query);
			Iterator itr=getBankDetails.iterator();
			while(itr.hasNext())
			{
				itr.next();
				Object bankName=itr.next();
				Object debit=itr.next();
				Object credit=itr.next();
				Object particulars=itr.next();
				Object type=itr.next();
				Object balance=itr.next();
				
				out.print(bankName+","+debit+","+credit+","+particulars+","+type+","+balance+",");
			}
		}
		if(request.getParameter("getTableData")!=null)
		{
			String date=request.getParameter("getTableData");
			//out.println("working");
			String query="SELECT petty_cash_details.id,petty_cash_details.debit,petty_cash_details.credit,debtor_master.type,petty_cash_details.balance FROM petty_cash_details,debtor_master WHERE petty_cash_details.debtor_id=debtor_master.id AND petty_cash_details.date='"+date+"'";
			List getPettyDetails=gd.getData(query);
			Iterator itr=getPettyDetails.iterator();
			while(itr.hasNext())
			{
				itr.next();
				Object debit=itr.next();
				Object credit=itr.next();
				Object type=itr.next();
				Object balance=itr.next();
				
				out.print(debit+","+credit+","+type+","+balance+",");
			}
		}
		if(request.getParameter("insertPetty")!=null)
		{
			String pettyDate=request.getParameter("date");
			String previousBalance=request.getParameter("previous_balance");
			String bankName=request.getParameter("bank_name");
			int count=Integer.parseInt(request.getParameter("count"));
			int bankCount=Integer.parseInt(request.getParameter("bankCount"));
			//int cash[]=new int[30];
			ArrayList<Integer> cash=new ArrayList<>();
			int updatedPettyBalance=0;
			int amt=0;
			int updateAmt=0;
			List debtorId=null;
			for(int i=0;i<=count;i++)
			{
				if(!request.getParameter("hlName,"+i).isEmpty())
				{
					String handLoanName=request.getParameter("hlName,"+i);
					String add="HL_";
					String alias=add+handLoanName;
					
					String handLoanDetails="SELECT handloan_details.handloan_id,handloan_details.balance FROM handloan_details,handloan_master WHERE handloan_details.handloan_id=handloan_master.id AND handloan_master.alias_name='"+alias+"' ORDER BY handloan_details.id DESC LIMIT 1";
					//System.out.println("hiiii"+handLoanDetails);
					List getDetails=gd.getData(handLoanDetails);
					
					if(!getDetails.isEmpty())
					{
						int addAmt=(int)getDetails.get(1);
						amt=Integer.parseInt(request.getParameter("hlAmt,"+i));
						cash.add(amt);
						updateAmt=addAmt+amt;
						
						String insertHandLoanDetails="INSERT INTO `handloan_details`(`handloan_id`, `date`, `credit`, `debit`, `mode`, `particulars`, `balance`) "
								+ "VALUES ("+getDetails.get(0)+",'"+pettyDate+"',"+amt+","+0+",'CASH','',"+updateAmt+")";
						int insertHandLoanStatus=gd.executeCommand(insertHandLoanDetails);
						if(insertHandLoanStatus>0)
						{
							System.out.println("inserted credit amt and balance in handloanDetails");
						}
						
						String getDebtorId="SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type='"+alias+"'";
						debtorId=gd.getData(getDebtorId);
						
					}
					else
					{
						amt=Integer.parseInt(request.getParameter("hlAmt,"+i));
						cash.add(amt);
						updateAmt=amt;
						
						String getHannLoanId="SELECT id,alias_name FROM handloan_master ORDER BY id DESC LIMIT 1";
						List handLoanId=gd.getData(getHannLoanId);
						
						String insertHandLoanDetails="INSERT INTO `handloan_details`(`handloan_id`, `date`, `credit`, `debit`, `mode`, `particulars`, `balance`) "
								+ "VALUES ("+handLoanId.get(0)+",'"+pettyDate+"',"+amt+","+0+",'CASH','',"+updateAmt+")";
						int insertHandLoanStatus=gd.executeCommand(insertHandLoanDetails);
						if(insertHandLoanStatus>0)
						{
							System.out.println("inserted credit amt and balance in handloanDetails");
						}
						
						String getDebtorId="SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type='"+handLoanId.get(1)+"'";
						debtorId=gd.getData(getDebtorId);
						
					}
					//out.println("handloan new amt : "+updateAmt+"<br>");
					
					String getLastPettyBalance="SELECT petty_cash_details.id,petty_cash_details.balance FROM petty_cash_details ORDER BY petty_cash_details.id DESC LIMIT 1";
					List lastPettyBalance=gd.getData(getLastPettyBalance);
					
					if(!lastPettyBalance.isEmpty())
					{
						updatedPettyBalance=amt+(int)lastPettyBalance.get(1);
					}
					else
					{
						updatedPettyBalance=amt+0;
					}
					
					
					String insertPetty="INSERT INTO `petty_cash_details`(`date`, `debit`, `credit`, `debtor_id`, `balance`) VALUES ('"+pettyDate+"',"+0+","+amt+","+debtorId.get(0)+","+updatedPettyBalance+")";
					int insertStatus=gd.executeCommand(insertPetty);
					if(insertStatus>0)
					{
						System.out.println("inserted in pettyCash for "+i+" time");
					}
				}
				else
				{
					System.out.println("nothing update in handloan");
					
					//out.print("nothing update in handloan");
				}
				
				
				//out.println("petty balance new"+updatedPettyBalance+"<br>");
				
				
					
				//out.println("Alias : "+alias+" insert amount : "+amt+" new amt : "+updateAmt);
			}
			for(int j=0;j<=bankCount;j++)
			{
				if(!request.getParameter("bName,"+j).isEmpty())
				{
					String bankAlias=request.getParameter("bName,"+j);
					
					String bankDetailsQuery="SELECT bank_account_details.bid,bank_account_details.balance FROM bank_account_details,account_details WHERE bank_account_details.bid=account_details.acc_id AND account_details.acc_aliasname='"+bankAlias+"' ORDER BY bank_account_details.id DESC LIMIT 1";
					List getBankDetails=gd.getData(bankDetailsQuery);
					
					int bankBalance=(int)getBankDetails.get(1);
					int withdrawlAmt=Integer.parseInt(request.getParameter("bAmt,"+j));
					
					if(bankBalance<withdrawlAmt)
					{

						System.out.println("Insufficient balance in your "+bankAlias+" Bank");
						request.setAttribute("status", "Insufficient balance in your "+bankAlias+" Bank");
						RequestDispatcher rq=request.getRequestDispatcher("jsp/admin/PTCash/ptcash.jsp");
						rq.forward(request, response);
					}
					else
					{
						cash.add(withdrawlAmt);
						String getDebtorId="SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type='"+bankAlias+"'";
						debtorId=gd.getData(getDebtorId);
						
						int newBankBalance=bankBalance-withdrawlAmt;
						String insertBankdetails="INSERT INTO `bank_account_details`(`bid`, `date`, `debit`, `credit`, `particulars`, `debter_id`, `balance`) "
								+ "VALUES ("+getBankDetails.get(0)+",'"+pettyDate+"',"+withdrawlAmt+","+0+",'ATM WITHDRAWL',"+debtorId.get(0)+","+newBankBalance+")";
						System.out.println(insertBankdetails);
						int bankDetailsStatus=gd.executeCommand(insertBankdetails);
						if(bankDetailsStatus>0)
						{
							System.out.println("inserted in bank account details");
						}
						else
						{
							System.out.println("bank error");
						}
						
						String getLastPettyBalance="SELECT petty_cash_details.id,petty_cash_details.balance FROM petty_cash_details ORDER BY petty_cash_details.id DESC LIMIT 1";
						List lastPettyBalance=gd.getData(getLastPettyBalance);
						
						if(!lastPettyBalance.isEmpty())
						{
							updatedPettyBalance=withdrawlAmt+(int)lastPettyBalance.get(1);
						}
						else
						{
							updatedPettyBalance=withdrawlAmt+0;
						}
						
						
						String insertPetty="INSERT INTO `petty_cash_details`(`date`, `debit`, `credit`, `debtor_id`, `balance`) VALUES ('"+pettyDate+"',"+0+","+withdrawlAmt+","+debtorId.get(0)+","+updatedPettyBalance+")";
						int insertStatus=gd.executeCommand(insertPetty);
						if(insertStatus>0)
						{
							System.out.println("inserted in pettyCash for "+j+" time");
						}
						else
						{
							System.out.println("petty error");
						}
					
					}
				}
				else
				{
					System.out.println("nothing update in bank");
					//out.print("nothing update in handloan");
				}
				
			}
			
			
			int sum=PTCash.sum(cash);
			String getLastPettyBalance="SELECT petty_cash_details.id,petty_cash_details.balance FROM petty_cash_details ORDER BY petty_cash_details.id DESC LIMIT 1";
			List lastPettyBalance=gd.getData(getLastPettyBalance);
			request.setAttribute("tab", "tab1");
			request.setAttribute("status", "Rs."+sum+" Petty Cash Added. Total Petty Cash Balance is Rs."+lastPettyBalance.get(1));
			RequestDispatcher rq=request.getRequestDispatcher("jsp/admin/PTCash/ptcash.jsp");
			rq.forward(request, response);
			
			
		}
		
			
		
		if(request.getParameter("handloanpagebtn")!=null)
		{
			int status1=0;		
			String name=request.getParameter("namep");
			String newName=request.getParameter("namepnew");
			
			String mobileNo=request.getParameter("mobilenop");	
			String aliasname="HL_"+name.replace(" ", "_")+"_"+mobileNo;
			String newAlias="HL_"+newName.replace(" ", "_")+"_"+mobileNo;
			String date=request.getParameter("datep");				
			String amount=request.getParameter("paidAmtp");				
			String paymode=request.getParameter("payModep");
			String chequeNo=request.getParameter("chequeNop");
			String bank_name=request.getParameter("bNamep");
			String stus=request.getParameter("status");
			
			//out.println("working"+bank_name);
			
			//System.out.println("inside btn");
			
			
			if(stus.equals("New"))
			{
				System.out.println("inside new");
				String HL_MasterDetails="INSERT INTO handloan_master(name,mob_no,alias_name) VALUES('"+newName+"','"+mobileNo+"','"+newAlias+"')";
				status1=gd.executeCommand(HL_MasterDetails);
				
				String debtor_master="insert into `debtor_master`(`type`) values('"+newAlias+"')";
				gd.executeCommand(debtor_master);
				
				if(paymode.equals("CHEQUE"))
				{
					System.out.println("inside new cheque");
					String insertHandLoanDetails="INSERT INTO `handloan_details`(`handloan_id`, `date`, `credit`, `debit`, `mode`, `particulars`, `balance`) VALUES ((SELECT MAX(id) FROM handloan_master),'"+date+"',"+amount+","+0+",'CHEQUE','"+chequeNo+"',"+amount+")";
					int insertStatus=gd.executeCommand(insertHandLoanDetails);
					if(insertStatus>0)
					{
						System.out.println("inside new cheque sucess");
						String getBankBalance="SELECT bank_account_details.bid,bank_account_details.balance FROM bank_account_details,account_details WHERE bank_account_details.bid=account_details.acc_id AND account_details.acc_aliasname='"+bank_name+"' ORDER BY bank_account_details.id DESC LIMIT 1";
						List bankBalance=gd.getData(getBankBalance);
						int newBankBalance=Integer.parseInt(amount)+(int)bankBalance.get(1);
						int debtorId=rd.getDebtorId(newAlias);
						
						String insertBankDetails="INSERT INTO `bank_account_details`(`bid`, `date`, `debit`, `credit`, `particulars`, `debter_id`, `balance`) "
								+ "VALUES ("+bankBalance.get(0)+",'"+date+"','0',"+amount+",'HANDLOAN CHEQUE_"+chequeNo+"',"+debtorId+","+newBankBalance+")";
						int bankStatus=gd.executeCommand(insertBankDetails);
						if(bankStatus>0)
						{
							System.out.println(amount+" New Cheque Inserted "+newBankBalance);
							request.setAttribute("status", "Rs."+amount+" HandLoan Added in Bank. Total Bank Balance of "+bank_name+" is Rs. "+newBankBalance);
							request.setAttribute("tab", "tab2");
							
							RequestDispatcher rq=request.getRequestDispatcher("jsp/admin/PTCash/ptcash.jsp");
							rq.forward(request, response);
						}
						
					}
				}
				else if(paymode.equals("TRANSFER"))
				{
					System.out.println("inside new transfer");
					String insertHandLoanDetails="INSERT INTO `handloan_details`(`handloan_id`, `date`, `credit`, `debit`, `mode`, `particulars`, `balance`) VALUES ((SELECT MAX(id) FROM handloan_master),'"+date+"',"+amount+","+0+",'TRANSFER','-',"+amount+")";
					int insertStatus=gd.executeCommand(insertHandLoanDetails);
					if(insertStatus>0)
					{
						System.out.println("inside new transfer success");
						String getBankBalance="SELECT bank_account_details.bid,bank_account_details.balance FROM bank_account_details,account_details WHERE bank_account_details.bid=account_details.acc_id AND account_details.acc_aliasname='"+bank_name+"' ORDER BY bank_account_details.id DESC LIMIT 1";
						System.out.println(getBankBalance);
						List bankBalance=gd.getData(getBankBalance);
						int newBankBalance=Integer.parseInt(amount)+(int)bankBalance.get(1);
						int debtorId=rd.getDebtorId(newAlias);
						
						String insertBankDetails="INSERT INTO `bank_account_details`(`bid`, `date`, `debit`, `credit`, `particulars`, `debter_id`, `balance`) "
								+ "VALUES ("+bankBalance.get(0)+",'"+date+"',"+0+","+amount+",'HANDLOAN TRANSFER',"+debtorId+","+newBankBalance+")";
						int bankStatus=gd.executeCommand(insertBankDetails);
						if(bankStatus>0)
						{
							System.out.println(amount+" New Transfer Inserted "+newBankBalance);
							request.setAttribute("status", "Rs."+amount+" HandLoan Transfer in Bank. Total Bank Balance of "+bank_name+" is Rs. "+newBankBalance);
							request.setAttribute("tab", "tab2");
							
							RequestDispatcher rq=request.getRequestDispatcher("jsp/admin/PTCash/ptcash.jsp");
							rq.forward(request, response);
						}
						
					}
					
				}
				
			}
			else if(stus.equals("Old"))
			{
				String getHandloadDetailsBalance="SELECT handloan_details.handloan_id,handloan_details.balance FROM handloan_details,handloan_master WHERE handloan_details.handloan_id=handloan_master.id AND handloan_master.alias_name='"+aliasname+"' ORDER BY handloan_details.id DESC LIMIT 1";
				List handLoanDetailsBalance=gd.getData(getHandloadDetailsBalance);
				int newHandLoanBalance=Integer.parseInt(amount)+(int)handLoanDetailsBalance.get(1);
				
				if(paymode.equals("CHEQUE"))
				{
					String insertHandLoanDetails="INSERT INTO `handloan_details`(`handloan_id`, `date`, `credit`, `debit`, `mode`, `particulars`, `balance`) VALUES ("+handLoanDetailsBalance.get(0)+",'"+date+"',"+amount+","+0+",'CHEQUE','"+chequeNo+"',"+newHandLoanBalance+")";
					int insertStatus=gd.executeCommand(insertHandLoanDetails);
					if(insertStatus>0)
					{
						String getBankBalance="SELECT bank_account_details.bid,bank_account_details.balance FROM bank_account_details,account_details WHERE bank_account_details.bid=account_details.acc_id AND account_details.acc_aliasname='"+bank_name+"' ORDER BY bank_account_details.id DESC LIMIT 1";
						List bankBalance=gd.getData(getBankBalance);
						int newBankBalance=Integer.parseInt(amount)+(int)bankBalance.get(1);
						int debtorId=rd.getDebtorId(aliasname);
						
						String insertBankDetails="INSERT INTO `bank_account_details`(`bid`, `date`, `debit`, `credit`, `particulars`, `debter_id`, `balance`) "
								+ "VALUES ("+bankBalance.get(0)+",'"+date+"','0',"+amount+",'HANDLOAN CHEQUE_"+chequeNo+"',"+debtorId+","+newBankBalance+")";
						int bankStatus=gd.executeCommand(insertBankDetails);
						if(bankStatus>0)
						{
							System.out.println(newHandLoanBalance+" Old Cheque Inserted "+newBankBalance);
							
							request.setAttribute("status", "Rs."+amount+" HandLoan Added in Bank. Total Bank Balance of "+bank_name+" is Rs. "+newBankBalance);
							request.setAttribute("tab", "tab2");
							
							RequestDispatcher rq=request.getRequestDispatcher("jsp/admin/PTCash/ptcash.jsp");
							rq.forward(request, response);
						}
						
					}
					
				}
				else if(paymode.equals("TRANSFER"))
				{
					String insertHandLoanDetails="INSERT INTO `handloan_details`(`handloan_id`, `date`, `credit`, `debit`, `mode`, `particulars`, `balance`) VALUES ("+handLoanDetailsBalance.get(0)+",'"+date+"',"+amount+","+0+",'TRANSFER','',"+newHandLoanBalance+")";
					int insertStatus=gd.executeCommand(insertHandLoanDetails);
					if(insertStatus>0)
					{
						String getBankBalance="SELECT bank_account_details.bid,bank_account_details.balance FROM bank_account_details,account_details WHERE bank_account_details.bid=account_details.acc_id AND account_details.acc_aliasname='"+bank_name+"' ORDER BY bank_account_details.id DESC LIMIT 1";
						List bankBalance=gd.getData(getBankBalance);
						int newBankBalance=Integer.parseInt(amount)+(int)bankBalance.get(1);
						int debtorId=rd.getDebtorId(aliasname);
						
						String insertBankDetails="INSERT INTO `bank_account_details`(`bid`, `date`, `debit`, `credit`, `particulars`, `debter_id`, `balance`) "
								+ "VALUES ("+bankBalance.get(0)+",'"+date+"','0',"+amount+",'HANDLOAN TRANSFER',"+debtorId+","+newBankBalance+")";
						int bankStatus=gd.executeCommand(insertBankDetails);
						if(bankStatus>0)
						{
							System.out.println(newHandLoanBalance+" Old Transfer Inserted "+newBankBalance);
							request.setAttribute("status", "Rs."+amount+" HandLoan Transfer in Bank. Total Bank Balance of "+bank_name+" is Rs. "+newBankBalance);
							request.setAttribute("tab", "tab2");
							
							RequestDispatcher rq=request.getRequestDispatcher("jsp/admin/PTCash/ptcash.jsp");
							rq.forward(request, response);
						}
					}
					
				}
				
			}
			
			
			
		}
		
		if(request.getParameter("details")!=null)
		{
			String name=request.getParameter("details");
			String getDetails="SELECT mob_no FROM handloan_master WHERE name='"+name+"'";
			List details=gd.getData(getDetails);
			out.print(details.get(0));
		}
			
		if(request.getParameter("findHanLoanName")!=null)
		{
			String name=request.getParameter("findHanLoanName");
			String query="SELECT id, name FROM handloan_master";
			List getHandloadName=gd.getData(query);
			Iterator itr=getHandloadName.iterator();
			while(itr.hasNext())
			{
				itr.next();
				out.println("<option>"+itr.next()+"</option>");
			}
			
		}
			
		if(request.getParameter("handloanbtn")!=null)
		{
			
			//Handloan master
			int status1=0;		
			String name=request.getParameter("name");				
			String mobileNo=request.getParameter("mobileno");	
			String aliasname="HL_"+name.replace(" ", "_")+"_"+mobileNo;				
			String date=request.getParameter("date");				
			String amount=request.getParameter("paidAmt");				
			String paymode=request.getParameter("payMode");
			String chequeNo=request.getParameter("chequeNo");
			String bank_name=request.getParameter("bankInfo");
			int updatedPettyBalance=0;
			
			System.out.println("alias : "+aliasname);
			
			String HL_MasterDetails="INSERT INTO handloan_master(name,mob_no,alias_name) VALUES('"+name+"','"+mobileNo+"','"+aliasname+"')";
			status=gd.executeCommand(HL_MasterDetails);
			
			//debtor master 
			
			String debtor_master="insert into `debtor_master`(`type`) values('"+aliasname+"')";
			gd.executeCommand(debtor_master);
			
			String maxid="select MAX(id) from handloan_master";
			String handloan_id=gd.getData(maxid).get(0).toString();
			
					
			if(paymode.equals("CASH"))
			{
				String insert_query1="insert into `handloan_details`(`handloan_id`,`date`,`debit`,`credit`,`mode`,`balance`) values('"+handloan_id+"','"+date+"',"+0+",'"+amount+"','"+paymode+"','"+amount+"')";
				System.out.println("cash:"+insert_query1);
				status1=gd.executeCommand(insert_query1);
				
				
				String getLastPettyBalance="SELECT petty_cash_details.id,petty_cash_details.balance FROM petty_cash_details ORDER BY petty_cash_details.id DESC LIMIT 1";
				List lastPettyBalance=gd.getData(getLastPettyBalance);
				
				if(!lastPettyBalance.isEmpty())
				{
					updatedPettyBalance=Integer.parseInt(amount)+(int)lastPettyBalance.get(1);
				}
				else
				{
					updatedPettyBalance=Integer.parseInt(amount)+0;
				}
				
				String getDebtorId="SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type='"+aliasname+"'";
				List debtorId=gd.getData(getDebtorId);
				
				String insertPetty="INSERT INTO `petty_cash_details`(`date`, `debit`, `credit`, `debtor_id`, `balance`) VALUES ('"+date+"',"+0+",'"+amount+"',"+debtorId.get(0)+","+updatedPettyBalance+")";
				int insertStatus=gd.executeCommand(insertPetty);
				if(insertStatus>0)
				{
					
					System.out.println("inserted in pettyCash");
				}
				
				
			}
			
		
			
			if(status1>0)
			{
				System.out.println("inserted Successfully");
				//request.setAttribute("hName", aliasname);
				//request.setAttribute("amt", amount);
				request.setAttribute("status", "Handloan Details and Petty Cash Added");
			}
			else
			{
				System.out.println("plz Try Again");
				request.setAttribute("status", "Handloan Insertion Fail");
			}
			
			RequestDispatcher rq=request.getRequestDispatcher("jsp/admin/PTCash/ptcash.jsp");
			rq.forward(request, response);
			
		}
		
		if(request.getParameter("findName")!=null)
		{
			String name=request.getParameter("findName");
			String query="SELECT handloan_master.id,handloan_master.alias_name FROM handloan_master";
			
			List getName=gd.getData(query);
			Iterator itr=getName.iterator();
			while(itr.hasNext())
			{
				itr.next();
				out.print("<option>"+itr.next().toString().replace("HL_", "")+"</option>");
			}	
			
		}
		if(request.getParameter("findBankName")!=null)
		{
			String bankName=request.getParameter("findBankName");
			String query="SELECT account_details.acc_id,account_details.acc_aliasname FROM account_details";
			List getBankDetails=gd.getData(query);
			Iterator itr=getBankDetails.iterator();
			while(itr.hasNext())
			{
				itr.next();
				out.print("<option>"+itr.next()+"</option>");
			}
		}
		
		
		if(request.getParameter("eName")!=null)
		{
			String name=request.getParameter("eName");
			String add="HL_";
			String alias=add+name;
			String query="SELECT handloan_details.credit FROM handloan_details,handloan_master WHERE handloan_master.id=handloan_details.handloan_id AND handloan_master.alias_name='"+alias+"'";
			
			List getAmt=gd.getData(query);
			out.print(getAmt.get(0));
		}
		
	}

}
