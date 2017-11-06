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
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800'
	rel='stylesheet' type='text/css'>

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
										<th>Sr.No</th>
										<th>Client Name</th>
										<th>Remaining Amount</th>
										<th>Action</th>
									</tr>
								</thead>
								<%
									RequireData data = new RequireData();

									List details = data.getCustomerListForPay();
									int srno = 0;
									String custid = "";
									String custname = "";
									

									if (details != null) {
										Iterator itr = details.iterator();
								%>
								<tbody>
									<%
										while (itr.hasNext()) {
												srno++;
												custid = itr.next().toString();
												custname = itr.next().toString();
												
									%>
									<tr class="gradeX">
										<td><%=srno%></td>
										<td><%=custname%></td>
										<td style="text-align: center;">
											<a href="#" data-toggle='modal' onclick='getCustomerTotalPayment(<%=custid%>)'><span class="badge badge-info" id="paymentLabel<%=custid%>">Show</span></a>
										</td>
										<td style="text-align: center;">
											<a href="#CustomerPaymentView" data-toggle='modal' onclick='getCustomerProjectPayment(<%=custid%>)'><span class="badge badge-info" id="paymentLabel<%=custid%>">View</span></a>
										</td>
										
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


	<!--========================================================== Modal======================================= -->
	<div id="CustomerPaymentView" class="modal hide fade" role="dialog"
		style="width: 55%; margin-left: -28%;">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-body">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"><i class="icon-th"></i></span>
							<h5>Jcb And Poc PaymentDetails</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th>Sr No.</th>
										<th>Site Name</th>
										<th>Opening Balance</th>
										<th>Age</th>
										<th>Amount</th>
										<th>Action</th>	
									</tr>
								</thead>
								<tbody id="CustomerPaymentViewTable">
									
								</tbody>
							</table>
							
						</div>
					</div>
				</div>
			</div>

			</div>

		</div>

	
	<!--  modal end -->
	

	<!--end-Footer-part-->
	<script type="text/javascript">
	//==================================================CustomerTotalPayment========================================
		function getCustomerTotalPayment(str){
		var paymentLabel="paymentLabel"+str;
		
		var lable=document.getElementById(paymentLabel).innerHTML;
		//alert(lable);
		if(lable=="Show"){
			document.getElementById(paymentLabel).innerHTML="";
			var xhttp;
			xhttp = new XMLHttpRequest();
			try{ 
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						var demoStr = this.responseText;
						document.getElementById(paymentLabel).innerHTML=demoStr;
						
					}
	
				};
			
				xhttp.open("POST", "/SAMERP/JcbPocPayment.do?custid="+str, true);
				xhttp.send();
			} catch (e) {
				alert("Unable to connect to server");
			}
		}else{
			document.getElementById(paymentLabel).innerHTML="Show";
		}
	}
		
	//=================================================EndCustomerTotalPayment======================================
	//================================================GetCustomerProjectPayment===================================
		function getCustomerProjectPayment(str) {
			var xhttp;
			xhttp = new XMLHttpRequest();
			try{
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						var demoStr = this.responseText.split("~");
						
						document.getElementById("CustomerPaymentViewTable").innerHTML = "";
						
						
					    var i = 0
						for (; demoStr[i];) {
							var projectRow=demoStr[i].split(",");
							
							var Row="";
							var td="";
							var j = 5;
							var k=0;
							for (; projectRow[j];) {
								k++;
								
								if(k > 1){
									var jcbId=projectRow[j];
									j++;
									td +="<tr><td>"+ projectRow[j]; j++; 
									td +="</td><td>"+ projectRow[j]; j++; 
									td +="</td><td><a href=\"#myModal\" data-toggle=\"modal\" onclick=\"searchName("+jcbId+")\">Update</a></td></tr>";
								}
								
							}
							Row ="<tr><td rowspan="+k+">"+(i+1)+"</td><td rowspan="+k+">"+projectRow[0]+"</td><td rowspan="+k+">"+projectRow[1]+"</td><td>"+projectRow[3]+"</td><td>"+projectRow[4]+"</td><td><a href=\"#myModal\" data-toggle=\"modal\" onclick=\"searchName("+projectRow[2]+")\">Update</a></td></tr>";
							
							document.getElementById("CustomerPaymentViewTable").innerHTML += Row += td;
							i++;
						}
					}
	
				};
			
				xhttp.open("POST", "/SAMERP/JcbPocPayment.do?custIdView="+str, true);
				xhttp.send();
			} catch (e) {
				alert("Unable to connect to server");
			}
	
		}
	//===============================================End GetCustomerProjectPayment===================================
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