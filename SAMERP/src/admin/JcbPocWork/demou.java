package admin.JcbPocWork;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;


import dao.General.GenericDAO;
import utility.RequireData;

public class demou {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		GenericDAO gd=new GenericDAO();
		demou du=new demou();
		RequireData rd =new  RequireData();
		
		List getWholeCustAmount=new ArrayList();
		String query = "SELECT jcbpoc_master.intcustid,customer_master.custname ,jcbpoc_master.bucket_hr,"
				+ "jcbpoc_master.bucket_rate,jcbpoc_master.breaker_hr,jcbpoc_master.breaker_rate "
				+ "FROM customer_master,jcbpoc_master WHERE jcbpoc_master.intcustid=customer_master.intcustid "
				+ "AND jcbpoc_master.status=0 ORDER BY jcbpoc_master.intcustid";
		List getCustList=gd.getData(query);
		Iterator custList=getCustList.iterator();
		double allOverBucketAmount;
		double allOverBreakerAmount;
		int demoCustId1=0;
		int demoCustId2=0;
		while(custList.hasNext())
		{
			Object custId=custList.next();
			
			demoCustId1=(int) custId;
			
			Object custName=custList.next();
			
			Object bucket_hr=custList.next();
			
			String[] demoBucketHr=bucket_hr.toString().split(":");
			
			
			
			Object bucket_rate=custList.next();
			
			//System.out.println("customer "+custName+" BUCK AMOUNT "+du.getWholeDayAmount(Double.parseDouble(demoBucketHr[0]), Double.parseDouble(demoBucketHr[1]), Double.parseDouble(bucket_rate.toString())));
			allOverBucketAmount=du.getWholeDayAmount(Double.parseDouble(demoBucketHr[0]), Double.parseDouble(demoBucketHr[1]), Double.parseDouble(bucket_rate.toString()));
			
			
			Object breaker_hr=custList.next();
			String[] demoBreakerHr=breaker_hr.toString().split(":");
			
			Object breaker_rate=custList.next();
			
			//System.out.println("customer "+custName+" BREAKER AMOUNT "+du.getWholeDayAmount(Double.parseDouble(demoBreakerHr[0]), Double.parseDouble(demoBreakerHr[1]), Double.parseDouble(breaker_rate.toString())));
			allOverBreakerAmount=du.getWholeDayAmount(Double.parseDouble(demoBreakerHr[0]), Double.parseDouble(demoBreakerHr[1]), Double.parseDouble(breaker_rate.toString()));
			
			
			if(demoCustId2==demoCustId1){
				double tempVar=Double.parseDouble(getWholeCustAmount.get(getWholeCustAmount.size()-1).toString());
				tempVar+=allOverBucketAmount+allOverBreakerAmount;
				System.out.println(tempVar);
				getWholeCustAmount.set(getWholeCustAmount.size()-1, tempVar);
			}
			else{
				getWholeCustAmount.add(custId);
				getWholeCustAmount.add(allOverBucketAmount+allOverBreakerAmount);
				
			}
			demoCustId2=(int) custId;
			
		}
		
		System.out.println(getWholeCustAmount);
		
		System.out.println("whole Samrudhi balance is "+du.wholeSAMRUDHIBillAmount(getWholeCustAmount));
		
		
		
		
			}
	public double getWholeDayAmount(double hour, double minute,double givenRate)
	{
		double hr=hour,min=minute;
		double rate=givenRate;
		double rateIntoMinute=rate/60;
		double totalTimeInMinute=(hr*60)+min;
		
		double singleDayValue=rateIntoMinute*totalTimeInMinute;
		 return singleDayValue;
		
		
	}
	public Double wholeSAMRUDHIBillAmount(List demoList)
	{
		Double wholeAmount=0.00;
		Iterator getAmount=demoList.iterator();
		while(getAmount.hasNext())
		{
			getAmount.next();
			wholeAmount+=Double.parseDouble(getAmount.next().toString());
			
		}
		
		return wholeAmount;
		
	}

}
