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
import utility.RequireData;


public class AddDailyStock extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		//report data for ajax
		if(request.getParameter("getReportData")!=null)
		{
			String indName=request.getParameter("individualName");
			String firstDate=request.getParameter("fromDate");
			String lastDate=request.getParameter("toDate");
			String singleData=request.getParameter("wholeData");
			GenericDAO gd=new GenericDAO();
			String demo="";
			RequireData rd=new RequireData();
			
			String getDates="SELECT date from daily_stock_details where date BETWEEN '"+firstDate+"' and '"+lastDate+"' GROUP BY date";
			System.out.println(singleData);
			List datesData=gd.getData(getDates);
			Iterator datesItr=datesData.iterator();
			while(datesItr.hasNext())
			{
				Object particularDate=datesItr.next();
				String getContDetails="";
				if(singleData!=null) {
					int dbId=rd.getDebtorId(singleData);
				getContDetails="SELECT contractor_master.id,contractor_master.aliasname FROM contractor_master,daily_stock_details,"
						+ "product_master WHERE product_master.id=daily_stock_details.product_id AND "
						+ "contractor_master.id=product_master.contractor_id and daily_stock_details.date='"+particularDate+"'"
						+ "  and contractor_master.id="+dbId+" GROUP by contractor_master.id";
				}
				else {
					getContDetails="SELECT contractor_master.id,contractor_master.aliasname FROM contractor_master,daily_stock_details,"
							+ "product_master WHERE product_master.id=daily_stock_details.product_id AND "
							+ "contractor_master.id=product_master.contractor_id and daily_stock_details.date='"+particularDate+"'"
							+ " GROUP by contractor_master.id";
				}
				
				List getContDetailsList=gd.getData(getContDetails);
				
				Iterator gCDLItr=getContDetailsList.iterator();
				
				while(gCDLItr.hasNext())
				{
					Object contId=gCDLItr.next();
					Object contName=gCDLItr.next();
					out.print("#"+particularDate+"/"+contName+".");
					String getData="SELECT product_master.name,daily_stock_details.product_qty,daily_stock_details.qty_rate,"
							+ "daily_stock_details.quering_qty,daily_stock_details.query_qty_rate FROM daily_stock_details,"
							+ " product_master,contractor_master WHERE contractor_master.id=product_master.contractor_id"
							+ " and daily_stock_details.product_id=product_master.id AND daily_stock_details.date='"+particularDate+"'"
							+ " and contractor_master.id="+contId;
					List data=gd.getData(getData);
					Iterator dataItr=data.iterator();
					
					while(dataItr.hasNext())
					{
						out.print(dataItr.next()+","+dataItr.next()+","+dataItr.next()+","+dataItr.next()+","+dataItr.next()+"/");
					}
					
				}
				
				
				
			}
		}
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
				String query="SELECT product_master.id,product_master.name,final_stock.qty FROM product_master,final_stock"
						+ " WHERE product_master.id=final_stock.product_id AND product_master.contractor_id="+contId;
				List demoList=gd.getData(query);
				if(!demoList.isEmpty())
				{
					Iterator itr=demoList.iterator();
					out.print("1"+",");
					while(itr.hasNext())
					{
						out.print(itr.next()+","+itr.next()+","+itr.next()+",");
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
			String contIdDS=request.getParameter("contIdDS");
		String pDate=request.getParameter("partDate");
		String[] allData=request.getParameter("insertData").split(",");
		GenericDAO gd=new GenericDAO();
		boolean status=false;
		boolean finalStockStatus=false;
		boolean existStatus=false;
		
		if(!pDate.isEmpty())
		{
			String getDateExistDetail="SELECT date FROM `daily_stock_details`,product_master,contractor_master WHERE contractor_master.id="
					+ "product_master.contractor_id and daily_stock_details.product_id=product_master.id "
					+ "AND contractor_master.id="+contIdDS+" GROUP BY date ";
			List getDateExistDetailList=gd.getData(getDateExistDetail);
			Iterator traverseDS=getDateExistDetailList.iterator();
			while(traverseDS.hasNext())
			{
				if(pDate.equals(traverseDS.next().toString()))
					existStatus=true;
			}
			
			if(!existStatus)
			{
				for(int i=0;i<allData.length;i+=3)
				{
					String productId=allData[i];
					String productQty=allData[i+1];
					String queryQty=allData[i+2];
					
					String getProId="SELECT rate_master.production_rate, rate_master.querying_rate FROM rate_master WHERE rate_master.product_id="+productId;
					if(!gd.getData(getProId).isEmpty())
					{
						List demoList=gd.getData(getProId);
						
						if(demoList.get(0).toString().equals("0"))
						{
							out.print("4,");
						}
						else{
						
							//demoList.get(0)+demoList.get(1);
							
							if(!productQty.equals("-"))
							{
								String insertQuery="";
								if(queryQty.equals("-"))
								{
									insertQuery="INSERT INTO `daily_stock_details`(`product_id`, `product_qty`, "
											+ "`qty_rate`, `query_qty_rate`, `date`) "
											+ "VALUES ("+productId+","+productQty+","+demoList.get(0)+","+demoList.get(1)+",'"+pDate+"')";
								}
								else{
									insertQuery="INSERT INTO `daily_stock_details`(`product_id`, `product_qty`, `quering_qty`, "
											+ "`qty_rate`, `query_qty_rate`, `date`) "
											+ "VALUES ("+productId+","+productQty+","+queryQty+","+demoList.get(0)+","+demoList.get(1)+",'"+pDate+"')";
								}
										
								int x=gd.executeCommand(insertQuery);
								if(x>0)
								{
									status = true;
									System.out.println("successfully done");
								}
								if(status)
								{
									int totalQty=0;
									String getProQty="SELECT `qty` FROM `final_stock` WHERE product_id="+productId;
									if(!gd.getData(getProQty).isEmpty())
									{
										int oldQty=Integer.parseInt(gd.getData(getProQty).get(0).toString());
										
										int addedQty=Integer.parseInt(productQty);
										
										totalQty=oldQty+addedQty;
										
										String updateFinalStock="UPDATE `final_stock` SET `qty`="+totalQty+" WHERE product_id="+productId;
										
										int xx=gd.executeCommand(updateFinalStock);
										if(xx>0)
										{
											finalStockStatus=true;
										}
									}
								}
							}
						}
					}
				}
			}
		}
		if(finalStockStatus)
		{
			out.print("1,");
		}
		if(existStatus)
		{
			out.print("3,");
		}
		
		
		}
		
		
	}

}