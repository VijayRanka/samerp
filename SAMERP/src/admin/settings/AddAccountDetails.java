package admin.settings;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;
import utility.RequireData;

//@WebServlet("/AddAccountDetails")
public class AddAccountDetails extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doPost(request, response);
	}

	public String getFirstLetters(String text)
	{
	  String firstLetters = "";
	  text = text.replaceAll("[.,]", ""); // Replace dots, etc (optional)
	  for(String s : text.split(" "))
	  {
	    firstLetters += s.charAt(0);
	  }
	  return firstLetters;
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		GenericDAO gd= new GenericDAO();
		String acc_id=request.getParameter("delete");
		
		
		//for reporting
		if(request.getParameter("getDateData")!=null)
		{
			String fromDate=request.getParameter("fromDate");
			String toDate=request.getParameter("toDate");
			String indName=request.getParameter("individualName");
			
			if(indName!=null)
			{
				String getBankData="SELECT bank_account_details.date,bank_account_details.debit,bank_account_details.credit,bank_account_details.particulars,debtor_master.type,bank_account_details.balance FROM bank_account_details,debtor_master,account_details WHERE bank_account_details.bid=account_details.acc_id AND bank_account_details.debter_id=debtor_master.id AND bank_account_details.date BETWEEN '"+fromDate+"' and '"+toDate+"' AND account_details.acc_aliasname='"+indName+"' order by bank_account_details.id";
				List bankData=gd.getData(getBankData);
				Iterator itr=bankData.iterator();
				while(itr.hasNext())
				{
					Object date=itr.next();
					Object debit=itr.next();
					Object credit=itr.next();
					Object particulars=itr.next();
					Object type=itr.next();
					Object balance=itr.next();
					
					out.print(date+","+debit+","+credit+","+particulars+","+type+","+balance+",");
					
				}
			}
			else
			{
				String getBankData="SELECT bank_account_details.date,account_details.acc_aliasname,bank_account_details.debit,bank_account_details.credit,bank_account_details.particulars,debtor_master.type,bank_account_details.balance FROM bank_account_details,debtor_master,account_details WHERE bank_account_details.bid=account_details.acc_id AND bank_account_details.debter_id=debtor_master.id AND bank_account_details.date BETWEEN '"+fromDate+"' and '"+toDate+"' order by bank_account_details.id";
				List bankData=gd.getData(getBankData);
				Iterator itr=bankData.iterator();
				while(itr.hasNext())
				{
					Object date=itr.next();
					Object bName=itr.next();
					Object debit=itr.next();
					Object credit=itr.next();
					Object particulars=itr.next();
					Object type=itr.next();
					Object balance=itr.next();
					
					out.print(date+","+bName+","+debit+","+credit+","+particulars+","+type+","+balance+",");
					
				}
			}
			
			
		}
		
		if(request.getParameter("findNameByReport")!=null)
		{
			String getBankAlias="SELECT acc_aliasname FROM account_details";
			List bankAlias=gd.getData(getBankAlias);
			Iterator itr=bankAlias.iterator();
			while(itr.hasNext())
			{
				out.print("<option>"+itr.next()+"</option>");
			}
		}
		
		
		
		if(request.getParameter("updateid")!=null)
		{
			String accId=request.getParameter("updateid");
			RequireData rd=new RequireData();
			List demoList=rd.getAccountRowData(accId);
			Iterator itr=demoList.iterator();
			while(itr.hasNext())
					{
						out.print(itr.next()+",");
					}
			
		}
		if(request.getParameter("Update")!=null)
		{
			AddAccountDetails aad=new AddAccountDetails();
			
			String bId=request.getParameter("modalId");
			String bName=request.getParameter("modalbName");
			String branch=request.getParameter("modalBranch");
			String accHolderName=request.getParameter("modalAccHolderName");
			String accNo=request.getParameter("modalAccNo");
			String opBalance=request.getParameter("modalBalance");
			String alias=request.getParameter("modalAlias");
			String oldAlias=request.getParameter("oldAlias");
			int status=0;
			
			
			String firstLetter=aad.getFirstLetters(bName);
			String space="_";
			String finalAlias=firstLetter+space+accNo;
			
			String updateAccountDetails="UPDATE `account_details` SET `bank_name`='"+bName+"',`branch`='"+branch+"',`acc_holder_name`='"+accHolderName+"',`acc_no`='"+accNo+"'"
					+ ",`acc_aliasname`='"+finalAlias+"' WHERE acc_id="+bId+"";
			status=gd.executeCommand(updateAccountDetails);
			if(status==1)
			{
				String updateDebtorMaster="UPDATE `debtor_master` SET `type`='"+finalAlias+"' WHERE type='"+oldAlias+"'";
				int status1=gd.executeCommand(updateDebtorMaster);
				if(status1>0)
				{
					System.out.println("updated in debtor");
				}
				System.out.println("successfully Updated in suppliers material");
				request.setAttribute("status", "Updated Successfully");
				RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addAccountDetails.jsp");
				rd.forward(request, response);
			}
			
		}
		
		if(request.getParameter("insertAccDetails")!=null)
		{
			
			AddAccountDetails aad=new AddAccountDetails();
			//out.print("hello");
			
			String bname=request.getParameter("bankName");
			String branch=request.getParameter("branch");
			String accHolderName=request.getParameter("accountHolderName");
			String accNo=request.getParameter("accNo");
			int openingBalance=Integer.parseInt(request.getParameter("openingBalance"));
			int status=0;
			
			String firstLetter=aad.getFirstLetters(bname);
			String space="_";
			String alias=firstLetter+space+accNo;
			
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			String requiredDate = df.format(new Date()).toString();
			
			//out.println(alias);
			
			/*out.println(bname);
			out.println(branch);
			
			out.println(accNo);
			out.println(openingBalance);*/
			
			String insertQuery="INSERT INTO `account_details`(`bank_name`, "
					+ "`branch`,`acc_holder_name`,`acc_no`,`acc_aliasname`) VALUES ('"+bname+"','"+branch+"','"+accHolderName+"','"+accNo+"','"+alias+"')";
			status=gd.executeCommand(insertQuery);
			if(status!=0)
			{
				String insertQuery2="INSERT INTO `debtor_master`(`type`) VALUES ('"+alias+"')";
				int st1=gd.executeCommand(insertQuery2);
				if(st1>0)
				{
					System.out.println("alias name inserted in debtor master");
				}
				
				String insertQuery1="INSERT INTO `bank_account_details`(`bid`, `date`, `particulars`,`debter_id`, `balance`) VALUES ((SELECT MAX(account_details.acc_id) FROM account_details),'"+requiredDate+"','Opening Balance',(SELECT MAX(debtor_master.id) FROM debtor_master),"+openingBalance+")";
				int st=gd.executeCommand(insertQuery1);
				if(st!=0)
				{
					System.out.println("successfully inserted in Bank");
					request.setAttribute("status", "Inserted Successfully");
					RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addAccountDetails.jsp");
					rd.forward(request, response);
				}
				
			}
		
		}
		
		if(acc_id==null)
		{
			int i;			
			String deleteQuery="DELETE FROM account_details WHERE account_details.acc_id='"+acc_id+"'";
			i=gd.executeCommand(deleteQuery);
			if(i==1)
			{
				System.out.println("successfully deleted in suppliers material");
				
			}			
		}
		else
		{
			request.setAttribute("error", "3");
			RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addAccountDetails.jsp");
			rd.forward(request, response);
		}
		
	}

}
