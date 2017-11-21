package utility;

import java.util.Iterator;
import java.util.List;

import dao.General.GenericDAO;

public class demou {	

	public static void main(String[] args) {

		GenericDAO gd=new GenericDAO();	
		RequireData rd=new RequireData();
		
		String saleData="SELECT sale_master.id, sale_master.product_count, client_details.client_organization_name, sale_master.chalan_no, "
				+ "sale_master.date, sale_master.vehicle_details,sale_master.debtor_id, sale_master.vehicle_deposit FROM sale_master, "
				+ "client_details WHERE sale_master.client_id = client_details.client_id AND (sale_master.date between '2017-11-01' AND '2017-11-30')"; 
		
				//AND sale_master.client_id=4
		
		List saleDataList= gd.getData(saleData);
		Iterator itr=saleDataList.iterator();
			
		while (itr.hasNext()) {
			
			String sid = itr.next().toString();
			String productCount = itr.next().toString();
			String clientOrgName = itr.next().toString();
			String chalanNo = itr.next().toString();
			String date = itr.next().toString();
			String vehicleDetail = itr.next().toString();
			String debtorid = itr.next().toString();
			String deposit = itr.next().toString();
			
			String vehicleNumber="";
			
			if(vehicleDetail.equals("")){

				vehicleNumber=rd.getVehicleNumber(Integer.parseInt(debtorid));

			}else {
				vehicleNumber=vehicleDetail;
			}
			
			System.out.println(productCount+" "+clientOrgName+" "+chalanNo+" "+date+" "+vehicleNumber+" "+deposit);
			
			String saleMasterData="SELECT sale_details_master.product_name, sale_details_master.qty, sale_details_master.rate, "
					+ "sale_details_master.supplier_name, sale_details_master.third_party_chalan FROM sale_details_master, sale_master "
					+ "WHERE sale_details_master.sale_master_id=sale_master.id AND sale_master.id="+sid;
			
			List saleMasterDataList=gd.getData(saleMasterData);
			Iterator itr1=saleMasterDataList.iterator();
			
			while (itr1.hasNext()) {
				
				String productName=itr1.next().toString();
				String qty=itr1.next().toString();
				String rate=itr1.next().toString();
				String supplierName=itr1.next().toString();
				String chalanNoTP=itr1.next().toString();
				
				System.out.println(productName+" "+qty+" "+rate+" "+supplierName+" "+chalanNoTP);
			}
			System.out.println();
		}
		
	}
}