<%@page import="java.util.ArrayList"%>
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
<title>Product Payment</title>
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />
<link rel="stylesheet" href="/SAMERP/config/css/select2.css" /> 
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">

<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>

<style type="text/css">

.table td {
   text-align: center;   
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
</style>

</head>
<body onload="setSelectValue()">
<!--Header-part-->
<div id="header">
  <h1><a href="/SAMERP/dashboard.jsp">SAMERP</a></h1>
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
  <div id="breadcrumb"> <a href="/SAMERP/dashboard.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Product Supplier Payment</a>  </div>
  
  
  <!--Action boxes-->
  <div class="container-fluid" >
    <div class="quick-actions_homepage">
      <ul class="quick-actions">
      <!-- loop for all of them goes here -->
      	<hr>
      	<div class="control-group" style="height: 50px;">
         <!-- <label class="control-label"><span style="color: red;  margin-left: -25%;">*</span>Select Supplier :</label> -->
      
         <div class="controls" style="margin-left: 32%; margin-top: 0.3%; margin-right: 32%;" >
         		<select name="Supplierid" onchange="setSupId()" id="Supplierid" autofocus  required >
            	<option value=""> Select Supplier</option>
            	  <%
            	  		RequireData rd = new RequireData();
            	  		List supplierList1 = rd.getSupplierList();
            	  		Iterator itr1 = supplierList1.iterator();
	              		while(itr1.hasNext()){
	              %>
		                	<option value="<%=itr1.next()%>"><%=itr1.next()%></option>
		           <%
	              		}
		           %>   
       		</select>  
       		
       		<input type="hidden" name="supid" id="supid" />
       		
         </div>
        </div>
      	<div class="quick-actions_homepage offset3">
		<li class="bg_lb" style = "background: #0455a9;"> <a href="#" onclick="showdata('paymentDetails')" > <i class="icon-desktop"></i><span class="label label-success"></span>View Balance</a> </li>
		<li class="bg_lb" style = "background: #0455a9;" > <a href="#" onclick="showdata('billDetails')" > <i class="icon-list-alt"></i><span class="label label-success"></span>Bill Entry</a> </li>
		<li class="bg_lb" style = "background: #0455a9;"> <a href="#paymentEntry" data-toggle='modal' onclick="showdata()" > <i class="icon-money"></i><span class="label label-success"></span>Payment Entry</a> </li>
      </div></ul>
    </div>
  </div>
  <!--End-Action boxes-->
   
</div>
  <div class="container-fluid" >
    <hr>
   	<div class="row-fluid">
    <div class="span12">
    <div class="widget-box" id="billDetails" style="display:none;">
          <div class="widget-title"> <span class="icon">
            <input type="checkbox" id="title-checkbox" name="title-checkbox" />
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
                  <th>Vehicle Number</th> 
                  <th width="20%">Product Name</th>
                  <th>Quantity</th>
                  <th>Rate</th>
                </tr>
              </thead>
              <tbody>
              
                <% 
                String s = request.getParameter("ppid");
            	System.out.println(s);
            		
            	if(s!=null){
	              	List chalanList = rd.getChalanDetails(s);
	              	Iterator itr2 = chalanList.iterator();
	              	
	              	int i=1;
	              	
	              	while(itr2.hasNext()){
	              		
	              		String pid = itr2.next().toString();
	              		String span = itr2.next().toString();
	              %>
	                <tr id="tdId<%=i%>">
	                  <td rowspan="<%=span%>"><input id="<%= pid%>" type="checkbox" /></td>
	                  <td rowspan="<%=span%>"> <%=i%> </td>
	                  <td id="mytd<%=i%>" rowspan="<%= span%>"><%=itr2.next() %></td>
	                  <td rowspan="<%= span%>"><%=itr2.next() %></td>
	                  <td rowspan="<%= span%>"><%=itr2.next() %></td>
	                  
	     			  <%
	     			 	itr2.next();
	   			  		List l = rd.getChalanProductDetails(pid);
	   			 		Iterator itr3 = l.iterator();
	   			 	  %>
	   			 	  	
		   			 	<td><%=itr3.next() %></td>
		                <td><%=itr3.next() %></td>
		                <td><%=itr3.next() %></td>
	                
	   			 	  <%
	   			 		while(itr3.hasNext()){
	     			  %>	
	     				<tr>
	     				<td><%=itr3.next() %></td>
		                <td><%=itr3.next() %></td>
		                <td><%=itr3.next() %></td>
		                
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
              </tbody>
            </table>
           </form>
         </div>
         <a href="" id="chalanSubmitBtn" onclick="selectedChalan()" class="btn btn-success" style=" margin-left: 50%; margin-top: 3%;" data-toggle='modal'>Submit</a><hr style="    border-top-color: #c5bbbb;">
      </div>
      
      
      
      
      
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
                 <th>Credit Amount</th>
                 <th>Debit Amount</th>
                 <th>Mode</th>
                 <th>Cheque Number</th>
                 <th>Bank Account</th>
                 <th>Total Balance</th>
               </tr>
             </thead>
             <tbody>
             <%
             	
             	List payList = new ArrayList();
             	if(request.getParameter("ppid")!=null){
             		
             		payList = rd.getSupplierPaymentDetails(request.getParameter("ppid"));
             	}
             	
             	int i=1;
             	Iterator itr = payList.iterator();
             	while(itr.hasNext()){
             		itr.next();
             		itr.next();
             %>
             
               <tr class="gradeX">
                 <td><%=i %></td>
                 <td><%=itr.next()%></td>
                 <%
	                for(int j=1; j<=6; j++){
	                	Object ss = itr.next();
	                	if(ss!=null){
                 %>			
                 			<td><%=ss%></td>
                 <%	
                 		}else{ 
                 %>		
	                  		<td><%="-"%></td>
	             <%
	                	}
	                }
                 %>
                 
                 <td><%=itr.next()%></td>
               </tr>
               
              <%
              		i++;
            	}
              %>
               
             </tbody>
           </table>
         </div>
       </div>
			        
   
   </div>   
</div>
</div>
</div>
<!--Footer-part-->
<div class="row-fluid">
  <div id="footer" class="span12"> 2013 &copy; Matrix Admin. Brought to you by <a href="http://themedesigner.in">Themedesigner.in</a> </div>
</div>
<!--end-Footer-part--> 

<%-- <div class="modal hide fade zoom-out" id="viewBalanceDetails" style=" margin-left: -36%; width: 70%;" role="dialog" >
	<div class="modal-header">
		<a class="close" data-dismiss="modal"></a>
		<h5> New Payment Entry Details</h5>
	</div>
	
	<div class="modal-body" style="padding-bottom: 0;">
		<form class="form-horizontal" action="" method="post" name="">
			<div class="form-group">
				<div class="widget-content nopadding">
					
	             	<div class="widget-box">
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
			                  <th>Credit</th>
			                  <th>Debit</th>
			                  <th>Particular</th>
			                  <th>Total Balance</th>
			                </tr>
			              </thead>
			              <tbody>
			              <%
			              	
			              	List payList = new ArrayList();
			              	if(request.getParameter("ppid")!=null){
			              		
			              		payList = rd.getSupplierPaymentDetails(request.getParameter("ppid"));
			              	}
			              	
			              	int i=0;
			              	Iterator itr = payList.iterator();
			              	while(itr.hasNext()){
			              		itr.next();
			              	
			              %>
			              
			                <tr class="gradeX">
			                  <td><%=i %></td>
			                  <td><%=itr.next()%></td>
			                  <td><%=itr.next()%></td>
			                  <td><%=itr.next()%></td>
			                  <td><%=itr.next()%></td>
			                  <td><%=itr.next()%></td>
			                  <td><%=itr.next()%></td>
			                </tr>
			                
		                <%
		              		}
		                %>
			                
			              </tbody>
			            </table>
			          </div>
			        </div>
		            
				</div>
			</div>
		</form>
	</div>
	
	<div class="modal-footer">
		<a href="#" class="btn btn-danger" data-dismiss="modal">Close</a>
	</div>
</div> --%>

<div class="modal hide fade zoom-out" id="billEntry" role="dialog" >
	<div class="modal-header">
		<a class="close" data-dismiss="modal"></a>
		<h5> New Bill Entry Details</h5>
	</div>
	
	<div class="modal-body" style="padding: 0;">
		<form class="form-horizontal" action="/SAMERP/productSupplierPayment" method="post" name="">
			<div class="form-group">
				<div class="widget-content nopadding">

					<%
						DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	            		String requiredDate = df.format(new Date()).toString();
					%>
					
	             	<div class="control-group" style="">
	             		<label class="control-label">Bill Number : </label>
			               <div class="controls">
			                 <input type="text" name="billNo" onkeyup="this.value=this.value.toUpperCase()" placeholder="Bill Number" required/>
			               </div>
	             	</div>
	             	
	             	<div class="control-group" style="">
	             		<label class="control-label">Bill Amount : </label>
			               <div class="controls">
			                 <input type="text" name="billAmt" placeholder="Bill Amount" required/>
			               </div>
	             	</div>
	             	
	             	<div class="control-group" style="">
	             		<label class="control-label">Date : </label>
			               <div class="controls">
			                 <input type="date" name="billDate" value="<%= requiredDate%>" required/>
			               </div>
	             	</div>
		            
				</div>
			</div>
			
			<input type="hidden" name="supid1" id="supid1" />
			<input type="hidden" id="checkedChalan" name="checkedChalan" placeholder="Chalan Number(s)">
			
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
		<form class="form-horizontal" action="/SAMERP/productSupplierPayment" method="post" name="">
			<div class="form-group">
				<div class="widget-content nopadding">
					
					<%
						String totalR="";
						if(request.getParameter("ppid")!=null){
							totalR = rd.getTotalRemaining(request.getParameter("ppid"));
						}
					%>
					
					<div class="control-group" style="">
	             	   <label class="control-label">Total Remaining : </label>
		               <div class="controls">
		                 <input type="text" name="remaminAmt" readonly="readonly" placeholder="Total Remaining Amount" value="<%=totalR %>" required/>
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
				              %>
					                	<option value="<%=itr6.next()%>"><%=itr6.next()%></option>
					           <%
				              		}
					           %>   
       					</select>  
		               </div>
	             	</div>
		            
				</div>
			</div>
			
			<input type="hidden" name="supid2" id="supid2" />
			
			<div class="modal-footer">
				<input type="submit" id="paymentSubmitbtn" name="paymentSubmitbtn" class="btn btn-primary" value="Submit" />
				<a href="#" class="btn btn-danger" data-dismiss="modal">Cancel</a>
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

function myFunction1() {
	  var input, filter, table, tr, td, i, j, index, num, span1, t;
	  input = document.getElementById("myInput");
	  filter = input.value.toUpperCase();
	  table = document.getElementById("chalanDetailsTable");
	  tr = table.getElementsByTagName("tr");
	  for (i = 0; i < tr.length; i++) {
		  
		index = tr[i].getElementsByTagName("td")[1];
	    td = tr[i].getElementsByTagName("td")[2];

	    if (td) {
	      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
	    	  num = index.innerHTML;
	    	  //alert("num"+num.trim());
	    	  
	    	  if(isFinite(num.trim())){
	    		//alert("mytd"+num);
	    		var x=document.getElementById("tdId"+num.trim()).childNodes;
	    		
	    		span1 = x[1].rowSpan;

	    		//alert("span "+span1);
	    		var count=0;
	    		while(span1>0){
	    			alert("tr"+i);
	    			tr[i].style.display = "";
	    			span1--;
	    			
	    			if(span1>0){
		    			i++;
	    			} 
	    			
	    		}
	    	  }
		        
	      } else {
	    	//alert("tr"+i);
	        tr[i].style.display = "none";
	      }
	    }       
	  }
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

function setSupId() {	
	document.getElementById("supid").value = document.getElementById("Supplierid").value;
	var s = document.getElementById("supid").value;
	//window.location.replace("?ppid="+s);
	
	if(s!=""){
		var f=document.getElementById("chalanForm");
	    f.action='/SAMERP/jsp/admin/productPurchase/productSupplierPayment.jsp?ppid='+s;
	    f.method="post";
	    f.submit();  
	}
}

function setSelectValue(){
	var m = <%=request.getParameter("ppid") %>
	var e = document.getElementById("Supplierid");

	if(m!=null){
		e.value=m;
	}
	var txt = e.options[e.selectedIndex].text;
	getSetSelect('s2id_Supplierid', txt);
	myFunction();
}

function myFunction() {
    var x = document.getElementById("snackbar")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}

function getSetSelect(id,value)
{
	var x=document.getElementById(id).children;
	var xx=x[0].children;	
	xx[0].innerHTML=value;
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
	document.getElementById("supid1").value = m;
	
})

$('#paymentEntry').on('shown.bs.modal', function () {
	var m = <%=request.getParameter("ppid") %>
	document.getElementById("supid2").value = m;
	
})
</script>

</body>
</html>