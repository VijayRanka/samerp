<%@page import="java.util.ArrayList"%>
<%@page import="utility.SysDate"%>
<%@page import="dao.General.GenericDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="utility.RequireData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Supplier Payment</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />
<link rel="stylesheet" href="/SAMERP/config/css/select2.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link rel="stylesheet" href="/SAMERP/config/css/colorpicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bs_modal_transition.css" />
<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
</head>
<style>

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
    bottom: 30px;
    font-size: 15px;
    border-radius:50px 50px;
}

#snackbar.show {
    visibility: visible;
    -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
    animation: fadein 0.5s, fadeout 0.5s 2.5s;
}

@-webkit-keyframes fadein {
    from {bottom: 0; opacity: 0;} 
    to {bottom: 30px; opacity: 1;}
}

@keyframes fadein {
    from {bottom: 0; opacity: 0;}
    to {bottom: 30px; opacity: 1;}
}

@-webkit-keyframes fadeout {
    from {bottom: 30px; opacity: 1;} 
    to {bottom: 0; opacity: 0;}
}

@keyframes fadeout {
    from {bottom: 30px; opacity: 1;}
    to {bottom: 0; opacity: 0;}
}

select {
    background-color: #fff;
    border: 1px solid #ccc;
}
</style>
<body onload="myFunction()">

<!--Header-part-->
<div id="header">
  <h1><a href="#">SARTHAK</a></h1>
</div>

<!--start-top-serch-->
<div id="search">
<% if(request.getAttribute("status")!=null){ %>
<div id="snackbar"><%=request.getAttribute("status")%></div>
<%} %>

  <button type="submit" class="tip-bottom">LOGOUT</button>
</div>
<!--close-top-serch-->
<!--sidebar-menu-->
<jsp:include page="/jsp/admin/common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->

<!--main-container-part-->
<div id="content">
<!--breadcrumbs-->
 <div id="content-header">
    <div id="breadcrumb"> <a href="/SAMERP/dashboard.jsp" class="tip-bottom" data-original-title="Go to Home"><i class="icon-home">
    </i> Home</a> <a href="#" class="current">Supplier Payment(Raw Material)</a> </div>
  </div>
<!--End-breadcrumbs-->
<div class="container-fluid">
  <hr>
  <form id="form-wizard" class="form-horizontal" action="#" method="post">
      <div class="row-fluid">
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-money"></i> </span>
            <h5> Supplier Payment(Raw Material) </h5>
          </div>
          <div class="widget-content nopadding">
            
                 <div class="control-group offset3" id="supErr">
	              <label class="control-label">Select Supplier</label>
	              <div class="controls">
	              	<%String supName=request.getParameter("supName"); %>
	              	<%String id=request.getParameter("bid");%>
	              	<%Object bName=request.getAttribute("businessName"); %>
	              	<%Object bid1=request.getAttribute("bid1"); %>
	                <input type="text" list="getSupplier" id="supplier" <%if(supName==null){ %> <%if(bName==null){ %> value=""  <%} %>  value="<%=bName%>" <%}%>  value="<%=supName%>" oninput="getId(this.value)" name="supName" onfocus="getSup()" autocomplete="off" placeholder="Supplier Name" onkeyup="clearErr()">
	                 <datalist id="getSupplier"></datalist>
	                 <input type="hidden" id="supId" name="supId" <%if(id==null){ %> <%if(bid1==null) {%> value=""  <%} %>  value="<%=bid1%>" <%}%> value="<%=id %>">
	              		<span id="supMsg" class="help-inline" style="display:none">Select Supplier</span>
            		 
	              </div>
	              </div>	

             	<div class="control-group">
                  	<div class="quick-actions_homepage offset3">
				      <ul class="quick-actions">
				      <!-- loop for all of them goes here -->
				        <li class="bg_ls"><a href="#" id="eLink" onclick="viewBalance()"> <i class="icon-desktop"></i><span class="label label-success"></span> View Balance</a> </li>
						<li class="bg_ls"><a href="#" id="entryLink" onclick="billEntry()"> <i class="icon-list-alt"></i><span class="label label-success"></span> Bill Entry</a> </li>
						<li class="bg_ls"> <a href="#" onclick="payment()"> <i class="icon-money"></i><span class="label label-success"></span> Payment</a> </li>
				      </ul>
			    	</div>
				</div>
         		
              
            
          </div>
        </div>
      </div>
    </div>
  <div class="row-fluid viewBillTable"> 
  	<div class="span12">
  		<div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-desktop"></i> </span>
            <h5>View Balance</h5>
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
             	RequireData rd1=new RequireData();
             	List payList = new ArrayList();
             	if(request.getParameter("bid")!=null){
             		
             		payList = rd1.getSupplierPaymentDetails(request.getParameter("bid"));
             	}
             	else if(bid1!=null)
             	{
             		
             		payList = rd1.getSupplierPaymentDetails(bid1.toString());
             	}
             	
             	int i=1;
             	Iterator itr1 = payList.iterator();
             	while(itr1.hasNext()){
             		itr1.next();
             		itr1.next();
             %>
             
               <tr class="gradeX">
                 <td><%=i %></td>
                 <td><%=itr1.next()%></td>
                 <%
	                for(int j=1; j<=6; j++){
	                	Object ss = itr1.next();
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
                 
                 <td><%=itr1.next()%></td>
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

<div class="row-fluid billEntryTable">
  	<div class="span12">
  		<div class="widget-box">
          <div class="widget-title"><span class="icon"> <i class="icon-list-alt"></i> </span>
            <h5>Available Chalan Details</h5>
          </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered table-striped" id="billEntryTab">
              <thead>
                <tr>
                  <th>Select</th>
                  <th>S.No.</th>
                  <th>Chalan No.</th>
                  <th>Date</th>
                  <th>Particulars</th>
                </tr>
              </thead>
              <tbody>
              <% if(supName!=null){%>
				<% String supId=request.getParameter("bid");
					//System.out.print(supId);
					RequireData rd = new RequireData();  
					List billEntry=rd.getBillEntryData(supId);
					Iterator itr=billEntry.iterator();
					if(!billEntry.isEmpty()){
						int count=1;
				%>
				
				<%while(itr.hasNext()) {%>
                <tr>
                  <td style="text-align: center"><input class="messageCheckbox" type="checkbox" name="bill" value="<%=itr.next() %>"></td>
                  <td style="text-align: center"><%=count %></td>
                  <td style="text-align: center"><%=itr.next() %></td>
                  <td style="text-align: center"><%=itr.next() %></td>
                  <td style="text-align: center" id=""><%=itr.next() %></td>
                </tr>
                <%count++;} %>
                <%}else{ %>
                <tr>
                	<td style="text-align: center" colspan="5">This Supplier dont have chalan or its been proccessed</td>
                </tr>
				<%} %>
                <%}else if(bName!=null){ %>
                
                
                <% String supId=bid1.toString();
					//System.out.print(supId);
					RequireData rd = new RequireData();  
					List billEntry=rd.getBillEntryData(supId);
					Iterator itr=billEntry.iterator();
					if(!billEntry.isEmpty()){
						int count=1;
				%>
				
				<%while(itr.hasNext()) {%>
                <tr>
                  <td style="text-align: center"><input class="messageCheckbox" type="checkbox" name="bill" value="<%=itr.next() %>"></td>
                  <td style="text-align: center"><%=count %></td>
                  <td style="text-align: center"><%=itr.next() %></td>
                  <td style="text-align: center"><%=itr.next() %></td>
                  <td style="text-align: center" id=""><%=itr.next() %></td>
                </tr>
                <%count++;} %>
                <%}else{ %>
                <tr>
                	<td style="text-align: center" colspan="5">This Supplier dont have chalan or its been proccessed</td>
                </tr>
				<%} %>
                
                
                
                
                <%} %>
                <tr>
                	<td colspan="5" style="text-align: center"><input type="button" id="tableButton" class="btn btn-primary" value="OK"  data-toggle="modal" data-target="#billEntryModal" onclick="billProcess()" disabled/></td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
  	</div>
  </div>

</form>
</div>

</div>

<!--end-main-container-part-->

<div class="modal hide fade zoom-out" id="billEntryModal" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
   <form class="form-horizontal" action="/SAMERP/RawSupplier" method="post">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Bill Entry Confirmation</h4>
      </div>
      <div class="modal-body">
	     
	        <div class="form-group">
			<div class="widget-content nopadding">
	        	<div class="control-group">
	                  <label class="control-label">Bill No</label>
	                  <div class="controls">
	                       <input type="text" id="bNo" name="bNo" autofocus  required/>
	                       <input type="hidden" id="ids" name="pids" />
	                       <input type="hidden" id="msid" name="msid" />
	                       <input type="hidden" id="busName" name="busName"/>
	         		  </div>
	        	</div>
	        	<div class="control-group">
	                  <label class="control-label">Bill Amount</label>
	                  <div class="controls">
	                       <input type="text" id="bAmt" name="bAmt" required/>
	         		  </div>
	        	</div>
	        	<div class="control-group">
	                  <label class="control-label">Date</label>
	                  <div class="controls">
	                  		<% SysDate sd= new SysDate();
                  			   String date[] =	sd.todayDate().split("-");
                  				//System.out.println("Date is==>"+ date);
              				%>
	                       <input type="date" id="bDate" name="bDate" value="<%= date[2]+"-"+date[1]+"-"+date[0] %>" />
	         		  </div>
	        	</div>
		      </div>
	      	</div>
      </div> 
      <div class="modal-footer">
        <button type="submit" name="billEntry" id="" class="btn btn-primary" style="margin-right:5px;">Add</button> 
        <button type="button" id="" class="btn btn-default" data-dismiss="modal">Close</button>    
      </div>
    </div>
   </form>
  </div>
</div>


<div class="modal hide fade zoom-out" id="payNow" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
   <form class="form-horizontal" action="/SAMERP/RawSupplier" method="post">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Payment For Raw Material Supplier</h4>
      </div>
      <div class="modal-body">
         <div class="form-group">
			<div class="widget-content nopadding">
	        	<div class="control-group">
	                  <label class="control-label">Date</label>
	                  <div class="controls">
	                       <input type="date" id="pDate" name="paidDate" value="<%= date[2]+"-"+date[1]+"-"+date[0] %>" />
	                       
	         		  </div>
	        	</div>
	        	<div class="control-group">
	                  <label class="control-label">Total Amount</label>
	                  <div class="controls">
	                       <input type="text" readonly="readonly" id="pTAmt" name=remaminAmt required/>
	         		  </div>
	        	</div>
	        	<div class="control-group">
	                  <label class="control-label">Paid Amount</label>
	                  <div class="controls">
	                  		<input type="text" id="pAmt" name="paidAmt" required/>
	                  </div>
	        	</div>
	        	<div class="control-group">
	                  <label class="control-label">Payment Mode</label>
	                  <div class="controls">
	                  		<input type="radio" name="payMode" value="Cash" checked style="margin-bottom: 5px;" onchange="pMode('cash')"><span style="margin: 5px;">Cash</span>
  							<input type="radio" id="" name="payMode" value="Cheque" style="margin-bottom: 5px;" onchange="pMode('chq')"><span style="margin: 5px;">Cheque</span>
  							<input type="radio" name="payMode" value="Transfer" style="margin-bottom: 5px;" onchange="pMode('transfer')"><span style="margin: 5px;">Transfer</span>  
	                  </div>
	                  
	        	</div>
	        	
	        	<div class="control-group" id="bankDetails" style="display: none;">
	             	   <label class="control-label">Bank Name : </label>
		               <div class="controls">
		                 <input type="text" list="getBankDetails" oninput="getBankId(this.value)" autocomplete="off" onfocus="getBAlias()" placeholder="Bank Name" name="bankName" id="bankName"/>
		                 <datalist id="getBankDetails"></datalist>
	                 	<input type="hidden" placeholder="Bank id" name="bankInfo" id="bankid"/>
		                 
		               </div>
	            </div>
		      
		      	<div class="control-group" id="chq" style="display: none;">
	             	   <label class="control-label">Cheque No. : </label>
		               <div class="controls">
		                 <input type="text" placeholder="Cheque No." name="chequeNo" id="chqNo"/>
		               </div>
	            </div>
		      	<input type="hidden" name="supid2" id="supid2" />
		      </div>
	      	</div>
      </div> 
      <div class="modal-footer">
        <button type="submit" name="paymentSubmitbtn" class="btn btn-primary" style="margin-right:5px;">Submit</button> 
        <button type="button" id="" class="btn btn-danger" data-dismiss="modal">Close</button>    
      </div>
    </div>
   </form>
  </div>
</div>


<!--Footer-part-->

<div class="row-fluid">
  <div id="footer" class="span12"> 2013 &copy; Matrix Admin. Brought to you by <a href="http://themedesigner.in">Themedesigner.in</a> </div>
</div>

<!--end-Footer-part-->
<script src="/SAMERP/config/js/jquery.min.js"></script> 
<script src="/SAMERP/config/js/bootstrap-colorpicker.js"></script> 
<script src="/SAMERP/config/js/bootstrap-datepicker.js"></script> 
<script src="/SAMERP/config/js/wysihtml5-0.3.0.js"></script> 
<script src="/SAMERP/config/js/jquery.peity.min.js"></script> 
<script src="/SAMERP/config/js/bootstrap-wysihtml5.js"></script> 
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> 
<script src="/SAMERP/config/js/jquery.ui.custom.js"></script> 
<script src="/SAMERP/config/js/jquery.uniform.js"></script> 
<script src="/SAMERP/config/js/select2.min.js"></script> 
<script src="/SAMERP/config/js/jquery.dataTables.min.js"></script> 
<script src="/SAMERP/config/js/matrix.js"></script>
<script src="/SAMERP/config/js/matrix.tables.js"></script>
<script src="/SAMERP/config/js/bootstrap.min.js"></script> 


<script type="text/javascript">

//to show payment modal
function payment()
{
	var supName=document.getElementById('supplier').value
	if(supName=="")
	{
		document.getElementById('supplier').focus();
		var mainDiv=document.getElementById("supErr");
		var msg=document.getElementById("supMsg");
		
		mainDiv.setAttribute("class", "control-group offset3 error");
		msg.setAttribute("style","display:block");
	}
	else
	{
		$('#payNow').modal('show'); 	
	}
	
}

//to clear validation error onkeyup
function clearErr()
{
	var mainDiv=document.getElementById("supErr");
	var msg=document.getElementById("supMsg");
	
	mainDiv.setAttribute("class", "control-group offset3");
	msg.setAttribute("style","display:none");
}

function getBAlias()
{
	//ajax	
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var demoStr = this.responseText;
			document.getElementById("getBankDetails").innerHTML = demoStr;
			}
		};
	xhttp.open("POST", "/SAMERP/RawSupplier?getBanks=1", true);
	xhttp.send();
}

function getBankId(val)
{
	 var opts = document.getElementById('getBankDetails').childNodes;
	 for (var i = 0; i < opts.length; i++) {
		 if (opts[i].value === val) 
		 {
			 var xhttp;
				xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						var demoStr = this.responseText;
						document.getElementById("bankid").value = demoStr;
						}
					};
				xhttp.open("POST", "/SAMERP/RawSupplier?findBankId="+opts[i].value, true);
				xhttp.send();
			 break;
		 }
	 }
}

function pMode(c)
{
	if(c=='cash')
	{
		var bd=document.getElementById('bankDetails');
		var cq=document.getElementById('chq');
		bd.style.display = "none";
		cq.style.display = "none";
		document.getElementById("bankName").required=false;
		document.getElementById("chqNo").required=false;	
	}
	else if(c=='chq')
	{
		var bd=document.getElementById('bankDetails');
		var cq=document.getElementById('chq');
		bd.style.display = "block";
		cq.style.display = "block";
		document.getElementById("bankName").required=true;
		document.getElementById("chqNo").required=true;	
	}
	else if(c=='transfer')
	{
		var bd=document.getElementById('bankDetails');
		var cq=document.getElementById('chq');
		bd.style.display = "block";
		cq.style.display = "none";
		document.getElementById("bankName").required=true;
		document.getElementById("chqNo").required=false;	
	} 
}

function billProcess()
{

	var checkboxes = document.getElementsByName('bill');
	var selected = [];
	for (var i=0; i<checkboxes.length; i++) {
	    if (checkboxes[i].checked) {
	        selected.push(checkboxes[i].value);
	    }
	}
	
	$(document).on('shown.bs.modal','#billEntryModal', function (e) {
		//alert('something'); 
		document.getElementById('ids').value=selected;
		
		var msid=document.getElementById('supId').value;
		
		var bus=document.getElementById('supplier').value;
		
		document.getElementById('msid').value=msid;
		document.getElementById('busName').value=bus;
		

	});
	
	
	//
	//$('#billEntryModal').modal('show');
}

$(document).on('shown.bs.modal','#payNow', function (e) {

	var sid=document.getElementById('supId').value;
	
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var demoStr = this.responseText;
				document.getElementById('pTAmt').value=demoStr;
				document.getElementById("supid2").value = sid;
			}
		};
	xhttp.open("POST", "/SAMERP/RawSupplier?sid="+sid, true);
	xhttp.send();
	
	
	
});

function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
};


function viewBalance()
{
	var supName=document.getElementById('supplier').value
	if(supName=="")
	{
		document.getElementById('supplier').focus();
		var mainDiv=document.getElementById("supErr");
		var msg=document.getElementById("supMsg");
		
		mainDiv.setAttribute("class", "control-group offset3 error");
		msg.setAttribute("style","display:block");
	}
	else
	{
		var id=document.getElementById('supId').value;
		var link = document.getElementById("eLink");
		link.setAttribute("href","/SAMERP/jsp/admin/payment/rawSupplier.jsp?bid="+id+"&supName="+supName+"&show=viewBalance");		
	}
}
function billEntry()
{	
	var supName=document.getElementById('supplier').value
	if(supName=="")
	{
		document.getElementById('supplier').focus();
		var mainDiv=document.getElementById("supErr");
		var msg=document.getElementById("supMsg");
		
		mainDiv.setAttribute("class", "control-group offset3 error");
		msg.setAttribute("style","display:block");
	}
	else
	{
		var id=document.getElementById('supId').value;
		var link = document.getElementById("entryLink");
		link.setAttribute("href","/SAMERP/jsp/admin/payment/rawSupplier.jsp?bid="+id+"&supName="+supName+"&show=billEntry");	
	}
	
	
	 //document.getElementById('supplier').value=supName;
	
	/*  if(!supName=="")
	{
		$('.viewBillTable').hide(1000);
		$('.billEntryTable').show(1000);
	} */
	 /*else
	{
		$('.viewBillTable').hide(1000);
		$('.billEntryTable').hide(1000);
	} */
	 //return false;
	
	/* 
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var demoStr = this.responseText.split(",");
			//document.getElementById("getSupplier").innerHTML = demoStr;
			var len=demoStr.length;
			var table=document.getElementById('billEntryTab');
			for (var i=1;i<=len/4;i++)
			{
					var row=table.insertRow(0);
			}
			//alert(demoStr.length);
			}
		};
	xhttp.open("POST", "/SAMERP/RawSupplier?getData="+id, true);
	xhttp.send();
 */
 
 }


function getId(val)
{
	 var opts = document.getElementById('getSupplier').childNodes;
	 for (var i = 0; i < opts.length; i++) {
		 if (opts[i].value === val) 
		 {
			 var xhttp;
				xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						var demoStr = this.responseText;
						document.getElementById("supId").value = demoStr;
						}
					};
				xhttp.open("POST", "/SAMERP/RawSupplier?findId="+opts[i].value, true);
				xhttp.send();
			 break;
		 }
	 }
}

/* function viewBill()
{
	$('.viewBillTable').show(1000);
	$('.billEntryTable').hide(1000);
	
} */

function myFunction() {
	//focus on particular name box();
	
	//document.getElementById("inpBox").focus();
	if(document.getElementById("snackbar")!=null){
    var x = document.getElementById("snackbar")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
	}
}

//for getting supplier name in AJAX Dropdown
function getSup()
{
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var demoStr = this.responseText;
			document.getElementById("getSupplier").innerHTML = demoStr;
			}
		};
	xhttp.open("POST", "/SAMERP/RawSupplier?findList=1", true);
	xhttp.send();
}



$(document).ready(function(){
	
	$(document).on('change', 'input[type="checkbox"]', function(e){
		document.getElementById('tableButton').disabled=false;
    });
	
	var supName=document.getElementById('supplier').value
	if(supName=="")
	{
		$('.viewBillTable').hide();
		$('.billEntryTable').hide();
	}
	
	var showTable = getUrlParameter('show');
	if(showTable=="billEntry" && !supName=="")
	{
		$('.viewBillTable').hide(1000);
		$('.billEntryTable').show(1000);
	}
	else if(showTable=="viewBalance" && !supName=="")
	{
		$('.billEntryTable').hide(1200);
		$('.viewBillTable').show(1400);
	}
	
	//alert('working');
	//$('.viewBillTable').hide();
	//$('.billEntryTable').hide();
	});

</script> 

</body>
</html>
