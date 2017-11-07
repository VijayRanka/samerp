package admin.settings;

import java.io.IOException;
import java.io.PrintWriter;
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
import utility.SysDate;

public class AddContractor extends HttpServlet {
       
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		GenericDAO gd=new GenericDAO();

		if(request.getParameter("submit")!=null)
		{
				String name=request.getParameter("name");		
				String contact_no=request.getParameter("contact_no");
				String address=request.getParameter("address");
				String due_balance=request.getParameter("due_balance");
				String alias_name=request.getParameter("alias_name");
				String replacealiasname=alias_name.replace(' ', '_');
				
				List cheackname=null;
				if(alias_name!=null)
				{
					String query1="select `name` from `contractor_master` where `name`='"+name+"'";
					cheackname=gd.getData(query1);
				}
				
				if(cheackname.isEmpty())
				{
					char x= alias_name.charAt(0);
					if(x==' ')
					{
						request.setAttribute("status", "please Enter Correct Name");
						RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addContractor.jsp");
						rd.forward(request, response);
					}
					else
					{
						
					
						//debtor Master Insert
						
						String query1="insert into `debtor_master`(`type`) values('"+replacealiasname+"')";
						gd.executeCommand(query1);
						
						//contractor_master
						
						String query="INSERT INTO `contractor_master`(`name`,`contact_no`,`address`,`due_balance`,`aliasname`) VALUES('"+name+"','"+contact_no+"','"+address+"','"+due_balance+"','"+replacealiasname+"')";
						int i=gd.executeCommand(query);
						if(i>0)
						{
							System.out.println("Inserted Successfully");
							request.setAttribute("status1", "Inserted Successfully");
						}
						else
						{
							System.out.println("please try Again");
						}
						RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addContractor.jsp");
						rd.forward(request, response);
					}
				}
				else
				{
					request.setAttribute("error", "2");
					RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addContractor.jsp");
					rd.forward(request, response);
					
				}
				
				
				
		}
		
		if(request.getParameter("deleteId")!=null)
		{
			String id=request.getParameter("deleteId");
			String query="delete from `contractor_master` where `id`="+id+"";
			int i=gd.executeCommand(query);
			
			if(i>0)
			{
				System.out.println("Deleted Successfully");
				request.setAttribute("status1", "Deleted Successfully");
			}
			else
			{
				System.out.println("Please try Again");
			}
			RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addContractor.jsp");
			rd.forward(request, response);
		}
		
		if(request.getParameter("Updateid")!=null)
		{
			String RowId=request.getParameter("Updateid");
			System.out.println("id 1:"+RowId);
			RequireData rd=new RequireData();
			List demoList=rd.updateContactorDetails(RowId);
			Iterator itr=demoList.iterator();
			while(itr.hasNext())
			{
				out.print(itr.next()+",");
			}
	
		}
		if(request.getParameter("save")!=null)
		{
			
			String id=request.getParameter("Updateid");
			System.out.println("id 2:"+id);
			String update_name=request.getParameter("name");
			String update_contact_no=request.getParameter("contact_no");
			String update_address=request.getParameter("address");
			String update_duebalance=request.getParameter("due_balance");
			String update_aliasname=request.getParameter("alias_name");
			String up_aliasname=update_aliasname.replace(' ', '_');
			boolean check=false;
			
			List cheackAliasName=null;
			if(update_aliasname!=null)
			{
				String query1="select `name` from `contractor_master` where `name`='"+update_name+"'";
				cheackAliasName=gd.getData(query1);
				check=cheackAliasName.contains(update_name);
			
			}
			if(check)
			{
				char x=update_aliasname.charAt(0);
				if(x==' ')
				{
					request.setAttribute("status", "please Enter Correct Name");
					RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addContractor.jsp");
					rd.forward(request, response);
				}
				else
				{
					/*String debtor_query="update `debtor_master` set `type`='"+up_aliasname+"'";
					gd.executeCommand(debtor_query);*/
					String query="update `contractor_master` set `name`='"+update_name+"',`contact_no`='"+update_contact_no+"',`address`='"+update_address+"',`due_balance`='"+update_duebalance+"',`aliasname`='"+up_aliasname+"' where `id`="+id+"";
					System.out.println("update:"+query);
					int i=gd.executeCommand(query);
					
					if(i>0)
					{
						System.out.println("updated Successfully");
						request.setAttribute("status1", "update Successfully");
						
					}
					else
					{
						System.out.println("Please try again");
						
					}
					RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addContractor.jsp");
					rd.forward(request, response);
				}
			}
			else
			{
				request.setAttribute("error","2");
				RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addContractor.jsp");
				rd.forward(request, response);
				
			}
			
			
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
