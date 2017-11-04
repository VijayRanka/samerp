
package utility;

import java.util.List;

import dao.General.GenericDAO;

public class demou {
	

	public static void main(String[] args) {
		SysDate sd=new SysDate();
		GenericDAO gd=new GenericDAO();
		System.out.println(sd.todayDate().toString().split("-")[2]+"-"+sd.todayDate().toString().split("-")[1]+"-"+sd.todayDate().toString().split("-")[0]);
		String demo="SELECT `exp_id`, `date`, `name`, `amount`, `payment_mode`, `reason`,"
				+ "`expenses_type`.`expenses_type_name`,`debtor_master`.`type`, `other_details` FROM "
				+ "`expenses_master`,`debtor_master`,`expenses_type` WHERE expenses_type.expenses_type_id=expenses_master.expenses_type_id "
				+ "and expenses_master.debtor_id=debtor_master.id and expenses_master.date='"+sd.todayDate().toString().split("-")[2]+"-"+sd.todayDate().toString().split("-")[1]+"-"+sd.todayDate().toString().split("-")[0]+"' order by date";
		List demoList=gd.getData(demo);
		System.out.println(demoList);

		
		
		
}
}