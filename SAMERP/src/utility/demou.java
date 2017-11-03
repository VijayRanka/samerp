
package utility;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;


import com.sun.org.apache.xalan.internal.xsltc.compiler.sym;

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

		
		
		System.out.println("Sum : "+sum(1,2,3,4,5,6));
		
		
		
		/*		// TODO Auto-generated method stub
		String contId="2";
		
		int count1=1;
		GenericDAO gd=new GenericDAO();
		
		String getLoadingCharges="SELECT expenses_type.expenses_type_name,debtor_master.type"
				+ ",expenses_master.name,expenses_master.amount,expenses_master.payment_mode,"
				+ "expenses_master.date FROM expenses_type,debtor_master,expenses_master "
				+ "WHERE expenses_master.expenses_type_id=expenses_type.expenses_type_id "
				+ "AND expenses_master.debtor_id=debtor_master.id AND expenses_master.date "
				+ "BETWEEN '2017-10-12' AND '2017-10-28' AND debtor_master.type='Team_2'";
		System.out.println(gd.getData(getLoadingCharges));
		
		String getContractorDeposit="SELECT expenses_type.expenses_type_name,debtor_master.type,expenses_master.name,expenses_master.amount,expenses_master.payment_mode,expenses_master.date FROM expenses_type,debtor_master,expenses_master WHERE expenses_master.expenses_type_id=expenses_type.expenses_type_id AND expenses_master.debtor_id=debtor_master.id AND expenses_master.date BETWEEN '2017-10-12' AND '2017-10-28' AND debtor_master.type=(SELECT contractor_master.aliasname FROM contractor_master WHERE contractor_master.id=2)";
		
		System.out.println(gd.getData(getContractorDeposit));
		
		
			*/

}
}