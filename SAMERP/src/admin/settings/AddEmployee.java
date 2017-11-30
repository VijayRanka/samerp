package admin.settings;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;
import utility.RequireData;


public class AddEmployee extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddEmployee() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		GenericDAO gd=new GenericDAO();
		
		

		
		if(request.getParameter("empid")!=null)
		{
			RequireData req=new RequireData();
			String str=request.getParameter("empid");
			
			if(str.equals("DRIVER") ||str.equals("HELPER"))
			{
				List list=req.getVehicle();
				Iterator itr3=list.iterator();
				while(itr3.hasNext())
				{
					out.print(itr3.next()+",");
				}
			}else if(str.equals("HOME WORKER") ||str.equals("LABOUR")){
				List list=req.getContractorVehicle();
				
				Iterator itr4=list.iterator();
				while(itr4.hasNext())
				{
					out.print(itr4.next()+",");
				}
				
			}
			
		}
		
		//for inserting data into table--->employee_details
		if(request.getParameter("InsertBtn")!=null){
			
			int status=0;
			String insertQuery="";
			String[] checkStatus=new String[100];
			
			System.out.println("get name:"+request.getParameter("getname"));
			
			String reqdate=request.getParameter("date");
			String employeename=request.getParameter("employee_name");
			String contactno=request.getParameter("contact_no");
			String Debtor_Id=request.getParameter("contractorVehicle_name").trim();
			String empid=request.getParameter("employeeid");
			
			RequireData rq=new RequireData();
			String WorkWith=rq.getType(Debtor_Id).get(0).toString();				
			String desig=request.getParameter("designation");
			char designation=desig.charAt(0);		
			
			String aliasname="EMP_"+desig+"_"+employeename.replace(" ", "_")+'_'+WorkWith;			
			checkStatus=aliasname.split("_");	
			
			String checkStatus1="SELECT emplyoee_details.emp_id, emplyoee_details.aliasname FROM emplyoee_details WHERE emplyoee_details.aliasname LIKE '%TRANSPORT_"+checkStatus[4]+"%' AND emplyoee_details.aliasname LIKE '%"+desig+"%' AND emplyoee_details.status=0 ";
			List ckst=gd.getData(checkStatus1);
			if(!ckst.isEmpty())
			{
				String updatestatus="UPDATE emplyoee_details SET status=1 WHERE emp_id='"+ckst.get(0)+"'";
				int st=gd.executeCommand(updatestatus);				
			}
						
			insertQuery="INSERT INTO emplyoee_details(emp_date,emp_name, emp_contactno,emp_workwith,emp_designation,aliasname)"
					+ " VALUES ('"+reqdate+"','"+employeename+"','"+contactno+"','"+Debtor_Id+"','"+desig+"','"+aliasname+"');";
			
			status=gd.executeCommand(insertQuery);	
			if(status==1)
			{
				insertQuery="INSERT INTO `debtor_master`(`type`) values('"+aliasname+"')";
				gd.executeCommand(insertQuery);
				
				String opening_bal=request.getParameter("opening_balance");
				String credit=request.getParameter("opening_balance");
				String mx_query="SELECT MAX(id) FROM debtor_master";
				String maxid=gd.getData(mx_query).get(0).toString();
				
				if(desig.equals("DRIVER") || desig.equals("HELPER") )
				{
					String drier_helper_op_bal="INSERT INTO driver_helper_payment_master(debter_id,exp_id,date,credit,debit,extra_charges,particular,type,balance) VALUES('"+maxid+"',NULL,'"+reqdate+"','"+credit+"',0,0,'Opening Balance','"+desig+"','"+opening_bal+"')";
					int i=gd.executeCommand(drier_helper_op_bal);					
				}			
			}				
			if(status!=0)
			{
				System.out.println("employee successfully inserted");
				request.setAttribute("status", "Employee Inserted Successfully");				
			}			
			RequestDispatcher req=request.getRequestDispatcher("jsp/admin/settings/addEmployee.jsp");
			req.forward(request, response);
		}
		
		if(request.getParameter("deleteId")!=null)
		{
			int delstatus=0;
			String deleteQuery="Delete from emplyoee_details where emp_id="+request.getParameter("deleteId");
			delstatus=gd.executeCommand(deleteQuery);
			if(delstatus!=0)
			{
				System.out.println("employee successfully deleted");
				request.setAttribute("status", "Employee Deleted Successfully");				
			}
			RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addEmployee.jsp");
			rd.forward(request, response);		
		}		
		
		if(request.getParameter("employeeid")!=null)
		{
			String RowId=request.getParameter("employeeid");
			RequireData rd=new RequireData();
			List demoList=rd.getEmployeeRowData(RowId);
			Iterator itr=demoList.iterator();
			while(itr.hasNext())
			{
				out.print(itr.next()+",");
			}
		}		
		
		if(request.getParameter("update")!=null)
		{
			String Emp_id=request.getParameter("Updateid");
			String up_date = request.getParameter("date");
			String employee_name = request.getParameter("employee_name");
			String contact_no = request.getParameter("contact_no");
			String alias = request.getParameter("alias");
			System.out.println("alias:"+alias);
		/*	String work_with= request.getParameter("contractorVehicle_alias");
			System.out.println("workwith up:"+work_with);
			String designation = request.getParameter("designation")*/;
			String aliasA[] = alias.split("_");
			
			String newAlias = aliasA[0]+"_"+aliasA[1]+ "_"+employee_name+ "_"+aliasA[3] +"_"+aliasA[4];
			/*String query="SELECT debtor_master.type FROM emplyoee_details,debtor_master WHERE emplyoee_details.emp_workwith=debtor_master.id AND debtor_master.id='"+work_with+"'";
			System.out.println("query:"+query);
			String workwith=gd.getData(query).get(0).toString();	
			
			System.out.println("work_with:"+workwith);*/
			
			/*String update_aliasname="EMP_"+designation+"_"+employee_name.replace(" ", "_")+"_"+work_with;
			
			System.out.println("up:"+update_aliasname);
			
			
			String up_aliasname="";*/
			
			//String emp_WorkWith="(SELECT debtor_master.type FROM emplyoee_details,debtor_master WHERE emplyoee_details.emp_workwith=debtor_master.id AND emplyoee_details.emp_workwith='"+work_with+"')";

			String updateEmployeeQuery = "UPDATE emplyoee_details,debtor_master SET emplyoee_details.emp_date='"+up_date+"',emplyoee_details.emp_name='"+employee_name+"',emplyoee_details.emp_contactno='"+contact_no+"', aliasname='"+newAlias+"' WHERE emplyoee_details.emp_workwith=debtor_master.id AND emplyoee_details.emp_id='"+Emp_id+"'";
			
			int updatestatus = gd.executeCommand(updateEmployeeQuery);
			
			if(updatestatus!=0)
			{
				System.out.println("update Empolyee Successfully");
				request.setAttribute("status", "Empolyee Updated Successfully");
			}else
			{
				System.out.println("update Empolyee fail");
				request.setAttribute("status", "Empolyee Update Fail");
			}
			RequestDispatcher req = request.getRequestDispatcher("jsp/admin/settings/addEmployee.jsp");
			req.forward(request, response);
			
			
		}
	}
}