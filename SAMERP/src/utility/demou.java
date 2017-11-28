package utility;

import java.util.Iterator;
import java.util.List;

import dao.General.GenericDAO;

public class demou {

   
	public static void main(String[] args) {

		
		GenericDAO gd = new GenericDAO();
		RequireData rd = new RequireData();

		String ch="";
		
		int billId=3;
		List ch1=gd.getData("SELECT chalan_no FROM sale_master WHERE bill_id="+billId);
		Iterator itr1=ch1.iterator();
		while (itr1.hasNext()) {
			Object object = itr1.next();
			ch+=object+",";			
		}
		

		double amount=0.0;
		double temp=0.0;
		
		String[] chalanNos=ch.split(",");
			for(int i=0;i<chalanNos.length;i++)
			{
				String getDataByChalan="SELECT sale_master.id,sale_master.product_count,sale_master.date,sale_master.chalan_no FROM `sale_master` WHERE chalan_no='"+chalanNos[i]+"';";
				List chalanData=gd.getData(getDataByChalan);
				Iterator itr=chalanData.iterator();
				
				while(itr.hasNext())
				{
					Object id=itr.next();
					Object prodCount=itr.next();
					Object date=itr.next();
					Object chalanNo=itr.next();
					System.out.print(prodCount+","+date+","+chalanNo+",");
					
					String getSaleDetails="SELECT sale_details_master.product_name,product_master.hsncode,"
							+ "sale_details_master.gst,sale_details_master.qty,sale_details_master.rate FROM "
							+ "sale_details_master,product_master WHERE sale_details_master.sale_master_id="+id
							+ " AND sale_details_master.product_name=product_master.name";
					List saleDetails=gd.getData(getSaleDetails);
					Iterator itr2=saleDetails.iterator();
					double totalAmountwithGST=0.0;
					while(itr2.hasNext())
					{
						Object prodName=itr2.next();
						Object hsnCode=itr2.next();
						double gst=Double.parseDouble(itr2.next().toString());
						int qty=Integer.parseInt(itr2.next().toString());
						double rate=Double.parseDouble(itr2.next().toString());
						amount+=qty*rate;
						System.out.print(prodName+","+hsnCode+","+gst+","+qty+","+rate+","+qty*rate+","+(qty*rate*gst/100)/2+","+(qty*rate*gst/100)/2+",");
						totalAmountwithGST+=(qty*rate)+((qty*rate*gst)/100);
						
					}
					
					System.out.print(totalAmountwithGST+",");		
					temp+=totalAmountwithGST;
				}
			}
			
			System.out.println("Amount "+amount);
			System.out.println("SGst "+ ( temp- amount)/2);
			System.out.println("CGst "+ ( temp- amount)/2);
			System.out.println(temp);
					
	}
}