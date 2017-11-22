package utility;

import java.util.Iterator;
import java.util.List;

import dao.General.GenericDAO;

public class demou {	

	public static void main(String[] args) {

		GenericDAO gd=new GenericDAO();	
		RequireData rd=new RequireData();
		

//		String clientPaymentQuery="SELECT `bill_id`, client_details.client_organization_name, `bank_id`, `date`, `bill_amt`, `paid_amt`, `mode`, `cheque_no`, "
//				+ "`total_remaining_amt` FROM `client_payment_master`,client_details WHERE client_details.client_id=client_payment_master.client_id "
//				+ "AND (client_payment_master.date BETWEEN '2017-11-01' AND '2017-11-30')";
//		
//		List clientPaymentList=gd.getData(clientPaymentQuery);
//		
//		Iterator iterator=clientPaymentList.iterator();
//		
//		while (iterator.hasNext()) {
//			
//			System.out.println(iterator.next()+","+iterator.next()+","+iterator.next()+","+iterator.next()+","+iterator.next()+","+iterator.next()+","+iterator.next()+","+iterator.next()+","+iterator.next()+",");
//		}
	}
}