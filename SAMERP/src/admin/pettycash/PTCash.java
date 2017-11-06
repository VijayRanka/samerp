package admin.pettycash;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;

@WebServlet("/PTCash")
public class PTCash extends HttpServlet {
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			response.setContentType("text/html");
			PrintWriter out=response.getWriter();
			GenericDAO gd=new GenericDAO();
						
			int status=0;
			
			if(request.getParameter("handloanbtn")!=null)
			{
				
			
			
			
			}
			
			if(request.getParameter("handloanbtn")!=null)
			{
				
				//Handloan master
				int status1=0;		
				
				
				String name=request.getParameter("name");				
				String mobileNo=request.getParameter("mobileno");				
				String aliasname="HL_"+name.replace(" ", "_")+"_"+mobileNo;				
				String HL_MasterDetails="insert into `handloan_master`(`name`,`mob_no`,`alias_name`) values('"+name+"','"+mobileNo+"','"+aliasname+"')";
				status=gd.executeCommand(HL_MasterDetails);
				
				if(status==0)
				{
					System.out.println("Inserted Successfully");
					request.setAttribute("status", "Inserted Successfully");
				}
				
					
				
				//debtor master 
				
				String debtor_master="insert into `debtor_master`(`type`) values('"+aliasname+"')";
				gd.executeCommand(debtor_master);
				
				String maxid="select MAX(id) from handloan_master";
				String handloan_id=gd.getData(maxid).get(0).toString();
				
						
				String date=request.getParameter("date");				
				String amount=request.getParameter("paidAmt");				
				String paymode=request.getParameter("payMode");
				String chequeNo=request.getParameter("chequeNo");
				String bank_name=request.getParameter("bankInfo");
				
				System.out.println(handloan_id+","+date+","+amount+","+paymode+","+chequeNo+","+bank_name);
				
				if(paymode.equals("Cash"))
				{
					String insert_cash="insert into `handloan_details`(`handloan_id`,`date`,`credit`,`mode`) values('"+handloan_id+"','"+date+"','"+amount+"','"+paymode+"','"+amount+"')";
					status1=gd.executeCommand(insert_cash);
					
				}else if(paymode.equals("Cheque"))
				{
					String insert_cash="insert into `handloan_details`(`handloan_id`,`date`,`credit`,`mode`,`particulars`,`description`) values('"+handloan_id+"','"+date+"','"+amount+"','"+paymode+"','"+chequeNo+"','"+bank_name+"','"+amount+"')";
					status1=gd.executeCommand(insert_cash);
					
				}else if(paymode.equals("Transfer"))
				{
					String insert_cash="insert into `handloan_details`(`handloan_id`,`date`,`credit`,`mode`,`description`) values('"+handloan_id+"','"+date+"','"+amount+"','"+paymode+"','"+bank_name+"','"+amount+"')";
					status1=gd.executeCommand(insert_cash);
				}
				
				
				if(status1==0)
				{
					System.out.println("inserted Successfully");
					request.setAttribute("status", "Insertion Successfully");
				}else
				{
					System.out.println("plz Try Again");
					request.setAttribute("status", "Insertion Fail");
				}
				
				RequestDispatcher rq=request.getRequestDispatcher("jsp/admin/PTCash/ptcash.jsp");
				rq.forward(request, response);
				
			}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
