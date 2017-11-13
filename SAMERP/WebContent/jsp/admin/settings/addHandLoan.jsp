<%@page import="utility.SysDate"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="utility.RequireData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
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
</style>
<body onload="setFocusToTextBox()">

<!--Header-part-->
<div id="header">
  <h1><a href="dashboard.html">Matrix Admin</a></h1>
</div>

<!--start-top-serch-->

<div id="search">
<% if(request.getAttribute("status1")!=null){ %>
<div id="snackbar"><%=request.getAttribute("status1")%></div>
<%} %>

  <button type="submit" class="tip-bottom">LOGOUT</button>
</div>

<!--close-top-serch-->

<!--sidebar-menu-->
<jsp:include page="../common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->	

	<div id="content">
		<!--breadcrumbs-->
		<div id="content-header">
			<div id="breadcrumb">
				<a href="index.html" class="tip-bottom"
					data-original-title="Go to Home"><i class="icon-home"> </i>
					Home</a> <a href="#" class="current">Add HandLoan </a>
			</div>
		</div>
		<%
			RequireData rq=new RequireData();
		
		%>
		<!--End-breadcrumbs-->
		<div class="container-fluid">
			<hr>
			<div class="row-fluid">
				<div class="span14">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-align-justify"></i>
							</span>
							<h5>Add HandLoan</h5>
						</div>
						<div class="widget-content nopadding">
							<form class="form-horizontal" action="/SAMERP/AddHandLoan" method="post" name="handloan">
								<div class="form-group">
									<div class="widget-content nopadding">
				
										<%
											String totalR = "";
											if (request.getParameter("ppid") != null) {
												totalR = rq.getTotalRemaining(request.getParameter("ppid"));
											}
										%>
				
				
										<div class="control-group" style="">
											<label class="control-label">Name: </label>
											<div class="controls">
												<input type="text" name="name" placeholder="Name" onkeyup="this.value=this.value.toUpperCase()" required />
											</div>
										</div>
										
										<div class="control-group" style="">
											<label class="control-label">Mobile No: </label>
											<div class="controls">
												<input type="text" name="mobileno" placeholder="Mobile No"	maxlength="10" required />
											</div>
										</div>
				
										<div class="control-group">
											<label class="control-label">Date :</label>
											<div class="controls">
												<%
													SysDate date1 = new SysDate();
													String[] demo1 = date1.todayDate().split("-");
													String reqdate = demo1[2] + "-" + demo1[1] + "-" + demo1[0];
												%>
												<input type="date" name="date" value="<%=reqdate%>">
											</div>
										</div>
				
										<div class="control-group" style="">
											<label class="control-label">Amount : </label>
											<div class="controls">
												<input type="text" name="paidAmt" placeholder="Amount" 	required />
											</div>
										</div>
				
										<div class="control-group" style="">
											<label class="control-label">Payment Mode : </label>
											<div class="controls">
												<input type="radio" value="Cash" style="margin-left: 1%;" name="payMode" onclick="displayBank()" checked="checked" />Cash
												 <input type="radio" value="Cheque" style="margin-left: 1%;" name="payMode"	onclick="displayBank('bankDetails', 'chequeDetails')" />
												Cheque <input type="radio" value="Transfer"	style="margin-left: 1%;" name="payMode"	onclick="displayBank('bankDetails')" /> Transfer
											</div>
										</div>
				
										<div class="control-group" id="chequeDetails"
											style="display: none;">
											<label class="control-label">Cheque Number : </label>
											<div class="controls">
												<input type="text" placeholder="Cheque Number" name="chequeNo"
													id="chequeNo" />
											</div>
										</div>
				
				
										<div class="control-group" id="bankDetails" style="display: none;">
											<label class="control-label">Bank Details : </label>
											<div class="controls" style=" width: 220px";
}">
												<select name="bankInfo" id="bankInfo" style=" width: 220px">
													<option value="">Select Bank Account</option>
													<%
														List List1 = rq.getBank();
														Iterator itr6 = List1.iterator();
														while (itr6.hasNext()) {
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
				
								<div class="modal-footer" style="120px;">
									<input type="submit" id="handloanbtn" name="handloanbtn"
										class="btn btn-primary" value="Submit" style="margin-right: 10px;"/> <a href="/SAMERP/index.jsp"
										class="btn btn-danger" data-dismiss="modal" style="margin-right: 404px;">Exit</a>
								</div>
				
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="row-fluid">
				<div class="span14">

					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"><i class="icon-th"></i></span>
							<h5>HandLoan Details</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered data-table">
								<thead>
									<tr>
										<th>HandLoan Id</th>
										<th>Name</th>
										<th>Mobile No</th>
										<th>Date</th>
										<th>Amount</th>
										<th>Mode</th>
										<th>Particulars</th>
										<th>AliasName</th>
										<th>Action</th>
									</tr>
								</thead>
								<%
									int id = 0, count = 1;
									RequireData rd = new RequireData();
									List l = rq.getHandLoanDetails();
									if (l != null) {
										Iterator itr = l.iterator();
								%>
								<tbody>
									<%
										while (itr.hasNext()) {
												String id1 = itr.next().toString();
									%>
									<tr class="gradeX">
										<td id="<%=id1%>"><%=count%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										
										<td><a href="#update" data-toggle="modal"
											onclick="searchName(<%=id1%>)">Update</a> </td>
									</tr>
									<%
										count++;
											}
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
	<div class="modal hide fade zoom-out" id="update" role="dialog">
		<div class="modal-header">
			<a class="close" data-dismiss="modal"></a>
			<h5>Hand Loan Details</h5>
		</div>

		<div class="modal-body" style="padding: 0;">
			<form class="form-horizontal" action="/SAMERP/AddHandLoan" method="post" name="ptcash">
				<div class="form-group">
					<div class="widget-content nopadding">

						<%
							String total = "";
							if (request.getParameter("ppid") != null) {
								total = rq.getTotalRemaining(request.getParameter("ppid"));
							}
						%>


						<div class="control-group" style="">
							<label class="control-label">Name: </label>
							<div class="controls">
							<input type="hidden" name="Updateid" id="Updateid">
								<input type="text" name="name" id="update_name" placeholder="Name" onkeyup="this.value=this.value.toUpperCase()" pattern="[a-z A-Z]*" required />
							</div>
						</div>
						
						<div class="control-group" style="">
							<label class="control-label">Mobile No: </label>
							<div class="controls">
								<input type="text" name="mobileno" id="update_mobileno" placeholder="Mobile No"	maxlength="10"  pattern="[0-9]*" required />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">Date :</label>
							<div class="controls">
								<%
									SysDate date= new SysDate();
									String[] demo = date.todayDate().split("-");
									String rqdate = demo[2] + "-" + demo[1] + "-" + demo[0];
								%>
								<input type="date" name="date" id="update_date" value="<%=rqdate%>" required>
							</div>
						</div>

						<div class="control-group" style="">
							<label class="control-label">Amount : </label>
							<div class="controls">
								<input type="text" name="paidAmt" id="update_amount" placeholder="Amount" 	pattern="[0-9]*" required />
							</div>
						</div>
						
						<div class="control-group" style="">
							<label class="control-label">AliasName: </label>
							<div class="controls">
								<input type="text" name="aliasname" id="update_aliasname" placeholder="AliasName" 	pattern="[a-z A-Z _ 0-9]*" required />
							</div>
						</div>

						<div class="control-group" style="">
							<label class="control-label">Payment Mode : </label>
							<div class="controls">
								<input type="radio" value="Cash" style="margin-left: 1%;"  id="payid" name="payMode" readonly onclick="bankDetails()" checked="checked" />Cash
								 <input type="radio" value="Cheque" style="margin-left: 1%;"  id="payid" name="payMode"	readonly onclick="bankDetails('bankDetails1', 'chequeDetails1')" />
								Cheque <input type="radio" value="Transfer"	style="margin-left: 1%;"  id="payid" name="payMode"	readonly onclick="bankDetails('bankDetails')" /> Transfer
							</div>
						</div>

						<div class="control-group" id="chequeDetails"
							style="display: none;">
							<label class="control-label">Cheque Number : </label>
							<div class="controls">
								<input type="text" placeholder="Cheque Number" readonly name="chequeNo"
									id="chequeNo" />
							</div>
						</div>


						<div class="control-group" id="bankDetails" style="display: none;">
							<label class="control-label">Bank Details : </label>
							<div class="controls" style="width: 44%;">
								<select name="bankInfo" id="bankInfo" readonly>
									<option value="">Select Bank Account</option>
									<%
										List List = rq.getBank();
										Iterator itr5 = List1.iterator();
										while (itr5.hasNext()) {
									%>
									<option value="<%=itr5.next()%>"><%=itr5.next()%></option>
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
					<input type="submit" name="update" class="btn btn-primary" value="Submit" style="margin-right: 10px;"/>
					 <a href="/SAMERP/index.jsp" class="btn btn-danger" data-dismiss="modal">Cancel</a>
				</div>

			</form>
		</div>
	</div>
	

	<script type="text/javascript">
	
	function searchName(id1) {
		
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				
				var demoStr = this.responseText.split(",");
			
				document.getElementById("Updateid").value = demoStr[0];
				document.getElementById("update_name").value = demoStr[1];
				document.getElementById("update_mobileno").value = demoStr[2];
				
				var date=new Date(demoStr[3]);
				 var d = date.getDate();
				    var m = date.getMonth() + 1;
				    var y = date.getFullYear();
				    var getdate=('' + y + '-' + (m<=9 ? '0' + m : m) + '-' + (d <= 9 ? '0' + d : d));
				    
				    document.getElementById("update_date").value = getdate;
				    
				document.getElementById("update_amount").value = demoStr[4];
				document.getElementById("update_aliasname").value = demoStr[5];
				document.getElementById("payid").value = demoStr[6];
				document.getElementById("chequeNo").value = demoStr[7];
				
				}
			};
		xhttp.open("POST","/SAMERP/AddHandLoan?Updateid="+id1, true);
		xhttp.send();
		
		
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

function showModal(){
	var someVarName = localStorage.getItem("someVarName");
	
	var error = document.getElementById("error").value;

	if(error==2)
	{
		$('#Insert_time').modal('show');
	}	
	
	if(someVarName>0)
		{
			$('#update').modal('show');
		}
	localStorage.setItem('someVarName', null);
}

function setFocusToTextBox()
{
	document.getElementById("updatecname").focus();
	showModal();   	
	 myFunction();
}

function bankDetails(id, id1){
	var x = document.getElementById(id);
	var y = document.getElementById(id1);
	
	if( x==null ){
		document.getElementById("chequeNo1").required=false;
		document.getElementById("bankInfo1").required=false;
		
		document.getElementById("chequeDetails1").style.display = "none";
		document.getElementById("bankDetails1").style.display = "none";
		
	}
	else if(x!=null && y!=null){
		x.style.display = "block";
		y.style.display = "block";
		
		document.getElementById("chequeNo1").required=true;
		document.getElementById("bankInfo1").required=true;
	}
	else{	

		document.getElementById("chequeNo1").required=false;
		document.getElementById("chequeDetails1").style.display = "none";
		
		x.style.display = "block";
		document.getElementById("bankInfo1").required=true;
	}
}


</script>

<div class="row-fluid">
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a
				href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
	</div>
<script src="/SAMERP/config/js/jquery.min.js"></script>
	<script src="/SAMERP/config/js/jquery.ui.custom.js"></script>
	<script src="/SAMERP/config/js/bootstrap.min.js"></script>
	<script src="/SAMERP/config/js/jquery.uniform.js"></script>
	<script src="/SAMERP/config/js/select2.min.js"></script>
	<script src="/SAMERP/config/js/jquery.dataTables.min.js"></script>
	<script src="/SAMERP/config/js/matrix.js"></script>
	<script src="/SAMERP/config/js/matrix.tables.js"></script>
</body>
</html>
