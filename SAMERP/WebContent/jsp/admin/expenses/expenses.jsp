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

<title>SAMERP PROJECT</title>

<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/colorpicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />
<link rel="stylesheet" href="/SAMERP/config/css/select2.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bs_modal_transition.css" />
<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">
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
    border-radius: 20px;
    padding: 16px;
    position: fixed;
    z-index: 1;
    left: 50%;
    top: 80px;
    font-size: 14px;
}

#snackbar.show {
    visibility: visible;
    -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
    animation: fadein 0.5s, fadeout 0.5s 2.5s;
}

@-webkit-keyframes fadein {
    from {top: 0; opacity: 0;} 
    to {top: 80px; opacity: 1;}
}

@keyframes fadein {
    from {top: 0; opacity: 0;}
    to {top: 80px; opacity: 1;}
}

@-webkit-keyframes fadeout {
    from {top: 80px; opacity: 1;} 
    to {top: 0; opacity: 0;}
}

@keyframes fadeout {
    from {top: 80px; opacity: 1;}
    to {top: 0; opacity: 0;}
}
.ttiptext {
	position:absolute;
    height:17.5px;
    width: 26px;
    background-color: #3a87ad;
    color: #fff;
    text-align: center;
    border-radius: 0px 150px 150px 0px;
    padding: 5px 0;
    left: 473px;
    top:49px;
}
#readingDiv{
display: none;}
#vehicleLtrDiv{
display: none;}


</style>
<body onload="myFunction()">

<!--Header-part-->
<div id="header">
  <h1><a href="/SAMERP/dashboard.jsp">Matrix Admin</a></h1>
</div>

<!--start-top-serch-->
<% if(request.getAttribute("status")!=null){ %>
<div id="snackbar"><%=request.getAttribute("status")%></div>
<%} %>
<div id="search">
  <button type="submit" class="tip-bottom">LOGOUT</button>
</div>
<!--close-top-serch-->
<!--sidebar-menu-->
<jsp:include page="../common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->

<!--main-container-part-->
<div id="content">
<!--breadcrumbs-->
  <div id="content-header">
    <div id="breadcrumb"> <a href="/SAMERP/dashboard.jsp" class="tip-bottom" data-original-title="Go to Home"><i class="icon-home">
    </i> Home</a> <a href="#" class="current">Expenses</a> </div>
  </div>
<!--End-breadcrumbs-->
<div class="container-fluid">
  <hr>
  <div class="row-fluid">
    <div class="span12">
      
    </div>
</div>
  <div class="row-fluid">
  	<div class="span12">
  	 <div class="widget-box">
          <div class="widget-title">
            <ul class="nav nav-tabs">
              <li class="active"><a data-toggle="tab" href="#tab1">Expenses</a></li>
            </ul>
          </div>
          <div class="widget-content tab-content">
            <div id="tab1" class="tab-pane active">
              
              <div class="widget-box">
        <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
          <h5>Expenses-Details</h5>
           <span class="badge badge-inverse pull-right" id="badgeClass" onclick="ableAll(this.id)" style="margin-right: 5px;margin-top: 10px; cursor: pointer;">
           Diesel Expense
            </span>
             <span class="badge badge-inverse pull-right" href="#bankcashid" data-toggle="modal"  style="margin-right: 5px;margin-top: 10px; cursor: pointer;background-color: green;">
           Cash Deposite to Bank</span>
        </div>
        <div class="widget-content nopadding">
          <form action="/SAMERP/Expenses.do" method="post" class="form-horizontal">
          <div class="control-group">
              <label class="control-label">Date :</label>
              <div class="controls">
              <% RequireData rd=new RequireData(); 
              SysDate sd=new SysDate();
              String[] sdDemo=sd.todayDate().split("-");
              %>
                <input name="date" type="date" value="<%=sdDemo[2]+"-"+sdDemo[1]+"-"+sdDemo[0] %>" class="span6">
                </div>
            </div>
           <div class="control-group">
              <label class="control-label">Expense-Type :</label>
              <div class="controls">
             <input name="expType" list="getExpList" id="expenses_type_name" onfocus="searchName3()" onblur="checkData(this.value,this.id)" autocomplete="off" type="text" class="span6" placeholder="Expence Type" onkeyup="this.value=this.value.toUpperCase()" required/>
             <datalist id="getExpList"></datalist>
             </div>
            </div>
             <div class="control-group" id="readingDiv">
              <label class="control-label"><strong>Vehicle-Reading</strong></label>
              <div class="controls">
             <input name="vehicleReading" id="vehicleReading" type="text" class="span6" placeholder="Vehicle Readings"/>
             </div>
            </div>
            <div class="control-group" id="vehicleLtrDiv">
              <label class="control-label"><strong>Diesel-Qty</strong></label>
              <div class="controls">
             <input name="vehicleLtrQty" id="vehicleLtrQty" type="text" class="span6" placeholder="Qty In Litre(s)"/>
             </div>
            </div>
            <div class="control-group">
              <label class="control-label">Debtors Type :</label>
              <div class="controls">
                <select required class="span6" name="debtorType" id="debtorType">
                 <%
                  List debtorList=rd.getDebtorList();
                  if(!(debtorList.isEmpty())){
	                  Iterator itr=debtorList.iterator();
	                  while(itr.hasNext()){%>
                <option value="<%=itr.next() %>"><%=itr.next() %></option>
                <%itr.next();}} %>
                </select>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">Giving To :</label>
              <div class="controls">
                <input list="getList" id="name" onkeyup="searchName(this.value,this.id,this.list.id)" onblur="" autocomplete="off" type="text" class="span6" name="name" placeholder="Name" required/>
              	<datalist id="getList"></datalist>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">Amount :</label>
              <div class="controls">
                <input type="text" name="amount" class="span6" placeholder="Amount" required/>
                </div>
            </div>
            <div class="control-group" style="">
	             	   <label class="control-label">Payment Mode : </label>
		               <div class="controls">
		                 <input type="radio" value="CASH" style="margin-left: 1%;" name="type" onclick="displayBank()" checked="checked"/> Cash
		                 <input type="radio" value="CHEQUE" style="margin-left: 1%;" name="type" onclick="displayBank('bankDetails', 'chequeDetails')" /> Cheque
		                 <input type="radio" value="TRANSFER" style="margin-left: 1%;" name="type" onclick="displayBank('bankDetails')" /> Transfer
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
			            	  		Iterator itrDemo = List1.iterator();
				              		while(itrDemo.hasNext()){
				              %>
					                	<option value="<%=itrDemo.next()%>"><%=itrDemo.next()%></option>
					           <%
				              		}
					           %>   
       					</select>  
		               </div>
	             	</div>
             <div class="control-group">
              <label class="control-label"> Description :</label>
              <div class="controls">
                <input type="text" id="reason" list="getList" value="-" name="reason" onkeyup="searchName(this.value,this.id,this.list.id)" class="span6" placeholder="Reason" autocomplete="off" required/>
              	<datalist id=getList"></datalist>
              </div>
            </div>
            <div class="form-actions">
              <center><button type="submit" name="save" class="btn btn-success pull-center">Save</button>
              <a href="/SAMERP/index.jsp"><button type="button" class="btn btn-danger">Cancel</button></a>
              </center>
            </div>
          </form>
        </div>
      </div>
      <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
            <h5>Expenses :</h5>
          </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
            
            <div class="controls" style="float: right;position: relative;right: 280px;">
              <span  style="position: relative;bottom: 5px;"><b id="dateFun">From Date:</b></span>
              <% sdDemo=sd.todayDate().split("-");
              %>
                <input id="fromDate" type="date" value="<%=sdDemo[2]+"-"+sdDemo[1]+"-"+sdDemo[0] %>" onchange="getData(this.value,1)" style="width: 130px">
                  <span  style="position: relative;bottom: 5px;"><b id="dateFun">To Date:</b></span>
                 <input id="toDate" type="date" value="<%=sdDemo[2]+"-"+sdDemo[1]+"-"+sdDemo[0] %>" onchange="getData(this.value,2)" style="width: 130px">
                </div> 
                <script>
                var firstDate="";
            	var lastDate="";
                function getData(value,id)
                {
                	
                	if(id==1)
                		{
                		firstDate=value;
                		}
                	else if(id==2)
                		{
                		if(firstDate=="")
                			firstDate=document.getElementById("fromDate").value;
                		lastDate=value;
                		var xhttp;
                		xhttp = new XMLHttpRequest();
                		xhttp.onreadystatechange = function() {
                			if (this.readyState == 4 && this.status == 200) {
                				var demoStr = this.responseText.split(",");
                				if(demoStr=="")
                					document.getElementById("wholeDataList").innerHTML="<tr><td colspan='10'>No Records Found!</td></tr>"
                				else{
                				var a="";
                				var count=1;
                				for(var i=0;i<demoStr.length-1;i=i+11)
                					{
                					 a+= "<tr>"+
                					"<td style='text-align: center'>"+count+"</td>"+
                					"<td style='text-align: center'>"+demoStr[i+1]+"</td>"+
                					"<td style='text-align: center'>"+demoStr[i+2]+"</td>"+
                					"<td style='text-align: center'>"+demoStr[i+3]+"</td>"+
                					"<td style='text-align: center' >"+demoStr[i+4]+"</td>"+
                					"<td style='text-align: center'>"+demoStr[i+5]+"</td>"+
                					"<td style='text-align: center'>"+demoStr[i+6]+"</td>"+
                					"<td style='text-align: center'' >"+demoStr[i+7]+"</td>"+
                					"<td style='text-align: center'>"+demoStr[i+8]+"</td>"+
                					"<td style='text-align: center'>"+demoStr[i+9]+"</td>"+
                					"<td style='text-align: center'>"+demoStr[i+10]+"</td>"+
                					" <td style='text-align: center'>"+
                					"<a data-toggle='modal' href='#update' onclick='getUpdateData("+demoStr[i]+")'>Update</a></td>"+
                					"<tr>";
                					count++;
                					}
                				document.getElementById("wholeDataList").innerHTML=a;
                				}
                			
                			}
                				
                			};
                		xhttp.open("POST", "/SAMERP/Expenses.do?getDateData=1&fromDate="+firstDate+"&toDate="+lastDate, true);
                		xhttp.send();
                		}
                }
                </script>
              <thead>
                <tr>
                  <th>S.No.</th>
                  <th style="width:80px">Date</th>
                  <th>Name</th>
                  <th>Amount</th>
                  <th>Payment Mode</th>
                  <th>Vehicle Reading</th>
                  <th>Qty In Litres(s)</th>
                  <th>Expenses Type</th>
                  <th>Debtor Type</th>
                  <th>Cheque Details</th>
                  <th>Description</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody id="wholeDataList">
	              <%
	             
	              List getExpData=rd.getExpensesDetails();
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
                  <td style="text-align: center"><a data-toggle="modal" href="#update" onclick="getUpdateData(<%=dataId%>)">Update</a>|<a href="/SAMERP/Expenses.do?deleteId=<%=dataId%>">Delete</a></td>
                </tr>
                <%i++;}} %>
              </tbody>
            </table>
          </div>
        </div>
            </div>
            
          </div>
        </div>
  	</div>
  </div>
</div>
</div>


<!--end-main-container-part-->

<!--Footer-part-->
<div class="row-fluid">
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a
				href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
	</div>

<!--end-Footer-part-->
<div class="modal hide fade zoom-out" id="update" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
   <form class="form-horizontal" action="/SAMERP/Expenses.do" method="post">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Update Data</h4>
      </div>
      <div class="modal-body" id="showModal">
	     
	        <div class="form-group">
			<div class="widget-content nopadding">
	        	<div class="control-group">
	                  <label class="control-label">Date</label>
	                  <div class="controls">
	                	<input type="hidden" id="uId" name="uId"/>
	                    <input type="date" id="uDate" name="uDate" disabled="disabled"/>
	         			</div>
	        	</div>
	        	
	        	<div class="control-group">
	                 		 <label class="control-label">Name</label>
	                  <div class="controls">
	                    <input type="text" id="uName" name="uName" onkeyup="this.value=this.value.toUpperCase()"/>
	         			</div>
	        	</div>
	        	
	        	<div class="control-group">
	                  <label class="control-label">Amount</label>
	                  <div class="controls">
	                     <input type="text" id="uAmount" name="uAmount" readonly="readonly"/>
	                      <input type="hidden" id="oldAmount" name="oldAmount" value="0" />
	                     <input type="checkbox" id="revertCheck" onclick="onUamount()">Reverted
	         			</div>
	        	</div>
	        	<div class="control-group">
	                  <label class="control-label">Payment Mode</label>
	                  <div class="controls">
	                   <input type="text" id="uPayMode" name="uPayMode" readonly="readonly" >
	         			</div>
	        	</div>
	        	<div class="control-group">
	                  <label class="control-label">Expenses Type</label>
	                  <div class="controls">
	                     <input type="text" name="updExpType" value="" id="updExpType" placeholder="Expence Type" disabled="disabled"/>
							<datalist id="updList"></datalist>	         			
	         			</div>
	        	</div>
	        	<div class="control-group" id="uChequeDetails">
	                  <label class="control-label">Cheque Details</label>
	                  <div class="controls">
	                       <input type="text" id="uOtherDetails" name="uOtherDetails" onkeyup="this.value=this.value.toUpperCase()"/>
	         			</div>
	        	</div>
	        	
	        	<div class="control-group">
	                  <label class="control-label">Debtor Type</label>
	                  <div class="controls">
	                      <input type="text" required name="uDebtorType" id="uDebtorType" readonly="readonly">
	         			</div>
	        	</div>
	        	<div class="control-group" id="uVehR">
	                  <label class="control-label">Vehicle Reading</label>
	                  <div class="controls">
	                     <input type="text" id="uVehReading" name="uVehReading"/>
	         			</div>
	        	</div>
	        	
	        	<div class="control-group" id="uVehDsQty">
	                  <label class="control-label">Diesel Qty</label>
	                  <div class="controls">
	                    <input type="text" pattern="[0-9]*" id="uDieselQty" name="uDieselQty" />
	         			</div>
	        	</div>
	        	
	        	<div class="control-group">
	                  <label class="control-label">Reason</label>
	                  <div class="controls">
	                     <input type="text" id="uReason" name="uReason" onkeyup="this.value=this.value.toUpperCase()"/>
	         			</div>
	        	</div>
	        	
		      </div>
	      	</div>
      </div> 
      <div class="modal-footer">
        <button type="submit" name="UpdateData" class="btn btn-primary" style="margin-right:5px;">Save changes</button> 
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>    
          </div>
    </div>
   </form>
  </div>
</div>


<div id="bankcashid" class="modal hide fade" role="dialog"
		style="width: 55%; margin-left: -28%;">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Cash Deposite to Bank </h4>
				</div>			

					<form action='/SAMERP/Expenses.do' name="form2" method="Post"
						class="form-horizontal">
						<div class="modal-body">
						<div class="control-group">
									<label class="control-label" style="margin-bottom: 14px;">Bank Name:</label>

									<div class="controls" style="width: 400px;margin-left: 171px;">
										<select name="bank_name" class="span4" >

											<%
												List details = rd.getBankAliasList();
												if (details != null) {
													Iterator itr = details.iterator();
													while (itr.hasNext()) {
														String id = itr.next().toString();
														String alias_name = itr.next().toString();
											%>
											<option value="<%=id%>"><%=alias_name%></option>
											<%
												}
											%>
										</select>
									</div>
									<%
										}
									%>
								</div>
						<div class="control-group">
							<label class="control-label">Amount:</label>
							<div class="controls">
								<div class="input-append">
									<input type="text" name="amount" id="amountid" class="span4"
										placeholder="Amount" 
										onkeyup="this.value=this.value.toUpperCase()" style="margin-left: 11px;width: 345px;" required />
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">Date :</label>
							<div class="controls">
								<%
									SysDate date = new SysDate();
									String[] demo = date.todayDate().split("-");
								%>
								<input name="date" type="date"
									value="<%=demo[2] + "-" + demo[1] + "-" + demo[0]%>" class="span4" style="margin-left: 11px;width: 345px;">
							</div>
						</div>

					</div>
						<div class="modal-footer" style="padding-left: 450px">
							<button type="submit" name="Bank_Deposite" class="btn btn-success">Submit</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						</div>
						
					</form>
				</div>

			</div>

		</div>
		<div class="modal hide fade zoom-out" id="pettyCashError" role="dialog" style="width: 50%; margin-left: -25%;" >
	<div class="modal-header">
		<a class="close" data-dismiss="modal"></a>
		<i style=" font-size: 180%; color: #ec971f;" class="icon-warning-sign"> <h4 style="color: #ec971f; display: inherit; "> Warning </h4> </i> 
	</div>
	
	<div class="modal-body" style="padding: 0;">
		<form class="form-horizontal" action="" method="post" name="">
			<div class="form-group">
				<div class="widget-content nopadding" style=" margin-top: 3%; margin-left: 5%; margin-right: 5%;">
					
					<div align="center" class="control-group">
					<div class="alert">
		              <h4 id="payStatus"> Insufficient balance in your Bank Account..!!  </h4> </div>
					</div>
					
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" href="#" class="btn btn-primary" id="pettyCashOk" tabindex="1" data-dismiss="modal">OK</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal" class="btn btn-danger" tabindex="2">Cancel</button>
				
			</div>
	
		</form>
	</div>
</div>

<script>
function onUamount()
{
	if(document.getElementById('uAmount').readOnly==false)
		{
		document.getElementById('uAmount').value=firstAmount;
		document.getElementById('oldAmount').value="0";
		document.getElementById('uAmount').readOnly=true;
		}
	else
		{
		window.firstAmount=document.getElementById('uAmount').value;
		document.getElementById('oldAmount').value=firstAmount;
		document.getElementById('uAmount').readOnly=false;
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
function myFunction() {
	
	<%if(request.getAttribute("payError")!=null){%>
	var payError = "<%=request.getAttribute("payError") %>";
	
	if(payError.split("_")[1]==='c')
		{
		
			if(payError.split("_")[2]==='0')
					{
				document.getElementById("pettyCashOk").setAttribute("onclick","window.location='/SAMERP/jsp/admin/PTCash/ptcash.jsp'");
				$('#payStatus').text(payError.split("_")[0]);
				$('#pettyCashError').modal('show');
					}
			
			if(payError.split("_")[2]==='-1')
					{
				document.getElementById("pettyCashOk").setAttribute("onclick","window.location='/SAMERP/jsp/admin/PTCash/ptcash.jsp'");
				$('#payStatus').text(payError.split("_")[0]);
				$('#pettyCashError').modal('show');
					}
			if(payError.split("_")[2]==='-2')
					{
				document.getElementById("pettyCashOk").setAttribute("onclick","window.location='/SAMERP/jsp/admin/PTCash/ptcash.jsp'");
				$('#payStatus').text(payError.split("_")[0]);
				$('#pettyCashError').modal('show');
					}
		}
		else if(payError.split("_")[1]==='b')
		{
				if(payError.split("_")[2]==='0')
						{
					document.getElementById("pettyCashOk").setAttribute("onclick","window.location='/SAMERP/jsp/admin/PTCash/ptcash.jsp'");
					$('#payStatus').text(payError.split("_")[0]);
					$('#pettyCashError').modal('show');
						}
				if(payError.split("_")[2]==='-1')
						{
					document.getElementById("pettyCashOk").setAttribute("onclick","window.location='/SAMERP/jsp/admin/PTCash/ptcash.jsp'");
					$('#payStatus').text(payError.split("_")[0]);
					$('#pettyCashError').modal('show');
						}
				if(payError.split("_")[2]==='-2')
						{
					document.getElementById("pettyCashOk").setAttribute("onclick","window.location='/SAMERP/jsp/admin/settings/addAccountDetails.jsp'");
					$('#payStatus').text(payError.split("_")[0]);
					$('#pettyCashError').modal('show');
						}
		}
	<%}%>
	document.getElementById("expenses_type_name").focus();
    var x = document.getElementById("snackbar");
    if(x!=null)
    	{
	    x.className = "show";
	    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
    	}
    document.getElementById("DataTables_Table_0_wrapper").children[0].children[0].setAttribute("style","width:150px;");
    
}

function getVehicleUList(id)
{
	
	}

function ableAll(id)
{
	
	if(document.getElementById("vehicleReading")!=null)
	{
	document.getElementById("vehicleReading").value="";
	document.getElementById("vehicleLtrQty").value="";
	}
	if(document.getElementById(id).style.backgroundColor=="green")
	document.getElementById(id).style.backgroundColor="black";
	else
		document.getElementById(id).style.backgroundColor="green";
	if(document.getElementById("readingDiv").style.display=="block")
		{
		document.getElementById("vehicleReading").required=false;
		document.getElementById("vehicleLtrQty").required=false;
		document.getElementById("readingDiv").style.display="none";
		document.getElementById("vehicleLtrDiv").style.display="none";
		document.getElementById("expenses_type_name").value="";
		document.getElementById("expenses_type_name").focus();
		
		}
	else{
			document.getElementById("readingDiv").style.display="block";
			document.getElementById("vehicleLtrDiv").style.display="block";
			document.getElementById("vehicleReading").required=true;
			document.getElementById("vehicleLtrQty").required=true;
			document.getElementById("expenses_type_name").value="DIESEL";
			document.getElementById("vehicleReading").focus();
		} 
	if(document.getElementById("vehicleReading")!=null)
		{
		document.getElementById("vehicleReading").value="";
		document.getElementById("vehicleLtrQty").value="";
		
		}
	
	}
	function getUpdateData(id)
	{
		
		if(document.getElementById("uVehDsQty").style.display=="none")
			{
			document.getElementById("uVehDsQty").style.display="block";
			document.getElementById("uVehR").style.display="block";
			
			document.getElementById("uVehReading").value="";
			document.getElementById("uDieselQty").value="";
			}
		if(document.getElementById("uChequeDetails").style.display=="none")
			{
			document.getElementById("uChequeDetails").style.display="block";
			document.getElementById("uChequeDetails").style.display=""
			}
		document.getElementById('oldAmount').value="0";
		document.getElementById('uAmount').readOnly=true;
		document.getElementById('revertCheck').checked=false;
		document.getElementById('uniform-revertCheck').children[0].setAttribute("class","");
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var demoStr = this.responseText.split(",");
				document.getElementById("uId").value=demoStr[0];
				document.getElementById("uDate").value=demoStr[1];
				document.getElementById("uName").value=demoStr[2];
				document.getElementById("uAmount").value=demoStr[3];
				document.getElementById("uPayMode").value=demoStr[4];
				document.getElementById("uReason").value=demoStr[5];
				document.getElementById("updExpType").value=demoStr[6];
				document.getElementById("uDebtorType").value=demoStr[8];
				if(demoStr[4]=="CASH")
					document.getElementById("uChequeDetails").style.display="none";
				else
				document.getElementById("uOtherDetails").value=demoStr[9];
				if(demoStr[10]==1)
				{
						document.getElementById("uVehReading").value=demoStr[12];
						document.getElementById("uDieselQty").value=demoStr[13];
				}
				else{
					document.getElementById("uVehDsQty").style.display="none";
					document.getElementById("uVehR").style.display="none";	
				}
				}
			};
		xhttp.open("POST", "/SAMERP/Expenses.do?getUpdate="+id, true);
		xhttp.send();
	}
	function getSetSelect(id,value)
	{
		var x=document.getElementById(id).children;
		var xx=x[0].children;
		xx[0].innerHTML=value;
	}
function callOut(id)
{
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var demoStr = this.responseText;
			document.getElementById(id).innerHTML = demoStr;
			}
		};
	xhttp.open("POST", "/SAMERP/Expenses.do?findVehicleList=1", true);
	xhttp.send();
	}
	
function getAdd(event){
		if(event.keyCode==13)
			{
			
			 return false;
			 
			}
	}
	
function addDebtoryList()
{
	if(document.getElementById("debtor").value=="")
		{
		document.getElementById("warning").style.display="block";
		document.getElementById("warning").innerHTML="Fill It";
		document.getElementById("debtor").focus();
		}
	else if(document.getElementById("debtor").value==" ")
		{
		document.getElementById("debtor").value="";
		}
	else{
		var value=document.getElementById("debtor").value;
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var demoStr = this.responseText.split(",");
				if(demoStr[0]==1)
					{
					getSetSelect('s2id_debtorType',demoStr[2]);
					document.getElementById("debtorType").value=demoStr[1];
					document.getElementById("name").focus();
					
					var li=document.createElement('OPTION');
					li.value=demoStr[1];
					li.innerHTML=demoStr[2];
					document.getElementById('debtorType').appendChild(li);
					 
					document.getElementById('debtorType').value=demoStr[1];
					
					
					var newDiv=document.createElement("DIV");
					newDiv.id="snackbar";
					document.body.appendChild(newDiv);
					var x = document.getElementById("snackbar");
					x.innerHTML=demoStr[2]+"Added Successfully";
				    x.className = "show";
				    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
				    document.getElementById("debtor").value="";
				    document.getElementById('closeButt').click();
				    document.getElementById('name').focus();
				    
					}
				else{
					alert(demoStr[1]);
					document.getElementById("debtor").value="";
					document.getElementById('debtor').focus();
				}
				
				}
			};
		xhttp.open("POST", "/SAMERP/Expenses.do?addDebtorList=1&debtor="+value, true);
		xhttp.send();
	}
}

function searchName(str,id,list) {
	if (str == " ") {
		document.getElementById(id).value="";
	}
	else if(str==""){
		document.getElementById(list).innerHTML="";
	}
	else{
		if(!document.getElementById(id).value==""){
			var xhttp;
			document.getElementById(id).value=str.toUpperCase();
			xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var demoStr = this.responseText;
					document.getElementById(list).innerHTML = demoStr;
					}
				};
			xhttp.open("POST", "/SAMERP/Expenses.do?findName="+str+"&id="+id, true);
			xhttp.send();
		}
	}
}
function searchName3() {
	
			var xhttp;
			xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var demoStr = this.responseText;
					document.getElementById("getExpList").innerHTML = demoStr;
					}
				};
			xhttp.open("POST", "/SAMERP/Expenses.do?findList=1", true);
			xhttp.send();
	}
function searchName2(str,id,list) {
	if (str == " ") {
		document.getElementById(id).value="";
	}
	else if(str==""){
		document.getElementById(list).innerHTML="";
	}
	else{
		if(!document.getElementById(id).value==""){
			var xhttp;
			document.getElementById(id).value=str.toUpperCase();
			xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var demoStr = this.responseText;
					document.getElementById(list).innerHTML = demoStr;
					}
				};
			xhttp.open("POST", "/SAMERP/Expenses.do?findExpType="+str+"&id="+id, true);
			xhttp.send();
		}
	}
}
function checkData(str,id) {
	if (str == " ") {
		document.getElementById(id).value="";
	}
	else if(str==""){
		document.getElementById("getList").innerHTML="";
	}
	else{
		document.getElementById('getList').innerHTML='';
		if(!document.getElementById(id).value==""){
			var xhttp;
			document.getElementById(id).value=str.toUpperCase();
			xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var demoStr = this.responseText.split(",");
						if(demoStr[0]==0)
						{
							if (confirm("Are You Want To Add "+demoStr[1]) == true) {
						        insertData(str);
						    }
							else{
								document.getElementById(id).value="";
								document.getElementById("getList").innerHTML="";
								document.getElementById(id).focus();
							}
							}
							
					}
				};
			xhttp.open("POST", "/SAMERP/Expenses.do?insertName="+str, true);
			xhttp.send();
		}
	}
}
function insertData(str) {
	if(str=="")
		{
		   alert("something wrong happening");
		   document.getElementById("expenses_type_name").value="";
		   document.getElementById("expenses_type_name").focus();
			document.getElementById("getList").innerHTML="";
		}
	else
		{
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var newdata = this.responseText.split(",");
				if(newdata[0]==1)
					{
					var newDiv=document.createElement("DIV");
					newDiv.id="snackbar";
					document.body.appendChild(newDiv);
					var x = document.getElementById("snackbar");
					x.innerHTML=newdata[1];
				    x.className = "show";
				    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
					}
					
				}
			};
		xhttp.open("POST","/SAMERP/Expenses.do?addNewExpType="+str, true);
		xhttp.send();
			
		}
		
}
function getExpOptions() {
	if(document.getElementById('ddd').value=="")
		{
		   alert("fill something in popup");
		}
	else
		{
		var newoption=document.getElementById('ddd').value;
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				
				var newdata = this.responseText.split(",");
				alert(newdata[0]+","+newdata[1]);
				addNowFunction(newdata[0],newdata[1]);
				getReveal();
				document.getElementById('ddd').value="";
					
				}
			};
		xhttp.open("POST","/SAMERP/Expenses.do?addExpTypeNewOption="+document.getElementById('ddd').value, true);
		xhttp.send();

			
		}
		
}
function addNowFunction(id,value)
{
	var option = document.createElement("option");
    option.text = value;
    option.value = id;
    var select = document.getElementById("expenseType");
    select.appendChild(option);
    var element = document.getElementById("expenseType");
    element.value =id;
    }
    
</script>	
<!-- <script src="/SAMERP/config/js/excanvas.min.js"></script> 
<script src="/SAMERP/config/js/jquery.min.js"></script> 
<script src="/SAMERP/config/js/jquery.ui.custom.js"></script> 
<script src="/SAMERP/config/js/bootstrap.min.js"></script> 
<script src="/SAMERP/config/js/bootstrap-colorpicker.js"></script> 
<script src="/SAMERP/config/js/bootstrap-datepicker.js"></script> 
<script src="/SAMERP/config/js/jquery.toggle.buttons.js"></script> 
<script src="/SAMERP/config/js/masked.js"></script> 
<script src="/SAMERP/config/js/jquery.uniform.js"></script>
<script src="/SAMERP/config/js/matrix.js"></script> 
<script src="/SAMERP/config/js/select2.min.js"></script> 
<script src="/SAMERP/config/js/matrix.form_common.js"></script> 
<script src="/SAMERP/config/js/wysihtml5-0.3.0.js"></script> 
<script src="/SAMERP/config/js/jquery.peity.min.js"></script> 
<script src="/SAMERP/config/js/bootstrap-wysihtml5.js"></script> 
</body>
<script>
$('#update').on('shown.bs.modal', function () {
    $('#uName').focus();
}) 
</script> -->
<script src="/SAMERP/config/js/jquery.min.js"></script> 
<script src="/SAMERP/config/js/jquery.ui.custom.js"></script> 
<script src="/SAMERP/config/js/bootstrap.min.js"></script> 
<script src="/SAMERP/config/js/bootstrap-colorpicker.js"></script> 
<script src="/SAMERP/config/js/bootstrap-datepicker.js"></script> 
<script src="/SAMERP/config/js/jquery.uniform.js"></script> 
<script src="/SAMERP/config/js/select2.min.js"></script> 
<script src="/SAMERP/config/js/jquery.dataTables.min.js"></script> 
<script src="/SAMERP/config/js/matrix.js"></script> 
<script src="/SAMERP/config/js/matrix.tables.js"></script>
<script src="/SAMERP/config/js/wysihtml5-0.3.0.js"></script> 
<script src="/SAMERP/config/js/jquery.peity.min.js"></script> 
<script src="/SAMERP/config/js/bootstrap-wysihtml5.js"></script> 
<script src="/SAMERP/config/js/jquery.toggle.buttons.js"></script>
<script>
$('#update').on('shown.bs.modal', function () {
    $('#uName').focus();
}) 
$('#pettyCashError').on('shown.bs.modal', function () {
    $('#pettyCashOk').focus();
})
</script> 
</html>
