package admin.settings;

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
import utility.SysDate;

/**
 * Servlet implementation class AddDailyStock
 */

public class AddRates extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddRates() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		if(request.getParameter("getPrdctData")!=null)
		{
			String contId=request.getParameter("getPrdctData").trim();
			if(contId.equalsIgnoreCase("select"))
			{
				out.println("2");
			}
			else
			{
				GenericDAO gd=new GenericDAO();
				String query="SELECT product_master.id,product_master.name, rate_master.production_rate,rate_master.querying_rate,rate_master.date FROM "
						+ "product_master,rate_master WHERE rate_master.product_id=product_master.id AND "
						+ "product_master.contractor_id="+contId;
				List demoList=gd.getData(query);
				if(!demoList.isEmpty())
				{
					Iterator itr=demoList.iterator();
					out.print("1"+",");
					while(itr.hasNext())
					{
						out.print(itr.next()+","+itr.next()+","+itr.next()+","+itr.next()+","+itr.next()+",");
					}
				}
				else
				{
					out.print("0");
				}
			}
		}
		if(request.getParameter("insertData")!=null)
		{
			
		GenericDAO gd=new GenericDAO();
		
		String productId=request.getParameter("proId");
		String prodRate=request.getParameter("prodQty");
		String querRate=request.getParameter("querQty");
		SysDate sd=new SysDate();
		
		String insertQuery="UPDATE `rate_master` SET `production_rate`="+prodRate+",`querying_rate`="+querRate+",`date`='"+sd.todayDate().toString().split("-")[2]+"-"+sd.todayDate().toString().split("-")[1]+"-"+sd.todayDate().toString().split("-")[0]+"' WHERE product_id="+productId;
			int x=gd.executeCommand(insertQuery);
			if(x==1)
			{
				out.println("1,"+sd.todayDate().toString().split("-")[2]+"-"+sd.todayDate().toString().split("-")[1]+"-"+sd.todayDate().toString().split("-")[0]);
			}
			else
				out.println(0+",");
		
		}
		
		
	}

}
