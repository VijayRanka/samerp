package admin.supply;

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

public class SaleSupply extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out = response.getWriter();
		GenericDAO dao = new GenericDAO();
		
		String CustomerSearch = request.getParameter("q");
		String CustomerPrint = request.getParameter("CustomerPrint");

		String query = "";
		

		List details = null;
		
		if (CustomerSearch == null && CustomerPrint==null) {
			
		}else if (CustomerSearch == null) {
			query="SELECT * FROM `client_details` where `client_id`="+CustomerPrint;
			details=dao.getData(query);
			
			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + "~");

			}
		}else {
			query="SELECT `clientid`,`client_name` FROM `client_details` WHERE `client_name` LIKE '"+CustomerSearch+"%'";
			System.out.println("query 1====" + query);
			details = dao.getData(query);
			System.out.println("Query===" + details);

			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + ",");

			}
		}

		
	}

}
