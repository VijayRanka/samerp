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
			String bId=request.getParameter("modalId");
			String bName=request.getParameter("modalbName");
			String branch=request.getParameter("modalBranch");
			String accNo=request.getParameter("modalAccNo");
			String opBalance=request.getParameter("modalBalance");
			String alias=request.getParameter("modalAlias");
			int status=0;
			GenericDAO gd= new GenericDAO();
			
			String query="UPDATE `account_details` SET `bank_name`='"+bName+"',`branch`='"+branch+"',`acc_no`='"+accNo+"',"
					+ "`opening_balance`='"+opBalance+"',`acc_aliasname`='"+alias+"' WHERE acc_id="+bId+"";
			status=gd.executeCommand(query);
			if(status==1)
			{
				System.out.println("successfully Updated in suppliers material");
				request.setAttribute("status", "Updated Successfully");
				RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addAccountDetails.jsp");
				rd.forward(request, response);
			}
			
		}
		
		
		
		
		if(request.getParameter("insertAccDetails")!=null)
		{
			GenericDAO gd=new GenericDAO();
			AddAccountDetails aad=new AddAccountDetails();
			//out.print("hello");
			
			String bname=request.getParameter("bankName");
			String branch=request.getParameter("branch");
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
					+ "`branch`, `acc_no`,`acc_aliasname`) VALUES ('"+bname+"','"+branch+"','"+accNo+"','"+alias+"')";
			status=gd.executeCommand(insertQuery);
			if(status!=0)
			{
				String insertQuery1="INSERT INTO `bank_account_details`(`bid`, `date`, `particulars`, `balance`) VALUES ((SELECT MAX(account_details.acc_id) FROM account_details),'"+requiredDate+"','Opening Balance',"+openingBalance+")";
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
		
		if(request.getParameter("deleteId")!=null)
		{
			GenericDAO gd=new GenericDAO();
			int delstatus=0;
			String deleteQuery="Delete from `account_details` where acc_id="+request.getParameter("deleteId");
			delstatus=gd.executeCommand(deleteQuery);
			if(delstatus!=0)
			{
				System.out.println("successfully deleted in suppliers material");
				request.setAttribute("status", "Deleted Successfully");
				RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addAccountDetails.jsp");
				rd.forward(request, response);
			}
			
		}
		
	}

}
