<!DOCTYPE html>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="utility.RequireData"%>
<%@page import="utility.SysDate"%>
<html lang="en">
<head>
<title>Matrix Admin</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/colorpicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />
<link rel="stylesheet" href="/SAMERP/config/css/select2.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-wysihtml5.css" />
<link href="/SAMERP/config/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800'
	rel='stylesheet' type='text/css'>

<style type="text/css">
#s2id_autogen3, #s2id_vehicle_update, #s2id_vehicle, #s2id_cust_project,
	#s2id_cust_project_update {
	float: right;
}
</style>
</head>
<body>

	<!--Header-part-->
	<div id="header">
		<h1>
			<a href="dashboard.html">Matrix Admin</a>
		</h1>
	</div>

	<!--start-top-serch-->
	<div id="search">

		<button type="submit" class="tip-bottom">LOGOUT</button>
	</div>
	<!--close-top-serch-->
	<!--sidebar-menu-->
	<jsp:include page="/jsp/admin/common/left_navbar.jsp"></jsp:include>
	<!--sidebar-menu-->
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				<a href="index.html" title="Go to Home" class="tip-bottom"><i
					class="icon-home"></i> Home</a> <a href="#" class="current">JCB & POKLAND Receive-Payment</a>
			</div>
			<h1>JCB & POKLAND Receive-Payment</h1>
		</div>
		<div class="container-fluid">
			<hr>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="alert alert-info" style="padding-left: 150px;" id="addWork">
							<strong>Enter Party/Customer Name <span class="badge badge-info">OR</span> Contact No : </strong>
							<input list="browsers" name="browser" id="editdata"	onkeyup="CustomerSearch(this.value)" onkeydown="CustomerPrint()" autocomplete="off" required>
							<datalist id="browsers"></datalist>
						</div>
						<div class="alert alert-info" style="display: none;" id="updateWork" >
						<h4><strong>Update Work Detail</strong></h4>

						</div>
						<div class="widget-content nopadding">
							<form action="/SAMERP/JcbPocPaymentReceived.do" method="post" name="payForm" id="payForm" class="form-horizontal" style="padding-left: 240px;">
								<div class="control-group">
									<label class="control-label">Date :</label>
									<div class="controls">
										<input type="date" name="payDate" id="payDate" value="dd/mm/yyyy" class="span4" required="required"/>
										<input type="hidden" name="custId" id="custId">
										<input type="hidden" name="custUpdateId" id="custUpdateId">
										<input type="hidden" name="debtorId" id="debtorId">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Received Amount :</label>
									<div class="controls">
										<input type="text" name="payAmount" id="payAmount" class="span4" placeholder="Amount" onkeypress="return isNumber(event)" required="required"/>
									</div>
								</div>
								<div class="control-group" id="payLine">
									<label class="control-label">Payment Mode :</label>
									<div class="controls">
										<input type="radio" name="radios" id="radios1" value="1" onclick="showBank(this.value)" style="margin-left: 0px;" checked="checked" /> Cash
										<input type="radio" name="radios" id="radios2" value="2" onclick="showBank(this.value)" style="margin-left: 0px;" /> Cheque
										<input type="radio" name="radios" id="radios3" value="3" onclick="showBank(this.value)" style="margin-left: 0px;" /> Transfer
									</div>
								</div>
								<div class="control-group hide" id="selectBank">
									<label class="control-label">Select Bank :</label>
									<div class="controls">
									<%
										RequireData rd = new RequireData();
										List bank = rd.getBank();
										Iterator itr = bank.iterator();
									%>
										<select class="span4" name="payBank" id="payBank">
											<option></option>
												<%
													while (itr.hasNext()) {
												%>
												<option value="<%=itr.next()%>"><%=itr.next()%></option>
												<%
													}
												%>
										</select>
										
									</div>
									<span class="help-inline error" id="payBankError" style="color: red; font-weight: bold;"></span>
								</div>
								<div class="control-group hide" id="bankCheque">
									<label class="control-label">Cheque No :</label>
									<div class="controls">
										<input type="text" name="payCheque" id="payCheque" class="span4" placeholder="Cheque No" />
										<span class="help-inline error" id="payChequeError" style="color: red; font-weight: bold;"></span>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Description :</label>
									<div class="controls">
										<input type="text" name="payDescription" id="payDescription" class="span4" />
									</div>
								</div>
							
								<div class="form-actions">
									<button type="button" id="saveBtn" onclick="paySubmit()" class="btn btn-success" disabled="disabled">Submit</button>
								</div>
							</form>
						</div>
					</div>

				</div>
			</div>
			
			
			
			<div class="row-fluid">
				<div class="span12">

					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"><i class="icon-th"></i></span>
							<h5>Data table</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered data-table">
								<thead>
									<tr>
										<th>Sr no.</th>
										<th>Date</th>
										<th>Description</th>
										<th>Credit</th>
										<th>Debit</th>
										<th>Total Balance</th>
									</tr>	
								</thead>
								<%
									List details = rd.getJcbPocPaymentList();
									int srno = 0;
									String id="";
									String date = "";
									Object description = "";
									Object amount = "";
									Object pay_mode = "";

									if (details != null) {
										Iterator itr2 = details.iterator();
								%>
								<tbody>
									<%
										while (itr2.hasNext()) {
												srno++;
												id = itr2.next().toString();
												date = itr2.next().toString();
												description = itr2.next();
												amount = itr2.next();
												pay_mode = itr2.next();
												if(description == null){
													description="";
												}
												if(amount == null){
													amount="";
												}
												if(pay_mode == null){
													pay_mode="";
												}
									%>
									
									
									<tr class="gradeX">
										<td><%=srno%></td>
										<td><%=id%></td>
										<td><%=date%></td>
										<td><%=description%></td>
										<td><%=amount%></td>
										<td><%=pay_mode%></td>
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
			
			
			
		</div>



	</div>
	<!--Footer-part-->
	<div class="row-fluid">
		<div id="footer" class="span12">
			2013 &copy; Matrix Admin. Brought to you by <a
				href="http://themedesigner.in">Themedesigner.in</a>
		</div>
	</div>
	<!--end-Footer-part-->
<script type="text/javascript">
function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && ( charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}
function paySubmit(){
	var x=validationCheck();
	
	if(x != false){
		document.getElementById("payForm").submit();
	}
}
//**********************Payment Mode******************************************
function showBank(str) {
	if(str==1){
		document.getElementById("selectBank").className="control-group hide";
		document.getElementById("bankCheque").className="control-group hide";
	}
	if(str==2){
		document.getElementById("selectBank").className="control-group";
		document.getElementById("bankCheque").className="control-group";
	}
	if(str==3){
		document.getElementById("selectBank").className="control-group";
		document.getElementById("bankCheque").className="control-group hide";
	}
}
//**********************Customer Search******************************************


function CustomerSearch(str) {

	var xhttp;
	if (str == "") {
		return;
	}
	xhttp = new XMLHttpRequest();

	try {
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				//document.getElementById("imeino").innerHTML = this.responseText;
				var demoStr = this.responseText.split(",");
				var text = "";
				var i = 0
				for (; demoStr[i];) {
					text += "<option id="+demoStr[i];
					i++;
					text += " value="+demoStr[i]+">";
					i++
					text += demoStr[i] + "</option>";
					i++;
				}
				document.getElementById("browsers").innerHTML = text;
			}

		};

		xhttp.open("POST", "/SAMERP/JcbPocDetails.do?q=" + str, true);
		xhttp.send();
	} catch (e) {
		alert("Unable to connect to server");
	}
}
//********************************END Search***********************************
//********************************Print Customer Data**************************
function  CustomerPrint() {
	var val = document.getElementById('editdata').value;
      var str = $('#browsers').find('option[value="' + val + '"]').attr('id');
		if (str == null || str=="undefined") {
			return;
		}
		if(event.keyCode == 13 || event.keyCode == 9) {
			document.getElementById('custId').value=str;
			var id=document.getElementById('custId').value;
			document.getElementById("custUpdateId").disabled = true;
			if (id != null) {
				document.getElementById('saveBtn').disabled = false;
			}else {
				document.getElementById('saveBtn').disabled = true;
			}
	    }
}
//******************************************END Cutomer Print******************************************************************
//******************************************END validationCheck******************************************************************
function validationCheck(){
	var radios2=document.getElementById("radios2").checked;
	var radios3=document.getElementById("radios3").checked;
	
	if(radios2 == true){
		var payBank = document.forms["payForm"]["payBank"].value;
		var payCheque = document.forms["payForm"]["payCheque"].value;;
		if(payBank == ""){
			document.getElementById("payBankError").innerHTML ="Select Bank!";
			return false;
		}else{
			document.getElementById("payBankError").innerHTML ="";
		}
		if(payCheque == ""){
			document.getElementById("payChequeError").innerHTML ="Enter Cheque No!";
			return false;
		}else{
			document.getElementById("payChequeError").innerHTML ="";
		}
		
	}
	if(radios3 == true){
		var payBank = document.getElementById("payBank").value;
		
		if(payBank == ""){
			document.getElementById("payBankError").innerHTML ="Select Bank!";
			return false;
		}
		
	}
}
//******************************************END validationCheck******************************************************************
//******************************************Update******************************************************************
			function getSr(id){
							var x = document.getElementById('updateWork');
							var y = document.getElementById('addWork');
						    if (x.style.display === 'none') {
						        x.style.display = 'block';
						        y.style.display = 'none';
						        document.getElementById('saveBtn').disabled = false;
						        document.getElementById("custUpdateId").disabled = false;
						        document.getElementById('custId').disabled = true;
						        document.getElementById('payLine').style.display = 'none';
						    }
						    window.scrollTo(0, 200);
					    var xhttp;
						xhttp = new XMLHttpRequest();
						try{ 
						xhttp.onreadystatechange = function() {
							if (this.readyState == 4 && this.status == 200) {
								var demoStr = this.responseText.split("~");
				 				document.getElementById("custUpdateId").value = demoStr[0];
				 				document.getElementById("payDescription").value = demoStr[1];
				 				document.getElementById("payAmount").value = demoStr[2];
				 				document.getElementById("payDate").value =demoStr[3];
				 				var chacke=demoStr[4];
				 				if (chacke == "cash") {
				 					document.getElementById("radios1").checked = true;
				 					showBank(1)
								}
								if (chacke == "Cheque") {
									document.getElementById("radios2").checked = true;
									showBank(2)
								}
								if (chacke == "Transfer") {
									document.getElementById("radios3").checked = true;
									showBank(3)
								}
				 				document.getElementById("payBank").value = demoStr[5];
				 				document.getElementById("payCheque").value = demoStr[6];
				 				document.getElementById("debtorId").value = demoStr[7];
							}
				
						};
						
						xhttp.open("POST", "/SAMERP/JcbPocPaymentReceived.do?updateselect=" + id, true);
						xhttp.send();
						}
						catch(e)
						{
							alert("Unable to connect to server");
						}  
				}
// 	======================================================	Update End=======================================================
</script>


	<script src="/SAMERP/config/js/jquery.min.js"></script>
	<script src="/SAMERP/config/js/jquery.ui.custom.js"></script>
	<script src="/SAMERP/config/js/bootstrap.min.js"></script>
	<script src="/SAMERP/config/js/bootstrap-colorpicker.js"></script>
	<script src="/SAMERP/config/js/bootstrap-datepicker.js"></script>
	<script src="/SAMERP/config/js/masked.js"></script>
	<script src="/SAMERP/config/js/jquery.uniform.js"></script>
	<script src="/SAMERP/config/js/select2.min.js"></script>
	<script src="/SAMERP/config/js/jquery.dataTables.min.js"></script>
	<script src="/SAMERP/config/js/matrix.js"></script>
	<script src="/SAMERP/config/js/matrix.tables.js"></script>
	<script src="/SAMERP/config/js/matrix.form_common.js"></script>
	<script src="/SAMERP/config/js/wysihtml5-0.3.0.js"></script>
	<script src="/SAMERP/config/js/jquery.peity.min.js"></script>
	<script src="/SAMERP/config/js/bootstrap-wysihtml5.js"></script>
	<script>
	$('.textarea_editor').wysihtml5();
</script>




</body>
</html>
