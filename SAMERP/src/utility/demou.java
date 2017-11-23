package utility;

import java.util.Iterator;
import java.util.List;

import dao.General.GenericDAO;

public class demou {	

	public static void main(String[] args) {

		GenericDAO gd=new GenericDAO();	
		RequireData rd=new RequireData();
		
		
		
		String q="SELECT `client_id` FROM `client_details` WHERE `client_organization_name`='JAY GANESH ENTERPRISE'";
		
		
		
		/*String dm="SELECT handloan_details.balance FROM handloan_details,handloan_master"
				+ " WHERE handloan_master.id=handloan_details.handloan_id and handloan_details.id="
				+ "(SELECT MAX(handloan_details.id) FROM handloan_details WHERE handloan_master.id=1)";
		System.out.println(dm);*/
		//System.out.println(gd.getData(dm).get(0).toString());*/

	}
}