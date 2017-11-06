package admin.JcbPocWork;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import dao.General.GenericDAO;
import utility.RequireData;

public class CustomerPaymentCalculation {
	
	//CustomerPaymentCalculation cpc=new CustomerPaymentCalculation();
	
//	public static void main(String args[]) {
//	
//	}
		
	public Double getCustomerTotalPayment(String id) {
		GenericDAO gd=new GenericDAO();
		List getWholeCustAmount=new ArrayList();
		String query = "SELECT jcbpoc_master.bucket_hr,jcbpoc_master.bucket_rate,j"
				+ "cbpoc_master.breaker_hr,jcbpoc_master.breaker_rate "
				+ "FROM jcbpoc_master WHERE jcbpoc_master.intcustid="+id;
		List getCustList=gd.getData(query);
		Iterator custList=getCustList.iterator();
		
		double allOverBucketAmount;
		double allOverBreakerAmount;
		int demoCustId1=0;
		int demoCustId2=0;
		while(custList.hasNext())
		{
			Object bucket_hr=custList.next();
			String[] demoBucketHr=bucket_hr.toString().split(":");
			
			Object bucket_rate=custList.next();
			allOverBucketAmount=CustomerPaymentCalculation.getWholeDayAmount(Double.parseDouble(demoBucketHr[0]), Double.parseDouble(demoBucketHr[1]), Double.parseDouble(bucket_rate.toString()));
			
			Object breaker_hr=custList.next();
			String[] demoBreakerHr=breaker_hr.toString().split(":");
			
			Object breaker_rate=custList.next();
			allOverBreakerAmount=CustomerPaymentCalculation.getWholeDayAmount(Double.parseDouble(demoBreakerHr[0]), Double.parseDouble(demoBreakerHr[1]), Double.parseDouble(breaker_rate.toString()));
			
			getWholeCustAmount.add(allOverBucketAmount+allOverBreakerAmount);
		}
		
		System.out.println(getWholeCustAmount);
		
		System.out.println("whole Samrudhi balance is "+CustomerPaymentCalculation.wholeSAMRUDHIBillAmount(getWholeCustAmount));
		
		return CustomerPaymentCalculation.wholeSAMRUDHIBillAmount(getWholeCustAmount);
	}
	public List getCustomerTotalPayment(String custid, String projectId) {
		GenericDAO gd=new GenericDAO();
		demo du=new demo();
		RequireData rd =new  RequireData();
		
		List getWholeCustAmount=new ArrayList();
		String query = "SELECT jcbpoc_master.intjcbpocid,(SELECT DATEDIFF(CURDATE(),jcbpoc_master.data))AS age,"
				+ "jcbpoc_master.bucket_hr,jcbpoc_master.bucket_rate,jcbpoc_master.breaker_hr,jcbpoc_master.breaker_rate "
				+ "FROM jcbpoc_master WHERE jcbpoc_master.intcustid="+custid+" AND jcbpoc_master.project_id="+projectId+" AND jcbpoc_master.status=0";
		List getCustList=gd.getData(query);
		Iterator custList=getCustList.iterator();
		
		double allOverBucketAmount;
		double allOverBreakerAmount;
		
		while(custList.hasNext())
		{
			Object jcbpocId=custList.next();
			Object age=custList.next();
			
			Object bucket_hr=custList.next();
			String[] demoBucketHr=bucket_hr.toString().split(":");
			
			Object bucket_rate=custList.next();
			allOverBucketAmount=du.getWholeDayAmount(Double.parseDouble(demoBucketHr[0]), Double.parseDouble(demoBucketHr[1]), Double.parseDouble(bucket_rate.toString()));
			
			
			Object breaker_hr=custList.next();
			String[] demoBreakerHr=breaker_hr.toString().split(":");
			
			Object breaker_rate=custList.next();
			allOverBreakerAmount=du.getWholeDayAmount(Double.parseDouble(demoBreakerHr[0]), Double.parseDouble(demoBreakerHr[1]), Double.parseDouble(breaker_rate.toString()));
		
				getWholeCustAmount.add(jcbpocId);
				getWholeCustAmount.add(age);
				getWholeCustAmount.add(allOverBucketAmount+allOverBreakerAmount);
			
		}
		
		return getWholeCustAmount;
	}
	public static double getWholeDayAmount(double hour, double minute,double givenRate)
	{
		double hr=hour,min=minute;
		double rate=givenRate;
		double rateIntoMinute=rate/60;
		double totalTimeInMinute=(hr*60)+min;
		
		double singleDayValue=rateIntoMinute*totalTimeInMinute;
		return singleDayValue;
	}
	public static double wholeSAMRUDHIBillAmount(List demoList)
	{
		double wholeAmount=0.00;
		Iterator getAmount=demoList.iterator();
		while(getAmount.hasNext())
		{
			wholeAmount+=Double.parseDouble(getAmount.next().toString());
		}
		return wholeAmount;
		
	}

}
