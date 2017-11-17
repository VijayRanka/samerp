<%@page import="admin.JcbPocWork.demo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="com.mysql.jdbc.ResultSet"%>
<%@page import="dao.General.GenericDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.*"%>
<%@ page import="utility.*"%>
<%@page import="java.text.DateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SAMERP PROJECT</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />
<link rel="stylesheet" href="/SAMERP/config/css/select2.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link href="/SAMERP/config/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800'
	rel='stylesheet' type='text/css'>

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
	border-radius: 50px 50px;
}

#snackbar.show {
	visibility: visible;
	-webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
	animation: fadein 0.5s, fadeout 0.5s 2.5s;
}

@
-webkit-keyframes fadein {
	from {bottom: 0;
	opacity: 0;
}

to {
	bottom: 30px;
	opacity: 1;
}

}
@
keyframes fadein {
	from {bottom: 0;
	opacity: 0;
}

to {
	bottom: 30px;
	opacity: 1;
}

}
@
-webkit-keyframes fadeout {
	from {bottom: 30px;
	opacity: 1;
}

to {
	bottom: 0;
	opacity: 0;
}

}
@
keyframes fadeout {
	from {bottom: 30px;
	opacity: 1;
}

to {
	bottom: 0;
	opacity: 0;
}
}
</style>
</head>
<body onload="setFocusToTextBox()">

	<!--Header-part-->
	<div id="header">
		<h1>
			<a href="dashboard.html">Matrix Admin</a>
		</h1>
	</div>

	<!--start-top-serch-->
	<div id="search">

		<%
			if (request.getAttribute("status") != null) {
		%>
		<div id="snackbar"><%=request.getAttribute("status")%></div>
		<%
			}
		%>

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
			<div id="breadcrumb">
				<a href="/SAMERP/index.jsp" title="Go to Home" class="tip-bottom"><i
					class="fa fa-home"></i> Home</a> <a href="#" class="current">Add
					Client</a>
			</div>

		</div>
		<div class="container-fluid">
			<hr>
			<%
			String pay= "";
			
  			if(request.getAttribute("pay")!=null){
  				pay = request.getAttribute("pay").toString();
  			}
				RequireData rq = new RequireData();
			%>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-align-justify"></i>
							</span>
							<h5>Contractor Payment</h5>

						</div>
						<div class="widget-content nopadding">
							<form action="" method="Post" name="form"
								class="form-horizontal" onsubmit="return validateForm()">

								<div class="controls">
									<div class="control-group">
										<label class="control-label">Contracter Name:</label>

										<div class="controls">
											<select name="contractor_name" id="selectid"
												onchange="setPayId()" class="span6" placeholder="Select Team">
												<option selected>Select Contractor</option>
												<%
													List details = rq.getContractorListDetails();
													if (details != null) {
														Iterator itr = details.iterator();
														while (itr.hasNext()) {
															String id = itr.next().toString();
														
															String alias_name = itr.next().toString();
												%>
												<option <%if(request.getParameter("ppid")!=null){if(request.getParameter("ppid").equals(id)){%>selected<% }} %> value="<%=id%>"><%=alias_name%></option>
												<%
													}
												%>
											</select> <input type="hidden" name="supid" id="supid">
										</div>
										<%
											}
										%>
									</div>
								</div>
							</form>
						</div>
					</div>

					<div id="table" class="row-fluid">
						<div class="span15">
							<form action="/SAMERP/ContractorPayment" method="Post"
								id="paymentForm" class="form-horizontal"
								onsubmit="return validateForm()">
								<div class="widget-box">

									<div class="widget-title">
										<span class="icon">
										<%
											  if(request.getParameter("ppid")!=null){
											  List demoList=rq.getProductListContractor(request.getParameter("ppid").toString());
											  List countList=(List)demoList.get(0);
											  if(!countList.isEmpty()){
											  %>
										 <input type="checkbox" id="getACB" onclick="getAllCheckBoxes()"/>
										 <%} }%>
										</span>
										<h5>
											Stock Details
											<h5>
									</div>
									<div class="widget-content nopadding">
										<table class="table table-bordered table-striped with-check">
											<thead>
												  <tr>
											    <th valign="top" rowspan="2">S.No.</th>
											    <th rowspan="2" valign="top">Date</th>
											    <th colspan='3'>Prod Details
											    </th>
											    <th rowspan="2" valign="top">Prod Charges</th>
											    <th colspan='2'>Query Qty</th>
											    <th rowspan="2" valign="top">Query Charges</th>
											  </tr>
											  <tr>
											    <th>Products</th>
											    <th>Qty</th>
											    <th>Rate</th>
											    <th>Qty</th>
											    <th>Rate</th>
											  </tr>
											  </thead>
											  
											  
											  <tbody id="tBody">
											  <%
											  if(request.getParameter("ppid")!=null){
												  
											  List demoList=rq.getProductListContractor(request.getParameter("ppid").toString());
											  if(!demoList.isEmpty()){
												  List countList=(List)demoList.get(1);
												  List demoWholeData=(List)demoList.get(0);
												  %>
												  <input type="hidden" id="megaCount" value="<%=countList.size()%>">
												  <%
												  int initialCount=0;
												  int sCount=1;
												  for(int i=0;i<countList.size();i++)
												  {
													  Object dateObj;
													  if(initialCount<1)
													  	dateObj=demoWholeData.get(initialCount);
													  else
														  dateObj=demoWholeData.get(++initialCount);
													  
													  int dataCount=(int)countList.get(i);
													  
													  %>
											    <tr id="trBody<%=i+1%>">
												    <td rowspan="<%=dataCount-1 %>" valign="top"><input type="checkbox" id="check_<%=i+1%>" onclick="selectChecks(this.id)"></td>
												    <td id="dateObj_<%=i+1 %>" rowspan="<%=dataCount-1 %>" valign="top"><%=dateObj %></td>
												    
													  
													  
													<%
													for(int l=0;l<dataCount-1;l++)
													  {
														  
														  Object prodId=demoWholeData.get(++initialCount);
														  Object name=demoWholeData.get(++initialCount);
														  Object proQty=demoWholeData.get(++initialCount);
														  Object proQtyRate=demoWholeData.get(++initialCount);
														  Object totalProAmt=demoWholeData.get(++initialCount);
														  Object queryQty=demoWholeData.get(++initialCount);
														  Object queryQtyRate=demoWholeData.get(++initialCount);
														  Object totalQueryAmt=demoWholeData.get(++initialCount);
														  
														  if(l>0){
														  %>
														  <tr id="mainData_<%=i+1 %>_<%=l%>"><%} %>
														  
													<td><%=name %></td>
													<td><%=proQty %></td>
													<td><%=proQtyRate %></td>
													<td><%=totalProAmt %></td>
													<td><%=queryQty %></td>
													<td><%=queryQtyRate %></td>
													<td><%=totalQueryAmt %></td>
											   <%} %> 
											  	</tr>	  
														 <% }
													 
												  }
												  
											  }%>
											  <% if(request.getParameter("ppid")!=null){ %>
											  <tr id="calculation">
											  <td></td>
											  <td></td>
											  <th colspan="3" style="text-align: right; ">Total Production Charge</td>
											  <td id="totalProdCharge" style="text-align: center; "></td>
											  <th colspan="2" style="text-align: right; ">Total Querying Charge</td>
											  <td id="totalQueryCharge" style="text-align: center; "></td>
											  </tr>
											  <%} %>
											</tbody>
										</table>
									</div>
								</div>
								<%
											  if(request.getParameter("ppid")!=null){
											  List demoList=rq.getProductListContractor(request.getParameter("ppid").toString());
											  List countList=(List)demoList.get(0);
											  if(!countList.isEmpty()){
											  %>
										 <button type="button" name="view&pay"
									id="payButton" style="margin-left: 480px;" class="btn btn-success" disabled="disabled" onclick="getModal()">View&Pay</button>
										 <%} }%>
							</form>
						</div>
					</div>
					
				</div>
			</div>
			<%if(request.getParameter("ppid")!=null){ %>
			<div class="row-fluid">
				<div class="span12">
				<div class="widget-box">
							<div class="widget-title">
								<span class="icon"><i class="icon-th"></i></span>
								<h5>Details</h5>
							</div>
							<div class="widget-content nopadding">
								<table class="table table-bordered data-table">
									<thead>
										<tr>
											<th>S.No.</th>
											<th>Paid Date</th>
											<th>From-Date</th>
											<th>To Date</th>
											<th>Loading Charges</th>
											<th>Deposit</th>
											<th>Work Amount</th>
											<th>Total Bill Amount</th>
											<th>Paid Amount</th>
											<th>Mode</th>
											<th>Cheque Details</th>
											<th>Bank Info</th>
											<th>Balance</th>
											
										</tr>
									</thead>
									 <tbody>
									<%if(request.getParameter("ppid")!=null){
									List demoList=rq.getContTransactions(request.getParameter("ppid").toString());
									if(demoList!=null)
									{
										int i=1;
									Iterator itr=demoList.iterator();
									while(itr.hasNext())
									{
										itr.next();
										itr.next();
									%>
									<tr>
									<td><%=i %></td>
									<td><%=itr.next() %></td>
									<td><%=itr.next() %></td>
									<td><%=itr.next() %></td>
									<td><%=itr.next() %></td>
									<td><%=itr.next() %></td>
									<td><%=itr.next() %></td>
									<td><%=itr.next() %></td>
									<td><%=itr.next() %></td>
									<td><%=itr.next() %></td>
									<td><%=itr.next() %></td>
									<td><%=itr.next() %></td>
									<td><%=itr.next() %></td>
									</tr>	
									<%itr.next();
									i++;}}
									}%>

									</tbody>
								</table>
							</div>
						</div>
				</div>
			</div>
			<%} %>
		</div>
</div>

		<div id="myModal" class="modal hide fade" role="dialog"
			style="width: 55%; margin-left: -28%;">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Payment Details <font style='color:#eb0a1a' id="payHeading"></font></h4>
					</div>


					<form action='/SAMERP/ConstractorPayment' name="form2" method="Post" onsubmit="myfunction()""
						class="form-horizontal">

						<div class="modal-body">

							<%
								DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
								String requireddate = df.format(new Date()).toString();
							%>
							<div class="control-group">
								<label class="control-label">Date:</label>
								<div class="controls">
									<input type="date" name="current_date" value="<%=requireddate%>"
										id="Updateconame" class="span4" placeholder="Date" readonly="readonly" />
								</div>
							</div>

							<div class="control-group">
								<label class="control-label">(+)Total Product Payment:</label>
								<div class="controls">

									<div class="input-append">

										<input type="text" name="product_payment" id="product_pymt"
											class="span4" placeholder="Total Product Payment" readonly="readonly" />
									</div>
								</div>
							</div>

							<div class="control-group">
								<label class="control-label">(+)Total Querying Payment:</label>
								<div class="controls">
									<input type="text" name="querying_paymt" id="querying_pymt"
										class="span4" placeholder="Total Querying Payment " readonly="readonly" />
								</div>
							</div>

							<div class="control-group">
								<label class="control-label"> (+)Total Loading Charges:</label>
								<div class="controls">

									<div class="input-prepend"> 
									<span class="add-on" id="loadingCount" style="font-weight: bolder;"></span>
                   					<input type="text" id="totalLoadCharge" placeholder="Total Loading Charges" class="span4" style="width: 329px" readonly="readonly">

									</div>
								</div>
							</div><div class="control-group">
								<label class="control-label">(-)Contractor Deposit:</label>
								<div class="controls">

								<div class="input-prepend"> 
									<span class="add-on" id="depositCount" style="font-weight: bolder;"></span>
                   					<input type="text" name="" id="totalDeposit" placeholder="Total Deposit" class="span4" style="width: 329px" readonly="readonly">
									</div>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label"> Total:</label>
								<div class="controls">

									<input type="text" name="total" id="grandTotal"
										placeholder="Client Balance Amount" class="span4" readonly="readonly" />
								</div>
							</div>

						</div>
						<div class="modal-footer" style="padding-left: 450px">
						<button type="button"  class="btn btn-success" data-toggle="modal" data-target="#paymentEntry" onclick="getPaymentEntryModal()">Pay</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						</div>

					</form>
				</div>

			</div>

		</div>

<%if(request.getParameter("ppid")!=null){ %>
<div class="modal hide fade zoom-out" id="paymentEntry" role="dialog" >
<form class="form-horizontal" action="/SAMERP/ContractorPayment" method="post">
	<div class="modal-header">
		<a class="close" data-dismiss="modal"></a>
		<h5>Payment Entry</h5>
	</div>
	
	<div class="modal-body" style="padding: 0;">
		
			<div class="form-group">
				<div class="widget-content nopadding">
					<div class="control-group" style="">
	             	   <label class="control-label">(+)Previous Remaining : </label>
		               <div class="controls">
		                 <input type="text" name="prevRemAmount" id="prevRemAmount" readonly="readonly" placeholder="Previous Remaining Amount" />
		               </div>
	             	</div>
	             	<div class="control-group" style="">
	             	   <label class="control-label">(+)Current Amount : </label>
		               <div class="controls">
		                 <input type="text" name="currentAmount" id="currentAmount" readonly="readonly"  placeholder="Current Amount"/>
		               </div>
	             	</div>
	             	<div class="control-group" style="">
	             	   <label class="control-label">Total Payment : </label>
		               <div class="controls">
		                 <input type="text" name="totalPayAmt" id="totalPayAmt" readonly="readonly"  placeholder="Total Payment"/>
		               </div>
	             	</div>
					
					<div class="control-group" style="">
	             	   <label class="control-label">(-)Paid Amount : </label>
		               <div class="controls">
		                 <input type="text" name="paidAmount" id="paidAmount" placeholder="Paid Amount" required/>
		               </div>
	             	</div>
					
					<div class="control-group" style="">
					<%SysDate sd= new SysDate(); %>
	             		<label class="control-label">Date : </label>
			               <div class="controls">
			               
			                 <input type="date" name="paidDate" value="<%=sd.todayDate().split("-")[2]+"-"+sd.todayDate().split("-")[1]+"-"+sd.todayDate().split("-")[0] %>" required/>
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
			            	  		List List1 = rq.getBank();
			            	  		Iterator itr = List1.iterator();
				              		while(itr.hasNext()){
				              %>
					                	<option value="<%=itr.next()%>"><%=itr.next()%></option>
					           <%
				              		}
					           %>   
       					</select>  
		               </div>
	             	</div>
		            
				</div>
			</div>
		</div>
		<div class="modal-footer">
		        <input type="hidden" value="<%=request.getParameter("ppid") %>" name="contId"/>
		         <input type="text" name="dateFromTo" id="dateFromTo"/>
		          <input type="hidden" name="deposit" id="deposit"/>
		           <input type="hidden" name="loadingCharges" id="loadingCharges"/>
				<input type="submit" id="paymentSubmitbtn" name="paymentSubmit" class="btn btn-primary" value="Submit" />
				<button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
			</div>
	</form>
</div>
<%} %>

<div class="row-fluid">
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a
				href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
	</div>


		<script type="text/javascript"> 
		
		function getParameterByName(name, url) {
		    if (!url) url = window.location.href;
		    name = name.replace(/[\[\]]/g, "\\$&");
		    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
		        results = regex.exec(url);
		    if (!results) return null;
		    if (!results[2]) return '';
		    return decodeURIComponent(results[2].replace(/\+/g, " "));
		}
		
		function getPaymentEntryModal()
		{
			var x=document.getElementById("prevRemAmount").value;
			var contId=getParameterByName("ppid").trim();
			var xhttp;
			xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var demoStr = this.responseText;
					var totalAmount=0;
					if(demoStr!=0)
						{
							x=demoStr;
							document.getElementById("prevRemAmount").value=demoStr;
						}
					else{
						x=0;
						document.getElementById("prevRemAmount").value=0;
					}
					document.getElementById("currentAmount").value=totalGrandAmount;
					
					document.getElementById("totalPayAmt").value=+x+ +totalGrandAmount;
					
					document.getElementById("dateFromTo").value=getDate(myArray[0])+","+getDate(myArray[myArray.length-1]);
					}
				};
			xhttp.open("POST", "/SAMERP/ContractorPayment?contId="+contId, true);
			xhttp.send();
		}
		function getAllCheckBoxes()
		{
			if(document.getElementById("getACB").checked==true)
				{
				var count=document.getElementById("megaCount").value;
				if(count>0)
					{
					window.myArray=[];
					for(var i=1;i<=count;i++)
					{
						myArray.push(i);
					}
					var totalProQty=0;
					var totalQQty=0;
					 for(var i=1;i<=count;i++)
						{
							 totalProQty=totalProQty+ +document.getElementById('trBody'+i).children[5].innerHTML.trim();
							 totalQQty=+totalQQty+ +document.getElementById('trBody'+i).children[8].innerHTML.trim();
							
							var dataCount=document.getElementById('trBody'+i).children[1].rowSpan;
							for(var j=1;j<dataCount;j++)
								{
								totalProQty=totalProQty+ +	document.getElementById('mainData_'+i+"_"+j).children[3].innerHTML.trim();
								
								totalQQty=+totalQQty+ +document.getElementById('mainData_'+i+"_"+j).children[6].innerHTML.trim();
								
								}
						} 
					 document.getElementById('totalProdCharge').innerHTML=totalProQty;
					 document.getElementById('totalQueryCharge').innerHTML=totalQQty;
					 document.getElementById('payButton').disabled=false;
					}
				
				}
			else if(document.getElementById("getACB").checked==false){
				var count=document.getElementById("megaCount").value;
				if(count>0)
					{
					window.myArray=[];
					 document.getElementById('totalProdCharge').innerHTML="";
					 document.getElementById('totalQueryCharge').innerHTML="";
					 document.getElementById('payButton').disabled=true;
					}
			}
				
		}
		
		function getModal()
		{
			if(myArray.length>0)
				{
				if(myArray.length==1)
				{
				myArray.push(myArray[0]);
				}
			if(totalProdCharge.innerHTML.trim()!=null && totalQueryCharge.innerHTML.trim()!=null)
			{
				var startDate=getDate(myArray[0]);
				var lastDate=getDate(myArray[myArray.length-1]);
				document.getElementById("payHeading").innerHTML="(from "+startDate.split("-")[2]+"-"+startDate.split("-")[1]+"-"+startDate.split("-")[0]+" to "+lastDate.split("-")[2]+"-"+lastDate.split("-")[1]+"-"+lastDate.split("-")[0]+")";
				var contId=getParameterByName("ppid").trim();
				var xhttp;
				xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						var myData = this.responseText.split(",");
						var totalAmount=0;
						if(myData[0]==1)
							{
							document.getElementById("depositCount").innerHTML=myData[1];
							document.getElementById("totalDeposit").value=myData[2];
							
							document.getElementById("deposit").value=myData[2];
							document.getElementById("loadingCharges").value=myData[4];
							
							document.getElementById("loadingCount").innerHTML=myData[3];
						    document.getElementById("totalLoadCharge").value=myData[4];
						    totalAmount= +myData[2] - +myData[4];
							}
						else
							{
							document.getElementById("deposit").value=0;
							document.getElementById("loadingCharges").value=0;
							document.getElementById("totalDeposit").setAttribute("placeholder","No Amount");
						    document.getElementById("totalLoadCharge").setAttribute("placeholder","No Amount");
							}
					    var x=document.getElementById("product_pymt").value=totalProdCharge.innerHTML.trim();
					    var xx=document.getElementById("querying_pymt").value=totalQueryCharge.innerHTML.trim();
					    window.totalGrandAmount=document.getElementById("grandTotal").value= +x+ +xx - totalAmount;
					    if(totalGrandAmount<0)
					    alert("Already "+Math.abs(totalGrandAmount)+" paid! No Need To Pay Extra")
					    $("#myModal").modal();
					    	
						
						}
					};
				xhttp.open("POST", "/SAMERP/ContractorPayment?getAmountList=1&startDate="+startDate+"&lastDate="+lastDate+"&contrId="+contId, true);
				xhttp.send();
			}
				
				}
			
		}
		function getDate(id)
		{
			var x=document.getElementById("trBody"+id).children[1].innerHTML.trim();
			return x;
			
		}
		
		
		
		function selectChecks(id)
		{
			//  document.getElementById(id);   alert();
			
			var demoCount=id.split("_")[1];
			var arrayAmount=[];
			var getInitial;
			var status=false;
			var count=document.getElementById("megaCount").value;
			alert(count);

			for(var i=1;i<=count;i++)
				{
				
				if(i==demoCount)
					{}
				else if(document.getElementById("check_"+i).checked==true)
				{
					getInitial="check_"+i;
					status=true;
					break;
				}
				}
			
			
			if(status==true)
				{
					var fromCount=getInitial.split("_")[1];
					
					
					for(var j=demoCount;j<=count;j++)
					{
					if(document.getElementById("check_"+j).checked==true)
					{
						document.getElementById('uniform-check_'+j).children[0].setAttribute('class','');
						document.getElementById("check_"+j).checked=false;
						if(arrayAmount.length>0)
							{
							for(var k=0;k<arrayAmount.length;k++)
								{
								if(arrayAmount[k]!=null)
									{
										if(arrayAmount[k]==j)
											{
											arrayAmount.splice(j,arrayAmount.length-1);
											}
									}
								else{
									break;
								}
									
								}
							}
						
					}
					}
					
					if(fromCount<demoCount){
						var finalStatus=false;
					for(;fromCount<=demoCount;fromCount++)
						{
						document.getElementById('uniform-check_'+fromCount).children[0].setAttribute('class','checked')
						document.getElementById("check_"+fromCount).checked=true;
						arrayAmount.push(fromCount);
						finalStatus=true;
						
						}
						if(finalStatus)
							{
							
								if(arrayAmount.length>0)
									{
									
									setRates(arrayAmount,1);
									}
								
								
							}
					}
					else{
						
					}
				}
			else{
				arrayAmount.push(demoCount);
				 document.getElementById('payButton').disabled=false;
				setRates(arrayAmount,1);
			}
			checkDataBelow();	
		}
		
		function checkDataBelow()
		{
			var count=document.getElementById("megaCount").value;
			forAll=1;
			for(var i=1;i<=count;i++)
				{
				if(document.getElementById("check_"+i).checked==false)
					{
						
						forAll++;
					}
				}
			if(forAll-1==count)
				{
				document.getElementById('totalProdCharge').innerHTML="";
				document.getElementById('totalQueryCharge').innerHTML="";
				document.getElementById('payButton').disabled=true;
				
				document.getElementById('payButton').style.cursor="not-allowed";
				if(myArray.length>0)
				{
				myArray=[];
				}
				} 
			
		}		
		
		function setRates(arrayAmt,value)
		{
			if(value==1)
				{
					var totalProRate=0;
					var totalQueryRate=0;
					for(var i=0;i<arrayAmt.length;i++)
						{

						totalProRate=+totalProRate+ +document.getElementById('trBody'+arrayAmt[i]).children[5].innerHTML.trim();
						totalQueryRate=+totalQueryRate+ +document.getElementById('trBody'+arrayAmt[i]).children[8].innerHTML.trim();
			
							var dataCount=document.getElementById('trBody'+arrayAmt[i]).children[1].rowSpan;
							for(var j=1;j<dataCount;j++)
								{
								totalProRate=+totalProRate+ +document.getElementById('mainData_'+arrayAmt[i]+"_"+j).children[3].innerHTML.trim();
								totalQueryRate=+totalQueryRate+ +document.getElementById('mainData_'+arrayAmt[i]+"_"+j).children[6].innerHTML.trim();
								}
						}
						
					document.getElementById('totalProdCharge').innerHTML=totalProRate;
					document.getElementById('totalQueryCharge').innerHTML=totalQueryRate;
					if(arrayAmt.length>0 && arrayAmt.length<2)
						{
						arrayAmt.push(arrayAmt[0]);
						window.myArray=arrayAmt;
						}
					else
						{
						window.myArray=arrayAmt;
						}
					checkDataBelow();
					
					
					
					
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
			function setPayId() {
				var s = document.getElementById("selectid").value;
				window.location.href="/SAMERP/jsp/admin/payment/contractorPayment.jsp?ppid="+s;
			}

			function myFunction() {
				 if( document.getElementById("snackbar")!=null)
					 {
						var x = document.getElementById("snackbar")
						x.className = "show";
						setTimeout(function() {
							x.className = x.className.replace("show", "");
						}, 3000);
					 }
			}

			
			function showModal() {
				
				var someVarName = localStorage.getItem("someVarName");
				
				var pay = document.getElementById("pay").value;
	
				if (pay== 3) {
					$('#paymentEntry').modal('show');
				}
				if (someVarName > 0) {
					$('#myModal').modal('show');
				}
				localStorage.setItem('someVarName', null);
			}

			function setFocusToTextBox() {

				myFunction();
			}
			/* 
			function contractorPmt() {
			    var x = document.getElementById("paymentEntry")
			    x.className = "show";
			    setTimeout(function(){ x.className = x.className.replace("show", ""); });
			} */
		</script>

		<!--end-Footer-part-->

		<script src="/SAMERP/config/js/jquery.min.js"></script>
		<script src="/SAMERP/config/js/jquery.ui.custom.js"></script>
		<script src="/SAMERP/config/js/bootstrap.min.js"></script>
		<script src="/SAMERP/config/js/jquery.uniform.js"></script>
		<script src="/SAMERP/config/js/select2.min.js"></script>
		<script src="/SAMERP/config/js/jquery.dataTables.min.js"></script>
		<script src="/SAMERP/config/js/matrix.js"></script>
		<script src="/SAMERP/config/js/matrix.tables.js"></script>
</body>
<script>
$("#myModal").on('shown',function(){
	$('#payButton').focus();
	
});	
$("#paymentEntry").on('shown',function(){
	$('#paidAmount').focus();
	
});	
	
</script>

</html>