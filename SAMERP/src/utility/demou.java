package utility;

import java.util.Iterator;
import java.util.List;

import dao.General.GenericDAO;

public class demou {	

	public static void main(String[] args) {

		GenericDAO gd=new GenericDAO();	

		RequireData rd=new RequireData();
		
	//	String a="SELECT bank_name FROM account_details WHERE acc_id=null";
		
	//	System.out.println(gd.getData(a).get(0));
		
		
		String clientPaymentQuery="SELECT `bill_id`, client_details.client_organization_name, `date`, `bill_amt`, `paid_amt`, `mode`, `cheque_no`, `bank_id`,"
				+ "`total_remaining_amt` FROM `client_payment_master`,client_details WHERE client_details.client_id=client_payment_master.client_id "
				+ "AND (client_payment_master.date BETWEEN '2017-11-01' AND '2017-11-30')";
		
		List clientPaymentList=gd.getData(clientPaymentQuery);
		
		Iterator iterator=clientPaymentList.iterator();
		
		while (iterator.hasNext()) {
			
			System.out.print(iterator.next()+","+iterator.next()+","+iterator.next()+","+iterator.next()+","+iterator.next()+","+iterator.next()+","+iterator.next()+",");
			
			Object bankid=iterator.next().toString();
			int bank_id=Integer.parseInt((String) bankid);
			
			if(bank_id==0){
				System.out.print("-"+",");
			}else {
				String a="SELECT bank_name FROM account_details WHERE acc_id="+bank_id;
				
				System.out.print(gd.getData(a).get(0)+",");
			}
			System.out.print(iterator.next()+",");
			System.out.println();
		}
		
		
		
		String q="SELECT `client_id` FROM `client_details` WHERE `client_organization_name`='JAY GANESH ENTERPRISE'";
		
		
		
		/*String dm="SELECT handloan_details.balance FROM handloan_details,handloan_master"
				+ " WHERE handloan_master.id=handloan_details.handloan_id and handloan_details.id="
				+ "(SELECT MAX(handloan_details.id) FROM handloan_details WHERE handloan_master.id=1)";
		System.out.println(dm);*/
		//System.out.println(gd.getData(dm).get(0).toString());*/


	}
}