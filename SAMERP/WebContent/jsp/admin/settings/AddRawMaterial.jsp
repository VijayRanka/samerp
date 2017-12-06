<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.mysql.jdbc.ResultSet"%>
<%@page import="dao.General.GenericDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.*"%>
<%@ page import="utility.*"%>
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
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">
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

<body onload=" setFocusToTextBox()">

<!--Header-part-->
<jsp:include page="/jsp/admin/common/header_navbar.jsp"></jsp:include>
<!--close-Header-part-->

		<%
			if (request.getAttribute("status") != null) {
		%>
		<div id="snackbar"><%=request.getAttribute("status")%></div>
		<%
			}
		%>


	<!--close-top-serch-->
	<!--sidebar-menu-->
	<div id="sidebar">
		<a href="#" class="visible-phone"><i class="fa fa-home"></i>
			Dashboard</a>
		<ul>
			<li class="active"><a href="/SAMERP/index.jsp"><i
					class="fa fa-home"></i> <span>Dashboard</span></a></li>
			<li class="submenu"><a href="#"><i class="fa fa-th-list"></i>
					<span>Settings</span> <span class="label label-important">4</span></a>
				<ul>
					<li><a
						href="/SAMERP/jsp/admin/settings/addMaterialSuppliers.jsp">Add
							Material Suppliers</a></li>
					<li><a href="/SAMERP/jsp/admin/settings/addVehicles.jsp">Add
							Vehicles</a></li>
					<li><a href="/SAMERP/jsp/admin/settings/addClient.jsp">Add
							Clients</a></li>
					<li><a href="/SAMERP/jsp/admin/settings/addAccountDetails.jsp">Add
							Account Details</a></li>

				</ul>
			<li><a href="charts.html"><i class="fa fa-signal"></i> <span>Charts
						&amp; graphs</span></a></li>
			<li><a href="widgets.html"><i class="fa fa-inbox"></i> <span>Widgets</span></a>
			</li>
			<li><a href="tables.html"><i class="icon icon-th"></i> <span>Tables</span></a></li>
			<li><a href="grid.html"><i class="icon icon-fullscreen"></i>
					<span>Full width</span></a></li>
			<li class="submenu"><a href="#"><i class="icon icon-th-list"></i>
					<span>Forms</span> <span class="label label-important">3</span></a>
				<ul>
					<li><a href="form-common.html">Basic Form</a></li>
					<li><a href="form-validation.html">Form with Validation</a></li>
					<li><a href="form-wizard.html">Form with Wizard</a></li>
				</ul></li>
			<li><a href="buttons.html"><i class="icon icon-tint"></i> <span>Buttons
						&amp; icons</span></a></li>
			<li><a href="interface.html"><i class="icon icon-pencil"></i>
					<span>Eelements</span></a></li>
			<li class="submenu"><a href="#"><i class="icon icon-file"></i>
					<span>Addons</span> <span class="label label-important">5</span></a>
				<ul>
					<li><a href="index2.html">Dashboard2</a></li>
					<li><a href="gallery.html">Gallery</a></li>
					<li><a href="calendar.html">Calendar</a></li>
					<li><a href="invoice.html">Invoice</a></li>
					<li><a href="chat.html">Chat option</a></li>
				</ul></li>
		</ul>
	</div>
	<!--sidebar-menu-->

	<!--main-container-part-->
	<div id="content">
		<!--breadcrumbs-->

		<div id="content-header">
			<div id="breadcrumb">
				<a href="/SAMERP/dashboard.jsp" title="Go to Home" class="tip-bottom"><i
					class="fa fa-home"></i> Home</a> <a href="#" class="current">Add Raw Material</a>
			</div>
		
		</div>
		<div class="container-fluid">
			<hr>
			<%
				RequireData rq = new RequireData();
			%>
			<div class="row-fluid">
				<div class="span15">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-align-justify"></i>
							</span>
							<h5>Add Raw Material</h5>
						</div>
						<div class="widget-content nopadding">
							<form action="/SAMERP/AddRawMaterial" method="Post"
								class="form-horizontal" onsubmit="return validateForm()">
								<div class="control-group">
									<label class="control-label">Material Name:</label>
									<div class="controls">
										<input type="text" id="material_name" name="material_name" class="span6"
											onkeyup="this.value=this.value.toUpperCase()"
											placeholder="Material Name" pattern="[a-z A-Z 0-9]*"
											required />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Unit:</label>
									<div class="controls">
										<input type="text" name="unit" id="unit" class="span6"
											onkeyup="this.value=this.value.toUpperCase()"
											placeholder="Unit" pattern="[a-z A-Z 0-9]*" required />
									</div>
								</div>
								
								<div class="form-actions" style="padding-left: 350px">
									<button type="submit" name="insert" class="btn btn-success" style="background:#1196c1;">Submit</button>&nbsp;&nbsp;&nbsp;
									 <a href="/SAMERP/dashboard.jsp" id="cancelbtn"  class="btn btn-danger">Exit</a>
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
							<h5>client Details</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered data-table">
								<thead>
									<tr>
										<th>Material_Id</th>
										<th>Material Name</th>
										<th>Unit</th>
										<th>Action</th>
									</tr>
								</thead>
								<%
									int id = 0, count = 1;
								
									List list = rq.getMaterialDetails();
									if (list != null) {
										Iterator itr = list.iterator();
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
										<td><a href="#myModal" data-toggle="modal"
											onclick="searchName(<%=id1%>)" class="tip-top" data-original-title="Update"><i class="icon-pencil"></i></a> / 
											<a href="/SAMERP/AddRawMaterial?deleteId=<%=id1%>" class="tip-top" data-original-title="Delete"><i class="icon-remove"></i></a></td>
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

<div id="myModal" class="modal hide fade" role="dialog"
		style="width: 55%; margin-left: -28%;">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Update Material Details</h4>
				</div>
				

					<form action='/SAMERP/AddRawMaterial' name="form2" method="Post"
						class="form-horizontal">
						<div class="modal-body">
						<div class="control-group">
							<label class="control-label">Material Name:</label>
							<div class="controls">
								<input type="hidden" id="Updateid" name="Updateid" /> <input
									type="text" name="mname" id="MaterialName" class="span4"
									placeholder="Material Name"
									onkeyup="this.value=this.value.toUpperCase()" required />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Unit:</label>
							<div class="controls">
								<div class="input-append">
									<input type="text" name="unit" id="Unit" class="span4"
										placeholder="Unit"
										onkeyup="this.value=this.value.toUpperCase()" required />
								</div>
							</div>
						</div>
						
						</div>
						<div class="modal-footer" style="padding-left: 450px">
							<button type="submit" name="save" class="btn btn-success" style="background:#1196c1;">Update</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						</div>
						
					</form>
				</div>

			</div>

		</div>
		
		<div class="row-fluid">
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a
				href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
	</div>
		
	
<script type="text/javascript">
	function searchName(id1) {
		
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				
				var demoStr = this.responseText.split(",");
				"WebContent/jsp/admin/settings/AddRawMaterial.jsp"
				document.getElementById("Updateid").value = demoStr[0];
				document.getElementById("MaterialName").value = demoStr[1];
				document.getElementById("Unit").value = demoStr[2];
							
				}
			};
		xhttp.open("POST","/SAMERP/AddRawMaterial?Updateid="+id1, true);
		xhttp.send();		
}

function myFunction() {
    var x = document.getElementById("snackbar")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}

function showModal()
{
	var someVarName = localStorage.getItem("someVarName");

		if(someVarName>0)
		{
			$('#myModal').modal('show');
		}
	localStorage.setItem('someVarName', null);
}

function setFocusToTextBox()
{
	document.getElementById("MaterialName").focus();
	showModal();   	
	 myFunction();
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