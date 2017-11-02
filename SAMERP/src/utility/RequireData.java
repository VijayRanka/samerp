package utility;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import dao.General.GenericDAO;

public class RequireData 
{
	GenericDAO gd=new GenericDAO();
	
	//starts your methods here

	
	// himanshu start
	public List getCustomerList() {
		String Customer_query="SELECT `intcustid`, `custname`, `address`, `contactno`, `gstin`, `bucket_rate`, `breaker_rate` FROM `customer_master` ORDER BY `intcustid` DESC";
		List CustomerList=gd.getData(Customer_query);
		return CustomerList;
	}
	
	public List getVehicleList() {
		String Vehicle_query="SELECT `vehicle_id`,`vehicle_aliasname` FROM `vehicle_details`";
		List VehicleList=gd.getData(Vehicle_query);
		return VehicleList;
	}
	public List getJcbPocWorkDetail() {
		String JcbPocWorkDetail_query="SELECT customer_master.`custname`,jcbpoc_master.`chalanno`,vehicle_details.vehicle_aliasname,jcbpoc_master.`data`,jcbpoc_master.bucket_hr,jcbpoc_master.breaker_hr,jcbpoc_master.deposit,jcbpoc_master.diesel,jcbpoc_master.intjcbpocid FROM `jcbpoc_master`,customer_master,vehicle_details WHERE jcbpoc_master.intcustid=customer_master.intcustid AND jcbpoc_master.intvehicleid=vehicle_details.vehicle_id ORDER BY jcbpoc_master.intjcbpocid DESC";
		List JcbPocWorkList=gd.getData(JcbPocWorkDetail_query);
		return JcbPocWorkList;
	}
//--himanshu end

	
	// mukesh start
		
	public List getVehiclesData()
			{
				String vehicleDetailsQuery = "select vehicle_id, vehicle_type, vehicle_number from vehicle_details order by vehicle_id desc;";
				List vehicleDetailsData = gd.getData(vehicleDetailsQuery);
				return vehicleDetailsData;
			}
			
			public List getVehicleRowData(String RowId)
			{
				String vehicleRowDataQuery = "select vehicle_id, vehicle_type, vehicle_number from vehicle_details where vehicle_id="+RowId+"; ";
				List vehicleDetailsData = gd.getData(vehicleRowDataQuery);
				System.out.println(vehicleDetailsData);
				return vehicleDetailsData;
			}
			
			public List getSupplierList()
			{
				String supplierListQuery = "select supplier_business_id, supplier_business_name from material_supply_master where type=2;";
				List supplierList = gd.getData(supplierListQuery);
				return supplierList;
			}
			
			public List getClientList()
			{
				String clientListQuery = "select client_id, client_organization_name from client_details;";
				List clientList = gd.getData(clientListQuery);
				return clientList;
			}
			
			public List getPurchaseProduct()
			{
				String purchaseQuery = "SELECT product_purchase_master.id, `product_count`, material_supply_master.supplier_business_name , "
						+ "client_details.client_organization_name , `chalan_no`, `vehicle_no`, `date` FROM `product_purchase_master`, "
						+ "material_supply_master, client_details "
						+ "WHERE material_supply_master.supplier_business_id=product_purchase_master.material_supply_master_id  "
						+ "AND client_details.client_id=product_purchase_master.client_details_id order by product_purchase_master.id DESC";
				List purchaseList = gd.getData(purchaseQuery);
				return purchaseList;
			}
			
			
			public List getProductDetails(String pid)
			{
				String pquery = "SELECT `product_name`, `qty`, `rate` FROM `purchased_product_details` WHERE purchased_product_details.product_purchase_master_id="+pid;
				List pList = gd.getData(pquery);
				return pList;
			}
			
			public List getCompletePurchaseData()
			{
				List finalData = new ArrayList();
				
				String purchaseQuery = "SELECT product_purchase_master.id, `product_count`, material_supply_master.supplier_business_name , "
						+ "client_details.client_organization_name , `chalan_no`, `vehicle_no`, `date` FROM `product_purchase_master`, "
						+ "material_supply_master, client_details "
						+ "WHERE material_supply_master.supplier_business_id=product_purchase_master.material_supply_master_id  "
						+ "AND client_details.client_id=product_purchase_master.client_details_id";
				List purchaseList = gd.getData(purchaseQuery);
				System.out.println(purchaseList);

				Iterator itr = purchaseList.iterator();
				Iterator itr2 = null;
				
				while(itr.hasNext()){
					
					String pquery = "SELECT `product_name`, `qty`, `rate` FROM `purchased_product_details` WHERE purchased_product_details.product_purchase_master_id="+itr.next();
					List pList = gd.getData(pquery);
					
					finalData.add(itr.next());
					finalData.add(itr.next());
					finalData.add(itr.next());
					finalData.add(itr.next());
					finalData.add(itr.next());
					finalData.add(itr.next());
					
					//s+=","+itr.next()+","+itr.next()+","+itr.next()+","+itr.next()+","+itr.next()+","+itr.next();
					
					itr2 = pList.iterator();
					
					while(itr2.hasNext()){
						finalData.add(itr2.next());
						finalData.add(itr2.next());
						finalData.add(itr2.next());
						
						//s+=","+itr2.next()+","+itr2.next()+","+itr2.next();
					}
					
				}
				
				System.out.println(finalData);
				return finalData;
			}
				
			public List getChalanDetails(String ppid){
				List chalanList=new ArrayList();
				if(!ppid.equals("")){
					String chalanQuery = "SELECT id , `product_count`, `chalan_no`, `date` , `vehicle_no`, `material_supply_master_id` FROM "
							+ "`product_purchase_master` WHERE  material_supply_master_id="+ppid+" and product_purchase_master.bill_check_status=0";
					chalanList = gd.getData(chalanQuery);
				}
				return chalanList;
			}
			
			public List getChalanProductDetails(String pid)
			{
				String cpquery = "SELECT `product_name`, `qty`, `rate` FROM `purchased_product_details` WHERE purchased_product_details.product_purchase_master_id="+pid;
				List cpList = gd.getData(cpquery);
				return cpList;
			}
			
			public String getMaxId()
			{
				String query = "SELECT max(id) FROM `supplier_bill_details`";
				List list = gd.getData(query);
				String s = list.get(0).toString();
				return s;
			}
			
			public String getTotalRemaining( String supid)
			{
				String query = "SELECT `id`, `total_remaining` FROM `total_supplier_payment_master` WHERE id=(SELECT MAX(id) FROM total_supplier_payment_master WHERE supplier_id="+supid+")";
				List list = gd.getData(query);
				String s = list.get(1).toString();
				return s;
			}
			
			public List getSupplierPaymentDetails(String pid)
			{
				String query = "SELECT total_supplier_payment_master.id, `supplier_id`, `date`, (SELECT supplier_bill_details.billno FROM supplier_bill_details "
						+ "WHERE total_supplier_payment_master.bill_id=supplier_bill_details.id) AS bill_no , `bill_amt`, `paid_amt`,(SELECT supplier_payment_master.mode"
						+ " FROM supplier_payment_master WHERE total_supplier_payment_master.payment_id=supplier_payment_master.id) AS mode, (SELECT "
						+ "supplier_payment_master.cheque_no FROM supplier_payment_master WHERE total_supplier_payment_master.payment_id=supplier_payment_master.id)"
						+ " AS cheque_no, (SELECT account_details.acc_aliasname FROM account_details, supplier_payment_master WHERE"
						+ " account_details.acc_id=supplier_payment_master.description AND total_supplier_payment_master.payment_id=supplier_payment_master.id) "
						+ "AS bank_details, `total_remaining`FROM `total_supplier_payment_master` WHERE total_supplier_payment_master.supplier_id="+pid+" "
								+ "ORDER BY total_supplier_payment_master.id DESC";
				List List = gd.getData(query);
				return List;
			}
			
			public List getBank()
			{
				String query = "SELECT `acc_id`, `acc_aliasname` FROM `account_details`";
				List List = gd.getData(query);
				return List;
			}
			
			public List getVehicleDetails(){
				String q = "SELECT vehicle_id, vehicle_number FROM vehicle_details WHERE vehicle_type='TRANSPORT'";
				List l = gd.getData(q);
				return l;
			}
			
			public List getVehicleDetails(String vid){
				List l = new ArrayList<>();
				if(!vid.equals("")){
					String q = "SELECT sale_master.id, sale_master.date, client_details.client_organization_name, vehicle_details.vehicle_number, "
							+ "sale_master.vehicle_deposit  FROM sale_master, vehicle_details, client_details WHERE "
							+ "vehicle_details.vehicle_number=sale_master.vehicle_details AND client_details.client_id=sale_master.client_id AND "
							+ "sale_master.vehicle_details=(SELECT vehicle_details.vehicle_number FROM vehicle_details WHERE vehicle_details.vehicle_id="+vid+")";
					l = gd.getData(q);
					
				}
				return l;
			}
			
			public List getSaleSup(String saleId){
				String q = "SELECT  `supplier_name` FROM `sale_details_master` WHERE sale_details_master.sale_master_id="+saleId;
				List l = gd.getData(q);
				return l;
			}
			
			
			public List getSaleProductDetails(String saleId){
				String q = "SELECT   `qty`, `product_name` FROM `sale_details_master` WHERE sale_details_master.sale_master_id="+saleId;
				List l = gd.getData(q);
				return l;
			}
			
			public List getDieselAmt(String saleId){
				
				String q1 = "SELECT exp_master_id FROM vehicles_ride_details WHERE sales_id="+saleId;
				List l1 = gd.getData(q1);
				
				String expId = l1.get(0).toString();
				
				String q = "SELECT expenses_master.amount FROM expenses_master WHERE expenses_master.exp_id="+expId;
				List l = gd.getData(q);
				return l;
			}
			

	
	//--mukesh end
	
	// omkar start
	
	public List getSupplyMaterials(String supplierId)
	{
		String id=supplierId;
		String query="select `supplier_business_id`,`supplier_business_name`,`supplier_name`, `supplier_address`, `supplier_contactno`,`supplier_opening_balance`,`type` from `material_supply_master` where `supplier_business_id`="+id+"";
		List supplierList=gd.getData(query);
		return supplierList;
	}
	public List getAccountDetails()
	{
		String demo="SELECT account_details.acc_id,account_details.bank_name,account_details.branch,account_details.acc_no,bank_account_details.balance,account_details.acc_aliasname FROM account_details,bank_account_details WHERE account_details.acc_id=bank_account_details.bid AND bank_account_details.particulars='Opening Balance'";
		List demoList=gd.getData(demo);
		return demoList;	
	}
	
	public List getAccountRowData(String id)
	{
		String demo="select * from account_details where acc_id="+id+"";
		List demoList=gd.getData(demo);
		return demoList;
	}
	
	public List getRawNameDetails()
	{
		String demo="SELECT id,name FROM raw_material_master";
		List demoList=gd.getData(demo);
		return demoList;
	}
	
	public List getRawUnitDetails()
	{
		String demo="SELECT id,unit FROM raw_material_master";
		List demoList=gd.getData(demo);
		return demoList;
	}
	
	public List getPurchaseDetails()
	{
		String query="SELECT purchase_raw_material_master.id, material_supply_master.supplier_name,purchase_raw_material_master.chalan_no,purchase_raw_material_master.date,purchase_raw_material_master.vehicle_details,raw_material_master.name,purchase_raw_material_master.qty FROM material_supply_master,purchase_raw_material_master,raw_material_master WHERE material_supply_master.supplier_business_id=purchase_raw_material_master.material_supply_master_id AND raw_material_master.id=purchase_raw_material_master.raw_material_master_id GROUP BY purchase_raw_material_master.id ORDER BY purchase_raw_material_master.id";
		List list=gd.getData(query);
		return list;
	}
	
	public List getBillEntryData(String id)
	{
		String query="SELECT purchase_raw_material_master.id,purchase_raw_material_master.chalan_no,purchase_raw_material_master.date,raw_material_master.name FROM purchase_raw_material_master,raw_material_master WHERE purchase_raw_material_master.raw_material_master_id=raw_material_master.id AND purchase_raw_material_master.status=0 AND purchase_raw_material_master.material_supply_master_id='"+id+"'";
		List list=gd.getData(query);
		return list;
	}
	
	
	//--omkar end
	
	// sandeep start

	public List getBankAliasList()
		{
			String query="SELECT account_details.acc_id,account_details.acc_aliasname FROM account_details";
			List list=gd.getData(query);
			return list;
		}
		
		public List getContractorVehicle()
		{
			String query="SELECT contractor_master.id AS cid, contractor_master.aliasname AS calias FROM contractor_master UNION ALL SELECT vehicle_details.vehicle_id AS cid, vehicle_details.vehicle_aliasname AS calias FROM vehicle_details";
			List list=gd.getData(query);
			System.out.println("list is :"+list);
			return list;
		}
		
		public List getClientDetails()
		{
			String query="select `client_id`,`client_organization_name`,`client_name`,`client_contactno1`,`client_contactno2`,`client_email`,`client_address`,`client_balance_amount` from `client_details`";
			System.out.println("query is:"+query);
			List list=gd.getData(query);
			return list;		
		}
		
		public List setClientDetails(String cid)
		{
			String id=cid;
			String query="select `client_id`,`client_organization_name`,`client_name`,`client_contactno1`,`client_contactno2`,`client_email`,`client_address`,`client_balance_amount` from `client_details` where `client_id`="+id+"";
			List list=gd.getData(query);
			return list;
			
		}
		public List getClientRowCount()
		{
			String ClientRowCountQuery = "select count(*) from client_details;";
			List clientCount = gd.getData(ClientRowCountQuery);
			return clientCount;
		}
		

		public List getProductDetails()
		{
			String product="SELECT product_master.id ,contractor_master.aliasname ,product_master.name, product_master.hsncode,product_master.gstper FROM product_master, contractor_master WHERE product_master.contractor_id=contractor_master.id";
			List list=gd.getData(product);
			return list;
			
		}
		
		/*public String getConstructorName( String id )
		{
			String product="select `aliasname` from `contractor_master` where id="+id;
			List list=gd.getData(product);
			String id1 = list.get(0).toString();
			return id1;
			
		}*/
		
		
		public List updateProductDetails(String pid)
		{
			String id=pid;
			System.out.println("id :"+id);
			String query="SELECT product_master.id,product_master.name, product_master.hsncode,product_master.gstper,contractor_master.aliasname FROM product_master, contractor_master WHERE product_master.contractor_id=contractor_master.id AND product_master.id="+id+"";
			System.out.println("query is:"+query);
			List list=gd.getData(query);
			return list;
			
		}
		
		public List getContractorDetails()
		{
			String query="select `id`,`name`,`contact_no`,`address`,`due_balance`,`aliasname` from `contractor_master`";
			List details=gd.getData(query);
			return details;
			
		}
		public List getContractorListDetails()
		{
			String query="SELECT contractor_master.id,contractor_master.aliasname FROM contractor_master";
			
			List list=gd.getData(query);
			return list;
		}
		
		public List updateContactorDetails(String cid)
		{
			String id=cid;
			String query="select `id`,`name`,`contact_no`,`address`,`due_balance`,`aliasname` from `contractor_master` where `id`="+id+"";
			List list=gd.getData(query);
			return list;
				
		}
		
		public List getContracterName()
		{
			String query="select `id`,`aliasname` from `contractor_master` ";
			List list=gd.getData(query);
			return list;
		}
		
		public String getAliasName(String upid)
		{
			String id=upid;
			String query="SELECT contractor_master.aliasname FROM contractor_master,product_master WHERE product_master.contractor_id=contractor_master.id AND contractor_master.id="+id+"";
			List list=gd.getData(query);
			String aliasname=list.get(0).toString();
			return aliasname;
			
					
		}
		
		public List getMaterialDetails()
		{
			String query="select `id`,`name`,`unit` from `raw_material_master`";
			List list=gd.getData(query);
			return list;		
		}
		
		public List getRawMaterials(String rid)
		{
			String rawid=rid;
			String select_query="select `id`,`name`,`unit` from `raw_material_master` where `id`='"+rawid+"'";
			System.out.println(select_query);
			List list=gd.getData(select_query);
			return list;
		}	
		

		public List getMaterialSupplyData1()
		{
			String demo="select `supplier_business_id`,`supplier_business_name`,`supplier_name`,`supplier_address`,`supplier_contactno`,`supplier_opening_balance`,`type` from `material_supply_master`";
			List demoList=gd.getData(demo);
			return demoList;
		}

	
	//--sandeep end
	
	
	
	// sarang start
	
	public List getEmployeeData()
		{
			String demo="select * from emplyoee_details";
			List demoList=gd.getData(demo);
			return demoList;
		}
		
		public List getRowCount(String table_name)
		{
			String rowCountQuery = "select count(*) from "+table_name+";";
			List rowCount = gd.getData(rowCountQuery);
			return rowCount;
		}
		
		public List getEmployeeRowData(String RowId)
		{
			String employeeRowDataQuery = "select emp_id, emp_name, emp_contactno, emp_type, emp_address from emplyoee_details where emp_id="+RowId+"; ";
			List employeeDetailsData = gd.getData(employeeRowDataQuery);
			return employeeDetailsData;
		}
		
		public List getOrganizationData()
		{
			String demo="select organization_id, organization_name, organization_contactno1, organization_contactno2, organization_address, organization_email from organization_details";
			List demoList=gd.getData(demo);
			return demoList;
		}
		
		public List getOrganizationRowData(String RowId)
		{
			String organizationRowDataQuery = "select organization_id, organization_name, organization_address, organization_contactno1, organization_contactno2, organization_email from organization_details where organization_id="+RowId+"; ";
			List organizationDetailsData = gd.getData(organizationRowDataQuery);
			return organizationDetailsData;
		}
		
		public List getOrganizationList()
		{
			String organizationListQuery = "SELECT id,aliasname FROM contractor_master;";
			List organizationList = gd.getData(organizationListQuery);
			return organizationList;
		}
		
		public List getSalesDetails()
		{
			String sale_query="SELECT sale_master.id,sale_master.product_count,client_details.client_organization_name,sale_master.chalan_no,sale_master.date,sale_master.vehicle_details,sale_master.vehicle_deposit FROM sale_master,client_details WHERE sale_master.client_id=client_details.client_id";
			List list=gd.getData(sale_query);
			return list;		
		}
		
		public List getSaleDetailsMaster(String sid)
		{
			String query="SELECT sale_details_master.product_name,sale_details_master.qty,sale_details_master.rate,sale_details_master.supplier_name,sale_details_master.third_party_chalan FROM sale_details_master,sale_master WHERE sale_details_master.sale_master_id=sale_master.id AND sale_master.id="+sid+"";
			List list=gd.getData(query);
			return list;	
		}	
		
		public List getChalanDetailsForSale(String ppid){
			List chalanList=new ArrayList();
			if(!ppid.equals("")){
				String chalanQuery = "SELECT sale_master.id,sale_master.product_count,sale_master.chalan_no,sale_master.date FROM sale_master, "
						+ "client_details WHERE sale_master.client_id=client_details.client_id AND sale_master.client_id="+ppid+" AND sale_master.status=0";
				chalanList = gd.getData(chalanQuery);
			}
			return chalanList;
		}
		
		
		public List getSalePaymentDetails(String cl_id){
			List chalanList=new ArrayList();
			if(!cl_id.equals("")){
				String chalanQuery = "SELECT  `date`, `bill_id`, `bill_amt`, `paid_amt`, `mode`, `cheque_no`, `bank_id`, "
						+ "`total_remaining_amt` FROM `client_payment_master` WHERE client_id= "+cl_id+" ORDER BY id DESC";
				chalanList = gd.getData(chalanQuery);
			}
			return chalanList;
		}
		
		public List getChalanProductDetailsForSale(String pid)
		{
			String cpquery = "SELECT sale_details_master.product_name,sale_details_master.qty,sale_details_master.rate FROM sale_details_master, "
					+ "sale_master WHERE sale_details_master.sale_master_id=sale_master.id AND sale_master.id="+pid;
			List cpList = gd.getData(cpquery);
			return cpList;
		}
		
		public String getClientBillMaxId()
		{
			String query = "SELECT max(bill_id) FROM client_bill_master";
			List list = gd.getData(query);
			String id = list.get(0).toString();
			return id;
		}

		public String getTotalRemainingAmount( String clientid)
		{
			String query = "SELECT total_remaining_amt FROM client_payment_master WHERE id=(SELECT MAX(id) from client_payment_master WHERE client_id="+clientid+")";
			List list = gd.getData(query);
			String s = list.get(0).toString();
			return s;
		}

		
		public String getBankAliasName(int bankid)
		{
			String query="SELECT `acc_aliasname` FROM `account_details` WHERE `acc_id`="+bankid;
			List list=gd.getData(query);
			String aliasname=list.get(0).toString();
			return aliasname;
		}
	
	//--sarang end
	
	// vijay start
	
			
			public List getMaterialSupplyData()
			{
				String demo="select * from material_supply_master";
				List demoList=gd.getData(demo);
				return demoList;
			}
			public List getBankAliasName()
			{
				String demo="SELECT account_details.acc_aliasname FROM account_details";
				List demoList=gd.getData(demo);
				return demoList;
			}
			public List getExpensesDetails()
			{
				String demo="SELECT `exp_id`, `date`, `name`, `amount`, `payment_mode`, `reason`,"
						+ "`expenses_type`.`expenses_type_name`,`debtor_master`.`type`, `other_details` FROM "
						+ "`expenses_master`,`debtor_master`,`expenses_type` WHERE expenses_type.expenses_type_id=expenses_master.expenses_type_id "
						+ "and expenses_master.debtor_id=debtor_master.id order by date";
				List demoList=gd.getData(demo);
				return demoList;
			}
			public List getExpensesDetailsDash()
			{
				SysDate sd=new SysDate();
				String demo="SELECT `exp_id`, `date`, `name`, `amount`, `payment_mode`, `reason`,"
						+ "`expenses_type`.`expenses_type_name`,`debtor_master`.`type`, `other_details` FROM "
						+ "`expenses_master`,`debtor_master`,`expenses_type` WHERE expenses_type.expenses_type_id=expenses_master.expenses_type_id "
						+ "and expenses_master.debtor_id=debtor_master.id and expenses_master.date='"+sd.todayDate().toString().split("-")[2]+"-"+sd.todayDate().toString().split("-")[1]+"-"+sd.todayDate().toString().split("-")[0]+"' order by date";
				List demoList=gd.getData(demo);
				return demoList;
			}
			public List getExpensesType()
			{
				String demo="select expenses_type_id, expenses_type_name from expenses_type where status=0";
				List demoList=gd.getData(demo);
				return demoList;
			}
			public List getDebtorList()
			{
				String demo="select * from debtor_master";
				List demoList=gd.getData(demo);
				return demoList;
			}
			public String getVRM(String expId)
			{
				String returnString="";
				String demo="SELECT vehicle_details.vehicle_aliasname,vehicle_reading_master.vehicle_reading,vehicle_reading_master.vehicle_diesel_qty FROM "
						+ "vehicle_reading_master,vehicle_details WHERE vehicle_reading_master.vehicle_id=vehicle_details.vehicle_id "
						+ "and vehicle_reading_master.expenses_master_id="+expId;
				if(!gd.getData(demo).isEmpty())
					{
					returnString=gd.getData(demo).get(0)+","+gd.getData(demo).get(1)+","+gd.getData(demo).get(2);
						return returnString;
					}
				else 
					return null;
				
				
				
			}
			public List getContractorList()
			{
				
				String demo="SELECT contractor_master.id, contractor_master.aliasname FROM contractor_master WHERE contractor_master.status=0";
				if(!gd.getData(demo).isEmpty())
					{
					return gd.getData(demo);
					}
				else 
					return null;
				
				
				
			}
			
			public List getProductListContractor(String contId)
			{
				int count1=1;
				GenericDAO gd=new GenericDAO();
				List demo=new ArrayList();
				List count=new ArrayList();
				String demo1="SELECT daily_stock_details.date FROM daily_stock_details, product_master,"
						+ "contractor_master WHERE product_master.id=daily_stock_details.product_id and "
						+ "contractor_master.id=product_master.contractor_id AND daily_stock_details.status=0 AND contractor_master.id="+contId
						+ " GROUP BY daily_stock_details.date";
				List demo1List=gd.getData(demo1);
				
				if(!demo1List.isEmpty())
				{
					Iterator itr=demo1List.iterator();
					
					while(itr.hasNext())
					{
						Object dateObj=itr.next();
						demo.add(dateObj);
						String demo2="SELECT daily_stock_details.product_id,product_master.name,daily_stock_details."
								+ "product_qty, daily_stock_details.qty_rate,daily_stock_details.quering_qty, daily_stock_details"
								+ ".query_qty_rate FROM daily_stock_details, product_master,contractor_master WHERE product_master"
								+ ".id=daily_stock_details.product_id and contractor_master.id=product_master.contractor_id"
								+ " AND contractor_master.id="+contId+" AND daily_stock_details.status=0 AND daily_stock_details.date='"+dateObj+"'";
								List demo2List=gd.getData(demo2);
								if(!demo2List.isEmpty())
								{
									for(int i=0;i<demo2List.size();i+=6)
									{
										demo.add(demo2List.get(i));
										demo.add(demo2List.get(i+1));
										demo.add(demo2List.get(i+2));
										demo.add(demo2List.get(i+3));
										
										double qtyTotalCharge=Integer.parseInt(demo2List.get(i+2).toString())*Integer.parseInt(demo2List.get(i+3).toString());
										demo.add(qtyTotalCharge);
										
										demo.add(demo2List.get(i+4));
										demo.add(demo2List.get(i+5));
										
										double qtyTotalQueryCharge=Integer.parseInt(demo2List.get(i+4).toString())*Integer.parseInt(demo2List.get(i+5).toString());
										demo.add(qtyTotalQueryCharge);
										
										count1++;
										
									}
									count.add(count1);
									count1=1;
								}
					}
				}
				
				
				List combine=new ArrayList();
				
				combine.add(demo);
				combine.add(count);
				
				return combine;
			}
			
			

	
	
		//--vijay end
	
}
