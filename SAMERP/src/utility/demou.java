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
		
		
		String singleDate="2017-11-08";
		String getDataExp="SELECT exp_id,`date`, `name`, `amount`, `payment_mode`,"
					+ "`expenses_type`.`expenses_type_name`,`debtor_master`.`type`, `other_details`, `reason` FROM "
					+ "`expenses_master`,`debtor_master`,`expenses_type` WHERE expenses_type.expenses_type_id=expenses_master.expenses_type_id "
					+ "and expenses_master.debtor_id=debtor_master.id and "
					+ "expenses_master.date='"+singleDate+"'";
		
		if(!gd.getData(getDataExp).isEmpty())
		{
			List demoList=gd.getData(getDataExp);
			Iterator itr=demoList.iterator();
			while(itr.hasNext())
			{
				Object id=itr.next();
				Object date=itr.next();
				Object name=itr.next();
				Object amount=itr.next();
				Object payMode=itr.next();
				Object expType=itr.next();
				Object debtorType=itr.next();
				Object cDetails=itr.next();
				Object description=itr.next();
				
				System.out.print(date+","+name+","+amount+","+payMode+",");
				
				String vrmData=rd.getVRM(id.toString());
				if(vrmData!=null)
				{
					System.out.print(vrmData.split(",")[0]+","+vrmData.split(",")[1]+",");
				}
				else{
					System.out.print("-,-,");
				}
				
				System.out.print(expType+","+debtorType+",");
				if(cDetails!=null)
					System.out.print(cDetails+",");
				else
					System.out.print("-,");
				System.out.print(description+",");
				
			}
		}
		
		/*String getDateExistDetail="SELECT date FROM `daily_stock_details` GROUP BY date";
		List getDateExistDetailList=gd.getData(getDateExistDetail);
		Iterator traverseDS=getDateExistDetailList.iterator();
		while(traverseDS.hasNext())
		{
			System.out.println(traverseDS.next());
		}
		String bankId="";
		if(!bankId.isEmpty())
		{
			
			if(!gd.getData("SELECT account_details.acc_aliasname from account_details WHERE account_details.acc_id="+bankId).isEmpty())
			{
				String bankAlias=gd.getData("SELECT account_details.acc_aliasname from account_details WHERE account_details.acc_id="+bankId).get(0).toString();
				System.out.println(bankAlias);
			}
			
		}*/
		/*System.out.println(rd.getProductListContractor("1"));
		List demoList=rd.getProductListContractor("1");
		  List countList=(List)demoList.get(0);
		  System.out.println(countList);
		*/
		/*String startDate="2017-10-29";
		String lastDate=sd.todayDate().split("-")[2]+"-"+sd.todayDate().split("-")[1]+"-"+sd.todayDate().split("-")[0];
		String contId="1";
		int count=Integer.parseInt(gd.getData("SELECT DATEDIFF('"+lastDate+"','"+startDate+"')").get(0).toString());
		
		String getDateList="SELECT expenses_master.date FROM expenses_type,debtor_master,expenses_master WHERE "
				+ "expenses_master.expenses_type_id=expenses_type.expenses_type_id AND expenses_master.debtor_id=debtor_master.id"
				+ " AND debtor_master.type=(SELECT contractor_master.aliasname FROM "
				+ "contractor_master WHERE contractor_master.id=1) UNION SELECT sale_master.date FROM sale_master,"
				+ "contractor_master WHERE contractor_master.id=sale_master.loading_by_id "
				+ "and contractor_master.id=1 UNION SELECT contractor_payment_details.date FROM contractor_payment_details "
				+ "WHERE contractor_payment_details.contractor_id=1 GROUP BY date ORDER BY date";
		
		if(count>0){
			for(int i=0;i<=count;i++)
			{
				String getDate=gd.getData("SELECT DATE_ADD('"+startDate+"', INTERVAL "+i+" DAY)").get(0).toString();
				
				String expMaster="SELECT expenses_master.date, expenses_master.amount FROM "
						+ "expenses_type,debtor_master,expenses_master WHERE expenses_master.expenses_type_id=expenses_type."
						+ "expenses_type_id AND expenses_master.debtor_id=debtor_master.id AND expenses_master."
						+ "date='"+getDate+"' AND expenses_master.cp_status=1 AND debtor_master.type="
						+ "(SELECT contractor_master.aliasname FROM contractor_master WHERE "
						+ "contractor_master.id="+contId+")";
				System.out.println(expMaster);
				
				List demoList1=gd.getData(expMaster);
				if(!demoList1.isEmpty())
				System.out.println(getDate+" expenses "+demoList1);

				String saleMaster="SELECT sale_master.loading_charges FROM"
						+ " sale_master,contractor_master WHERE contractor_master.id=sale_master.loading_by_id "
						+ "and sale_master.date='"+getDate+"' and sale_master.cp_status=1 and contractor_master.id="+contId;
				
				System.out.println(saleMaster);
				List demoList2=gd.getData(saleMaster);
				if(!demoList2.isEmpty())
				System.out.println(getDate+" loading charges "+demoList2);
				
				String contPayment="SELECT contractor_payment_details.paid_amount FROM "
						+ "contractor_payment_details WHERE contractor_payment_details.contractor_id="+contId+" and contractor_payment_details.date='"+getDate+"'";
				
				List demoList3=gd.getData(contPayment);
				System.out.println(contPayment);
				if(!demoList3.isEmpty())
				System.out.println(getDate+" payment "+demoList3);
				
			}
			
		
		UPDATE FINAL STOCK...
		 * 
		 * UPDATE final_stock SET qty=40 WHERE final_stock.product_id=(SELECT product_master.id FROM product_master WHERE product_master.name='PIPE_6')
		 */
		
		
		
	
		
		
	}
}

