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
		if(request.getParameter("insertemployee")!=null){
			
			String employeename=request.getParameter("employeename");
			String contactno=request.getParameter("contactno");
			String employetype=request.getParameter("employetype");
			String address=request.getParameter("address");
			int status=0;
			
			String insertQuery="INSERT INTO emplyoee_details(emp_name, emp_contactno, emp_type, emp_address)"
					+ " VALUES ('"+employeename+"','"+contactno+"','"+employetype+"','"+address+"');";
			
			System.out.println("Q ===> "+insertQuery );
			
			status=gd.executeCommand(insertQuery);	
			if(status!=0)
			{
				System.out.println("employee successfully inserted");
				request.setAttribute("status", "Employee Inserted Successfully");
				RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addEmployee.jsp");
				rd.forward(request, response);
			}
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
				RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/settings/addEmployee.jsp");
				rd.forward(request, response);
			}
			
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
		
		if(request.getParameter("emp_submitbtn")!=null)
		{
			String employee_id = request.getParameter("employee_id");
			String employee_name = request.getParameter("employee_name");
			String contact_no = request.getParameter("contact_no");
			String employee_type = request.getParameter("employee_type");
			String employee_address = request.getParameter("employee_address");

			String updateEmployeeQuery = "update emplyoee_details set emp_name='"+employee_name+"', emp_contactno='"+contact_no+"',"
					+ " emp_type='"+employee_type+"', emp_address='"+employee_address+"'  where emp_id='"+employee_id+"';";
			
			int updatestatus = gd.executeCommand(updateEmployeeQuery);
			
			if(updatestatus!=0){
				System.out.println("update Empolyee Successfully");
				request.setAttribute("status", "Empolyee Updated Successfully");
			}else{
				System.out.println("update Empolyee fail");
				request.setAttribute("status", "Empolyee Update Fail");
			}
			RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addEmployee.jsp");
			rd.forward(request, response);
			
		}
	}
}