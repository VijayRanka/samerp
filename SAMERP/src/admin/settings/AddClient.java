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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.omg.CORBA.Request;

import dao.General.GenericDAO;
import utility.RequireData;



public class AddClient extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		GenericDAO gd=new GenericDAO();
		String delete_client=request.getParameter("delete");
		
		if(request.getParameter("insert")!=null)
		{
		String coname=request.getParameter("coname");
		String cname=request.getParameter("cname");
		String contactno1=request.getParameter("contactno1");
		String gstin=request.getParameter("gstin");
		String email=request.getParameter("email");
		String address=request.getParameter("address");
		String cbamount=request.getParameter("bamount");
		
		String client_aliasname="CL_"+coname;
		
		String src = "";
		if(request.getParameter("productPurchasePage1")!=null){
			src = request.getParameter("productPurchasePage1");
		}
		
		List checkRows=null;
	
		if(coname!=null)
		{
			String queryCheck="select `client_organization_name` from `client_details` where `client_organization_name`='"+coname+"'";
			checkRows=gd.getData(queryCheck);			
		}
		if(checkRows.isEmpty())
		{
			char x= coname.charAt(0);
			if(x==' ')
			{
				RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addClient.jsp");
				rd.include(request, response);
			}
			else
			{
				//debtor_master Entry
				String Client_Aliasname="insert into `debtor_master`(`type`) values('"+client_aliasname+"')";
				gd.executeCommand(Client_Aliasname);
				
				
				//Client_Details 
				
				String query="insert into `client_details` (`client_organization_name`,`client_name`,`client_contactno1`,`gstin`,`client_email`,`client_address`,`client_balance_amount`) values('"+coname+"','"+cname+"','"+contactno1+"','"+gstin+"','"+email+"','"+address+"','"+cbamount+"')";
				int i=gd.executeCommand(query);
				
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				String requireddate = df.format(new Date()).toString();
                List l=gd.getData("SELECT MAX(client_id) FROM client_details");
                int clientid = Integer.parseInt(l.get(0).toString());
                
                String insertClientPayment="INSERT INTO `client_payment_master`(`client_id`, `date`, `total_remaining_amt`) VALUES ("+clientid+",'"+requireddate+"',"+cbamount+")";
                gd.executeCommand(insertClientPayment);
                if(i==1)
				{
					System.out.println("inserted successfully");
					request.setAttribute("status","Inserted Successfully");
					
				}
				else
				{
					System.out.println("please try again");
					
				}
                
                
                if(src.equals("productPurchase"))
                {
					RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/productPurchase/productPurchase.jsp");
					rd.forward(request, response);
				}
				else if(src.equals("sale"))
				{
					RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/manufacture/purchaseRawMaterial.jsp");
					rd.forward(request, response);
				}
				else{
					RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addClient.jsp");
					rd.forward(request, response);
				}
				
			}
		}
		else
		{
			request.setAttribute("error", "2");
			
			if(src.equals("productPurchase")){
				RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/productPurchase/productPurchase.jsp");
				rd.forward(request, response);
			}
			else if(src.equals("RawPurchase"))
			{
				RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/manufacture/purchaseRawMaterial.jsp");
				rd.forward(request, response);
			}
			else{
				RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addClient.jsp");
				rd.forward(request, response);
			}
		}
		
		}
		
		
		if(delete_client==null)
		{	
			String delete="DELETE FROM client_details WHERE client_details.client_id='"+delete_client+"'";			
			int data=gd.executeCommand(delete);
			if(data==1)
			{
				System.out.println("Deleted Successfully");				
			}
			
		}
		else
		{
			request.setAttribute("error", "3");
			RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addClient.jsp");
			rd.forward(request, response);		
		}
		
		if(request.getParameter("Updateid")!=null)
		{
			String RowId=request.getParameter("Updateid");
			RequireData rd=new RequireData();
			List demoList=rd.setClientDetails(RowId);
			Iterator itr=demoList.iterator();
			while(itr.hasNext())
			{
				out.print(itr.next()+",");
			}
	
		}
		
		if(request.getParameter("save")!=null)
		{
			
			String id=request.getParameter("Updateid");
			String update_coname=request.getParameter("coname");			
			String old_coname=request.getParameter("old_coname");			
			String update_cname=request.getParameter("cname");
			String update_contactno1=request.getParameter("contactno1");
			String update_gstin=request.getParameter("gstin");
			String update_email=request.getParameter("email");
			String update_address=request.getParameter("address");
			int update_cbamount=Integer.parseInt(request.getParameter("bamount"));
			
			String update_clname="CL_"+update_coname;
			
			
			//Update Entry In Debtor Master
			
				String query1="UPDATE debtor_master SET debtor_master.type='"+update_clname+"' WHERE debtor_master.type='"+"CL_"+old_coname+"'";
			
				gd.executeCommand(query1);
			
			
				String query="update `client_details` set `client_organization_name`='"+update_coname+"',`client_name`='"+update_cname+"',`client_contactno1`='"+update_contactno1+"',`gstin`='"+update_gstin+"',`client_email`='"+update_email+"',`client_address`='"+update_address+"',`client_balance_amount`="+update_cbamount+" where `client_id`="+id+"";
				
				int i=gd.executeCommand(query);
				
				if(i>0)
				{
					System.out.println("updated Successfully");
					request.setAttribute("status", "update Successfully");
					
				}
				else
				{
					System.out.println("Please try again");
					
				}
				RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addClient.jsp");
				rd.forward(request, response);
			
		}
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
