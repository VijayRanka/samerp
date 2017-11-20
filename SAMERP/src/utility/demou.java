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
		SecureCode ed=new SecureCode();
		/*tring h="12345VHJA";
		System.out.println(h.charAt(5)=='V');*/
		
		String startDate="2017-11-07";
		String lastDate="2017-11-17";
		String contId="1";
		
		String demoStr="SELECT * FROM expenses_master";
		List demoList=gd.getData(demoStr);
		Iterator itr=demoList.iterator();
		while(itr.hasNext())
		{
			System.out.println(itr.next());
			System.out.println(itr.next());
			System.out.println(itr.next());
			System.out.println(itr.next());
			System.out.println(itr.next());
			System.out.println(itr.next());
			System.out.println(itr.next());
			System.out.println(itr.next());
			System.out.println(itr.next());
			System.out.println(itr.next());
			System.out.println(itr.next());
			System.out.println(itr.next());
		}
//		RequireData rd=new RequireData();
//		SysDate sd=new SysDate();
//		SecureCode ed=new SecureCode();
//		String h="12345VHJA";
//		System.out.println(h.charAt(5)=='V');
		
		
		
//		System.out.println(rd.badEntry("1", "2017-10-10", 0, 10000, "Cheque_123456", "1"));
//		badEntry(String bankId,String transactionDate,int debit,int credit,String particular,String debtorId)
		
		
		//String debtorId=gd.getData("SELECT id FROM debtor_master WHERE type='CL_"+gd.getData("SELECT client_details.client_organization_name FROM client_details WHERE client_details.client_id=4").get(0).toString()+"'").get(0).toString();
		
//		System.out.println(debtorId);
			
	}
}

//;