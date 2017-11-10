package admin.pettycash;

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

//@WebServlet("/PTCash")
public class PTCash extends HttpServlet {
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			response.setContentType("text/html");
			PrintWriter out=response.getWriter();
			GenericDAO gd=new GenericDAO();
						
			int status=0;
			
			
			if(request.getParameter("insertPetty")!=null)
			{
				String pettyDate=request.getParameter("date");
				String previousBalance=request.getParameter("previous_balance");
				//String handLoanName=request.getParameter("hlName");
				String bankName=request.getParameter("bank_name");
				int atmCash=Integer.parseInt(request.getParameter("amount"));
				//String payReceived=request.getParameter("pay_received");
				//String tAmt=request.getParameter("total");
				int count=Integer.parseInt(request.getParameter("count"));
				//int arrAmt[] = new int[count];
				ArrayList<Integer> arrAmt=new ArrayList<>();
				int sum=0;
				
				for(int i=0;i<=count;i++)
				{
					String handLoanName=request.getParameter("hlName,"+i);
					String add="HL_";
					String alias=add+handLoanName;
					
					String handLoanDetails="SELECT handloan_details.id,handloan_details.credit FROM handloan_details,handloan_master WHERE handloan_details.handloan_id=handloan_master.id AND handloan_master.alias_name='"+alias+"'";
					//List getDetails=gd.getData(handLoanDetails);
					 
					//int addAmt=(int)getDetails.get(1);
					int amt=Integer.parseInt(request.getParameter("hlAmt,"+i));
					arrAmt.add(amt);
				
					//int updateAmt=addAmt+amt;
					
					/*String updateHandLoanDetails="UPDATE `handloan_details` SET handloan_details.credit="+updateAmt+" WHERE handloan_details.id="+getDetails.get(0)+"";
					int updateStatus=gd.executeCommand(updateHandLoanDetails);
					if(updateStatus>0)
					{
						System.out.println("updated credit amt in handloanDetails");
					}*/
						
					//out.println("Alias : "+alias+" insert amount : "+amt+" new amt : "+updateAmt);
				}
				
				for(int num:arrAmt)
				{
					sum+=num;
				}
				out.print(sum);
				
				
				
				
				
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
				
				
				String HL_MasterDetails="INSERT INTO handloan_master(name,mob_no,alias_name) VALUES('"+name+"','"+mobileNo+"','"+aliasname+"')";
				status=gd.executeCommand(HL_MasterDetails);
				
				//debtor master 
				
				String debtor_master="insert into `debtor_master`(`type`) values('"+aliasname+"')";
				gd.executeCommand(debtor_master);
				
				String maxid="select MAX(id) from handloan_master";
				String handloan_id=gd.getData(maxid).get(0).toString();
				
						
				if(paymode.equals("Cash"))
				{
					String insert_query1="insert into `handloan_details`(`handloan_id`,`date`,`credit`,`mode`,`balance`) values('"+handloan_id+"','"+date+"','"+amount+"','"+paymode+"','"+amount+"')";
					System.out.println("cash:"+insert_query1);
					status1=gd.executeCommand(insert_query1);
					
				}else if(paymode.equals("Cheque"))
				{
					
					String insert_bank1="INSERT INTO bank_account_details(date,credit,particulars,balance) VALUES('"+date+"','"+amount+"','"+paymode+"','"+amount+"');";
					gd.executeCommand(insert_bank1);
					
					String insert_query2="insert into `handloan_details`(`handloan_id`,`date`,`credit`,`mode`,`particulars`,`description`,`balance`) values('"+handloan_id+"','"+date+"','"+amount+"','"+paymode+"','"+chequeNo+"','"+bank_name+"','"+amount+"')";
					System.out.println("cheque:"+insert_query2);
					status1=gd.executeCommand(insert_query2);
					
				}else if(paymode.equals("Transfer"))
				{
					
					String insert_bank2="INSERT INTO bank_account_details(date,credit,particulars,balance) VALUES('"+date+"','"+amount+"','"+paymode+"','"+amount+"');";
					gd.executeCommand(insert_bank2);
					
					String insert_query3="insert into `handloan_details`(`handloan_id`,`date`,`credit`,`mode`,`description`,`balance`) values('"+handloan_id+"','"+date+"','"+amount+"','"+paymode+"','"+bank_name+"','"+amount+"')";
					System.out.println("transfer:"+insert_query3);
					status1=gd.executeCommand(insert_query3);
				}
				
				
				if(status1>0)
				{
					System.out.println("inserted Successfully");
					request.setAttribute("hName", name);
					request.setAttribute("amt", amount);
					request.setAttribute("status", "Handloan Details Added");
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


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
