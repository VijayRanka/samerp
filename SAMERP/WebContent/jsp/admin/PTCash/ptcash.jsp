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
<title>Vertical Software</title>
<html lang="en">
<head>
<title>SAMERP PROJECT</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- <link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/colorpicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />
<link rel="stylesheet" href="/SAMERP/config/css/select2.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-wysihtml5.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bs_modal_transition.css" /> -->



<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link href="/SAMERP/config/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/colorpicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />
<link rel="stylesheet" href="/SAMERP/config/css/select2.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bs_modal_transition.css" />
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

@
-webkit-keyframes fadein {
	from {top: 0;
	opacity: 0;
}

to {
	top: 80px;
	opacity: 1;
}

}
@
keyframes fadein {
	from {top: 0;
	opacity: 0;
}

to {
	top: 80px;
	opacity: 1;
}

}
@
-webkit-keyframes fadeout {
	from {top: 80px;
	opacity: 1;
}

to {
	top: 0;
	opacity: 0;
}

}
@
keyframes fadeout {
	from {top: 80px;
	opacity: 1;
}

to {
	top: 0;
	opacity: 0;
}

}
.ttiptext {
	position: absolute;
	height: 17.5px;
	width: 26px;
	background-color: #3a87ad;
	color: #fff;
	text-align: center;
	border-radius: 0px 150px 150px 0px;
	padding: 5px 0;
	left: 473px;
	top: 49px;
}

#vehicleDiv {
	display: none;
}

#readingDiv {
	display: none;
}

#vehicleLtrDiv {
	display: none;
}
</style>
<body onload="">

	<!--Header-part-->
	<div id="header">
		<h1>
			<a href="dashboard.html">Matrix Admin</a>
		</h1>
	</div>

	<!--start-top-serch-->
	<%
		if (request.getAttribute("status") != null) {
	%>
	<div id="snackbar"><%=request.getAttribute("status")%></div>
	<%
		}
	%>
	
	<%
	RequireData rq=new RequireData();
	%>
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
			<div id="breadcrumb">
				<a href="index.html" class="tip-bottom"
					data-original-title="Go to Home"><i class="icon-home"> </i>
					Home</a> <a href="#" class="current">PT Cash</a>
			</div>
		</div>
		<!--End-breadcrumbs-->
		<div class="container-fluid">
			<hr>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
					<div class="widget-title">
							<span class="icon"> <i class="icon-align-justify"></i>
							</span>
							<h5>PT Cash</h5>
						</div>
						
						<div class="widget-content nopadding">
							<form action="/SAMERP/PTCash" method="Post"
								class="form-horizontal" onsubmit="return validateForm()">
								<div class="control-group">
									<label class="control-label">Date :</label>
									<div class="controls">
										<%
											SysDate date = new SysDate();
											String[] demo = date.todayDate().split("-");
											String requireddate = demo[2] + "-" + demo[1] + "-" + demo[0];
										%>
										<input type="date" name="date" value="<%=requireddate%>"
											class="span4">
									</div>
								</div>
								<%
								
								List list=rq.getPreviousBal();
								Iterator itr2=list.iterator();
								while(itr2.hasNext())
								{
									
									String pre_balance=itr2.next().toString();								
								%>

								<div class="control-group">
									<label class="control-label">Previous Balance:</label>
									<div class="controls">
										<input type="text" name="previous_balance" value="<%=pre_balance%>" class="span4" onkeyup="this.value=this.value.toUpperCase()"
											placeholder="Previous Balance" pattern="[0-9]*" required />
									</div>
								</div>
								<%
								
								}
								
								%>
								<a href="#paymentEntry" data-toggle="modal"
									style="position: absolute; margin-left: 46%; margin-top: 1.4%;">
									<span class="badge badge-inverse"><i class="icon-plus"></i></span>
								</a>

						<div class="control-group">
									<label class="control-label">Hand Loan:</label>
									<div class="controls">
										<input type="text" name="hand_loan" class="span4"
											placeholder="Hand Loan"
											onkeyup="this.value=this.value.toUpperCase()"
											pattern="[0-9]*" maxlength="10" required />
									</div>
								</div>
								
						
						<a href="#addbankname" data-toggle="modal"
									style="position: absolute; margin-left: 46%; margin-top: 1.4%;">
									<span class="badge badge-inverse"><i class="icon-plus"></i></span>
								</a>
						
						
							<div class="control-group">
										<label class="control-label">Bank Name:</label>
										<div class="controls" style="width: 893px;">
											<select name="bank_name" class="span4">

												<%
													List details = rq.getBankAliasList();
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
									<label class="control-label"> ATM Cash Amount:</label>
									<div class="controls">
										<input type="text" name="amount" class="span4"
											placeholder="Amount" pattern="[0-9]*" required />
									</div>
								</div>
								
									<div class="control-group">
									<label class="control-label"> Pay Received:</label>
									<div class="controls">
										<input type="text" name="pay_received" class="span4"
											placeholder="Pay Received" pattern="[0-9]*" required />
									</div>
								</div>									

								<div class="control-group">
									<label class="control-label">Total:</label>
									<div class="controls">
										<input type="text" class="span4" name="total"
											placeholder="Total" required />
									</div>
								</div>

								<div class="form-actions" style="padding-left: 350px">
									<button type="submit" name="insert" class="btn btn-success">OK</button>&nbsp;&nbsp;&nbsp;
									<a type="button" href="/SAMERP/index.jsp" class="btn btn-danger" style="margin-right: 20px">Exit</a>
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
							<h5>Contractor Details</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered data-table">
								<thead>
									<tr>
										<th>Sr.No</th>
										<th>Date</th>
										<th>Hand Loan</th>
										<th>Bank Name</th>
										<th>ATM Cash Amount</th>
										<th>Pay Received</th>
										<th>Total</th>
										<th>Action</th>
									</tr>
								</thead>
								
								<tbody>
							
								</tbody>
							</table>
						</div>
					</div>

				</div>
			</div>

		</div>
	</div>

<div class="modal hide fade" id="addbankname" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Add New Bank </h4>
				</div>
				<div class="modal-body">
					<form action="/SAMERP/PTCash" method="post" class="form-horizontal">
					<div class="control-group">
									<label class="control-label">Add Bank Name:</label>
									<div class="controls">
										<input type="text" class="span3" name="bank_name"
											placeholder="Bank Name" required />
									</div>
								</div>
								
						<div class='modal-footer' >
							<button type="submit" name="addBankName" class="btn btn-success">Submit</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>
	<div class="modal hide fade zoom-out" id="paymentEntry" role="dialog">
		<div class="modal-header">
			<a class="close" data-dismiss="modal"></a>
			<h5>Hand Loan Details</h5>
		</div>

		<div class="modal-body" style="padding: 0;">
			<form class="form-horizontal" action="/SAMERP/PTCash"
				method="post" name="ptcash">
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
								<input type="text" name="name" placeholder="Name" required />
							</div>
						</div>
						
						<div class="control-group" style="">
							<label class="control-label">Mobile No: </label>
							<div class="controls">
								<input type="text" name="mobileno" placeholder="Mobile No"
									maxlength="10" required />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">Date :</label>
							<div class="controls">
								<%
									SysDate date1 = new SysDate();
									String[] demo1 = date.todayDate().split("-");
									String reqdate = demo[2] + "-" + demo[1] + "-" + demo[0];
								%>
								<input type="date" name="date" value="<%=reqdate%>">
							</div>
						</div>

						<div class="control-group" style="">
							<label class="control-label">Amount : </label>
							<div class="controls">
								<input type="text" name="paidAmt" placeholder="Amount" 
									required />
							</div>
						</div>

						<div class="control-group" style="">
							<label class="control-label">Payment Mode : </label>
							<div class="controls">
								<input type="radio" value="Cash" style="margin-left: 1%;"
									name="payMode" onclick="displayBank()" checked="checked" />
								Cash <input type="radio" value="Cheque" style="margin-left: 1%;"
									name="payMode"
									onclick="displayBank('bankDetails', 'chequeDetails')" />
								Cheque <input type="radio" value="Transfer"
									style="margin-left: 1%;" name="payMode"
									onclick="displayBank('bankDetails')" /> Transfer
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
							<div class="controls" style="width: 44%;">
								<select name="bankInfo" id="bankInfo">
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

				<div class="modal-footer">
					<input type="submit" id="paymentSubmitbtn" name="handloanbtn"
						class="btn btn-primary" value="Submit" /> <a href="/SAMERP/index.jsp"
						class="btn btn-danger" data-dismiss="modal">Cancel</a>
				</div>

			</form>
		</div>
	</div>

	<!--end-main-container-part-->

	<!--Footer-part-->

	<div class="row-fluid">
		<div id="footer" class="span12">
			2013 &copy; Matrix Admin. Brought to you by <a
				href="http://themedesigner.in">Themedesigner.in</a>
		</div>
	</div>

<script>
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

</script>


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
</html>
