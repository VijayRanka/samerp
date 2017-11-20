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

</head>
<body onload="setYearMonth()">

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
				<a href="/SAMERP/dashboard.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> 
				<a href="/SAMERP/jsp/admin/jcb-poc-work/jcb_pokland_dashboard.jsp" class="tip-bottom">JCB & POKLAND Dashboard</a>  
				<a href="#" class="current">JCB & POKLAND Payment View </a>
			</div>
			<h1></h1>
		</div>
		<div class="container-fluid">
			
			<div class="row-fluid">
				<div class="span12">

					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"><i class="icon-th"></i></span>
							<h5>JCB & POKLAND Payment View</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered data-table">
								<thead>
									<tr>
										<th>Sr.No</th>
										<th>Client Name</th>
										<th>Remaining Amount</th>
										<th>Action<input type="hidden" id="custIdSelect"></th>
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
											<a href="#CustomerPaymentView" data-toggle='modal' onclick='custIdSelectFunction(<%=custid%>)'><span class="badge badge-info" id="paymentLabel<%=custid%>">View</span></a>
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
								<div class="controls" style="padding-left: 5%;">
									<span style="float: left;"><b>Year : </b></span>
									<select onchange="getCustomerProjectPayment()" class="span3" id="yearSelect" style="width: 25%; float: left;">
										
									</select>
								</div>
								<div class="controls">
									<span style="float: left; padding-left: 5%;"><b>Month : </b></span>
									<select onchange="getCustomerProjectPayment()" class="span3" id="monthSelect" style="width: 25%; float: left;">
										<option value="0">January</option>
										<option value="1">February</option>
										<option value="2">March</option>
										<option value="3">April</option>
										<option value="4">May</option>
										<option value="5">June</option>
										<option value="6">July</option>
										<option value="7">August</option>
										<option value="8">September</option>
										<option value="9">October</option>
										<option value="10">November</option>
										<option value="11">December</option>
									</select>
								</div>
								<button class="btn btn-inverse" onclick="printData()" style="margin-left: 3%;">Print</button>
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
	<div class="row-fluid">
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a
				href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
	</div>
	

	<!--end-Footer-part-->
	<script type="text/javascript">
//==================================================Year & Month Set========================================
	function setYearMonth(){
		var year = 2016;
		var till = 2017;
		var options = "";
		for(var y=year; y<=till; y++){
		  options += "<option>"+ y +"</option>";
		}
		document.getElementById("yearSelect").innerHTML = options;
		
		var thisYear = new Date().getFullYear();
		
		document.getElementById("yearSelect").value =thisYear;
		$("#s2id_yearSelect").find("span").html(thisYear);
		
		var thisMonth = new Date().getMonth();
		
		document.getElementById("monthSelect").value =thisMonth;
		var selectId=document.getElementById("s2id_monthSelect");
		
		var month = new Array();
		    month[0] = "January";
		    month[1] = "February";
		    month[2] = "March";
		    month[3] = "April";
		    month[4] = "May";
		    month[5] = "June";
		    month[6] = "July";
		    month[7] = "August";
		    month[8] = "September";
		    month[9] = "October";
		    month[10] = "November";
		    month[11] = "December";
		$("#s2id_monthSelect").find("span").html(month[thisMonth]);
}
	
//==================================================Year & Month Set========================================
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
		function custIdSelectFunction(str){
			document.getElementById("custIdSelect").value=str;
			getCustomerProjectPayment();
	}
		function getCustomerProjectPayment() {
			var str=document.getElementById("custIdSelect").value;
			var thisYear=document.getElementById("yearSelect").value;
			var thisMonth=document.getElementById("monthSelect").value;
			
			var xhttp;
			xhttp = new XMLHttpRequest();
			try{
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						var demoStr = this.responseText.split("~");
						
						document.getElementById("CustomerPaymentViewTable").innerHTML = "";
						
						
					    var i = 0;
					    var Row="";
					    var j=1;
						for (; demoStr[i];) {
							Row+="<tr><td>"+ j+"</td>";
							var date=demoStr[i].split("-");
							
							Row+="<td>"+ date[2]+"-"+date[1]+"-"+date[0]+"</td>";
							i++;
							Row+="<td>"+ demoStr[i]+"</td>";
							i++;
							var credit=demoStr[i];
							if(credit=="null"){
								Row+="<td>-</td>";
							}else{
								Row+="<td>"+credit +"</td>";
							}
							
							i++;
							var debit=demoStr[i];
							if(debit=="null"){
								Row+="<td>-</td>";
							}else{
								Row+="<td>"+debit +"</td>";
							}
							
							i++;
							Row+="<td>"+ demoStr[i]+"</td></tr>";
							i++;
							j++;
						}
						document.getElementById("CustomerPaymentViewTable").innerHTML += Row;
					}
	
				};
			
				xhttp.open("POST", "/SAMERP/JcbPocPayment.do?custIdView="+str+"&thisYear="+thisYear+"&thisMonth="+thisMonth, true);
				xhttp.send();
			} catch (e) {
				alert("Unable to connect to server");
			}
	
		}
// 		function getCustomerProjectPayment(str) {
// 			var xhttp;
// 			xhttp = new XMLHttpRequest();
// 			try{
// 				xhttp.onreadystatechange = function() {
// 					if (this.readyState == 4 && this.status == 200) {
// 						var demoStr = this.responseText.split("~");
						
// 						document.getElementById("CustomerPaymentViewTable").innerHTML = "";
						
						
// 					    var i = 0
// 						for (; demoStr[i];) {
// 							var projectRow=demoStr[i].split(",");
							
// 							var Row="";
// 							var td="";
// 							var j = 5;
// 							var k=0;
// 							for (; projectRow[j];) {
// 								k++;
								
// 								if(k > 1){
// 									var jcbId=projectRow[j];
// 									j++;
// 									td +="<tr><td>"+ projectRow[j]; j++; 
// 									td +="</td><td>"+ projectRow[j]; j++; 
// 									td +="</td><td><a href=\"#myModal\" data-toggle=\"modal\" onclick=\"searchName("+jcbId+")\">Update</a></td></tr>";
// 								}
								
// 							}
// 							Row ="<tr><td rowspan="+k+">"+(i+1)+"</td><td rowspan="+k+">"+projectRow[0]+"</td><td rowspan="+k+">"+projectRow[1]+"</td><td>"+projectRow[3]+"</td><td>"+projectRow[4]+"</td><td><a href=\"#myModal\" data-toggle=\"modal\" onclick=\"searchName("+projectRow[2]+")\">Update</a></td></tr>";
							
// 							document.getElementById("CustomerPaymentViewTable").innerHTML += Row += td;
// 							i++;
// 						}
// 					}
	
// 				};
			
// 				xhttp.open("POST", "/SAMERP/JcbPocPayment.do?custIdView="+str, true);
// 				xhttp.send();
// 			} catch (e) {
// 				alert("Unable to connect to server");
// 			}
	
// 		}
	//===============================================End GetCustomerProjectPayment===================================
		//===============================================PRINT========================================
	function printData()
	{
		var thisYear=document.getElementById("yearSelect").value;
		var thisMonth=document.getElementById("monthSelect").value;
		
		if (thisYear=="") {
			alert("Select Year Date!");
			return;
		}
		if (thisMonth=="") {
			alert("Select Month Date!");
			return;
		}
		var month = new Array();
	    month[0] = "January";
	    month[1] = "February";
	    month[2] = "March";
	    month[3] = "April";
	    month[4] = "May";
	    month[5] = "June";
	    month[6] = "July";
	    month[7] = "August";
	    month[8] = "September";
	    month[9] = "October";
	    month[10] = "November";
	    month[11] = "December";
		
	   var divToPrint=document.getElementById("CustomerPaymentViewTable");
	   var htmlToPrint = '' +       
       	   '<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />'+
    	   '<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />'+
    	   '<link rel="stylesheet" href="/SAMERP/config/css/colorpicker.css" />'+
    	   '<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />'+
    	   '<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />'+
    	   '<link rel="stylesheet" href="/SAMERP/config/css/select2.css" />'+
    	   '<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-wysihtml5.css" />'+
    	   '<style type="text/css">' +
    		'#createBillTable tbody {'+
    		'border: 1px;'+
    		'border-style: groove;'+
    	'}'+
       '#createBillTable tbody tr td{'+
    		'border: 1px;'+
    		'border-style: groove;'+
    	'}'+
    	'#createBillTable tbody tr th{'+
    		'border: 1px;'+
    		'border-style: groove;'+
    		'font-size: x-small;'+
    	'}'+
    	'h2,h3,h6{'+
    		'margin:-3px 0;'+
    	'}'+
       '</style>';
       htmlToPrint +="<table style=\"margin: 0 auto;\" id=\"createBillTable\"><thead><tr><th  colspan=\"6\"><h2 style=\"color: #ff704d\">SAMRUDDHI EARTHMOVERS</h2></th></tr><tr><th colspan=\"4\"><h3 style=\"margin-left: 35%;    font-size: larger;\">EARTH WORK CONTRACTORS</h3></th><th colspan=\"2\" style=\"vertical-align: bottom;\"><h6>Year : <var style=\"color: #ff704d;\">"+month[thisMonth]+"</var>-<var style=\"color: #ff704d;\">"+thisYear+"</var></h6></th></tr><tr style=\"border-top: 1px; border-top-style: groove;\"><th colspan=\"6\"><h6>A/P-Naigaon(Shivalaya Bunglow),Tal-Haveli,Dist-Pune.Con-No:98814907070/9921267070 E-mail:sbchoudhari11@gmail.com</h6></th></tr></thead><tbody><tr><th>Sr no.</th><th>Date</th><th>Description</th><th>Credit</th><th>Debit</th><th>Total Balance</th></tr></tbody>";
       htmlToPrint += divToPrint.outerHTML+"</table>";
	   newWin= window.open("");
	   newWin.document.write(htmlToPrint);
	 //  newWin.print();
// 	   newWin.close();
	}
	//===================================End PRINT=================================================
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