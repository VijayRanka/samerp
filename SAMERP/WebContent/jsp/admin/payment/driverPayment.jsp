
<%@page import="utility.RequireData"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>SAMERP PROJECT</title>
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />
<link rel="stylesheet" href="/SAMERP/config/css/select2.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="/SAMERP/config/css/fullcalendar.css" />
<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>

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

<body onload="setFocusToTextBox()">

<!--Header-part-->
<div id="header">
  <h1><a href="dashboard.html">Matrix Admin</a></h1>
</div>


<!--sidebar-menu-->
<jsp:include page="../common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->

<!--main-container-part-->
<div id="content">
<!--breadcrumbs-->
  <div id="content-header">
    <div id="breadcrumb"> <a href="/SAMERP/index.jsp" title="Go to Home" class="tip-bottom"><i class="fa fa-home"></i> Home</a> <a href="#" class="current">Driver Payment</a> </div>
  	
  </div>
<!--End-breadcrumbs-->


<!--Action boxes-->
  <div class="container-fluid">

			<div class="widget-box">
				<div class="widget-title">
					<span class="icon"><i class="icon-th"></i></span>
					<h5>Driver Details</h5>
				</div>
				<div class="widget-content nopadding">
					<table class="table table-bordered data-table">
						<thead>
							<tr>
								<th>Sr.No</th>
								<th>Debtor Id</th>
								<th>Date</th>
								<th>Credit</th>
								<th>Debit</th>
								<th>Extra Charges</th>
								<th>Particular</th>
								<th>Type</th>								
								<th>Balance</th>

							</tr>
						</thead>
						<%
						int id=0,count=1;
						RequireData rd=new RequireData();
						List list=rd.getDriverPayment();
						Iterator itr=list.iterator();
						while(itr.hasNext())
						{
							
							String id1=itr.next().toString();
						
						%>
						<tbody>
							<td id="<%=id1%>"><%=count %></td>
							<td><%=itr.next() %></td>
							<td><%=itr.next() %></td>
							<td><%=itr.next() %></td>
							<td><%=itr.next() %></td>
							<td><%=itr.next() %></td>
							<td><%=itr.next() %></td>
							<%
							String Driver="";
							String Helper="";
							String type=itr.next().toString();
							if(type.equals("1"))
							{
							%>
							<td>Driver</td>
							<%}else{ %>
							<td>Helper</td>
							<%} %>
							<td><%=itr.next() %></td>

						</tbody>
						<%
						}
						%>
					</table>
				</div>
			</div>
		</div>
    </div>
      
  

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