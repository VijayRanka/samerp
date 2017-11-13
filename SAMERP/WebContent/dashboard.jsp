<%@page import="java.util.LinkedHashSet"%>
<%@page import="java.util.Set"%>
<%@page import="utility.SysDate"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="utility.RequireData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dashboard</title>
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
.dataTables_filter {
    color: #878787;
    font-size: 11px;
    right: 0;
    top: 37px;
    margin: -31px 4px 2px 10px;
    position: absolute;
    text-align: left;
}
</style>
</head>
<body onload="setSelectValue()">
<!--Header-part-->
<div id="header">
  <h1><a href="/SAMERP/index.jsp">Matrix Admin</a></h1>
</div>
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
  <div id="breadcrumb"> <a href="index.html" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Dashboard</a>  </div>
  <!--Action boxes-->
  <div class="container-fluid" align="center">
    <div class="quick-actions_homepage">
      <ul class="quick-actions">
      <!-- loop for all of them goes here -->
       <!--  <li class="bg_ls"> <a href="#"> <i class="icon-user"></i><span class="label label-success"></span>Supply & Sale</a> </li>
		<li class="bg_lo"> <a href="#"> <i class="icon-user"></i><span class="label label-success"></span>Work Details</a> </li> -->
		<li class="bg_ly"> <a href="/SAMERP/jsp/admin/jcb-poc-work/jcb_pokland_dashboard.jsp"> <i class="icon-dashboard"></i><span class="label label-success"></span>JCB & POKLAND  <!-- Dashboard --></a> </li>
		<li class="bg_lg"> <a href="/SAMERP/jsp/admin/expenses/expenses.jsp"> <i class="icon-user"></i><span class="label label-success"></span>Expense</a> </li>
		<li class="bg_lb"> <a href="/SAMERP/jsp/admin/productPurchase/productSupplierPayment.jsp"> <i class="icon-money"></i><span class="label label-success"></span>Product Payment</a> </li>
		<li class="bg_ls"> <a href="/SAMERP/jsp/admin/payment/rawSupplier.jsp"> <i class="icon-money"></i><span class="label label-success"></span>Raw Payment</a> </li>
		<li class="bg_lo"> <a href="/SAMERP/jsp/admin/sale/salePayment.jsp"> <i class="icon-money"></i><span class="label label-success"></span>Sale Payment</a> </li>
      	<li class="bg_lr"> <a href="/SAMERP/jsp/admin/payment/contractorPayment.jsp"> <i class="icon-money"></i><span class="label label-success"></span>Contractor Payment</a> </li>
      </ul>
    </div>
<!--End-Action boxes-->    
 </div>
</div>
  <div class="container-fluid">
    <hr>
        
     <div class="row-fluid">
      <div class="span12">
        <div class="widget-box collapsible">
        
        


      <!-- daily expenses start  vijay ranka part with omkar Y shivadekar and sandeep and  MUKESH Sarang Kamble-->

        
          <div class="widget-title"> <a href="#collapseOne" data-toggle="collapse"> <span class="icon"><i class="icon-arrow-right"></i></span>
            <h5>Daily Expenses</h5>
            <%RequireData rd=new RequireData(); %>
             <span class="badge badge-important" style="margin-top: 10px; float: right;">Total Expense: <%=rd.totalExpenseDay() %></span>
            </a> 
             <div class="dateDiv" style="position: relative;left: 680px;bottom: 25px;">
             
             </div>
            </div>
          <div class="collapse" id="collapseOne">
          <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
            <div class="controls" style="float: right;position: relative;right: 280px;">
              <span  style="position: relative;bottom: 5px;"><b>Date:</b></span>
              <% SysDate sd=new SysDate();
              String[] sdDemo=sd.todayDate().split("-");
              %>
                <input name="date" type="date" value="<%=sdDemo[2]+"-"+sdDemo[1]+"-"+sdDemo[0] %>" onchange="getExpData(this.value)">
                </div> 
              <thead>
                <tr>
                  <th>S.No.</th>
                  <th>Date</th>
                  <th>Name</th>
                  <th>Amount</th>
                  <th>Payment Mode</th>
                  <th>Vehicle Reading</th>
                  <th>Qty In Litres(s)</th>
                  <th>Expenses Type</th>
                  <th>Debtor Type</th>
                  <th>Cheque Details</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody id="expenseDataTable">
	              <%
	             
	              List getExpData=rd.getExpensesDetailsDash();
	            	if(getExpData!=null){
	            	Iterator getexpitr=getExpData.iterator();
	            	int i=1;
	            	while(getexpitr.hasNext()){ Object dataId=getexpitr.next();
	              %>
                <tr id="tRow<%=i%>">
                  <td style="text-align: center"><%=i %></td>
                  <td style="text-align: center"><%=getexpitr.next() %></td>
                  <td style="text-align: center"><%=getexpitr.next() %></td>
                  <td style="text-align: center"><%=getexpitr.next() %></td>
                  <td style="text-align: center"><%=getexpitr.next() %></td>
                  
 
                  <% String vrmData=rd.getVRM(dataId.toString());
                  if(vrmData!=null){%>
                  <td style="text-align: center" ><%=vrmData.split(",")[0] %></td>
                  <td style="text-align: center"><%=vrmData.split(",")[1] %></td>
                  <%}else{ %>
                  <td style="text-align: center" >-</td>
                  <td style="text-align: center">-</td>
                  <%} %>
                 
                  <td style="text-align: center"><%=getexpitr.next() %></td>
                  
                  <% Object detailsdata=getexpitr.next(); %>
                  <td style="text-align: center"" ><%if(detailsdata.equals("")){ %>-<%} else{%><%=detailsdata %><%} %></td>
                  
                  <% Object otherdetailsdata=getexpitr.next(); %>
                  <td style="text-align: center"><%if(otherdetailsdata.equals("")){ %>-<%} else{%><%=otherdetailsdata %><%} %></td>
                  <td style="text-align: center"><%=getexpitr.next() %></td>
                </tr>
                <%i++;}} %>
              </tbody>
            </table>
          </div>          
          </div>
          
      <!-- daily expenses end  -->
          
          
          
          
      <!-- daily collection starts -->
          
          
          <div class="widget-title" > <a href="#collapseTwo" data-toggle="collapse"> <span class="icon"><i class="icon-arrow-right"></i></span>
            <h5 onclick="">Daily Collection</h5>
           <span class="badge badge-important" style="margin-top: 10px;float: right;" id="bankAmount">Bank Status: <%=rd.getTotalBadAmount() %></span>
           <span class="badge badge-important" style="margin-top: 10px;float: right;" id="pCash">Petty Cash: <%=rd.getTotalPtCash() %></span>
            </a> 
          </div>
          <div class="collapse" id="collapseTwo">
           <div class="widget-box">
          <div class="widget-title">
            <ul class="nav nav-tabs">
              <li class="active"><a data-toggle="tab" href="#tab1">Petty Cash</a></li>
              <li><a data-toggle="tab" href="#tab2">Bank Amount</a></li>
            </ul>
          </div>
          <div class="widget-content tab-content">
            <div id="tab1" class="tab-pane active">
              <!-- petty cash Table -->
              <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
            <div class="controls"style="float: right;position: relative;right: 280px;">
              <span  style="position: relative;bottom: 5px;"><b>Date:</b></span>
                <input name="date" type="date" value="<%=sdDemo[2]+"-"+sdDemo[1]+"-"+sdDemo[0] %>" onchange="getExpData(this.value)">
                </div> 
              <thead>
                <tr>
                  <th>S.No.</th>
                  <th>Credit</th>
                  <th>Debit</th>
                  <th>Type</th>
                  <th>Balance</th>
                </tr>
              </thead>
              <tbody id="expenseDataTable">
              <% List demo=rd.getPettyCashDetailsDash();
              if(demo!=null)
              {
            	  Iterator pettyList=demo.iterator();
            	  int i=1;
            	  while(pettyList.hasNext()){
              %>
                <tr id="tRow">
                  <td style="text-align: center"><%=i %></td>
                  <td style="text-align: center"><%=pettyList.next() %></td>
                  <td style="text-align: center"><%=pettyList.next() %></td>
                  <td style="text-align: center"><%=pettyList.next() %></td>
                  <td style="text-align: center"><%=pettyList.next() %></td>
                </tr>
                <%i++;}} %>
              </tbody>
            </table>
          </div>             
              
            </div>
            <div id="tab2" class="tab-pane">
              <!-- Bannk amount Table -->
              
              <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
            <div class="controls" style="float: right;position: relative;right: 280px;">
              <span  style="position: relative;bottom: 5px;"><b>Date:</b></span>
                <input name="date" type="date" value="<%=sdDemo[2]+"-"+sdDemo[1]+"-"+sdDemo[0] %>" onchange="getExpData(this.value)">
                </div> 
              <thead>
                <tr>
                  <th>S.No.</th>
                  <th>Bank</th>
                  <th>Credit</th>
                  <th>Debit</th>
                  <th>Particulars</th>
                  <th>Type</th>
                  <th>Balance</th>
                </tr>
              </thead>
              <tbody id="expenseDataTable">
              <% List badDetailsDash=rd.getbadDetailsDash();
              if(badDetailsDash!=null)
              {
            	  Iterator badList=badDetailsDash.iterator();
            	  int i=1;
            	  while(badList.hasNext()){
              %>
                <tr id="tRow">
                  <td style="text-align: center"><%=i %></td>
                  <td style="text-align: center"><%=badList.next() %></td>
                  <td style="text-align: center"><%=badList.next() %></td>
                  <td style="text-align: center"><%=badList.next() %></td>
                  <td style="text-align: center"><%=badList.next() %></td>
                  <td style="text-align: center"><%=badList.next() %></td>
                  <td style="text-align: center"><%=badList.next() %></td>
                </tr>
                <%i++;}} %>
              </tbody>
            </table>
          </div>
              
            </div>
          </div>
        </div>
           
          </div>
          
          
      <!-- daily collection end -->
          
          
          
          
      <!-- jcb - poc details start  -->
          
           <div class="widget-title"> <a href="#collapseThree" data-toggle="collapse"> <span class="icon"><i class="icon-arrow-right"></i></span>
            <h5>JCB-POC Work Details</h5>
            
            </a> 
          </div>
          <div class="collapse" id="collapseThree">
            
            <div class="widget-content nopadding	">
            <table class="table table-bordered data-table">
              <div class="controls"style="float: right;position: relative;right: 280px;">
              <span  style="position: relative;bottom: 5px;"><b>Date:</b></span>
                <input name="date" type="date" value="<%=sdDemo[2]+"-"+sdDemo[1]+"-"+sdDemo[0] %>" onchange="getJcbPocData(this.value)">
              </div> 
              <thead>
                <tr>
                  <th>S.No.</th>
                  <th>Vehicle Name</th>
                  <th>Customer Name</th>
                  <th>Bucket Hr</th>
                  <th>Breaker Hr</th>
                  <th>Deposit</th>
                  <th>Diesel Amount</th>
                </tr>
              </thead>
              <tbody id="jcbpocDataTable">
              </tbody>
            </table>
            </div>
          </div>
          
      <!-- jcb poc details end -->
      
      
      
      <!-- vehicle details start  --> 
          
          <div class="widget-title"> <a href="#collapseFour" data-toggle="collapse"> <span class="icon"><i class="icon-arrow-right"></i></span>
            <h5>Vehicle Details</h5>
            </a> 	
          </div>
          
          <div class="collapse" id="collapseFour">
          
          
          <div class="control-group" style="height: 50px;">
         <!-- <label class="control-label"><span style="color: red;  margin-left: -25%;">*</span>Select Supplier :</label> -->
      
         <div class="controls" style="margin-left: 5%; margin-top: 2%; margin-right: 70%;" >
         	
         		<select name="selectVehicle" onchange="setVId()" id="selectVehicle" autofocus  required >
            	<option value="" selected="selected"> Select Vehicle</option>
            	  <%
            	  		
            	  		List vehicleList = rd.getVehicleDetails();
            	  		Iterator itr1 = vehicleList.iterator();
	              		while(itr1.hasNext()){
	              %>
		                	<option value="<%=itr1.next()%>"><%=itr1.next()%></option>
		           <%
	              		}
		           %>   
       		</select>  
       		
       		<input type="hidden" name="vid" id="vid" />	
         </div>
        
        <label style=" margin-left: 35%; margin-top: -2%; margin-bottom: 7px;">From : </label> 
        <input type="date" name="fromDate" id="fromDate" value="" style=" margin-left: 40%; margin-top: -3%;" onchange="getDates()"/>
        
        <label style="margin-top: -3%; margin-bottom: -1px; margin-left: 65%;">To : </label> 
       	<input type="date" name="toDate" id="toDate" value="" style=" margin-left: 69%; margin-top: -2.2%;" onchange="getDates()"/>
	
        </div>
          
          
          <div class="widget-box">
          <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
            <h5>Vehicles List</h5>
          </div>
          <div class="widget-content nopadding">
          <form  id="vidDrop">
            <table class="table table-bordered data-table" id="vehicleDetails">
              <thead>
                <tr>
                  <th>Sr. No.</th>
                  <th>Date</th>
                  <th>Client Organization</th>
                  <th>Supplier Organization</th>
                  <th>Product Details</th>
                  <th>Deposit</th>
                  <th>Diesel Cost</th>
                </tr>
              </thead>
              <tbody>
             <%
             
             String vid="";
             
             if(request.getParameter("vid")!=null){
             	vid=request.getParameter("vid");
             }
             
             List vehicleDetailsData =rd.getVehicleDetails(vid);
             int i=1;
             
             if(vehicleDetailsData!=null)
             {
                Iterator itr = vehicleDetailsData.iterator();	 
                int k=1;
                while(itr.hasNext())
                {
                	String saleId = itr.next().toString();
                	List saleSup =rd.getSaleSup(saleId);
                	Iterator itr2 = saleSup.iterator();	
                	
                	List saleProductDetails =rd.getSaleProductDetails(saleId);
                	Iterator itr3 = saleProductDetails.iterator();	
                	
                	List dieselPrice =rd.getDieselAmt(saleId);
                	Iterator itr4 = dieselPrice.iterator();	
                	
                	Set set = new LinkedHashSet();
              %>            
                    	<tr class="gradeX">
  							<td> <%=i %></td>
	                      	<td><%=itr.next()%></td>
	                        <td><%=itr.next()%></td>
	                        
	                        <td>
	                        <%
	                        	
	                        	while(itr2.hasNext()){ 
		                        	set.add(itr2.next());
		                        }
	                        	
	                        	for (Object j : set) {
	                        %>
	                        		<%=j%><br>
	                        <%  } %>
	                        </td>
	                        
	                        <td>
	                        <%while(itr3.hasNext()){ 
	                        	out.print( itr3.next() + " ( " + itr3.next()+ " ) " );
	                        %>
	                      	<br>
	                        <%} %>
	                        </td>
	                        
	                        <%itr.next();%>
	                        <td id="deposit<%=k %>"><%=itr.next()%></td>
	                        
	                        
	                        <td id="diesel<%=k %>">
	                        <%
	                        	
	                        	while(itr4.hasNext()){ 
	                        %>
	                        		<%=itr4.next()%>
	                        <%  } %>
	                        </td>
	                        
                     	</tr>
             <%			k++;
                     	i++;
                 }
             }
             %>
              
     		  </tbody>
            </table>
            
           <!--  <table>
            	<tr> <td></td> <td></td> </tr>
            	<tr> <td id="tripCnt">Trip(s) : </td> <td><span id="tripCnt"> </span></td> </tr>
            	<tr> <td id="dieselCost">Diesel : </td> <td><span id="dieselCost"> </span></td> </tr>
            	<tr> <td>Deposit : </td> <td><span id="depositCost">  </span></td> </tr>
            	<tr> <td>Driver : </td> <td> <span id="driverCost"> </span></td> </tr>
            	<tr> <td>Total : </td> <td><span id="totalCost">  </span></td> </tr>
            
            </table> -->
            
            <span style="margin-bottom: 8%; margin-top: 2%; ">
            	<h4 style=" margin-bottom: 8%; margin-top: 2%; margin-left: 11%;">Total Expendeture of "<span id="vnum" style="color: #f1133c;"> </span>" From "<span id="fdate" style="color: #f1133c;"> </span>" To "<span id="tdate" style="color: #f1133c;"> </span>" : </h4> 
            </span>    
            
            <span style="float: right; position: relative; right: 13%; margin-top: -10.64%;">
            	<h4>
            	Trip(s) : <span id="tripCnt">  </span>  <br>
            	Diesel : <span id="dieselCost">  </span> <br>
            	Deposit : <span id="depositCost">  </span> <br>
            	Maintenance : <span id="driverCost">  </span> <br>
            	Total : <span id="totalCost">  </span>
            	</h4>
            </span>
            
            
            </form>
          </div>
        </div>
          </div>
     <!-- vehicle details end  -->
          
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
<script type="text/javascript">
//***************************************** JCB |POC************************************************************
function getJcbPocData(value)
{
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var demoStr = this.responseText.split("~");
			if(demoStr=="")
			document.getElementById("jcbpocDataTable").innerHTML="<tr><td colspan='10'>No Records Found!</td></tr>"
			else{
				var count=1;
				var wholeData="";
				
				for(var i=0;i<demoStr.length-2;i=i+6){
						
					wholeData+="<tr>"+
					"<td style='text-align: center'>"+count+"</td>"+
					"<td style='text-align: center'>"+demoStr[i]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+1]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+2]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+3]+"</td>"+
					"<td style='text-align: center' >"+demoStr[i+4]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+5]+"</td>"+
// 					"<td style='text-align: center'>"+demoStr[i+6]+"</td>"+
					"<tr>";
					count++;
				}
			
			document.getElementById("jcbpocDataTable").innerHTML=wholeData;
			}
		}
	};
	xhttp.open("GET", "/SAMERP/JcbPocDetails.do?jcbPocSelectList=" + value, true);
	xhttp.send();
	
	}
//******************************************************END JCB POC******************************************************
var demoStr=0;
function getExpData(value)
{
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var demoStr = this.responseText.split(",");
			if(demoStr=="")
			document.getElementById("expenseDataTable").innerHTML="<tr><td colspan='10'>No Records Found!</td></tr>"
			else{
				var count=1;
				var wholeData="";
				for(var i=0;i<demoStr.length-2;i=i+10){
					
			wholeData+="<tr>"+
			"<td style='text-align: center'>"+count+"</td>"+
			"<td style='text-align: center'>"+demoStr[i]+"</td>"+
			"<td style='text-align: center'>"+demoStr[i+1]+"</td>"+
			"<td style='text-align: center'>"+demoStr[i+2]+"</td>"+
			"<td style='text-align: center'>"+demoStr[i+3]+"</td>"+
			"<td style='text-align: center' >"+demoStr[i+4]+"</td>"+
			"<td style='text-align: center'>"+demoStr[i+5]+"</td>"+
			"<td style='text-align: center'>"+demoStr[i+6]+"</td>"+
			"<td style='text-align: center'' >"+demoStr[i+7]+"</td>"+
			"<td style='text-align: center'>"+demoStr[i+8]+"</td>"+
			"<td style='text-align: center'>"+demoStr[i+9]+"</td>"+
			"<tr>";
			count++;
				}
			
			document.getElementById("expenseDataTable").innerHTML=wholeData;
			}
		}
	};
	xhttp.open("POST", "/SAMERP/Expenses.do?getTableData="+value, true);
	xhttp.send();
	
	}

function showdata(id){
	document.getElementById(id).style.display='block';
}

function setVId(){	
	document.getElementById("vid").value = document.getElementById("selectVehicle").value;
	var s = document.getElementById("vid").value;
	//window.location.replace("?vid="+s);
	
	if(s!=""){
		var f=document.getElementById("vidDrop");
	    f.action='/SAMERP/dashboard.jsp?vid='+s;
	    f.method="post";
	    f.submit();  
	}
}

var m;
function setSelectValue(){
	m = <%=request.getParameter("vid") %>
	var e = document.getElementById("selectVehicle");

	if(m!=null){
		e.value=m;
	}
	var txt = e.options[e.selectedIndex].text;
	getSetSelect('s2id_selectVehicle', txt);
}


function getSetSelect(id,value)
{
	var x=document.getElementById(id).children;
	var xx=x[0].children;
	xx[0].innerHTML=value;

	if(m!=null){
		var e = document.getElementById("collapseFour").className="collapse in";
	}
	
    getWeek();
    getDates();
	
}

function getWeek(){

	var formatted_date = function(date){
	                var m = ("0"+ (date.getMonth()+1)).slice(-2); 
	                var d = ("0"+ date.getDate()).slice(-2); 
	                var y = date.getFullYear();
	                return  y +'-'+m+'-'+d; 
	}
	 
    var curr_date =new Date();
    var day = curr_date.getDay();
             
    var diff = curr_date.getDate() - day + (day == 0 ? -6:1); 
    
    var week_start_tstmp = curr_date.setDate(diff);           
             
    var week_start = new Date(week_start_tstmp);
             
    var week_start_date =formatted_date(week_start);
             
    var week_end  = new Date(week_start_tstmp); 
    
    week_end = new Date (week_end.setDate(week_end.getDate() + 6));
    
    var week_end_date =formatted_date(week_end);
    
    date=week_start_date + ' to '+week_end_date
 	    
 	document.getElementById("fromDate").value=week_start_date;
    document.getElementById("toDate").value=week_end_date; 
}

function getDates() {
	var fromDate = document.getElementById("fromDate").value.trim();
	var toDate = document.getElementById("toDate").value.trim();
	var counter=0, dieselCost=0, depositCost=0;
	
	table = document.getElementById("vehicleDetails");
	tr = table.getElementsByTagName("tr");
	  for (i = 0; i < tr.length; i++) {
		  td = tr[i].getElementsByTagName("td")[1];
		  	
		    if (td) {
				var date = td.innerHTML.toUpperCase();
		      if (date<=toDate && date>=fromDate ) {
		    	  tr[i].style.display = "";
		    	  ++counter;
		    	  dieselCost = +dieselCost + +document.getElementById("diesel"+i).innerHTML;
		    	  depositCost = +depositCost + +document.getElementById("deposit"+i).innerHTML;
		      }
		      else 
		      {
		  		  tr[i].style.display = "none";
		  	  }
		  	}       
		}
	  

	  
	  
	  var dropObj = document.getElementById("selectVehicle");
	  document.getElementById("vnum").innerHTML=""+dropObj.options[dropObj.selectedIndex].text+"";
	  
	  document.getElementById("fdate").innerHTML=""+fromDate+"";
	  document.getElementById("tdate").innerHTML=""+toDate+"";
	  
	  document.getElementById("tripCnt").innerHTML=counter;
	  document.getElementById("dieselCost").innerHTML=dieselCost;
	  document.getElementById("depositCost").innerHTML=depositCost;
	  
	  
	  getDriverExp(fromDate, toDate);
	  window.totalCost = +dieselCost + +depositCost ;
	  
}


function getDriverExp(sdate, edate)
{
	var value = document.getElementById("selectVehicle").value;
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			demoStr = this.responseText;
			var d = demoStr.split(",");
			
			if(d[0]!=""){
				var expDCost = document.getElementById("dieselCost").innerHTML;
				
				totalCost = +totalCost + +d[0];
				document.getElementById("dieselCost").innerHTML = expDCost + " + " + d[0];
				document.getElementById("driverCost").innerHTML = d[1];
				document.getElementById("totalCost").innerHTML = totalCost+  +d[1];
			}else{
				document.getElementById("dieselCost").innerHTML = "0 + 0";
				document.getElementById("driverCost").innerHTML = "0";
				document.getElementById("totalCost").innerHTML = "0";
			}
		}
	};
	
	xhttp.open("POST", "/SAMERP/AddVehicles?vno="+value+"&sdate="+sdate+"&edate="+edate, true);
	xhttp.send();
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

</body>
</html>
