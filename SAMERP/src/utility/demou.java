package utility;

import java.util.Iterator;
import java.util.List;

import dao.General.GenericDAO;

public class demou {	

	public static void main(String[] args) {

		//GenericDAO gd=new GenericDAO();		

		//vijay ranka data don't delet it
		GenericDAO gd=new GenericDAO();
		RequireData rd=new RequireData();
		SysDate sd=new SysDate();
		
/*		String id="3";
		String getUpdDetails="SELECT sale_master.date, client_details.client_organization_name,sale_master.chalan_no, "
				+ "sale_master.debtor_id,sale_master.vehicle_details,sale_master.vehicle_deposit FROM `sale_master`,client_details WHERE "
				+ "client_details.client_id=sale_master.client_id AND sale_master.id="+id;
		if(!gd.getData(getUpdDetails).isEmpty())
		{
			List demoList=gd.getData(getUpdDetails);
			Iterator itr=demoList.iterator();
			while(itr.hasNext())
			{
				Object date=itr.next();
				Object orgName=itr.next();
				Object chalanNo=itr.next();
				Object debtorId=itr.next();
				Object vehDetails=itr.next();
				Object vehDeposit=itr.next();
				System.out.print(date+","+orgName+","+chalanNo+",");
				
				if(debtorId.toString().equals("0"))
				{					
					System.out.print(vehDetails);
				}
				else
				{
					String getDebtorType="SELECT debtor_master.type FROM debtor_master WHERE debtor_master.id="+debtorId;
					System.out.print(gd.getData(getDebtorType).get(0).toString().split("_")[1]);
					
				}
				System.out.print(","+vehDeposit);	
			}	
		}*/		
	}
}