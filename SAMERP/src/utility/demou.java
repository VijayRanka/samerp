package utility;

import java.util.List;

import dao.General.GenericDAO;

public class demou {

	static GenericDAO gd=new GenericDAO();
	
	public static int checkPCStatus(int amount)
	{
		String statusString="SELECT balance FROM petty_cash_details WHERE id=(SELECT MAX(id) FROM petty_cash_details)";
		
		String a=gd.getData(statusString).get(0).toString();
		
		if(!a.isEmpty())
		{
			int pcAmount=Integer.parseInt(a.toString());
			if(pcAmount==0)
				return 0;  //petty cash balance is 0
			else if(pcAmount-amount<0)
				return -1;	//
			else
				return 1;  //
		}
		else{
			return 2;
		}
	}

	public static void main(String[] args) {
		
		
		System.out.println(checkPCStatus(1000));
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
//		String getDebtorId="SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type="
//				+ "(SELECT vehicle_details.vehicle_aliasname FROM vehicle_details WHERE "
//				+ "vehicle_details.vehicle_number='MH-12-MM-9999')";
//	
//		List debtorId_temp=gd.getData(getDebtorId);
//		
//		if(!debtorId_temp.isEmpty()){
//			System.out.println(debtorId_temp.get(0));
//		}
//		else{
//			System.out.println("Hi");
//		}
		
	}
}