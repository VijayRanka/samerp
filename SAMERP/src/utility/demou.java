
package utility;

import java.util.List;

import dao.General.GenericDAO;

public class demou {
	
    public static int sum(int a, int... b) {
    int sum = a;
    for (int i : b) {
        sum += i;
    }
	return sum;
    }

	public static void main(String[] args) {

		GenericDAO gd=new GenericDAO();
		String startDate="2017-10-29";
		String lastDate="2017-11-04";
		String contId="2";
		int count=Integer.parseInt(gd.getData("SELECT DATEDIFF('"+lastDate+"','"+startDate+"')").get(0).toString());
		if(count>0){
			for(int i=1;i<=count;i++)
			{
				String getDate="SELECT DATE_ADD('"+startDate+"', INTERVAL "+i+" DAY)";
				
				String expMaster="SELECT expenses_master.date, expenses_master.amount FROM "
						+ "expenses_type,debtor_master,expenses_master WHERE expenses_master.expenses_type_id=expenses_type."
						+ "expenses_type_id AND expenses_master.debtor_id=debtor_master.id AND expenses_master."
						+ "date='"+getDate+"' AND expenses_master.cp_status=0 AND debtor_master.type="
						+ "(SELECT contractor_master.aliasname FROM contractor_master WHERE "
						+ "contractor_master.id="+contId+")";
				
				List demoList1=gd.getData(expMaster);
				System.out.println(demoList1);
				String saleMaster="SELECT sale_master.loading_charges FROM"
						+ " sale_master,contractor_master WHERE contractor_master.id=sale_master.loading_by_id "
						+ "and sale_master.date='"+getDate+"' and sale_master.cp_status=0 and contractor_master.id="+contId;
				
				List demoList2=gd.getData(saleMaster);
				System.out.println(demoList2);
				
				String contPayment="SELECT contractor_payment_details.paid_amount FROM "
						+ "contractor_payment_details WHERE contractor_payment_details.date='"+getDate+"'";
				
				List demoList3=gd.getData(contPayment);
				System.out.println(demoList3);
				
			}
			
		}
		
		
		
		
		
		
}
}