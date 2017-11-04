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
		
		//for inserting data into table--->employee_details
		if(request.getParameter("submit")!=null){
			
			String employeename=request.getParameter("employee_name");
			String contactno=request.getParameter("contact_no");
			String Debtor_Id=request.getParameter("contractorVehicle_name");
			RequireData rq=new RequireData();
			String WorkWith=rq.getType(Debtor_Id).get(0).toString();
			
			String other=request.getParameter("other");
			String aliasname="EMP_"+employeename+'_'+WorkWith;
			int status=0;
			String insertQuery="";

			
			if(other.equals("")){
				insertQuery="INSERT INTO emplyoee_details(emp_name, emp_contactno,emp_workwith, aliasname)"
						+ " VALUES ('"+employeename+"','"+contactno+"','"+Debtor_Id+"','"+aliasname+"');";
			}
			else{
				insertQuery="INSERT INTO emplyoee_details(emp_name, emp_contactno,emp_workwith,emp_other,aliasname)"
						+ " VALUES ('"+employeename+"','"+contactno+"','"+Debtor_Id+"','"+other+"','"+aliasname+"');";
			}
			
			
			System.out.println("Q ===> "+insertQuery);
			
			status=gd.executeCommand(insertQuery);	
			if(status!=0)
			{
				System.out.println("employee successfully inserted");
				request.setAttribute("status", "Employee Inserted Successfully");
				
			}
			RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addEmployee.jsp");
			rd.forward(request, response);
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
		
		if(request.getParameter("insertemployee")!=null)
		{
			String Emp_id=request.getParameter("Updateid");
			String employee_name = request.getParameter("employee_name");
			String contact_no = request.getParameter("contact_no");
			String work_with= request.getParameter("contractorVehicle_alias");
			String other = request.getParameter("other");

			String updateEmployeeQuery = "update emplyoee_details set emp_name='"+employee_name+"', emp_contactno='"+contact_no+"', emp_workwith='"+work_with+"', emp_other='"+other+"'  where emp_id='"+Emp_id+"';";
			
			int updatestatus = gd.executeCommand(updateEmployeeQuery);
			
			System.out.println("update :"+updatestatus);
			if(updatestatus!=0)
			{
				System.out.println("update Empolyee Successfully");
				request.setAttribute("status", "Empolyee Updated Successfully");
			}else
			{
				System.out.println("update Empolyee fail");
				request.setAttribute("status", "Empolyee Update Fail");
			}
			RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addEmployee.jsp");
			rd.forward(request, response);
			
			
		}
	}
}