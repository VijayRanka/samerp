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
<link href="/SAMERP/config/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
	<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">
	
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



<body onload=" setFocusToTextBox()">

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
				<a href="/SAMERP/index.jsp" title="Go to Home" class="tip-bottom"><i
					class="fa fa-home"></i> Home</a> <a href="#" class="current"></a>
			</div>
			<h1></h1>
		</div>
		<div class="container-fluid">
			
			<div class="row-fluid">
				<div class="span12">

					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"><i class="icon-th"></i></span>
							<h5>Jcb And Poc PaymentDetails</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered data-table">
								<thead>
									<tr>
										<th>jcbpoc_id</th>
										<th>Client Name</th>
										<th>Remaining Amount</th>
										<th>Action</th>
									</tr>
								</thead>
								<%
									int id = 0, count = 1;
									
								%>
								<tbody>
									
									<tr class="gradeX">
										<td id=""><%=count%></td>
										<td>SANDEEP BATULE</td>
										<td>1200000</td>
										<td><a href="#myModal" data-toggle="modal"
											onclick="searchName()">View</a> / <a
											href="/SAMERP/AddClient?delete=">Delete</a></td>
									</tr>
									<%
										count++;
											
										
									%>
								</tbody>
							</table>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>


	<!-- Modal -->
	<div id="myModal" class="modal hide fade" role="dialog"
		style="width: 55%; margin-left: -28%;">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Update Client Details</h4>
				</div>
				

					<form action='/SAMERP/AddClient' name="form2" method="Post"
						class="form-horizontal">
						<div class="modal-body">
							<div class="widget-box">
						<div class="widget-title">
							<span class="icon"><i class="icon-th"></i></span>
							<h5>Jcb And Poc PaymentDetails</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered data-table">
								<thead>
									<tr>
										<th>JcbPoc_id</th>
										<th>Site Name</th>
										<th>Amount</th>
										<th>Age</th>
										<th>Action</th>	
									</tr>
								</thead>
								<%
									int id1 = 0, count1 = 1;
									
								%>
								<tbody>
									
									<tr class="gradeX">
										<td id=""><%=count%></td>
										<td>VerticalSoftware</td>
										<td>1500000</td>
										<td>10</td>
										<td><a href="#myModal" data-toggle="modal"
											onclick="searchName()">Update</a> / <a
											href="/SAMERP/AddClient?delete=">Delete</a></td>
									</tr>
									<%
										count1++;
											
										
									%>
								</tbody>
							</table>
						</div>
					</div>
						</div>
						<div class="modal-footer" style="padding-left: 450px">
							<button type="submit" name="save" class="btn btn-success">Update</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						</div>
						
					</form>
				</div>

			</div>

		</div>

	
	<!--  modal end -->
	

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
</html>