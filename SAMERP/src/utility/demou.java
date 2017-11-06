package utility;

import java.util.List;

import dao.General.GenericDAO;

public class demou {	

	public static void main(String[] args) {

		GenericDAO gd=new GenericDAO();		
		
		
		/*UPDATE FINAL STOCK...
		 * 
		 * UPDATE final_stock SET qty=40 WHERE final_stock.product_id=(SELECT product_master.id FROM product_master WHERE product_master.name='PIPE_6')
		 */
		
		int qty=10;
		
		
		String q="SELECT  final_stock.qty FROM final_stock WHERE final_stock.product_id=(SELECT product_master.id FROM product_master WHERE product_master.name='PIPE_6')";
		int product_qty=0;
		List qty_product=gd.getData(q);
		if(!qty_product.isEmpty()){
			product_qty= Integer.parseInt(qty_product.get(0).toString());
		System.out.println(product_qty);
		}
	}
}