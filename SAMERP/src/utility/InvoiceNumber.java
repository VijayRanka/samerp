package utility;

import java.util.List;

import dao.General.GenericDAO;

public class InvoiceNumber 
{
	int invoice_no;
	GenericDAO dao =  new GenericDAO();
	
	public int getInvoiceNumber()
	{
		List l=dao.getData("Select MAX(intInvoiceId)from invoice_master");
		
		if(l!=null)
		{
			 invoice_no= Integer.parseInt(l.get(0).toString());
			
			System.out.println("Invoice Id in Utility == > "+invoice_no);
		}
		return invoice_no;
	}
	

}
