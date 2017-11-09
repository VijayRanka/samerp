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
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/colorpicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />
<link rel="stylesheet" href="/SAMERP/config/css/select2.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-wysihtml5.css" />
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>

<style type="text/css">
#s2id_autogen3, #s2id_vehicle_update,#s2id_vehicle,#s2id_cust_project,#s2id_cust_project_update {
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
					class="icon-home"></i> Home</a> <a href="#" class="current">JCB/POC
					Detail</a>
			</div>
			<h1>JCB/POC Detail</h1>
		</div>
		<div class="container-fluid">
			<hr>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box" id="addWork" style="display: block;">
						<div class="alert alert-info" style="padding-left: 180px;">
							<strong>Enter Party/Customer Name <span class="badge badge-info">OR</span> Contact No : </strong>
							<input list="browsers" name="browser" id="editdata"	onkeyup="CustomerSearch(this.value)" onkeydown="CustomerPrint()" autocomplete="off" required>
							<datalist id="browsers"></datalist>
							<a href="#addCustomer" data-toggle="modal" class="btn btn-primary btn-mini" tabindex="-1" style="width: 35px; border: 2px black solid; font-size: 20px;">+</a>
							

						</div>
						<div class="widget-content nopadding">
							<form action="/SAMERP/JcbPocDetails.do" method="POST">
								<table class=""
									style="border-color: white; margin: 0 auto; width: 700px">
									<tr>
										<td colspan="2"><h4>Customer Detail</h4></td>
									</tr>
									<tr>
										<td style="text-align: right;">Customer Name : <input
											type="text" name="custname" id="custname" readonly="readonly" tabindex="-1"></td>
										<td style="text-align: right;">Address : <input
											type="text" name="address" id="address" readonly="readonly" tabindex="-1"></td>
									</tr>
									<tr>
										<td style="text-align: right;">Contact NO : <input
											type="text" name="contactno" id="contactno"
											readonly="readonly" tabindex="-1"></td>
										<td style="text-align: right;">
											Bucket Rate :
											<input type="text" name="bucket_rate" id="bucket_rate" class="span7" readonly="readonly" tabindex="-1">
											<input type="hidden" name="custid" id="custid">
											<button id="bucketRateShowButton" onclick="showUpdateRateButton(1)" tabindex="-1">^</button>
											<button id="bucketRateUpdateButton"  onclick="bucketRateCustomer()" tabindex="-1" style="display: none;">#</button>
										</td>
									</tr>
									<tr>
									<td style="text-align: right;">Customer Project : 
									
										<select	name="cust_project" id="cust_project" class="span6" style="float: right;">
												<option></option>
										</select>
										<a href="#addProject" data-toggle="modal" class="btn btn-primary btn-mini" tabindex="-1" style="width: 35px; border: 2px black solid; font-size: 20px;">+</a>
									</td>
										<td style="text-align: right;">
											Breaker Rate :
											<input type="text" name="breaker_rate" id="breaker_rate" class="span7" readonly="readonly" tabindex="-1">
											<button id="breakerRateShowButton" onclick="showUpdateRateButton(2)" tabindex="-1">^</button>
											<button id="breakerRateUpdateButton"  onclick="breakerRateCustomer()" tabindex="-1" style="display: none;">#</button>
										</td>
									</tr>
									<tr>
										<td style="height: 2px;"></td>
										<td></td>
									</tr>
									<tr>
										<td colspan="2"><h4>Work Detail</h4></td>
									</tr>
									<tr>
										<td style="text-align: right;">Chalan NO : <input
											type="text" name="chalanno" required="required"></td>
										<%
											SysDate sd = new SysDate();
										%>
										<td style="text-align: right;">Date :<input type="text"
											name="chalandate" data-date-format="dd-mm-yyyy"
											value="<%=sd.todayDate()%>" class="datepicker">

										</td>
									</tr>
									<%
										RequireData rd = new RequireData();
										List Vehicle = rd.getVehicleList();
										Iterator itr = Vehicle.iterator();
									%>
									<tr>
										<td style="padding-left: 60px;">Machine Name :
											<select	name="vehicle" id="vehicle" class="span8" style="float: right;">
												<option></option>
												<%
													while (itr.hasNext()) {
												%>
												<option value="<%=itr.next()%>"><%=itr.next()%></option>
												<%
													}
												%>
											</select>

										</td>
										<td style="text-align: right; padding-right: 100px;">
											Bucket Hrs : <input type="hidden" id="bucket_hrs" name="bucket_hrs" value="00:00" placeholder="HH:MM">
											<input type="text" id="bHrs" maxlength="2" value="00" onkeyup="if(this.value.length>=2){  $(this).next(':input').focus(); } setHours();" style="width: 40px;">
											 : 
											<input type="text" id="bMus" maxlength="2" value="00" onkeyup="if(this.value.length>=2){  $(this).next(':input').focus(); } setHours();" style="width: 40px;">
										</td>
									</tr>
									<tr>
										<td style="text-align: right;">
											Diesel Amount :<input type="text" name="diesel" placeholder="Diesel">
										</td>
										<td style="text-align: right; padding-right: 100px;">
											Breaker Hrs : <input type="hidden" id="breaker_hrs" name="breaker_hrs" value="00:00" placeholder="HH:MM">
											<input type="text" id="bkHrs"  maxlength="2" value="00" onkeyup="if(this.value.length>=2){  $(this).next(':input').focus(); } setHours();" style="width: 40px;">
											 : 
											<input type="text" id="bkMus"  maxlength="2" value="00" onkeyup="if(this.value.length>=2){  $(this).next(':input').focus(); }  setHours();" style="width: 40px;">
										</td>
									</tr>
									<tr>
										<td style="text-align: right; padding-right: 14%;">
											Deposit :
											<input type="radio" name="radios" value="1" checked="checked" onclick="showBank(this.value)" style="margin-left: 0px;" /> Cash
											<input type="radio" name="radios" value="2" onclick="showBank(this.value)" style="margin-left: 0px;" /> Cheque
										</td>
										<td style="text-align: right;">
<!-- 											HSN : <input type="text" name="hsnno" placeholder="HSN"> -->
										</td>
									</tr>
									<tr>
										<td style="text-align: right;">
											<input type="text" name="deposit" id="deposit" onkeypress="return isNumber(event)" placeholder="Deposit">
											<var class="control-group hide" id="selectBank">
												Select Bank :
													<select class="span8">
														<option>First option</option>
														<option>Second option</option>
														<option>Third option</option>
														<option>Fourth option</option>
														<option>Fifth option</option>
														<option>Sixth option</option>
														<option>Seventh option</option>
														<option>Eighth option</option>
													</select>
											</var>
										</td>
										<td style="text-align: right;">
											<var class="control-group hide" id="selectBankCheque">
												Cheque No :<input type="text" class="span8" placeholder="Cheque No" />
											</var>
										</td>
									</tr>
									<tr>
										<td colspan="2" style="text-align: center;"><button
												type="submit" name="insertorganizer" class="btn btn-success"">Submit</button>
											<a href="/SAMERP/index.jsp"><button type="button"
													class="btn btn-danger ">Exit</button></a></td>
									</tr>
								</table>
							</form>
						</div>
					</div>
<!-- 	=========================================update======================================== -->
					<div class="widget-box" id="updateWork" style="display: none;">
						<div class="alert alert-info" >
						<h4><strong>Update Work Detail</strong></h4>

						</div>
						<div class="widget-content nopadding">
							<form action="/SAMERP/JcbPocDetails.do?update=update" method="POST">
								<table class=""
									style="border-color: white; margin: 0 auto; width: 700px">
									<tr>
										<td colspan="2"><h4>Customer Detail</h4></td>
									</tr>
									<tr>
										<td style="text-align: right;">Customer Name : <input
											type="text" name="custname" id="custname_update" readonly="readonly" tabindex="-1"></td>
										<td style="text-align: right;">Address : <input
											type="text" name="address" id="address_update" readonly="readonly" tabindex="-1"></td>
									</tr>
									<tr>
										<td style="text-align: right;">Contact NO : <input
											type="text" name="contactno" id="contactno_update"
											readonly="readonly" tabindex="-1"></td>
										<td style="text-align: right;">Bucket Rate :<input
											type="text" name="bucket_rate" id="bucket_rate_update">
											<input type="hidden" name="jcbpocid" id="jcbpocid_update">
										</td>
									</tr>
									<tr>
										<td style="text-align: right;">Customer Project :
											<select	name="cust_project" id="cust_project_update" class="span8" style="float: right;">
												<option></option>
											</select>
										</td>
										<td style="text-align: right;">Breaker Rate :<input
											type="text" name="breaker_rate" id="breaker_rate_update">
										</td>
									</tr>
									<tr>
										<td style="height: 2px;"></td>
										<td></td>
									</tr>
									<tr>
										<td colspan="2"><h4>Work Detail</h4></td>
									</tr>
									<tr>
										<td style="text-align: right;">Chalan NO : <input
											type="text" name="chalanno" id="chalanno_update" required="required"></td>
										
										<td style="text-align: right;">Date :<input type="text"
											name="chalandate" id="chalandate_update" data-date-format="dd-mm-yyyy"
											value="" class="datepicker">

										</td>
									</tr>
									<%
										//RequireData urd = new RequireData();
										List uVehicle = rd.getVehicleList();
										Iterator uitr = Vehicle.iterator();
									%>
									<tr>
										<td style="padding-left: 60px;">Machine Name :<select
											name="vehicle" id="vehicle_update" class="span8" style="float: right;">
												<option></option>
												<%
													while (uitr.hasNext()) {
												%>
												<option value="<%=uitr.next()%>"><%=uitr.next()%></option>
												<%
													}
												%>
										</select>

										</td>
										<td style="text-align: right; padding-right: 100px;">
											Bucket Hrs : <input type="hidden" name="bucket_hrs" id="bucket_hrs_update" placeholder="HH:MM">
											<input type="text" id="bHrsUpdate" maxlength="2" value="00" onkeyup="if(this.value.length>=2){  $(this).next(':input').focus(); } setHoursUpdate();" style="width: 40px;">
											 : 
											<input type="text" id="bMusUpdate" maxlength="2" value="00" onkeyup="if(this.value.length>=2){  $(this).next(':input').focus(); } setHours();" style="width: 40px;">
										</td>
									</tr>
									<tr>
										<td style="text-align: right; ">
											Deposit :<input type="text" name="deposit" id="deposit_update" placeholder="Deposit">
										</td>
										<td style="text-align: right; padding-right: 100px;">
											Breaker Hrs : <input type="hidden" name="breaker_hrs" id="breaker_hrs_update" placeholder="HH:MM">
											<input type="text" id="bkHrsUpdate"  maxlength="2" value="00" onkeyup="if(this.value.length>=2){  $(this).next(':input').focus(); } setHoursUpdate();" style="width: 40px;">
											 : 
											<input type="text" id="bkMusUpdate"  maxlength="2" value="00" onkeyup="if(this.value.length>=2){  $(this).next(':input').focus(); }  setHoursUpdate();" style="width: 40px;">
										</td>
									</tr>
									<tr>
										<td style="text-align: right;">
											Diesel Amount :<input type="text" name="diesel" id="diesel_update" placeholder="Diesel">
										</td>
										<td style="text-align: right;">
											HSN : <input type="text" name="hsnno" placeholder="HSN">
										</td>
									</tr>
									<tr>
										<td colspan="2" style="text-align: center;"><button
												type="submit" name="insertorganizer" class="btn btn-success"">Submit</button>
											<a href="/SAMERP/index.jsp"><button type="button"
													class="btn btn-danger ">Exit</button></a></td>
									</tr>
								</table>
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
							<a href="#createBill" data-toggle="modal" tabindex="-1" ><span class="label label-important">Create Bill</span></a>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered data-table">
								<thead>
									<tr>
										<th></th>
										<th>Customer Name</th>
										<th>Chalan no</th>
										<th>Machine Name</th>
										<th>Date</th>
										<th>Bucket Hrs</th>
										<th>Breaker Hrs</th>
										<th>Deposit</th>
										<th>Diesel Amount</th>
										<th>Action</th>
									</tr>
								</thead>
								<%
									List details = rd.getJcbPocWorkDetail();
									int srno = 0;
									String custname = "";
									String chalanno = "";
									String vehiclename = "";
									String date = "";
									String bucket_hr = "";
									String breaker_hr = "";
									String bucket_rate = "";
									String breaker_rate = "";
									String jcbpocid = "";

									if (details != null) {
										Iterator itr2 = details.iterator();
								%>
								<tbody>
									<%
										while (itr2.hasNext()) {
												srno++;
												custname = itr2.next().toString();
												chalanno = itr2.next().toString();
												vehiclename = itr2.next().toString();
												date = itr2.next().toString();
												bucket_hr = itr2.next().toString();
												breaker_hr = itr2.next().toString();
												bucket_rate=itr2.next().toString();
												breaker_rate=itr2.next().toString();
												jcbpocid = itr2.next().toString();
									%>
									<tr class="gradeX">
										<td><%=srno%></td>
										<td><%=custname%></td>
										<td><%=chalanno%></td>
										<td><%=vehiclename%></td>
										<td><%=date%></td>
										<td><%=bucket_hr%></td>
										<td><%=breaker_hr%></td>
										<td><%=bucket_rate%></td>
										<td><%=breaker_rate%></td>
										<td><a href="#update" data-toggle='modal'
											onclick='getSr(<%=jcbpocid%>)'>Update</a> / <a
											href="/SAMERP/JcbPocDetails.do?deleteid=<%=jcbpocid%>">Delete</a></td>
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
	<!--===================================== Model================================================== -->
	<jsp:include page="config/addProject.jsp"></jsp:include>
	<div class="modal hide fade" id="addCustomer" role="dialog">
		<div class="modal-dialog">
		<form action="/SAMERP/AddCustomer.do?path=jcbpoc" method="post" class="form-horizontal" name="customerupdateform">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Add Customer</h4>
				</div>
				<div class="modal-body">
					<div class="control-group">
							<label class="control-label"> Customer Name :</label>
							<div class="controls">
								<input type="text" name="custname" id="custname"
									placeholder="Customer Name"
									onkeyup="this.value=this.value.toUpperCase()" required />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Address :</label>
							<div class="controls">
								<input type="text" name="address" id="address" placeholder="Address" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Contact No :</label>
							<div class="controls">
								<input type="text" name="contactno" id="contactno"
									placeholder="Contact Number"
									onkeypress="return isNumber(event)" onkeyup="if(this.value.length==10){ checkContactNo(this.value); }"  minlength="10" maxlength="10" autocomplete="off" required/>
								<span class="help-inline error" id="contactError" style="color: red; font-weight: bold;"></span>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">GSTIN :</label>
							<div class="controls">
								<input type="text" name="gstin" id="gstin" placeholder="GSTIN Number"/>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Bucket Rate :</label>
							<div class="controls">
								<input type="text" name="bucket_rate" id="bucket_rate"
									placeholder="Bucket Rate" onkeypress="return isNumber(event)"
									maxlength="10" required />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Breaker Rate :</label>
							<div class="controls">
								<input type="text" name="breaker_rate" id="breaker_rate"
									placeholder="Breaker Rate" onkeypress="return isNumber(event)"
									maxlength="10" required />
							</div>
						</div>
					</div>
			</div>
			<div class="modal-footer">
				<div class="form-actions">
							<button type="submit" name="insertorganizer" id="custSubmit"
								class="btn btn-success"
								style="float: right;">Submit</button>
							</div>

			</div>
			</form>
		</div>
	</div>
	<!-- ========================================Model End=========================================== -->
	
	
	
	
	
	
	
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
					text += " value="+demoStr[i]+">"
									+ demoStr[i] + "</option>";
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
		      //alert(str);
		      var xhttp;
				if (str == "") {
					return;
				}
				if(event.keyCode == 13) {
					xhttp = new XMLHttpRequest();
					try{ 
					xhttp.onreadystatechange = function() {
						if (this.readyState == 4 && this.status == 200) {
							var demoStr = this.responseText.split("~");
							
			 				document.getElementById("custid").value = demoStr[0];
			 				document.getElementById("custid_project").value = demoStr[0];
			 				document.getElementById("custname").value = demoStr[1];
			 				document.getElementById("address").value = demoStr[2];
			 				document.getElementById("contactno").value = demoStr[3];
			 				document.getElementById("bucket_rate").value =demoStr[4];
			 				document.getElementById("breaker_rate").value =demoStr[5];
			 				SelectCustomerProject(demoStr[0]);
						}

					};
					
					xhttp.open("POST", "/SAMERP/JcbPocDetails.do?CustomerPrint=" + str, true);
					xhttp.send();
					}
					catch(e)
					{
						alert("Unable to connect to server");
					}     
			    }
		}
		//******************************************END Cutomer Print******************************************************************
		//***************************************** SET Hours***************************************************************************** 
		function setHours() {
			var bkHrs=document.getElementById("bkHrs").value;
			var bkMus=document.getElementById("bkMus").value;
			
			var breaker_Hrs=bkHrs +":"+ bkMus;
			
			document.getElementById("breaker_hrs").value=breaker_Hrs;
			
			
			
			var bHrs=document.getElementById("bHrs").value;
			var bMus=document.getElementById("bMus").value;
			
			var bucket_Hrs=bHrs +":"+ bMus;
			
			document.getElementById("bucket_hrs").value=bucket_Hrs;
			
			
		}
		function setHoursUpdate() {
			var bkHrs=document.getElementById("bkHrsUpdate").value;
			var bkMus=document.getElementById("bkMusUpdate").value;
			
			var breaker_Hrs=bkHrs +":"+ bkMus;
			
			document.getElementById("breaker_hrs_update").value=breaker_Hrs;
			
			
			
			var bHrs=document.getElementById("bHrsUpdate").value;
			var bMus=document.getElementById("bMusUpdate").value;
			
			var bucket_Hrs=bHrs +":"+ bMus;
			
			document.getElementById("bucket_hrs_update").value=bucket_Hrs;
			
			
		}
		//***************************************** END SET Hours*****************************************************************************
		//******************************************Cutomer Project******************************************************************
		function SelectCustomerProject(str) {
			document.getElementById("cust_project").innerHTML = "";
			var xhttp;
			if (str == "") {
				document.getElementById("cust_project").innerHTML = "";
				return;
			}
			xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var textf=document.getElementById("cust_project").innerHTML = "<option value=''></option>";
					
					var demoStr = this.responseText.split(",");
					var text = "";
					for (var i = 0; i < demoStr.length-1; i++) {
						text += "<option value="+demoStr[i]+">";
								i++;
						text += demoStr[i]+ "</option>";
					}
					
					document.getElementById("cust_project").innerHTML =textf + text;

					myFunction();
				}

			};

			xhttp.open("POST", "/SAMERP/JcbPocDetails.do?CustomerProjectId=" + str, true);
			xhttp.send();

		}
		function SelectCustomerProjectUpdate(str) {
			document.getElementById("cust_project_update").innerHTML = "";
			var xhttp;
			if (str == "") {
				document.getElementById("cust_project_update").innerHTML = "";
				return;
			}
			xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var textf=document.getElementById("cust_project_update").innerHTML = "<option value=''></option>";
					
					var demoStr = this.responseText.split(",");
					var text = "";
					for (var i = 0; i < demoStr.length-1; i++) {
						text += "<option value="+demoStr[i]+">";
								i++;
						text += demoStr[i]+ "</option>";
					}
					
					document.getElementById("cust_project_update").innerHTML =textf + text;

					myFunction();
				}

			};

			xhttp.open("POST", "/SAMERP/JcbPocDetails.do?CustomerProjectIdUpdate=" + str, true);
			xhttp.send();

		}
		
		
		//******************************************Cutomer Project End******************************************************************
		//******************************************Rate Update ***********************************************************************
		function showUpdateRateButton(str) {
			if (str == 1) {
				var rate=document.getElementById('bucket_rate').value;
				if (rate=="") {
					alert("Select Customer!");
				}else {
					document.getElementById("bucketRateShowButton").style.display = "none";
					document.getElementById("bucketRateUpdateButton").style.display = "inline";
					document.getElementById("bucket_rate").readOnly=false;
				}
			}else {
				var rate=document.getElementById('breaker_rate').value;
				if (rate=="") {
					alert("Select Customer!");
				}else {
					document.getElementById("breakerRateShowButton").style.display = "none";
					document.getElementById("breakerRateUpdateButton").style.display = "inline";
					document.getElementById("breaker_rate").readOnly=false;
				}
			}
		}
		function bucketRateCustomer() {
			var rate=document.getElementById('bucket_rate').value;
			var id=document.getElementById('custid').value;
		    var xhttp;
			xhttp = new XMLHttpRequest();
			try{ 
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						var demoStr = this.responseText;
						document.getElementById("bucketRateShowButton").style.display = "inline";
						document.getElementById("bucketRateUpdateButton").style.display = "none";
						document.getElementById("bucket_rate").readOnly=true;
						alert(demoStr);
					}
	
				};
			
				xhttp.open("POST", "/SAMERP/JcbPocDetails.do?custid="+id+"&bucketRateCustomer=" + rate, true);
				xhttp.send();
			}
			catch(e)
			{
				alert("Unable to connect to server");
			}
		}
		function breakerRateCustomer() {
			var rate=document.getElementById('breaker_rate').value;
			var id=document.getElementById('custid').value;
			var xhttp;
			xhttp = new XMLHttpRequest();
			try{ 
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						var demoStr = this.responseText;
						document.getElementById("breakerRateShowButton").style.display = "inline";
						document.getElementById("breakerRateUpdateButton").style.display = "none";
						document.getElementById("breaker_rate").readOnly=true;
						alert(demoStr);
					}
	
				};
			
				xhttp.open("POST", "/SAMERP/JcbPocDetails.do?custid="+id+"&breakerRateCustomer=" + rate, true);
				xhttp.send();
			}
			catch(e)
			{
				alert("Unable to connect to server");
			}
		}
		
		
		
		
		
		
		
		
		
		
		
		//******************************************* END Rate Update******************************************************************
		//******************************************Update******************************************************************
			function getSr(id){
							var x = document.getElementById('updateWork');
							var y = document.getElementById('addWork');
						    if (x.style.display === 'none') {
						        x.style.display = 'block';
						        y.style.display = 'none';
						    }
						    window.scrollTo(0, 200);
						    SelectCustomerProjectUpdate(id);
					    var xhttp;
						xhttp = new XMLHttpRequest();
						try{ 
						xhttp.onreadystatechange = function() {
							if (this.readyState == 4 && this.status == 200) {
								var demoStr = this.responseText.split("~");
				 				document.getElementById("custname_update").value = demoStr[0];
				 				document.getElementById("address_update").value = demoStr[1];
				 				document.getElementById("contactno_update").value = demoStr[2];
				 				document.getElementById("bucket_rate_update").value = demoStr[3];
				 				document.getElementById("breaker_rate_update").value = demoStr[4];
				 				document.getElementById("chalanno_update").value = demoStr[5];
				 				document.getElementById("vehicle_update").value = demoStr[6];
				 				var date=demoStr[7].split("-");
				 				document.getElementById("chalandate_update").value =date[2]+"-"+date[1]+"-"+date[0];
				 				
				 				document.getElementById("bucket_hrs_update").value = demoStr[8];
				 				var newBHr=demoStr[8].split(":");
				 				document.getElementById("bHrsUpdate").value = newBHr[0];
				 				document.getElementById("bMusUpdate").value = newBHr[1];
				 				
				 				document.getElementById("breaker_hrs_update").value = demoStr[9];
				 				var newBrHr=demoStr[9].split(":");
				 				document.getElementById("bkHrsUpdate").value = newBrHr[0];
				 				document.getElementById("bkMusUpdate").value = newBrHr[1];
				 				
				 				document.getElementById("deposit_update").value = demoStr[10];
				 				document.getElementById("diesel_update").value = demoStr[11];
				 				document.getElementById("jcbpocid_update").value = demoStr[12];
				 				
							}
				
						};
						
						xhttp.open("POST", "/SAMERP/JcbPocDetails.do?updateselect=" + id, true);
						xhttp.send();
						}
						catch(e)
						{
							alert("Unable to connect to server");
						}  
				}
// 	======================================================	Update End=======================================================
	
//==================================================== Add Project ======================================================
	function insertDiv()
{
	var insertTable=document.getElementById("display-textfeild");
	var Row=insertTable.rows;
	var numrows=Row.length;
	var row = insertTable.insertRow(numrows);
    var cell1 = row.insertCell(0);
    cell1.innerHTML = "Project Name "+ (numrows+1) +":<input type=\"text\" name=\"projectname"+ (numrows+1) +"\" id=\"project_name"+ (numrows+1) +"\" onkeyup=\"this.value=this.value.toUpperCase()\" required>";
    document.getElementById('count_project').value=(numrows+1);
}

function deleteDiv()
{
	var deleteRows=document.getElementById("display-textfeild");
	var count=document.getElementById('count_project').value;
	var Rows = deleteRows.rows;
    var numRows = Rows.length;
    if(numRows>1){
    	deleteRows.deleteRow(numRows-1);
    	document.getElementById('count_project').value=(count-1);
    }
}
//================================================= End Project ==========================================================
//***************************************Contact Error *******************************
function checkContactNo(str) {
	var xhttp;
	if (str == "") {
		return;
	}
	xhttp = new XMLHttpRequest();

	try {
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var demoStr = this.responseText.split("~");
				if (demoStr[0] =="") {
					document.getElementById("contactError").innerHTML ="";
					document.getElementById("custSubmit").disabled = false;
				}else {
					document.getElementById("contactError").innerHTML ="This Contact Already Exists!";
					document.getElementById("custSubmit").disabled = true;
				}
			}

		};

		xhttp.open("POST", "/SAMERP/AddCustomer.do?checkContactNo=" + str, true);
		xhttp.send();
	} catch (e) {
		alert("Unable to connect to server");
	}
}
//*************************************** End Contact Error *******************************
//*************************************** DEPOSIT *******************************
function showBank(str) {
	if(str==1){
		document.getElementById("deposit").style.display = 'inline-block';;
		document.getElementById("selectBank").className="control-group hide";
		document.getElementById("selectBankCheque").className="control-group hide";
	}
	if(str==2){
		document.getElementById("deposit").style.display = "none";
		document.getElementById("selectBank").className="control-group";
		document.getElementById("selectBankCheque").className="control-group";
	}
	
}
//*************************************** END DEPOSIT *******************************
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
