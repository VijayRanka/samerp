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
/* 
td{
   text-align: -webkit-center;  
}
*/

 .modal.fade.in {
    top: 5%;
}
.createBillSarthak{
    position: relative;
    max-height: 510px;
    padding: 15px;
    overflow-y: auto;
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
         <label class="control-label"><span style="color: red;  margin-left: -32%;">*</span>Select Client :</label>
      
         <div class="controls" style="margin-left: 38%; margin-top: -2.7%; margin-right: 32%;" >
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
     
     		<div class="quick-actions_homepage" style="margin-left: 205px;">	
     		<li class="bg_ls"> <a href="#" onclick="showdata('paymentDetails')" > <i class="icon-desktop"></i><span class="label label-success"></span>View Balance</a> </li>
     		<li class="bg_ls"> <a href="#" onclick="showdata('billDetails')" > <i class="icon-list-alt"></i><span class="label label-success"></span>Generate Bill</a> </li>
     		<li class="bg_ls"> <a href="#paymentEntry" data-toggle='modal' onclick="showdata()" > <i class="icon-money"></i><span class="label label-success"></span>Payment Received</a> </li>
     		<li class="bg_ls"> <a href="#" onclick="showdata('showBills')" > <i class="icon-desktop"></i> <span class="label label-important"></span>View Bills</a></li>     		
     		</div>
     		
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
                  <th style="width: 140px;">Rate</th>
                  <th style="width: 80px;">GST</th>
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
	                  <td rowspan="<%=span%>"><input id="check_<%=i %>" type="checkbox" onclick="selectChecks(this.id)"/></td>
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
               		<td style="border-left: 0;">  </td>
               		<td style="border-left: 0;">  </td>
               		<td style="border-left: 0;">  </td>
               		<td style="border-left: 0;">  </td>
               		<td style="border-left: 0;">  </td>
               		<td style="border-left: 0;">  </td>
               		<td style="text-align: right; background-color: #efefef; font-weight: 700">Total Amount</td>
               		<td id="totalAmount" style="text-align: center; ">  </td>
               </tr>

               <tr>
               		<td style="border: 0">  </td>
               		<td style="border: 0">  </td>
               		<td style="border: 0">  </td>
               		<td style="border: 0">  </td>
               		<td style="border: 0">  </td>
               		<td style="border: 0">  </td>
               		<td style="text-align: right; background-color: #efefef; font-weight: 700">GST</td>
               		<td id="totalGST" style="text-align: center; ">  </td>
               </tr> 
               
               <tr>
               		<td style="border: 0">  </td>
               		<td style="border: 0">  </td>
               		<td style="border: 0">  </td>
               		<td style="border: 0">  </td>
               		<td style="border: 0">  </td>
               		<td style="border: 0">  </td>
               		<td style="text-align: right;  background-color: #efefef; font-weight: 700"> Total Amount with GST</td>
               		<td id="totalAmountGST" style="text-align: center; ">  </td>
               </tr>               
              </tbody>
            </table>

           </form>
         </div>
         <button  id="chalanSubmitBtn" onclick="selectedChalan()" disabled="disabled"  class="btn btn-success" style=" margin-left: 45%; margin-top: 3%;" data-toggle='modal'>Generate Bill</button>
         <hr style="borde
         r-top-color: #c5bbbb;">
      </div>
      
      
     <div class="widget-box" id="showBills" style="display:none;">
		        <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
          <h5>Data table</h5>
        </div>
        <div class="widget-content nopadding">
          <table class="table table-bordered data-table">
            <thead>
              <tr>
			 	 <th>Sr.No.</th>
                 <th>Bill Number</th>
                 <th>Date</th>
                 <th>Bill Amount</th>
                 <th>Action</th>  
              </tr>
            </thead>
            <tbody>
            <%
          		if(request.getParameter("ppid")!=null){
          			int count=0;
          			String clientID=request.getParameter("ppid");
          			List list=rd.getClientBillDetails(Integer.parseInt(clientID));
          			Iterator iterator=list.iterator();
          			while(iterator.hasNext()){
          				
          				String bill_id=iterator.next().toString();
          			
          	%>
          				<tr>
          					<td><%=++count %></td>
          					<td><%=bill_id %></td>
           					<td><%=iterator.next() %></td>
           					<td><%=iterator.next() %></td>
           					<td><a class="tip" title="Bill Print" <%-- onclick="getDeleteId('<%=sid%>')" --%> 
           						href="#createBillAgain" data-toggle='modal'><i class="icon-print"></i></a>
           					</td>       				
          				</tr>
          	<% 		
          			}
          		}
            %>

            </tbody>
          </table>
        </div>
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
		                 <input type="text" name="remaminAmt" placeholder="Total Remaining Amount" readonly="readonly" value="<%=totalRemaining %>" required/>
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


<!-- Bill  -->
<div class="modal hide fade" id="createBill" name="bill" role="dialog" style="width: 920px; margin-left: -460px;max-height: 600px">
  <div class="modal-dialog" role="document">
   <form class="form-horizontal" action="/SAMERP/SalePayment" method="post">
    <div class="modal-content">
      <div class="modal-body createBillSarthak" id="showModal">
	     
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
				
					    <%
	             			String maxid_temp=rd.getClientBillMaxId();
	             			int maxid=Integer.parseInt(maxid_temp);
	             		%>
					<tr>
						<td colspan="8" style="border: 0;">To,</td>
						<td colspan="4">Bill No : <%=maxid+1 %></td>
					</tr>
					<%
					String clientId = request.getParameter("ppid");
					List clientInfo=null;
					String name=null;
					String address=null;
					String gstin=null;
					if(clientId!=null){
						clientInfo=rd.getClientData(Integer.parseInt(clientId));
						name=clientInfo.get(0).toString();
						address = clientInfo.get(1).toString();
						if(clientInfo.get(2)!=null){
							gstin=clientInfo.get(2).toString();
						}else
							gstin=" ";
					}	
					

					
					%>
					<tr>
						<td colspan="3" style="border: 0;"><%=name %></td>
						<td colspan="5" style="border: 0;">GSTIN : <%=gstin %></td>
						<td colspan="4">Date : <%=requiredDate %></td>
					</tr>
					<tr>
					<td colspan="8" style="border: 0;"><%=address %></td>
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
						<th style="width: 105px;">Taxable Amount</th>
						<th>CGST</th>
						<th>SGST</th>
						<th>Total Amount</th>
					</tr>
					<tbody id="saleDetailsData">
					</tbody>
					
					
 					<tr>
 						<td colspan="8" style="text-align: left; border: 0;">TERMS & CONDITIONS :</td>
						<th style="text-align: right;">Taxable Amount</th>
						<th colspan="3" style="text-align: center;"><i id="totalAmount_1" ></th>
					</tr>
					<tr>
						<td colspan="8" style="text-align: left; border: 0;">1. Payment Within 30 days of delivery</td>
						<th style="text-align: right;">CGST</th>
						<th colspan="3" style="text-align: center;"><i id="CGST_1" ></th>
					</tr>
					<tr>
						<td colspan="8" style="text-align: left; border: 0;">2. Guarantee doesn't cover mishandling of component after delivery</td>
						<th style="text-align: right;">SGST</th>
						<th colspan="3" style="text-align: center;"><i id="SGST_1" ></th>
					</tr>
					<tr>
						<td colspan="8" style="text-align: left; border: 0;">3. We declare that this invoice shows the actual price of the goods described and that all particulars are true and correct</th>
						<th style="text-align: right;" >Total Amount</th>
						<th colspan="3" style="text-align: center;" id="totalamt"><i id="totalAmountGST_1" ></i></th>
					</tr>

					<tr>
						<th colspan="12" style="text-align: right;">(In Words)&nbsp;:- <i id="print_inwords"></i></th>
					</tr>
					<tr>
						<th colspan="12" style="text-align: right; height: 70px;" valign="bottom">For Sarthak Enterprises</th>
					</tr>
				</tbody>
			</table>
			<input type="hidden" name="clientID1" id="clientID1" />
			<input type="hidden" name="billNumber" id="billNumber" value="<%= (maxid+1) %>" />
			<input type="hidden" name="billDate" value="<%= requiredDate%>"/>
			<input type="hidden" id="totalBillAmount" name="totalBillAmount" value=""/>
			<input type="hidden" id="checkedChalan" name="checkedChalan">
      </div> 
      <div class="modal-footer">
        <button type="submit" name="generateBillData" class="btn btn-primary" onclick="printData()" style="margin-right:5px;">Save & Create Bill</button> 
          </div>
    </div>
   </form>
  </div>
</div>



<!-- A Bill  -->
<div class="modal hide fade" id="createBillAgain" name="bill" role="dialog" style="width: 920px; margin-left: -460px;max-height: 600px">
  <div class="modal-dialog" role="document">
   <form class="form-horizontal" action="/SAMERP/SalePayment" method="post">
    <div class="modal-content">
      <div class="modal-body createBillSarthak" id="showModal">
	     
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


				</thead>
				<tbody>
				

					<tr>
						<td colspan="8" style="border: 0;">To,</td>
						<td colspan="4">Bill No : <%=1 %></td>
					</tr>
					<%
					String client_Id = request.getParameter("ppid");
					List client_Info=null;
					String name1=null;
					String address1=null;
					String gstin1=null;
					if(client_Id!=null){
						client_Info=rd.getClientData(Integer.parseInt(clientId));
						name1=client_Info.get(0).toString();
						address1 = client_Info.get(1).toString();
						if(client_Info.get(2)!=null){
							gstin1=client_Info.get(2).toString();
						}else
							gstin1=" ";
					}	
					

					
					%>
					<tr>
						<td colspan="3" style="border: 0;"><%=name1 %></td>
						<td colspan="5" style="border: 0;">GSTIN : <%=gstin1 %></td>
						<td colspan="4">Date : <%=1 %></td>
					</tr>
					<tr>
					<td colspan="8" style="border: 0;"><%=address1 %></td>
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
						<th style="width: 105px;">Taxable Amount</th>
						<th>CGST</th>
						<th>SGST</th>
						<th>Total Amount</th>
					</tr>
					<tbody id="saleDetailsData">
					</tbody>
					
					
 					<tr>
 						<td colspan="8" style="text-align: left; border: 0;">TERMS & CONDITIONS :</td>
						<th style="text-align: right;">Taxable Amount</th>
						<th colspan="3" style="text-align: center;"><i id="totalAmount_1" ></th>
					</tr>
					<tr>
						<td colspan="8" style="text-align: left; border: 0;">1. Payment Within 30 days of delivery</td>
						<th style="text-align: right;">CGST</th>
						<th colspan="3" style="text-align: center;"><i id="CGST_1" ></th>
					</tr>
					<tr>
						<td colspan="8" style="text-align: left; border: 0;">2. Guarantee doesn't cover mishandling of component after delivery</td>
						<th style="text-align: right;">SGST</th>
						<th colspan="3" style="text-align: center;"><i id="SGST_1" ></th>
					</tr>
					<tr>
						<td colspan="8" style="text-align: left; border: 0;">3. We declare that this invoice shows the actual price of the goods described and that all particulars are true and correct</th>
						<th style="text-align: right;" >Total Amount</th>
						<th colspan="3" style="text-align: center;" id="totalamt"><i id="totalAmountGST_1" ></i></th>
					</tr>

					<tr>
						<th colspan="12" style="text-align: right;">(In Words)&nbsp;:- <i id="print_inwords"></i></th>
					</tr>
					<tr>
						<th colspan="12" style="text-align: right; height: 70px;" valign="bottom">For Sarthak Enterprises</th>
					</tr>
				</tbody>
			</table>
			<input type="hidden" name="clientID1" id="clientID1" />
			<input type="hidden" name="billNumber" id="billNumber" value="<%= (maxid+1) %>" />
			<input type="hidden" name="billDate" value="<%= requiredDate%>"/>
			<input type="hidden" id="totalBillAmount" name="totalBillAmount" value=""/>
			<input type="hidden" id="checkedChalan" name="checkedChalan">
      </div> 
      <div class="modal-footer">
        <button type="submit" name="generateBillData" class="btn btn-primary" onclick="printData()" style="margin-right:5px;">Save & Create PDF</button> 
          </div>
    </div>
   </form>
  </div>
</div>
 	
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
			document.getElementById('totalGST').innerHTML=tGst;
			document.getElementById('CGST_1').innerHTML=tGst/2;
			document.getElementById('SGST_1').innerHTML=tGst/2;
			document.getElementById('totalAmount').innerHTML=tAmount;
			document.getElementById('totalAmount_1').innerHTML=tAmount;
			document.getElementById('totalAmountGST').innerHTML=grandTotal;
			document.getElementById('totalAmountGST_1').innerHTML=grandTotal;
			document.getElementById('totalBillAmount').value=grandTotal;
			
			document.getElementById('chalanSubmitBtn').disabled=false;
			
		}
		inWords();
	}
	else{
		document.getElementById('totalGST').innerHTML="";
		document.getElementById('totalAmount').innerHTML="";
		document.getElementById('totalAmount_1').innerHTML="";
		document.getElementById('totalAmountGST').innerHTML="";
		document.getElementById('totalAmountGST_1').innerHTML="";
		document.getElementById('totalBillAmount').value="";
		document.getElementById('SGST_1').innerHTML="";
		document.getElementById('CGST_1').innerHTML="";
		document.getElementById('chalanSubmitBtn').disabled=true;
		inWords();
	}
	
}

function selectedChalan(){
	 document.getElementById("saleDetailsData").innerHTML="";
	 document.getElementById('checkedChalan').value="";
	var chalanNo = [];
	var iCount=document.getElementById("iCount").value;
	var chalan="";
	var status=0;
	for (var i = 1; i <= iCount; i++) {
		var checkBox=document.getElementById("check_"+i);
		if(checkBox.checked === true){	
			var c = document.getElementById('tdId'+i).children[2].innerHTML.trim();
			chalan+=c+",";
			status++;
		}
	}
	document.getElementById('checkedChalan').value=chalan;
	var mainLength=chalan.split(",").length-1;
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
  			var demoStr = this.responseText.split(",");
  			
  			var data1="",data2="",data3="",wholeData="";
  			var i=0,l=0;
  			var totalAmount=0;
  			 for(var j=1;j<=mainLength;j++)
  				{
  				 
  				 var count=l;
  				 l++;
  				data1="";data2="";
  				data1="<tr>"+
					"<td rowspan='"+demoStr[count]+"' valign='top' style='vertical-align: middle; text-align: -webkit-center;'>"+j+"</td>"+
					"<td rowspan='"+demoStr[count]+"' valign='top' style='vertical-align: middle; text-align: -webkit-center;'>"+demoStr[l++]+"</td>"+
					"<td rowspan='"+demoStr[count]+"' valign='top' style='vertical-align: middle; text-align: -webkit-center;'>"+demoStr[l++]+"</td>";
					for(var k=1;k<=demoStr[count];k++)
						{
						
						
						
						if(k==1)
							{
							if(totalAmount!=0){
								if(demoStr[count]>1)
									{
									totalAmount+=8*demoStr[count]+4;
									}
								}else
									{
									totalAmount=8*demoStr[count]+3;
									
									}
							
							data2+="<td style='text-align: -webkit-center;'>"+ demoStr[l++] +"</td>"+
							"<td style='text-align: -webkit-center;' >"+demoStr[l++]+"</td>"+
							"<td style='text-align: -webkit-center;'>"+demoStr[l++]+"</td>"+
							"<td style='text-align: -webkit-center;'>"+demoStr[l++]+"</td>"+
							"<td style='text-align: -webkit-center;'>"+demoStr[l++]+"</td>"+
							"<td style='text-align: -webkit-left;'>"+demoStr[l++]+"</td>"+
							"<td style='text-align: -webkit-center;'>"+demoStr[l++]+"</td>"+
							"<td style='text-align: -webkit-center;'>"+demoStr[l++]+"</td>"+
							"<td style='text-align:center; vertical-align: middle; ' rowspan='"+demoStr[count]+"' valign='bottom'>"+demoStr[totalAmount]+"</td>"+
						"</tr>";
							}
						else{
							data2+="<tr>"+
								"<td style='text-align: -webkit-center;'>"+demoStr[l++]+"</td>"+
								"<td style='text-align: -webkit-center;'>"+demoStr[l++]+"</td>"+
								"<td style='text-align: -webkit-center;'>"+demoStr[l++]+"</td>"+
								"<td style='text-align: -webkit-center;'>"+demoStr[l++]+"</td>"+
								"<td style='text-align: -webkit-center;'>"+demoStr[l++]+"</td>"+
								"<td style='text-align: -webkit-left;'>"+demoStr[l++]+"</td>"+
								"<td style='text-align: -webkit-center;'>"+demoStr[l++]+"</td>"+
								"<td style='text-align: -webkit-center;'>"+demoStr[l++]+"</td>"+
							"</tr>";
							
						}
						}
					l++;
					wholeData+=data1+data2;
				}
  			 document.getElementById("saleDetailsData").innerHTML=wholeData;
  			 
     	}
     };     
     xhttp.open('POST', "/SAMERP/SalePayment?dataByChalan=1&chalanNos=" +chalan , true);
     xhttp.send();
	if(status>0){
		$('#createBill').modal('show');
	}else{
		$('#checkboxError').modal('show');
	}
}


function selectChecks(id)
{
	var count=id.split("_")[1];
	var TotalCount=document.getElementById("iCount").value;
	//alert(TotalCount+" "+count);
	var grandTotal=0;
	var tAmount=0;
	var tGst=0;
	
	for(var i=1;i<=TotalCount;i++)
	{
		var checkBox=document.getElementById("check_"+i);
		if(checkBox.checked === true){
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
			document.getElementById('chalanSubmitBtn').disabled=false;
		}
		document.getElementById('CGST_1').innerHTML=tGst/2;
		document.getElementById('SGST_1').innerHTML=tGst/2;
		document.getElementById('totalAmountGST_1').innerHTML=grandTotal;
		document.getElementById('totalAmount_1').innerHTML=tAmount;
		document.getElementById('totalGST').innerHTML=tGst;
		document.getElementById('totalAmount').innerHTML=tAmount;
		document.getElementById('totalAmountGST').innerHTML=grandTotal;
		document.getElementById('totalBillAmount').value=grandTotal;
		inWords();
	}
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
    var str = document.getElementById("totalAmountGST").innerHTML;
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

//===============================================PRINT========================================
function printData()
{
   var divToPrint=document.getElementById("createBillTable");
   var htmlToPrint = '' +       
   	   '<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />'+
	   '<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />'+
	   '<link rel="stylesheet" href="/SAMERP/config/css/colorpicker.css" />'+
	   '<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />'+
	   '<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />'+
	   '<link rel="stylesheet" href="/SAMERP/config/css/select2.css" />'+
	   '<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-wysihtml5.css" />'+
	   '<style type="text/css">' +
		'#createBillTable tbody {'+
		'border: 1px;'+
		'border-style: groove;'+
	'}'+
   '#createBillTable tbody tr td{'+
		'border: 1px;'+
		'border-style: groove;'+
	'}'+
	'#createBillTable tbody tr th{'+
		'border: 1px;'+
		'border-style: groove;'+
		'font-size: x-small;'+
	'}'+
	'h2,h3,h6{'+
		'margin:-3px 0;'+
	'}'+
   '</style>';
   htmlToPrint += divToPrint.outerHTML+"</table>";
   newWin= window.open("");
   newWin.document.write(htmlToPrint);
 //  newWin.print();
//	   newWin.close();
}
//===================================End PRINT=================================================


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
$('#createBill').on('shown.bs.modal', function () {
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