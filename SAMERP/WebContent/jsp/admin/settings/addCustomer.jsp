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
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">

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
</style>
</head>

<body onload="loadFunction()">

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
				<a href="/SAMERP/dashboard.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> 
				<a href="/SAMERP/jsp/admin/jcb-poc-work/jcb_pokland_dashboard.jsp" class="tip-bottom">JCB & POKLAND Dashboard</a>  
				<a href="#" class="current">Add Customer</a>
				
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
							<h5>Add Customer</h5>
							<a href="#addProject" data-toggle="modal" tabindex="-1" ><span class="label label-important">Add Project</span></a>
						</div>
						<div class="widget-content nopadding">
							<form action="/SAMERP/AddCustomer.do" method="post"
								class="form-horizontal">
								<div class="control-group">
									<label class="control-label"> Customer Name :</label>
									<div class="controls">
										<input type="text" name="custname" id="custname" class="span6"
											placeholder="Customer Name"
											onkeyup="this.value=this.value.toUpperCase()" required />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Address :</label>
									<div class="controls">
										<input type="text" name="address" class="span6"
											placeholder="Address" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Contact No :</label>
									<div class="controls">
										<input type="text" name="contactno" class="span6"
											placeholder="Contact Number"
											onkeypress="return isNumber(event)" onkeyup="if(this.value.length==10){ checkContactNo(this.value); }"  minlength="10" maxlength="10" autocomplete="off" required/>
										<span class="help-inline error" id="contactError" style="color: red; font-weight: bold;"></span>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">GSTIN :</label>
									<div class="controls">
										<input type="text" name="gstin" class="span6"
											placeholder="GSTIN Number" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Bucket Rate :</label>
									<div class="controls">
										<input type="text" name="bucket_rate" class="span6"
											placeholder="Bucket Rate"
											onkeypress="return isNumber(event)" maxlength="10" required/>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Breaker Rate :</label>
									<div class="controls">
										<input type="text" name="breaker_rate" class="span6"
											placeholder="Breaker Rate"
											onkeypress="return isNumber(event)" maxlength="10" required />
									</div>
								</div>


								<div class="form-actions">
									<button type="submit" name="insertorganizer" id="custSubmit"
										class="btn btn-success"
										style="position: relative; right: 682px; float: right;">Submit</button>
									<a href="/SAMERP/dashboard.jsp"><button type="button"
											class="btn btn-danger "
											style="position: relative; right: 550px; float: right;">Exit</button></a>
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
										<th></th>
										<th>Customer Name</th>
										<th>Address</th>
										<th>Contact No</th>
										<th>GSTIN</th>
										<th>Bucket Rate</th>
										<th>Breaker Rate</th>
										<th>Action</th>
									</tr>
								</thead>
								<%
									RequireData data = new RequireData();

									List details = data.getCustomerList();
									int srno = 0;
									String custid = "";
									String custname = "";
									String address = "";
									String contact_no = "";
									String gstin=""; 
									String bucket_rate = "";
									String breaker_rate = "";

									if (details != null) {
										System.out.println("in Print Invoice.jsp" + details);

										Iterator itr = details.iterator();
								%>
								<tbody>
									<%
										while (itr.hasNext()) {
												srno++;
												custid = itr.next().toString();
												custname = itr.next().toString();
												address = itr.next().toString();
												contact_no = itr.next().toString();
												gstin = itr.next().toString();
												bucket_rate= itr.next().toString();
												breaker_rate= itr.next().toString();
									%>
									<tr class="gradeX">
										<td><%=srno%></td>
										<td><%=custname%></td>
										<td><%=address%></td>
										<td><%=contact_no%></td>
										<td><%=gstin%></td>
										<td><%=bucket_rate%></td>
										<td><%=breaker_rate%></td>
										<td><a href="#update" data-toggle='modal'
											onclick='getSr(<%=custid%>)'><i class="icon-pencil"></i></a> / 
											<a href="" onclick="DeleteCustomer(<%=custid%>)"><i class="icon-remove"></i></a></td>
										
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

	<!--end-main-container-part-->

	<!--Footer-part-->

	<div class="row-fluid">
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a
				href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
	</div>


	<!--end-Footer-part-->
	<!-- Model -->
	<div class="modal hide fade" id="update" role="dialog">
		<div class="modal-dialog">
		<form action="/SAMERP/AddCustomer.do" method="post"
						class="form-horizontal" name="customerupdateform">
						
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Update Customer Data</h4>
				</div>
				<div class="modal-body">


					<div class="control-group">
							<label class="control-label"> Customer Name :</label>
							<div class="controls">
								<input type="text" name="custname" id="update_custname"
									placeholder="Customer Name"
									onkeyup="this.value=this.value.toUpperCase()" required />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Address :</label>
							<div class="controls">
								<input type="text" name="address" id="update_address" placeholder="Address" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Contact No :</label>
							<div class="controls">
								<input type="text" name="contactno" id="update_contactno" placeholder="Contact Number"
									onkeypress="return isNumber(event)"  onkeyup="if(this.value.length==10){ checkContactNoUpdate(this.value); }"  minlength="10" maxlength="10" autocomplete="off" />
								<span class="help-inline error" id="contactErrorUpdate" style="color: red; font-weight: bold;"></span>
									<input type="hidden" name="custid" id="custid"/>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">GSTIN :</label>
							<div class="controls">
								<input type="text" name="gstin" id="update_gstin" placeholder="GSTIN Number"/>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Bucket Rate :</label>
							<div class="controls">
								<input type="text" name="bucket_rate" id="update_bucket_rate"
									placeholder="Bucket Rate" onkeypress="return isNumber(event)"
									maxlength="10" required />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Breaker Rate :</label>
							<div class="controls">
								<input type="text" name="breaker_rate" id="update_breaker_rate"
									placeholder="Breaker Rate" onkeypress="return isNumber(event)"
									maxlength="10" required />
							</div>
						</div>
					</div>
				</div>
			<div class="modal-footer">
				<div class="form-actions">
				<button type="submit" name="insertorganizer" id="custSubmitUpdate"	class="btn btn-success"	style="float: right;margin-left: 10px;margin-right:64px; " >Update</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal" style="margin-right: -153px;">Close</button>
				</div>

			</div>
			</form>
		</div>
	</div>
	<!-- Model End -->
	<jsp:include page="../jcb-poc-work/config/addProject.jsp"></jsp:include>
	
	<!--***************************************************** Add Project *******************************************************-->
	
	
		
	<!-- 	Add Form End -->
	
	<script type="text/javascript">

	function loadFunction(){
		document.getElementById("custname").focus();
	}
	
function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && ( charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

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
function checkContactNoUpdate(str) {
	var checkCustid=document.getElementById("custid").value;
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
					document.getElementById("contactErrorUpdate").innerHTML ="";
					document.getElementById("custSubmitUpdate").disabled = false;
				}else {
					document.getElementById("contactErrorUpdate").innerHTML ="This Contact Already Exists!";
					document.getElementById("custSubmitUpdate").disabled = true;
				}
			}

		};

		xhttp.open("POST", "/SAMERP/AddCustomer.do?checkContactNoUpdate=" + str+"&checkCustid="+checkCustid, true);
		xhttp.send();
	} catch (e) {
		alert("Unable to connect to server");
	}
}
//*************************************** End Contact Error *******************************


function getSr(id){
	    var xhttp;
		xhttp = new XMLHttpRequest();
		try{ 
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var demoStr = this.responseText.split(",");
				
 				document.getElementById("custid").value = demoStr[0];
 				document.getElementById("update_custname").value = demoStr[1];
 				document.getElementById("update_address").value = demoStr[2];
 				document.getElementById("update_contactno").value = demoStr[3];
 				document.getElementById("update_gstin").value = demoStr[4];
 				document.getElementById("update_bucket_rate").value = demoStr[5];
 				document.getElementById("update_breaker_rate").value = demoStr[6];
			}

		};
		
		xhttp.open("GET", "/SAMERP/AddCustomer.do?q=" + id, true);
		xhttp.send();
		}
		catch(e)
		{
			alert("Unable to connect to server");
		}  
}

function DeleteCustomer(id){
	var xhttp;
	xhttp = new XMLHttpRequest();
	try{ 
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var demoStr = this.responseText.split(",");
				
		}

	};
	
	xhttp.open("doDelete", "/SAMERP/AddCustomer.do?q=" + id, true);
	xhttp.send();
	}
	catch(e)
	{
		alert("Unable to connect to server");
	}     
}

</script>
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
