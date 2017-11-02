package utility;

import java.text.SimpleDateFormat;

public class SysDate {
	public String todayDate()
	{
		long millis=System.currentTimeMillis();  
		java.sql.Date date=new java.sql.Date(millis); 
	   String dateString = null;
	   SimpleDateFormat sdfr = new SimpleDateFormat("dd-MM-yyyy");
	   
	   try{
		dateString = sdfr.format( date );
	   }catch (Exception ex ){
		System.out.println(ex);
	   }
	   return dateString;
	}
}
