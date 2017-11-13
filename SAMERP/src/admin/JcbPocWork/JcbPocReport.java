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
		
		if (formDate != null && toDate != null) {
			query="SELECT `bill_id`, customer_master.custname, `date`, `bill_amount`, `gst` FROM `jcbpoc_invoice`,customer_master WHERE jcbpoc_invoice.cust_id=customer_master.intcustid AND bill_id IS NOT null AND jcbpoc_invoice.date BETWEEN '"+formDate+"' AND '"+toDate+"' ORDER BY jcbpoc_invoice.id ASC";
			details=dao.getData(query);
			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + "~");

			}
		}
	}

}
