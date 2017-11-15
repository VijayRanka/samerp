<%@page import="utility.RequireData"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SAMERP PROJECT</title>
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />
<link rel="stylesheet" href="/SAMERP/config/css/select2.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>

<style type="text/css">

#createBillTable tbody {
	border: 1px;
	border-style: groove;
}		
#createBillTable tbody tr td{
	border: 1px;
	border-style: groove;
}
#createBillTable tbody tr th{
	border: 1px;
	border-style: groove;
}
@media print
{
  table { page-break-after:auto }
  tr    { page-break-inside:avoid; page-break-after:auto }
  td    { page-break-inside:avoid; page-break-after:auto }
  thead { display:table-header-group }
  tfoot { display:table-footer-group }
}
@media print {
        table td, table th {
          border:block;
        }
}

.model-footer{
	padding: 0px 60px 0px;
}       
.form-actions {
	padding: 0px 45px 0px;
}
#snackbar {
	    visibility: hidden;
	    min-width: 250px;
	    margin-left: -125px;
	    background-color: #333;
	    color: #fff;
	    text-align: center;
	    border-radius: 2px;
	    padding: 16px;
	    position: fixed;
	    z-index: 1;
	    left: 50%;
	    top: 50px;
	    font-size: 15px;
	    border-radius:50px 50px;
	}

#snackbar.show {
    visibility: visible;
    -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
    animation: fadein 0.5s, fadeout 0.5s 2.5s;
}

@-webkit-keyframes fadein {
    from {top: 0; opacity: 0;} 
    to {top: 50px; opacity: 1;}
}

@keyframes fadein {
    from {top: 0; opacity: 0;}
    to {top: 50px; opacity: 1;}
}

@-webkit-keyframes fadeout {
    from {top: 50px; opacity: 1;} 
    to {top: 0; opacity: 0;}
}

@keyframes fadeout {
    from {top: 50px; opacity: 1;}
    to {top: 0; opacity: 0;}
}

.table td {
   text-align: center;   
}

.modal.fade.in {
    top: 5%;
}
</style>

</head>
<body onload="setSelectValue()">
<!--Header-part-->
<div id="header">
  <h1><a href="/SAMERP/index.jsp">SAMERP</a></h1>
</div>

<% if(request.getAttribute("status")!=null){ 
%>
<div id="snackbar"><%=request.getAttribute("status")%></div>
<%} %>

<!--close-Header-part--> 
<!--top-Header-menu-->
<!--start-top-serch-->
<div id="search">
	<button type="submit" class="tip-bottom" style="margin-top: -1px;">LOGOUT</button>
</div>
<!--close-top-serch--> 
<!--sidebar-menu-->
<jsp:include page="/jsp/admin/common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->

<div id="content">
<div id="content-header">
  <div id="breadcrumb"> <a href="index.html" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Sale Payment</a>  </div>
  
  
  <!--Action boxes-->
  <div class="container-fluid" align="center">
    <div class="quick-actions_homepage">
      <ul class="quick-actions">
      <!-- loop for all of them goes here -->
      	
      	<div class="control-group" style="height: 50px;">
         <label class="control-label"><span style="color: red;  margin-left: -25%;">*</span>Select Client :</label>
      
         <div class="controls" style="margin-left: 43%; margin-top: -2.7%; margin-right: 30%;" >
         		<select name="clientid" onchange="setClientId()" id="clientid" autofocus  required >
            	<option value=""> Select Client</option>
            	  <%
            	  		RequireData rd = new RequireData();
            	  		List clientList = rd.getClientList();
            	  		Iterator itr1 = clientList.iterator();
	              		while(itr1.hasNext()){
	              %>
		                	<option value="<%=itr1.next()%>"><%=itr1.next()%></option>
		           <%
	              		}
		           %>   
       		</select>  
       		
       		<input type="hidden" name="clt_id" id="clt_id" />
       		
         </div><hr>
        </div>
     
     		<li class="bg_ls"> <a href="#" onclick="showdata('paymentDetails')" > <i class="icon-desktop"></i><span class="label label-success"></span>View Balance</a> </li>
     		<li class="bg_ls"> <a href="#" onclick="showdata('billDetails')" > <i class="icon-list-alt"></i><span class="label label-success"></span>Bill Entry</a> </li>
     		<li class="bg_ls"> <a href="#paymentEntry" data-toggle='modal' onclick="showdata()" > <i class="icon-money"></i><span class="label label-success"></span>Payment Received</a> </li>
     		<li class="bg_ls"> <a href="#createBill" data-toggle="modal" > <i class="icon-desktop"></i> <span class="label label-important"></span>Create Bill</a></li>
      </ul>
    </div>
  </div>
  <!--End-Action boxes-->
</div>
		<%
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
          		String requiredDate = df.format(new Date()).toString();
		%>
  <div class="container-fluid" >
    <hr>

      <div class="widget-box" id="paymentDetails" style="display:none;">
        <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
          <h5>Data table</h5>
        </div>
        <div class="widget-content nopadding">
          <table class="table table-bordered data-table">
            <thead>
              <tr>
			 	 <th>Sr.No.</th>
                 <th>Date</th>
                 <th>Bill Number</th>
                 <th>Bill Amount</th>
                 <th>Paid Amount</th>
                 <th>Mode</th>
                 <th>Cheque Number</th>
                 <th>Bank</th>
                 <th>Total Balance</th>  
              </tr>
            </thead>
            <tbody>
	            <%
		            String client_id = request.getParameter("ppid");
					if(client_id!=null){	 
						
						int i=1;
						List paylist = rd.getSalePaymentDetails(client_id);
						Iterator itr=paylist.iterator();
					while(itr.hasNext()){
	//`date`, `bill_id`, `bill_amt`, `paid_amt`, `mode`, `cheque_no`, `bank_id`, `total_remaining_amt`			
	            %>
              <tr class="gradeX">
                <td><%=i++ %></td>
                <td><%=itr.next() %></td>
                <%
               		int bill= Integer.parseInt( itr.next().toString());
                	if(bill==0){
                %>
                	<td><%="-" %></td>
                <% 		
                	}else{
                %>
                	<td><%=bill %></td>
                <% 		
                	}
                %>
                
                <%
                	for(int d=0;d<4;d++){
                		Object data=itr.next();
                		if(data!=null){
                			%>
                			<td><%=data %></td>
                			<%
                		}else{
                			%>
                			<td><%="-" %></td>
                			<%
                		}
                	}
                	
                int bankid = Integer.parseInt( itr.next().toString());
                if(bankid==0){
                	%>
                	<td><%="-" %></td>
                	<%
                }
                else{
                    String bankalise=rd.getBankAliasName(bankid);	
                 %>
                  <td><%=bankalise %></td>
                 <%
                }
                
                %>
 
                <td><%=itr.next() %></td>
              </tr>
              <%
					}
				}
              %>
            </tbody>
          </table>
        </div>
      </div>   
      
      
            
    <div class="widget-box" id="billDetails" style="display:none;">
          <div class="widget-title"> <span class="icon">
		    <input type="checkbox" id="getAll" onclick="getAllCheckBoxes()"/>
            </span>
            <h5> Available Chalan Details </h5>
            <!-- <input type="text" id="myInput" onkeyup="myFunction1()" style=" float: right; margin-right: -6%; margin-top: 0.3%;" placeholder="Search for Supplier..." title="Type in a Supplier name"> -->
          </div>
          <div class="widget-content nopadding">
          <form id="chalanForm">
            <table class="table table-bordered table-striped with-check" id="chalanDetailsTable">
              <thead>
                <tr>
                  <th><i class="icon-resize-vertical"></i></th>
                  <th>Sr.No.</th>
                  <th>Chalan Number</th>
                  <th>Date</th>
                  <th width="20%">Product Name</th>
                  <th>Quantity</th>
                  <th>Rate</th>
                  <th>GST</th>
                </tr>
              </thead>
              <tbody>
              
                <% 
               
                String s = request.getParameter("ppid");

                int i=1,j;	
            	if(s!=null){
	              	List chalanList = rd.getChalanDetailsForSale(s);
	              	Iterator itr2 = chalanList.iterator();
	              	
	              	
	              	while(itr2.hasNext()){
	              		
	              		String sid = itr2.next().toString();
	              		String span = itr2.next().toString();
	              %>
	                <tr id="tdId<%=i%>">
	                  <td rowspan="<%=span%>"><input id="<%= sid%>" type="checkbox" onclick="selectChecks(this.id)"/></td>
	                  <td rowspan="<%=span%>"> <%=i%> </td>
	                  <td id="mytd<%=i%>" rowspan="<%= span%>"><%=itr2.next() %></td>
	                  <td rowspan="<%= span%>"><%=itr2.next() %></td>
	                  <%-- <td rowspan="<%= span%>"><%=itr2.next() %></td> --%>
	                  
	     			  <%
	   			  		List l = rd.getChalanProductDetailsForSale(sid);
	   			 		Iterator itr3 = l.iterator();
	   			 		
	   			 		String product_name=itr3.next().toString();
	   			 	 	int qty=Integer.parseInt(itr3.next().toString());
	   			 	 	int rate=Integer.parseInt(itr3.next().toString());
	   			 		int gst=Integer.parseInt(itr3.next().toString());

 	   			 		
	   			 	  %>
	   			 	  	
	     				<td><%=product_name %></td>
		                <td><%=qty %></td>
		                <td><%=rate %></td>
	                	<td><%=gst %></td>
	   			 	  <%

	   			 		j=0;
	   			 		while(itr3.hasNext()){
	   			 			
	   			 			
	   			 		String product_name1=itr3.next().toString();
	   			 	 	int qty1=Integer.parseInt(itr3.next().toString());
	   			 	 	int rate1=Integer.parseInt(itr3.next().toString());
	   			 		int gst1=Integer.parseInt(itr3.next().toString());
						j++;
	   			 		System.out.println(j);
	     			  %>	
	     				<tr id="innerTR_<%=i%>_<%=j%>">
	     				<td><%=product_name1 %></td>
		                <td><%=qty1 %></td>
		                <td><%=rate1 %></td>
		                <td><%=gst1 %></td>
		                
		                <%
		                	if(itr3.hasNext()){
		                %>
		                	</tr>
		                <%
		                	}
		                
	   			 		 }
		                %>
	                </tr>
	               <%
	               	i++;
	              	}
            	}
               %>
               <input type="hidden" id="iCount" value="<%=i-1%>">
               <tr>
               		<td>  </td>
               		<td>  </td>
               		<td>  </td>
               		<td>  </td>
               		<td>  </td>
               		<td>  </td>
               		<th style="text-align: right; ">Total Amount</th>
               		<td id="totalAmount" style="text-align: center; ">  </td>
               </tr>
               
               <tr>
               		<td>  </td>
               		<td>  </td>
               		<td>  </td>
               		<td>  </td>
               		<td>  </td>
               		<td>  </td>
               		<th style="text-align: right; ">Total Amount with GST</th>
               		<td id="totalAmountGST" style="text-align: center; ">  </td>
               </tr>               
              </tbody>
            </table>
           </form>
         </div>
         <button  id="chalanSubmitBtn" onclick="selectedChalan()" class="btn btn-success" style=" margin-left: 50%; margin-top: 3%;" data-toggle='modal'>Submit</button>
         <hr style="border-top-color: #c5bbbb;">
      </div>
      
      
      
      

      
    
   </div>   
</div>

<!--Footer-part-->
<div class="row-fluid">
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a
				href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
	</div>

<!--end-Footer-part--> 

<!-- #################    MODEL START  ################################ -->

<div class="modal hide fade zoom-out" id="billEntry" role="dialog" style="width: 35%; margin-left:-18%; margin-top: 10px;">
	<div class="modal-header">
		<a class="close" data-dismiss="modal"></a>
		<h5> New Bill Entry Details</h5>
	</div>
	
	<div class="modal-body" style="padding: 0;">
		<form class="form-horizontal" action="/SAMERP/SalePayment" method="post" name="">
			<div class="form-group">
				<div class="widget-content nopadding">
	             	<div class="control-group" style="">
	             		<%
	             			String maxid_temp=rd.getClientBillMaxId();
	             			int maxid=Integer.parseInt(maxid_temp);
	             		%>
	             		<label class="control-label">Bill Number : </label>
			               <div class="controls">
			                 <input type="text" name="billNo" value="<%=(maxid+1) %>" readonly="readonly"/>
			               </div>
	             	</div>
	             	
	             	<div class="control-group" style="">
	             		<label class="control-label">Bill Amount : </label>
			               <div class="controls">
			                 <input type="text" id="billAmt" name="billAmt" value=""/>
			               </div>
	             	</div>
	             	
<%-- 	             	<%


	             	
	             		float cgst=(sum/100)*9;
	             		float sgst=(sum/100)*9;
	             		float totalBillAmount=sum+cgst+sgst; 
	             	
	             	%>
	             	
	             	<div class="control-group" style="">
	             		<label class="control-label">CGST(9%) : </label>
			               <div class="controls">
			                 <input type="text" id="cgst" name="cgst" value="<%=cgst%>"/>
			               </div>
	             	</div>
	             	
	             	<div class="control-group" style="">
	             		<label class="control-label">SGST(9%) : </label>
			               <div class="controls">
			                 <input type="text" id="sgst" name="sgst" value="<%=sgst%>" />
			               </div>
	             	</div>	
	             	
	             	<div class="control-group" style="">
	             		<label class="control-label">Total Bill Amount : </label>
			               <div class="controls">
			                 <input type="text" id="tba" name="tba" value="<%=totalBillAmount%>"/>
			               </div>
	             	</div>	 --%>	             	             	
	             	
	             	<div class="control-group" style="">
	             		<label class="control-label">Date : </label>
			               <div class="controls">
			                 <input type="date" name="billDate" value="<%= requiredDate%>" required/>
			               </div>
	             	</div>
		            
				</div>
			</div>
			
			<input type="hidden" name="clientID1" id="clientID1" />
			<input type="hidden" id="checkedChalan" name="checkedChalan" >
			
			<div class="modal-footer">
				<input type="submit" name="billSubmit" class="btn green btn-primary" value="Submit" />
				<a href="#" class="btn btn-danger" data-dismiss="modal">Cancel</a>
			</div>
			
		</form>
	</div>
</div>



<div class="modal hide fade zoom-out" id="paymentEntry" role="dialog" >
	<div class="modal-header">
		<a class="close" data-dismiss="modal"></a>
		<h5> New Payment Entry Details</h5>
	</div>
	
	<div class="modal-body" style="padding: 0;">
		<form class="form-horizontal" action="/SAMERP/SalePayment" method="post" name="">
			<div class="form-group">
				<div class="widget-content nopadding">
					<%
						String totalRemaining="";
						if(request.getParameter("ppid")!=null){
							totalRemaining = rd.getTotalRemainingAmount(request.getParameter("ppid"));
						}
					%>
					<div class="control-group" style="">
	             	   <label class="control-label">Total Remaining : </label>
		               <div class="controls">
		                 <input type="text" name="remaminAmt" placeholder="Total Remaining Amount" value="<%=totalRemaining %>" required/>
		               </div>
	             	</div>
					
					<div class="control-group" style="">
	             	   <label class="control-label">Paid Amount : </label>
		               <div class="controls">
		                 <input type="text" name="paidAmt" placeholder="Paid Amount" required/>
		               </div>
	             	</div>
					
					<div class="control-group" style="">
	             		<label class="control-label">Date : </label>
			               <div class="controls">
			                 <input type="date" name="paidDate" value="<%= requiredDate%>" required/>
			               </div>
	             	</div>
					
	             	<div class="control-group" style="">
	             	   <label class="control-label">Payment Mode : </label>
		               <div class="controls">
		                 <input type="radio" value="Cash" style="margin-left: 1%;" name="payMode" onclick="displayBank()" checked="checked"/> Cash
		                 <input type="radio" value="Cheque" style="margin-left: 1%;" name="payMode" onclick="displayBank('bankDetails', 'chequeDetails')" /> Cheque
		                 <input type="radio" value="Transfer" style="margin-left: 1%;" name="payMode" onclick="displayBank('bankDetails')" /> Transfer
		               </div>
	             	</div>
	             	
	             	<div class="control-group" id="chequeDetails" style=" display: none;">
	             	   <label class="control-label">Cheque Number : </label>
		               <div class="controls">
		                 <input type="text" placeholder="Cheque Number" name="chequeNo" id="chequeNo"/>
		               </div>
	             	</div>
		            
	             	
	             	<div class="control-group" id="bankDetails" style=" display: none;">
	             	   <label class="control-label">Bank Details : </label>
		               <div class="controls" style="width: 44%;">
		                 <select name="bankInfo" id="bankInfo" >
            				<option value=""> Select Bank Account</option>
			            	  <%
			            	  		List List1 = rd.getBank();
			            	  		Iterator itr6 = List1.iterator();
				              		while(itr6.hasNext()){
				              			
				              			Object bankid=itr6.next();
				              			Object bankname=itr6.next();
				              %>
					                	<option value="<%=bankid%>"><%=bankname%></option>
					           <%
				              		}
					           %>   
       					</select>  
		               </div>
	             	</div>
		            
				</div>
			</div>
			
			<input type="hidden" name="clientID2" id="clientID2" />
			
			<div class="modal-footer">
				<input type="submit" id="paymentSubmitbtn" name="paymentSubmitbtn" class="btn btn-primary" value="Submit" />
				<a href="#" class="btn btn-danger" data-dismiss="modal">Cancel</a>
			</div>
	
		</form>
	</div>
</div>


	<div class="modal hide fade" id="createBill" name="bill" role="dialog" style="width: 920px; margin-left: -460px;">
	 	<div class="modal-dialog">
			<table style="margin: 0 auto; width: 800px;" id="createBillTable">
				<thead>
					<tr>
						<th colspan="12"><h2 style="color: #ff704d; margin: 0px; ">SARTHAK ENTERPRISES</h2></th>
					</tr>
					<tr>
						<th colspan="12" ><h4 style="margin: 0px;">Mannufacture RCC Pipe & Chember</h4></th>
					</tr>
					<tr style="border-top: 1px; border-top-style: groove;">
						<th colspan="12">A/P-Naigaon,Tal-Haveli,Dist-Pune 412110. Con-No:98814907070/9921267070 E-mail:sbchoudhari11@gmail.com</h2></th>
					</tr>
<!-- 					<tr>
						<th></th>
						<th></th>
						<th></th>
						<th colspan="4" style="padding-left: 68px;">STATE: MAHARASHTRA </th>
						<th colspan="2" style="padding-right: 40px;"> STATE CODE: 27</th>
					</tr> -->					
	<!-- 				.Con-No:98814907070/9921267070 E-mail:sbchoudhari11@gmail.com -->
				</thead>
				<tbody>
					<tr>
						<td colspan="8" style="border: 0;">To,</td>
						<td colspan="4">Bill No : <%=maxid+1 %></td>
					</tr>
					<tr>
					<td colspan="8" style="border: 0;"></td>
						<td colspan="4">Date : <%=requiredDate %></td>
					</tr>
					<tr>
					<td colspan="8" style="border: 0;"></td>
						<td colspan="4">GSTIN : 27ALTPC9493M1Z3</td>
					</tr>
					<tr>
						<th>Sr.No</th>
						<th>Date</th>
						<th>Challan No</th>
						<th>Description</th>
						<th>HSN Code</th>
						<th>GST(%)</th>
						<th>Qty</th>
						<th>Rate</th>
						<th>Taxable Amount</th>
						<th>CGST</th>
						<th>SGST</th>
						<th>Total Amount</th>
					</tr>
					<tr>
						<td>1</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>2</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>3</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					
					
 					<tr>
 						<th colspan="8" style="text-align: right; border: 0;"></th>
						<th style="text-align: right;">Taxable Amount</th>
						<th colspan="3" style="text-align: right;"></th>
					</tr>
					<tr>
						<th colspan="8" style="text-align: right; border: 0;"></th>
						<th style="text-align: right;">CGST</th>
						<th colspan="3" style="text-align: right;"></th>
					</tr>
					<tr>
						<th colspan="8" style="text-align: right; border: 0;"></th>
						<th style="text-align: right;">CGST</th>
						<th colspan="3" style="text-align: right;"></th>
					</tr>
					<tr>
						<th colspan="8" style="text-align: right; border: 0;"></th>
						<th style="text-align: right;" >Total Amount</th>
						<th colspan="3" style="text-align: right;" id="totalamt"><%-- <%=sum %> --%></th>
					</tr>

					<tr>
						<th colspan="12" style="text-align: right;">(In Words)&nbsp;:- <i id="print_inwords"></i></th>
					</tr>

					<tr>
						<th colspan="12" style="text-align: right; height: 70px;" valign="bottom">For Sarthak Enterprises</th>
					</tr>
				</tbody>
			</table>
	
			<!-- <button id="btnPrint" onclick="printData()">Print Preview</button> -->

			
			<div class="modal-footer">
				<div class="form-actions">
					<button type="submit" name="insertorganizer" class="btn btn-success" style="float: right;" onclick="myFunction()" >Submit</button>
				</div>
			</div>
		</div>
	</div>

<!-- 	
<div class="modal hide fade zoom-out" id="checkboxError" role="dialog" >
	<div class="modal-header">
		<a class="close" data-dismiss="modal"></a>
		<i style=" font-size: 180%; color: #ec971f;" class="icon-warning-sign"> <h4 style="color: #ec971f; margin-left: 5%; margin-top: -4%; "> Warning </h4> </i> 
	</div>
	
	<div class="modal-body" style="padding: 0;">
		<form class="form-horizontal" action="" method="post" name="">
			<div class="form-group">
				<div class="widget-content nopadding">
					
					<div align="center" class="control-group">
						<h4> Please select at least one record(s)..!!  </h4>
					</div>
					
				</div>
			</div>
			<div class="modal-footer">
				<a href="#" class="btn btn-primary" data-dismiss="modal">OK</a>
			</div>
	
		</form>
	</div>
</div>	
	 -->

<script type="text/javascript">

function getAllCheckBoxes(){
	
	if(document.getElementById("getAll").checked==true){
		
		var iCount=document.getElementById("iCount").value;
		var grandTotal=0;
		var tAmount=0;
		var tGst=0;
		if(iCount>0){
			for (var i = 1; i <= iCount; i++) {
				var qty = document.getElementById('tdId'+i).children[5].innerHTML.trim();
				var rate = document.getElementById('tdId'+i).children[6].innerHTML.trim();
				var gstper = document.getElementById('tdId'+i).children[7].innerHTML.trim();
				tAmount+=qty*rate;
				tGst+=(qty*rate*gstper)/100;
				grandTotal+=(qty*rate)+(qty*rate*gstper)/100;
				var dataCount=document.getElementById('tdId'+i).children[1].rowSpan;
				for(var j=1;j<dataCount;j++)
				{
					
					var qty1 = document.getElementById('innerTR_'+i+"_"+j).children[1].innerHTML.trim()
					var rate1 = document.getElementById('innerTR_'+i+"_"+j).children[2].innerHTML.trim()
					var gstper1 = document.getElementById('innerTR_'+i+"_"+j).children[3].innerHTML.trim()
					var innerTotal=(qty1*rate1)+(qty1*rate1*gstper1)/100;
					tGst+=(qty1*rate1*gstper1)/100;
					tAmount+=qty1*rate1;
					grandTotal+=innerTotal;
				}	
			}
			
			document.getElementById('totalAmount').innerHTML=tAmount;
			document.getElementById('totalAmountGST').innerHTML=grandTotal;
			inWords();
		}
		alert(tGST);

		//document.getElementById('chalanSubmitBtn').disabled=false;		
	}
	else{
		document.getElementById('totalAmount').innerHTML="";
		document.getElementById('totalAmountGST').innerHTML="";
		document.getElementById('chalanSubmitBtn').disabled=true;
	}
	
}

function selectChecks(id)
{
	
	var iCount=document.getElementById("iCount").value;

}

function setClientId() {	
	document.getElementById("clt_id").value = document.getElementById("clientid").value;
	var s = document.getElementById("clt_id").value;
	//window.location.replace("?ppid="+s);
	
	var f=document.getElementById("chalanForm");
    f.action='/SAMERP/jsp/admin/sale/salePayment.jsp?ppid='+s;
    f.method="post";
    f.submit();  
}

function setSelectValue(){

	inWords();
	var m = <%=request.getParameter("ppid") %>
	var e = document.getElementById("clientid");

	
	if(m!=null){
		e.value=m;
	}
	var txt = e.options[e.selectedIndex].text;
	getSetSelect('s2id_clientid', txt);
	snackBar();
	
}

function getSetSelect(id,value)
{
	var x=document.getElementById(id).children;
	var xx=x[0].children;
	xx[0].innerHTML=value;
}

function showdata(id){
	 var x = document.getElementById(id);
	   
	    $('.widget-box').hide();
	    x.style.display = "block";
}

function selectedChalan(){
	var checked = [];
	$(":checkbox").each(function() {
	    if(this.checked){
	    	if(isFinite(this.id))
		        checked.push(this.id);
	    } 
	});
	document.getElementById("checkedChalan").value=checked;
	
	if(checked.length>0){
		$('#billEntry').modal('show');
	}else{
		$('#checkboxError').modal('show');
	}
}

function displayBank(id, id1){
	var x = document.getElementById(id);
	var y = document.getElementById(id1);
	
	if( x==null ){
		document.getElementById("chequeNo").required=false;
		document.getElementById("bankInfo").required=false;
		
		document.getElementById("chequeDetails").style.display = "none";
		document.getElementById("bankDetails").style.display = "none";
		
	}
	else if(x!=null && y!=null){
		x.style.display = "block";
		y.style.display = "block";
		
		document.getElementById("chequeNo").required=true;
		document.getElementById("bankInfo").required=true;
	}
	else{	

		document.getElementById("chequeNo").required=false;
		document.getElementById("chequeDetails").style.display = "none";
		
		x.style.display = "block";
		document.getElementById("bankInfo").required=true;
	}
}

function snackBar() {
    var x = document.getElementById("snackbar")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}



function inWords()
{
    var str = document.getElementById("totalAmount").innerHTML;
    var splt = str.split("");
    var rev = splt.reverse();
    var once = ['Zero', ' One', ' Two', ' Three', ' Four', ' Five', ' Six', ' Seven', ' Eight', ' Nine'];
    var twos = ['Ten', ' Eleven', ' Twelve', ' Thirteen', ' Fourteen', ' Fifteen', ' Sixteen', ' Seventeen', ' Eighteen', ' Nineteen'];
    var tens = ['', 'Ten', ' Twenty', ' Thirty', ' Forty', ' Fifty', ' Sixty', ' Seventy', ' Eighty', ' Ninety'];

    numLength = rev.length;
    var word = new Array();
    var j = 0;

    for (i = 0; i < numLength; i++) {
        switch (i) {

            case 0:
                if ((rev[i] == 0) || (rev[i + 1] == 1)) {
                    word[j] = '';
                }
                else {
                    word[j] = '' + once[rev[i]];
                }
                word[j] = word[j];
                break;

            case 1:
                aboveTens();
                break;

            case 2:
                if (rev[i] == 0) {
                    word[j] = '';
                }
                else if ((rev[i - 1] == 0) || (rev[i - 2] == 0)) {
                    word[j] = once[rev[i]] + " Hundred ";
                }
                else {
                    word[j] = once[rev[i]] + " Hundred and";
                }
                break;

            case 3:
                if (rev[i] == 0 || rev[i + 1] == 1) {
                    word[j] = '';
                }
                else {
                    word[j] = once[rev[i]];
                }
                if ((rev[i + 1] != 0) || (rev[i] > 0)) {
                    word[j] = word[j] + " Thousand";
                }
                break;

                
            case 4:
                aboveTens();
                break;

            case 5:
                if ((rev[i] == 0) || (rev[i + 1] == 1)) {
                    word[j] = '';
                }
                else {
                    word[j] = once[rev[i]];
                }
                if (rev[i + 1] !== '0' || rev[i] > '0') {
                    word[j] = word[j] + " Lakh";
                }
                 
                break;

            case 6:
                aboveTens();
                break;

            case 7:
                if ((rev[i] == 0) || (rev[i + 1] == 1)) {
                    word[j] = '';
                }
                else {
                    word[j] = once[rev[i]];
                }
                if (rev[i + 1] !== '0' || rev[i] > '0') {
                    word[j] = word[j] + " Crore";
                }                
                break;

            case 8:
                aboveTens();
                break;

            //            This is optional. 

            //            case 9:
            //                if ((rev[i] == 0) || (rev[i + 1] == 1)) {
            //                    word[j] = '';
            //                }
            //                else {
            //                    word[j] = once[rev[i]];
            //                }
            //                if (rev[i + 1] !== '0' || rev[i] > '0') {
            //                    word[j] = word[j] + " Arab";
            //                }
            //                break;

            //            case 10:
            //                aboveTens();
            //                break;

            default: break;
        }
        j++;
    }

    function aboveTens() {
        if (rev[i] == 0) { word[j] = ''; }
        else if (rev[i] == 1) { word[j] = twos[rev[i - 1]]; }
        else { word[j] = tens[rev[i]]; }
    }

    word.reverse();
    var finalOutput = '';
    for (i = 0; i < numLength; i++) {
        finalOutput = finalOutput + word[i];
    }
    var print =finalOutput +" Only";
    document.getElementById("print_inwords").innerHTML = print;
}
/* sarang */
</script>


<script src="/SAMERP/config/js/jquery.min.js"></script> 
<script src="/SAMERP/config/js/jquery.ui.custom.js"></script> 
<script src="/SAMERP/config/js/bootstrap.min.js"></script> 
<script src="/SAMERP/config/js/bootstrap-datepicker.js"></script> 
<script src="/SAMERP/config/js/jquery.toggle.buttons.js"></script> 
<script src="/SAMERP/config/js/jquery.uniform.js"></script> 
<script src="/SAMERP/config/js/select2.min.js"></script> 
<script src="/SAMERP/config/js/jquery.dataTables.min.js"></script> 
<script src="/SAMERP/config/js/matrix.js"></script> 
<script src="/SAMERP/config/js/matrix.tables.js"></script>
<script src="/SAMERP/config/js/wysihtml5-0.3.0.js"></script> 
<script src="/SAMERP/config/js/jquery.peity.min.js"></script> 
<script src="/SAMERP/config/js/bootstrap-wysihtml5.js"></script>

<script type="text/javascript">
$('#billEntry').on('shown.bs.modal', function () {
	var m = <%=request.getParameter("ppid") %>
	document.getElementById("clientID1").value = m;
	
})

$('#paymentEntry').on('shown.bs.modal', function () {
	var m = <%=request.getParameter("ppid") %>
	document.getElementById("clientID2").value = m;
	
})

</script>

</body>
<script type="text/javascript">

$('#bill').on('shown.bs.modal', function () {
	myFunction();   
})
</script>
</html>