package admin.JcbPocWork;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;

/**
 * Servlet implementation class JcbPocReport
 */
public class JcbPocReport extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		GenericDAO dao = new GenericDAO();
		
		String query = "";
		int result=0;

		List details = null;
		
		String formDate = request.getParameter("formDate");
		String toDate = request.getParameter("toDate");
		String noGst = request.getParameter("noGst");
		
		String fromDateChalan = request.getParameter("fromDateChalan");
		String toDateChalan = request.getParameter("toDateChalan");
		
		if (formDate != null && toDate != null) {
			if (noGst.equals("1")) {
				query="SELECT `bill_id`, customer_master.custname, `date`, `bill_amount`, `gst` FROM `jcbpoc_invoice`,customer_master WHERE jcbpoc_invoice.cust_id=customer_master.intcustid AND bill_id IS NOT null AND jcbpoc_invoice.date BETWEEN '"+formDate+"' AND '"+toDate+"' ORDER BY jcbpoc_invoice.id ASC";
			}else{
				query="SELECT `id`, customer_master.custname, `date`, `bill_amount`, `gst` FROM `jcbpoc_invoice`,customer_master WHERE jcbpoc_invoice.cust_id=customer_master.intcustid AND jcbpoc_invoice.date BETWEEN '"+formDate+"' AND '"+toDate+"' ORDER BY jcbpoc_invoice.id ASC";
			}
			
			details=dao.getData(query);
			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + "~");

			}
		}
		if (fromDateChalan != null && toDateChalan != null) {
			String custID = request.getParameter("custID");
			String projectId = request.getParameter("projectId");
			String vehicleId = request.getParameter("vehicleId");
			query="SELECT customer_master.`custname`,jcbpoc_master.chalanno,jcbpoc_master.data, vehicle_details.vehicle_aliasname,jcbpoc_project.project_name,"
					+ "jcbpoc_master.bucket_hr,jcbpoc_master.breaker_hr,jcbpoc_master.deposit,jcbpoc_master.diesel FROM "
					+ "`jcbpoc_master`,customer_master,vehicle_details,jcbpoc_project  WHERE "
					+ "jcbpoc_master.intcustid=customer_master.intcustid AND "
					+ "jcbpoc_master.project_id=jcbpoc_project.id AND "
					+ "jcbpoc_master.intvehicleid=vehicle_details.vehicle_id AND "
					+ "jcbpoc_master.data BETWEEN '"+fromDateChalan+"' AND '"+toDateChalan+"' AND "
					+ "jcbpoc_master.intcustid"+custID
					+ " AND jcbpoc_master.intvehicleid"+vehicleId
					+ " AND jcbpoc_master.project_id"+projectId
					+ " ORDER BY jcbpoc_master.`chalanno` ASC";
			details=dao.getData(query);
			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + "~");

			}
		}
	}

}
