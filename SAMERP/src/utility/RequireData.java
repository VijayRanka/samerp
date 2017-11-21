package utility;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import dao.General.GenericDAO;

public class RequireData 
{
	GenericDAO gd=new GenericDAO();
	
	public boolean checkUser()
	{
		String check="SELECT * FROM `user_master` WHERE roll=1";
		if(gd.getData(check).isEmpty())
		{
			return false;
		}
		else
			return true;
		
	}
	
	//starts your methods here	
	// himanshu start	
				public List getBankList()
				{
					String bank_query="SELECT account_details.acc_id,account_details.bank_name FROM account_details";
					List list=gd.getData(bank_query);
					return list;
				}
				
				public List getCustomerList() {
					String Customer_query="SELECT `intcustid`, `custname`, `address`, `contactno`, `gstin`, `bucket_rate`, `breaker_rate` FROM `customer_master` ORDER BY `intcustid` DESC";
					List CustomerList=gd.getData(Customer_query);
					return CustomerList;
				}
				
				public List getVehicleList() {
					String Vehicle_query="SELECT `vehicle_id`,`vehicle_aliasname`FROM `vehicle_details` WHERE `vehicle_type`='JCB' OR `vehicle_type`='POCLAIN'";
					List VehicleList=gd.getData(Vehicle_query);
					return VehicleList;
				}
				public List getJcbPocWorkDetail() {
					String JcbPocWorkDetail_query="SELECT customer_master.`custname`,jcbpoc_master.`chalanno`,vehicle_details.vehicle_aliasname,jcbpoc_master.`data`,jcbpoc_master.bucket_hr,jcbpoc_master.breaker_hr,jcbpoc_master.deposit,jcbpoc_master.diesel,jcbpoc_master.intjcbpocid FROM `jcbpoc_master`,customer_master,vehicle_details WHERE jcbpoc_master.intcustid=customer_master.intcustid AND jcbpoc_master.intvehicleid=vehicle_details.vehicle_id ORDER BY jcbpoc_master.intjcbpocid DESC";
					List JcbPocWorkList=gd.getData(JcbPocWorkDetail_query);
					return JcbPocWorkList;
				}
				public List getCustomerListForPay() {
					String Customer_query="SELECT customer_master.intcustid,customer_master.custname FROM customer_master,jcbpoc_payment WHERE customer_master.intcustid=jcbpoc_payment.cust_id GROUP BY intcustid DESC";
					List CustomerList=gd.getData(Customer_query);
					return CustomerList;
				}
				public List getJcbPocBillDetail() {
					String JcbPocBillDetail_query="SELECT jcbpoc_invoice.id,customer_master.intcustid,customer_master.custname,jcbpoc_invoice.date,jcbpoc_invoice.bill_amount FROM `jcbpoc_invoice`,`customer_master` WHERE `jcbpoc_invoice`.status=0 AND `customer_master`.intcustid=`jcbpoc_invoice`.cust_id ORDER BY jcbpoc_invoice.id DESC";
					List JcbPocWorkList=gd.getData(JcbPocBillDetail_query);
					return JcbPocWorkList;
				}
				public List getJcbPocPaymentList() {
					String JcbPocWorkDetail_query="SELECT date,description,bill_amount,amount,total_balance FROM `jcbpoc_payment` WHERE status=0 ORDER BY id DESC";
					List JcbPocWorkList=gd.getData(JcbPocWorkDetail_query);
					return JcbPocWorkList;
				}
				public String getTotalRemainingBalance(String custId, String billAmt, String amt)
				{
					String query = "SELECT `total_balance` FROM `jcbpoc_payment` WHERE  cust_id="+custId+" ORDER BY jcbpoc_payment.`id` DESC LIMIT 1";
					String balance = gd.getData(query).toString();
					balance=balance.substring(1, balance.length() - 1);
					
					double billAmount=0;
					double amount=0;
					double finalBalance=0;
					if (balance != "" && !balance.isEmpty()) {
						finalBalance=Double.valueOf(balance);
					}
					if (billAmt != "") {
						billAmount=Double.valueOf(billAmt);
						finalBalance=finalBalance+billAmount;
						balance=String.valueOf(finalBalance);
					}
					if (amt != "") {
						amount=Double.valueOf(amt);
						finalBalance=finalBalance-amount;
						balance=String.valueOf(finalBalance);
					}
					
					return balance;
				}
			//--himanshu end

	
	// mukesh start
		
				public List getVehiclesData()
				{
					String vehicleDetailsQuery = "select vehicle_id, vehicle_type, vehicle_number,trip_allowance,helper_charges,driver_charges from vehicle_details order by vehicle_id desc;";
					List vehicleDetailsData = gd.getData(vehicleDetailsQuery);
					return vehicleDetailsData;
				}
				
				public List getVehicleRowData(String RowId)
				{
					String vehicleRowDataQuery = "select vehicle_id, vehicle_type, vehicle_number,trip_allowance,helper_charges,driver_charges,vehicle_aliasname from vehicle_details where vehicle_id="+RowId+"; ";
					List vehicleDetailsData = gd.getData(vehicleRowDataQuery);
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
				
				public List getSupplierPaymentUpdateDetails(String pid, String tid)
				{
					String query = "SELECT total_supplier_payment_master.id, `supplier_id`, `date`, (SELECT supplier_bill_details.billno FROM supplier_bill_details "
							+ "WHERE total_supplier_payment_master.bill_id=supplier_bill_details.id) AS bill_no , `bill_amt`, `paid_amt`,(SELECT supplier_payment_master.mode"
							+ " FROM supplier_payment_master WHERE total_supplier_payment_master.payment_id=supplier_payment_master.id) AS mode, (SELECT "
							+ "supplier_payment_master.cheque_no FROM supplier_payment_master WHERE total_supplier_payment_master.payment_id=supplier_payment_master.id)"
							+ " AS cheque_no, (SELECT account_details.acc_aliasname FROM account_details, supplier_payment_master WHERE"
							+ " account_details.acc_id=supplier_payment_master.description AND total_supplier_payment_master.payment_id=supplier_payment_master.id) "
							+ "AS bank_details, `total_remaining`FROM `total_supplier_payment_master` WHERE  total_supplier_payment_master.id="+tid+" AND total_supplier_payment_master.supplier_id="+pid+" "
									+ "ORDER BY total_supplier_payment_master.id DESC";
					List List = gd.getData(query);
					return List;
				}
				
				
				public List getVehicleDetails(){
					String q = "SELECT vehicle_id, vehicle_number FROM vehicle_details WHERE vehicle_type='TRANSPORT'";
					List l = gd.getData(q);
					return l;
				}
				
				
				public List getVehicleDetails1(String vdate){
					List l = new ArrayList<>();
					//System.out.println("vid "+vid);
						String q = "SELECT sale_master.id, sale_master.date, client_details.client_organization_name, debtor_master.type"
								+ " FROM sale_master, client_details, debtor_master WHERE client_details.client_id=sale_master.client_id AND "
								+ "debtor_master.id=sale_master.debtor_id AND sale_master.date='"+vdate+"'";
						l = gd.getData(q);
					return l;
				}
				
				
				public List getVehicleDetails(String vid){
					List l = new ArrayList<>();
					System.out.println("vid "+vid);
					if(!vid.equals("")){
						String q = "SELECT sale_master.id, sale_master.date, client_details.client_organization_name, sale_master.debtor_id, "
								+ "sale_master.vehicle_deposit  FROM sale_master, client_details WHERE "
								+ "sale_master.debtor_id=(SELECT debtor_master.id FROM debtor_master WHERE "
								+ "debtor_master.type=(SELECT `vehicle_aliasname` FROM `vehicle_details` WHERE vehicle_id="+vid+")) "
								+ "AND client_details.client_id=sale_master.client_id";
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
					String q = "SELECT expenses_master.amount FROM expenses_master WHERE expenses_master.exp_id=(SELECT exp_master_id FROM vehicles_ride_details WHERE sales_id="+saleId+")";
					List l = gd.getData(q);
					return l;
				}
				
				
				public List getDriverCharges(String vehicle){
					String q = "SELECT  `driver_charges`, `helper_charges`, `trip_allowance` FROM `vehicle_details` WHERE vehicle_number='"+vehicle+"'";
					List l = gd.getData(q);
					return l;
				}
				
				
				public String getDriverDebterIdFromVid(String vid){
					DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
					String tdate = df.format(new Date()).toString();
					
					String q = "SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type=(SELECT emplyoee_details.aliasname FROM emplyoee_details WHERE emplyoee_details.aliasname LIKE '%Driver%' AND emp_date<='"+tdate+"' AND status=0 AND emplyoee_details.emp_workwith=(SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type=(SELECT vehicle_details.vehicle_aliasname FROM vehicle_details WHERE vehicle_details.vehicle_id="+vid+")))";
					//SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type=(SELECT emplyoee_details.aliasname FROM emplyoee_details WHERE emplyoee_details.aliasname LIKE '%Driver%' AND emp_date>='2017-11-17' AND status=0 AND emplyoee_details.emp_workwith=(SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type=(SELECT vehicle_details.vehicle_aliasname FROM vehicle_details WHERE vehicle_details.vehicle_id="+vid+")))
					//System.out.println(q);
					List l = gd.getData(q);
					return l.get(0).toString();
				}
				
				public String getHelperDebterIdFromVid(String vid){
					DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
					String tdate = df.format(new Date()).toString();
					
					String q = "SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type=(SELECT emplyoee_details.aliasname FROM emplyoee_details WHERE emplyoee_details.aliasname LIKE '%Helper%' AND emp_date<='"+tdate+"'  AND status=0 AND emplyoee_details.emp_workwith=(SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type=(SELECT vehicle_details.vehicle_aliasname FROM vehicle_details WHERE vehicle_details.vehicle_id="+vid+")))";
					//System.out.println("hl "+q);
					//SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type=(SELECT emplyoee_details.aliasname FROM emplyoee_details WHERE emplyoee_details.aliasname LIKE '%Helper%' AND emp_date>=(SELECT emplyoee_details.emp_date FROM emplyoee_details WHERE emplyoee_details.aliasname LIKE '%Helper%' AND status=0 AND emplyoee_details.emp_workwith=(SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type=(SELECT vehicle_details.vehicle_aliasname FROM vehicle_details WHERE vehicle_details.vehicle_id="+vid+"))) AND status=0 AND emplyoee_details.emp_workwith=(SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type=(SELECT vehicle_details.vehicle_aliasname FROM vehicle_details WHERE vehicle_details.vehicle_id="+vid+")))";
					//SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type=(SELECT emplyoee_details.aliasname FROM emplyoee_details WHERE emplyoee_details.aliasname LIKE '%Driver%' AND emp_date>='2017-11-17' AND status=0 AND emplyoee_details.emp_workwith=(SELECT debtor_master.id FROM debtor_master WHERE debtor_master.type=(SELECT vehicle_details.vehicle_aliasname FROM vehicle_details WHERE vehicle_details.vehicle_id="+vid+")))
					List l = gd.getData(q);
					return l.get(0).toString();
				}
				
				public String getSupPaymentIdByTid(String tid){
					
					String q = "SELECT total_supplier_payment_master.payment_id FROM `total_supplier_payment_master` WHERE total_supplier_payment_master.id="+tid;
					List l = gd.getData(q);
					
					if(!l.isEmpty()){
						return l.get(0).toString();
					}
					else{
						return "";
					}
					
				}
				
				
				public boolean updateTPaymet(String tid, String diff){
					boolean flag = false;
					
					String q = "SELECT `total_remaining` FROM `total_supplier_payment_master` WHERE total_supplier_payment_master.id="+tid;
					List l = gd.getData(q);
					int totalR = Integer.parseInt(l.get(0).toString()) + Integer.parseInt(diff);
					
					
					String updateTPaymet = "UPDATE `total_supplier_payment_master` SET  `total_remaining`="+totalR+" WHERE total_supplier_payment_master.id="+tid;
					int updateTPaymetStatus = gd.executeCommand(updateTPaymet);
					
					if(updateTPaymetStatus==1){
						flag=true;
					}
					
					return flag;
				}
				
				
				
				
				
				
	
	//--mukesh end
	
	// omkar start
		

			public List getbadDetailsDash()
			{
				SysDate sd=new SysDate();
				String demo="SELECT account_details.acc_aliasname,bank_account_details."
						+ "credit,bank_account_details.debit,bank_account_details.particulars,debtor_master.type,bank_account_details.balance"
						+ " FROM `bank_account_details`, debtor_master,account_details WHERE account_details.acc_id=bank_account_details"
						+ ".bid AND debtor_master.id=bank_account_details.debter_id"
						+ " AND date='"+sd.todayDate().split("-")[2]+"-"+sd.todayDate().split("-")[1]+"-"+sd.todayDate().split("-")[0]+"'";
				if(!gd.getData(demo).isEmpty())
				{
					List demoList=gd.getData(demo);
					return demoList;
				}
				
				return null;
			}

			public List getPettyCashDetails() 
			{
                String query="SELECT petty_cash_details.id,petty_cash_details.date,debtor_master.type,petty_cash_details.debit,petty_cash_details.credit,petty_cash_details.balance FROM petty_cash_details,debtor_master WHERE petty_cash_details.debtor_id=debtor_master.id ORDER BY petty_cash_details.id DESC";
                List list=gd.getData(query);
                return list;
			}
			
			public List getPettyCashDetailsDash()
            {
                    SysDate sd=new SysDate();
                    String demo="SELECT petty_cash_details.credit,petty_cash_details.debit,debtor_master.type,petty_cash_details"
                                    + ".balance FROM `petty_cash_details`,debtor_master WHERE debtor_master.id=petty_cash_details."
                                    + "debtor_id AND date='"+sd.todayDate().split("-")[2]+"-"+sd.todayDate().split("-")[1]+"-"+sd.todayDate().split("-")[0]+"'";
                    if(!gd.getData(demo).isEmpty())
                    {
                            List demoList=gd.getData(demo);
                            return demoList;
                    }
                    
                    return null;
            }

	
	public List getSupplyMaterials(String supplierId)
	{
		String id=supplierId;
		String query="SELECT material_supply_master.supplier_business_id,material_supply_master.supplier_business_name,material_supply_master.supplier_name,material_supply_master.supplier_address,material_supply_master.supplier_contactno, material_supply_master.supplier_opening_balance FROM material_supply_master WHERE material_supply_master.supplier_business_id='"+id+"'";
		//System.out.println("query is:"+query);
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
	
	public List getHandLoanDetailsInPetty()
	{
		String query="SELECT handloan_details.id,handloan_details.date,handloan_master.alias_name,handloan_details.debit,handloan_details.credit,handloan_details.mode,handloan_details.particulars,handloan_details.balance FROM handloan_master,handloan_details WHERE handloan_details.handloan_id=handloan_master.id ORDER BY handloan_details.id DESC";
		List list=gd.getData(query);
		return list;
	}
	
	
	//--omkar end
	
	// sandeep start
	
	public List getDriverPayment()
	{
		String driverPayment="SELECT driver_helper_payment_master.id,driver_helper_payment_master.debter_id,driver_helper_payment_master.date, driver_helper_payment_master.credit,driver_helper_payment_master.debit, driver_helper_payment_master.etra_charges,driver_helper_payment_master.particular,driver_helper_payment_master.type,driver_helper_payment_master.balance FROM driver_helper_payment_master";
		List list=gd.getData(driverPayment);
		return list;
	}
	
	public List getContractorVeh(String id)
	{
		String work_with="";
		List list=gd.getData(work_with);
		return list;
	}
	
	public List updateHandLoanDetails(String handloanid)
	{
		System.out.println("up:"+handloanid);
		
		String hlupdate="SELECT handloan_details.id,handloan_master.name,handloan_master.mob_no,handloan_details.date,handloan_details.credit,handloan_master.alias_name,handloan_details.mode,handloan_details.particulars FROM handloan_master,handloan_details WHERE handloan_master.id=handloan_details.handloan_id AND handloan_details.handloan_id='"+handloanid+"'";
		List list=gd.getData(hlupdate);		
		System.out.println("required data:"+list);
		return list;
	}
	
	public List getHandLoanDetails()
	{		
		String handloan_insert="SELECT DISTINCT handloan_master.id,handloan_master.name,"
				+ "handloan_master.mob_no,handloan_details.date,handloan_details.credit,"
				+ "handloan_details.mode,handloan_details.particulars,"
				+ "handloan_master.alias_name FROM handloan_master,handloan_details "
				+ "WHERE handloan_master.id=handloan_details.handloan_id";
		List list=gd.getData(handloan_insert);
		return list;		
	}
	
	public List getNameAmount()
	{
		String select_query="SELECT DISTINCT handloan_master.name,handloan_details.credit FROM handloan_master,handloan_details";
		List list=gd.getData(select_query);
		return list;
	}
	
	public List getPreviousBal()
	{
		String maxid="SELECT MAX(id) FROM petty_cash_details";
		String petty_cash_id=gd.getData(maxid).get(0).toString();
		String previous_balance="SELECT petty_cash_details.balance FROM petty_cash_details WHERE petty_cash_details.id='"+petty_cash_id+"'";
		List balance=gd.getData(previous_balance);
		return balance;
		
	}
	
	public List getType(String debtor_id)
	{
		String query="SELECT debtor_master.type FROM debtor_master where debtor_master.id='"+debtor_id+"'";
		List list=gd.getData(query);
		return list;
		
	}

	public List getBankAliasList()
		{
			String query="SELECT account_details.acc_id,account_details.acc_aliasname FROM account_details";
			List list=gd.getData(query);
			return list;
		}
		
		public List getContractorVehicle()
		{
			String query="SELECT DISTINCT debtor_master.id,debtor_master.type FROM debtor_master,contractor_master,vehicle_details WHERE contractor_master.aliasname=debtor_master.type OR vehicle_details.vehicle_aliasname=debtor_master.type";
			List list=gd.getData(query);
			System.out.println("list is :"+list);
			return list;
		}
		
		public List getClientDetails()
		{
			String query="select `client_id`,`client_organization_name`,`client_name`,`client_contactno1`,`gstin`,`client_email`,`client_address`,`client_balance_amount` from `client_details`";
			System.out.println("query is:"+query);
			List list=gd.getData(query);
			return list;		
		}
		
		public List setClientDetails(String cid)
		{
			String id=cid;
			String query="select `client_id`,`client_organization_name`,`client_name`,`client_contactno1`,`gstin`,`client_email`,`client_address`,`client_balance_amount` from `client_details` where `client_id`="+id+"";
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
			String demo="SELECT emplyoee_details.emp_id,emplyoee_details.emp_date,emplyoee_details.emp_name,emplyoee_details.emp_contactno,debtor_master.type,emplyoee_details.emp_designation,emplyoee_details.aliasname FROM emplyoee_details,debtor_master WHERE emplyoee_details.emp_workwith=debtor_master.id";
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
			String employeeRowDataQuery = "SELECT emplyoee_details.emp_id,emplyoee_details.emp_date,emplyoee_details.emp_name,emplyoee_details.emp_contactno,emplyoee_details.emp_workwith,emplyoee_details.emp_designation,emplyoee_details.aliasname FROM emplyoee_details where emp_id="+RowId+"; ";
			List employeeDetailsData = gd.getData(employeeRowDataQuery);
			return employeeDetailsData;
		}
		
		public List getOrganizationData()
		{
			String demo="select organization_id, organization_name, organization_contactno1, organization_contactno2, organization_address, organization_email,organization_op_balance from organization_details";
			List demoList=gd.getData(demo);
			System.out.println("List is:"+demoList);
			return demoList;
		}
		
		public List getOrganizationRowData(String RowId)
		{
			String organizationRowDataQuery = "select organization_id, organization_name, organization_address, organization_contactno1, organization_contactno2, organization_email,organization_op_balance from organization_details where organization_id="+RowId+"; ";
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
			
//			String sale_query="SELECT sale_master.id,sale_master.product_count,client_details.client_organization_name,sale_master.chalan_no,sale_master.date,"
//					+ " sale_master.vehicle_details,sale_master.debtor_id, sale_master.vehicle_deposit FROM sale_master,client_details WHERE "
//					+ " sale_master.client_id = client_details.client_id AND (sale_master.date between  DATE_FORMAT(NOW() ,'%Y-%m-01') AND NOW() )";
			
			String sale_query="SELECT sale_master.id,sale_master.product_count,client_details.client_organization_name,sale_master.chalan_no,"
					+ "sale_master.date,sale_master.vehicle_details,sale_master.debtor_id,sale_master.vehicle_deposit FROM "
					+ "sale_master,client_details WHERE sale_master.client_id=client_details.client_id AND sale_master.status=0";

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
			String cpquery = "SELECT sale_details_master.product_name,sale_details_master.qty,sale_details_master.rate,sale_details_master.gst FROM sale_details_master, "
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
		
		public String getVehicleNumber(int debtor_id)
		{
			String query="SELECT vehicle_number FROM vehicle_details WHERE vehicle_aliasname=(SELECT debtor_master.type FROM debtor_master WHERE id="+debtor_id+")";
			List list=gd.getData(query);
			String vehicleNumber=list.get(0).toString();
			return vehicleNumber;
		}
	
		public List getSupplierList1()
		{
			String supplierListQuery = "select supplier_name from material_supply_master where type=2;";
			List supplierList = gd.getData(supplierListQuery);
			return supplierList;
		}
		
		public List getClientData(int client_id)
		{
			return gd.getData("SELECT client_organization_name, client_address,gstin FROM client_details WHERE client_id="+client_id);
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
				SysDate sd=new SysDate();
				String startDate=sd.todayDate().split("-")[2]+"-"+sd.todayDate().split("-")[1]+"-01";
				String lastDate=sd.todayDate().split("-")[2]+"-"+sd.todayDate().split("-")[1]+"-"+sd.todayDate().split("-")[0];
				String demo="SELECT `exp_id`, `date`, `name`, `amount`, `payment_mode`,"
						+ "`expenses_type`.`expenses_type_name`,`debtor_master`.`type`, `other_details`,bankId, `reason` FROM "
						+ "`expenses_master`,`debtor_master`,`expenses_type` WHERE expenses_type.expenses_type_id=expenses_master.expenses_type_id "
						+ "and expenses_master.debtor_id=debtor_master.id and date BETWEEN '"+startDate+"' and '"+lastDate+"' order by date";
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
				String demo="select * from debtor_master where status=0";
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
			public List getContractorPayment(String contId)
			{
				List demoList;
				String getList="SELECT * FROM `contractor_payment_details` WHERE contractor_id="+contId;
				if(!gd.getData(getList).isEmpty())
				{
					demoList=gd.getData(getList);
					return demoList;
				}
				else
				return null;
			}
			
			public List getContTransactions(String contId)
			{
				SysDate sd=new SysDate();
				String startDate=sd.todayDate().split("-")[2]+"-"+sd.todayDate().split("-")[1]+"-01";
				String lastDate=sd.todayDate().split("-")[2]+"-"+sd.todayDate().split("-")[1]+"-"+sd.todayDate().split("-")[0];
		
				String getDetails="SELECT * FROM `contractor_payment_details` WHERE contractor_id="+contId+" and date BETWEEN '"+startDate+"' and '"+lastDate+"'";
				if(!gd.getData(getDetails).isEmpty())
				{
					List demoList=gd.getData(getDetails);
					if(!demoList.isEmpty())
					return demoList;
					else
						return null;
				}
				return null;
			}
			public String getBankById(String bankId)
			{
				if(!bankId.isEmpty())
				{
					if(!gd.getData("SELECT account_details.acc_aliasname from account_details WHERE account_details.acc_id="+bankId).isEmpty())
					{
						String bankAlias=gd.getData("SELECT account_details.acc_aliasname from account_details WHERE account_details.acc_id="+bankId).get(0).toString();
						return bankAlias;
					}
					
				}
				return null;
			}
			public int totalExpenseDay()
			{
				int amount=0;
				SysDate sd=new SysDate();
				List getDataList=gd.getData("SELECT amount FROM `expenses_master` "
						+ "WHERE date='"+sd.todayDate().split("-")[2]+"-"+sd.todayDate().split("-")[1]+"-"+sd.todayDate().split("-")[0]+"'");
				System.out.println("SELECT amount FROM `expenses_master` "
						+ "WHERE date="+sd.todayDate().split("-")[2]+"-"+sd.todayDate().split("-")[1]+"-"+sd.todayDate().split("-")[0]);
				if(!getDataList.isEmpty())
				{
					Iterator itr=getDataList.iterator();
					while(itr.hasNext())
					{
						amount+=Integer.parseInt(itr.next().toString());
					}
					
				}
					
					return amount;
			}
			public String getTotalPtCash()
			{
				
				String demoList="SELECT id,petty_cash_details.balance FROM petty_cash_details ORDER BY id DESC LIMIT 1";
				if(!gd.getData(demoList).isEmpty())
					return gd.getData(demoList).get(1).toString();
				else
					return "0";
			}
			public String getTotalBadAmount	()
			{
				SysDate sd=new SysDate();
				String demoList="SELECT id,bank_account_details.balance FROM bank_account_details ORDER BY id DESC LIMIT 1";
				if(!gd.getData(demoList).isEmpty())
					return gd.getData(demoList).get(1).toString();
				else
					return "0";
			}
	
	
		//--vijay end
			
			//--common methods start
			
			//common entries
			
			public boolean badEntry(String bankId,String transactionDate,int debit,int credit,String particular,String debtorId)
			{
				boolean flag=false;
				String statusString="SELECT balance FROM bank_account_details WHERE id=(SELECT MAX(id) FROM bank_account_details WHERE bid="+bankId+")";
				GenericDAO gd=new GenericDAO();
				if(!gd.getData(statusString).isEmpty())
				{
					int balance=Integer.parseInt(gd.getData(statusString).get(0).toString());
					if(debit>0)
						balance=balance-debit;
					if(credit>0)
						balance=balance+credit;
					
					String insertQuery="INSERT INTO `bank_account_details`(`bid`, `date`, `debit`, `credit`, `particulars`, `debter_id`, `balance`)"
							+ " VALUES ('"+bankId+"', '"+transactionDate+"', '"+debit+"', '"+credit+"', '"+particular+"', '"+debtorId+"', '"+balance+"')";
					
					System.out.println(insertQuery);
					
					int x=gd.executeCommand(insertQuery);
					if(x>0)
					{
						flag=true;
					}
				}
				return flag;
			}
			
			
			public boolean pCashEntry(String transactionDate,int debit,int credit,String debtorId)
			{
				boolean flag=false;
				String getBalance="SELECT balance FROM petty_cash_details WHERE id=(SELECT MAX(id) FROM petty_cash_details)";
				GenericDAO gd=new GenericDAO();
				if(!gd.getData(getBalance).isEmpty())
				{
					int balance=Integer.parseInt(gd.getData(getBalance).get(0).toString());
					if(debit>0)
						balance=balance-debit;
					if(credit>0)
						balance=balance+credit;
					
					String insertQuery="INSERT INTO `petty_cash_details`(`date`, `debit`, `credit`, `debtor_id`, `balance`) "
							+ "VALUES ('"+transactionDate+"', "+debit+", "+credit+","+debtorId+", "+balance+")";
					int x=gd.executeCommand(insertQuery);
					if(x>0)
					{
						flag=true;
					}
				}
				return flag;
			}
			
			
			public int checkPCStatus(int amount)
			{
				String statusString="SELECT balance FROM petty_cash_details WHERE id=(SELECT MAX(id) FROM petty_cash_details)";
				
				if(!gd.getData(statusString).isEmpty())
				{
					String a=gd.getData(statusString).get(0).toString();
					
					int pcAmount=Integer.parseInt(a.toString());
					if(pcAmount==0)
						return 0;  //petty cash balance is 0
					else if(pcAmount-amount<0)
						return -1;	//
					else
						return 1;  //
				}
				else{
					return 2;
				}
			}
			
			
			public int checkBankBalance(int amount, String bankId)
			{
				String statusString="SELECT balance FROM bank_account_details WHERE id=(SELECT MAX(id) FROM bank_account_details WHERE bid='"+bankId+"')";
				if(!gd.getData(statusString).isEmpty())
				{
					String a=gd.getData(statusString).get(0).toString();
					int bankAmount=Integer.parseInt(a.toString());
					if(bankAmount==0)
						return 0;  //petty cash balance is 0
					else if(bankAmount-amount<0)
						return -1;	//
					else
						return 1;  //
				}
				else{
					return 2;
				}
			}
			
			
			
			
			public void commonExpEntry(String expTypeId, int debtorId, String name, String amount, String mode, String bankId, String chequeDetails, String date)
			{
				if(bankId=="")
					bankId="null";
				if(chequeDetails==null)
					chequeDetails="";
				
				String insertQuery="INSERT INTO `expenses_master`(`expenses_type_id`, `debtor_id`, `name`, `amount`, `payment_mode`,"
						+ " `bankId`, `other_details`, `date`) VALUES "
						+ "("+expTypeId+","+debtorId+",'"+name+"',"+amount+",'"+mode+"',"+bankId+",'"+chequeDetails+"','"+date+"')";
				System.out.println(insertQuery);
				int x=gd.executeCommand(insertQuery);
			}
			
			
			public int getDebtorId(String AliasName){
				
				String q = "SELECT `id` FROM `debtor_master` WHERE debtor_master.type='"+AliasName+"'";
				List l = gd.getData(q);
				
				int debterId = 0;
				if(!l.isEmpty()){
					debterId = Integer.parseInt(l.get(0).toString());
				}
				
				return debterId;
			}
			
			public List getBank()
			{
				String query = "SELECT `acc_id`, `acc_aliasname` FROM `account_details`";
				List List = gd.getData(query);
				return List;
			}
			//-- common methods end	
}