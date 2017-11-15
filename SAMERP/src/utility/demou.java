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
		String h="12345VHJA";
		System.out.println(h.charAt(5)=='V');
			
	}
}