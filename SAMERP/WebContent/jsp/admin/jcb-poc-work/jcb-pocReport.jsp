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
	<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">
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
<body onload="loadFunction()">

	<!--Header-part-->
	<div id="header">
		<h1>
			<a href="dashboard.html">Matrix Admin</a>
		</h1>
	</div>
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
	<!--sidebar-menu-->
	<jsp:include page="/jsp/admin/common/left_navbar.jsp"></jsp:include>
	<!--sidebar-menu-->

	<!--main-container-part-->
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				<a href="/SAMERP/dashboard.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> 
				<a href="/SAMERP/jsp/admin/jcb-poc-work/jcb_pokland_dashboard.jsp" title="Go to JCB & POKLAND Dashboard" class="tip-bottom">JCB & POKLAND Dashboard</a>  
				<a href="#" class="current">JCB & POKLAND Report </a>
			</div>
		</div>
		<div class="container-fluid" align="center">
		    <div class="quick-actions_homepage">
			      <ul class="quick-actions">
						<li class="bg_lg"> <a href="#" onclick="showReportType(1)"> <i class="icon-user"></i><span class="label label-success"></span>Bill Report</a> </li>
				      	<li class="bg_lb"> <a href="#" onclick="showReportType(2)"> <i class="icon-money"></i><span class="label label-success"></span>Chalan Report</a> </li>
			      </ul>
		    </div>
		</div>
		<div class="container-fluid" id="billReportType">
			<hr>
			<h4>Bill Report</h4>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="alert alert-info" style="    padding-left: 140px;">
								<strong>From : </strong>
								<input type="date" name="fromDate" id="fromDate">
								<strong>To : </strong>
								<input type="date" name="toDate" id="toDate">
								<div id="" style="float: right; padding-right: 20%;">
									<button class="btn btn-primary" onclick="getBillReportData()">Create</button>
									<button class="btn btn-success" onClick="doExport('#billListExport', {type: 'excel', numbers: {output: false}, onMsoNumberFormat: DoOnMsoNumberFormat, worksheetName: 'MSO-FORMATS', excelstyles: ['background-color', 'color']});">Excel</button>
<!-- 									<button class="btn btn-danger" onClick="doExport('#billListExport',{type: 'pdf',jspdf: {orientation: 'l',margins: {right: 10, left: 10, top: 40, bottom: 40},autotable: {tableWidth: 'auto'}}});">PDF</button> -->
									<button class="btn btn-inverse" onclick="printData()">Print</button>
								</div>
								<strong style="float: right;margin-right: -38%;">Without GST: </strong>
								<input type="checkbox" id="noGst"  style="float: right;margin-right: -40%;">
						</div>
						
					</div>
				</div>
			</div>
			<div class="row-fluid">
				<div class="span12">

					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"><i class="icon-th"></i></span>
							<h5>JCB & POKLAND Bill List</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered data-table" id="billListExport">
								<thead>
									<tr>
										<th>Invoice No</th>
										<th>Customer Name</th>
										<th>Date</th>
										<th>Taxable Amount</th>
										<th>GST</th>
										<th>CGST Amount</th>
										<th>SGST Amount</th>
										<th>Total Amount</th>
									</tr>
								</thead>
								<tbody id="billList">
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
		<div class="container-fluid hide" id="chalanReportType">
			<hr>
			<h4>Chalan Report</h4>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="alert alert-info" style="padding-left: 20%;">
								<strong style="margin-left: 4%;">From : </strong>
								<input type="date" name="fromDate" id="fromDateChalan">
								<strong style="padding-left: 7%;">To : </strong>
								<input type="date" name="toDate" id="toDateChalan"><br>
								<strong style="margin-left: -20%;">Enter Customer Name <span class="badge badge-info">OR</span> Contact No : </strong>
								<input list="browsers" name="browser" id="editdata"	onkeyup="CustomerSearch(this.value)" onkeydown="CustomerPrint()" onblur="SelectCustomerProject()" autocomplete="off" required>
								<datalist id="browsers"></datalist>
								<strong>Machine Name : </strong>
								<%
									RequireData rd = new RequireData();
									List Vehicle = rd.getVehicleList();
									Iterator itr = Vehicle.iterator();
								%>
								<select id="vehicleId">
								<option></option>
								<%
									while (itr.hasNext()) {
								%>
								<option value="<%=itr.next()%>"><%=itr.next()%></option>
								<%
									}
								%>
								</select><br>
								<strong style="margin-left: -9%;">Select Customer Project : </strong>
								<select id="cust_project">
									<option></option>
								</select>
								<div id="" style="padding-left: 20%;">
									<button class="btn btn-primary" onclick="getChalanReportData()">Create</button>
									<button class="btn btn-success" onClick="doExportChalan('#chalanListExport', {type: 'excel', numbers: {output: false}, onMsoNumberFormat: DoOnMsoNumberFormat, worksheetName: 'MSO-FORMATS', excelstyles: ['background-color', 'color']});">Excel</button>
<!-- 									<button class="btn btn-danger" onClick="doExport('#billListExport',{type: 'pdf',jspdf: {orientation: 'l',margins: {right: 10, left: 10, top: 40, bottom: 40},autotable: {tableWidth: 'auto'}}});">PDF</button> -->
									<button class="btn btn-inverse" onclick="printDataChalan()">Print</button>
								</div>
						</div>
						
					</div>
				</div>
			</div>
			<div class="row-fluid">
				<div class="span12">

					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"><i class="icon-th"></i></span>
							<h5>JCB & POKLAND Bill List</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered data-table" id="chalanListExport">
								<thead>
									<tr>
										<th>Sr No</th>
										<th>Customer Name</th>
										<th>Chalan No</th>
										<th>Date</th>
										<th>Vehicle</th>
										<th>Project</th>
										<th>Bucket Hr</th>
										<th>Breaker Hr</th>
										<th>Deposit</th>
										<th>Diesel Amount</th>
									</tr>
								</thead>
								<tbody id="chalanList">
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
	</div>

	<!--end-main-container-part-->

	<!--Footer-part-->

	<div class="row-fluid">
		<div id="footer" class="span12"> 2017 &copy; Vertical Software.  <a href="http://verticalsoftware.co.in">www.verticalsoftware.in</a> </div>
	</div>

	<!--end-Footer-part-->
	
	
<script type="text/javascript">

	function loadFunction(){
		document.getElementById("fromDate").focus();
	}
	// ##########################################	Report Type Show ##########################################
	function showReportType(str) {
		if(str==1){
			document.getElementById("billReportType").className="container-fluid";
			document.getElementById("chalanReportType").className="container-fluid hide";
		}
		if(str==2){
			document.getElementById("billReportType").className="container-fluid hide";
			document.getElementById("chalanReportType").className="container-fluid";
		}
	}
	// ########################################## End	Report Type Show ###########################################
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
		//******************************************Cutomer Project******************************************************************
		function SelectCustomerProject() {
			var val = document.getElementById('editdata').value;
		     var str = $('#browsers').find('option[value="' + val + '"]').attr('id');
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
//******************************************Cutomer Project End******************************************************************
// ##########################################	Grt Data For Report ###########################################
function getChalanReportData() {
	var from=document.getElementById("fromDateChalan").value;
	var to=document.getElementById("toDateChalan").value;
	
	var val = document.getElementById('editdata').value;
    var custID = $('#browsers').find('option[value="' + val + '"]').attr('id');
    
	var projectId=document.getElementById("cust_project").value;
	var vehicleId=document.getElementById("vehicleId").value;
	
	if (from=="") {
		alert("Select From Date!");
		return;
	}
	if (to=="") {
		alert("Select To Date!");
		return;
	}
	if (custID=="" || custID==null) {
		custID="<>''";
	}else {
		custID="="+custID;
	}
	
	if (projectId=="") {
		projectId="<>''";
	}else {
		projectId="="+projectId;
	}
	
	if (vehicleId=="") {
		vehicleId="<>''";
	}else {
		vehicleId="="+vehicleId;
	}
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var demoStr = this.responseText.split("~");
			if(demoStr=="")
			document.getElementById("chalanList").innerHTML="<tr><td colspan='10'>No Records Found!</td></tr>"
			else{
				var count=1;
				var wholeData="";
				for(var i=0;i<demoStr.length-2;i=i+9){
						
					wholeData+="<tr>"+"<td>"+count+"</td>"+"<td>"+demoStr[i]+"</td><td>"+demoStr[i+1]+"</td>";
					var billdate=demoStr[i+2].split("-");
					billdate=billdate[2]+"-"+billdate[1]+"-"+billdate[0];
					
					wholeData+="<td>"+billdate+"</td>"+
					"<td>"+demoStr[i+3]+"</td>"+
					"<td>"+demoStr[i+4]+"</td>"+
					"<td>"+demoStr[i+5]+"</td>"+
					"<td>"+demoStr[i+6]+"</td>"+
					"<td>"+demoStr[i+7]+"</td>"+
					"<td>"+demoStr[i+8]+"</td>"+
					"<tr>";
					count++;
				}
			
			document.getElementById("chalanList").innerHTML=wholeData;
			}
		}
	};
	xhttp.open("POST", "/SAMERP/JcbPocReport.do?fromDateChalan="+from+"&toDateChalan="+to+"&custID="+custID+"&projectId="+projectId+"&vehicleId="+vehicleId, true);
	xhttp.send();
}
function getBillReportData() {
	var from=document.getElementById("fromDate").value;
	var to=document.getElementById("toDate").value;
	var noGst=document.getElementById("noGst").checked
	
	if (from=="") {
		alert("Select From Date!");
		return;
	}
	if (to=="") {
		alert("Select To Date!");
		return;
	}
	if(noGst == true){
		noGst=2;
	}else {
		noGst=1;
	}
	alert(noGst);
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var demoStr = this.responseText.split("~");
			if(demoStr=="")
			document.getElementById("billList").innerHTML="<tr><td colspan='10'>No Records Found!</td></tr>"
			else{
				var count=1;
				var wholeData="";
				for(var i=0;i<demoStr.length-2;i=i+5){
						
					wholeData+="<tr>"+
					"<td>"+demoStr[i]+"</td>"+
					"<td>"+demoStr[i+1]+"</td>";
					var billdate=demoStr[i+2].split("-");
					billdate=billdate[2]+"-"+billdate[1]+"-"+billdate[0];
					
					wholeData+="<td>"+billdate+"</td>"+
					"<td>"+demoStr[i+3]+"</td>"+
					"<td>"+demoStr[i+4]+"%</td>";
					var gst=demoStr[i+4];
					gst=gst/2;
					gst=gst/100;
					var cgst=Math.round((demoStr[i+3]*gst) * 100) / 100;
					var sgst=Math.round((demoStr[i+3]*gst) * 100) / 100;
					wholeData+="<td >"+cgst+"</td>"+
					"<td>"+sgst+"</td>"+
					"<td>"+Math.round((parseFloat(demoStr[i+3]) + parseFloat(cgst) + parseFloat(sgst)) * 100) / 100+"</td>"+
					"<tr>";
					count++;
				}
			
			document.getElementById("billList").innerHTML=wholeData;
			}
		}
	};
	xhttp.open("POST", "/SAMERP/JcbPocReport.do?formDate="+from+"&toDate="+to+"&noGst="+noGst, true);
	xhttp.send();
}
// ########################################## End	Grt Data For Report ###########################################

// ########################################## Excel ###########################################
function doExport(selector, params) {
      var options = {
        //ignoreRow: [1,11,12,-2],
        //ignoreColumn: [0,-1],
        //pdfmake: {enabled: true},
        tableName: 'billListExport',
        worksheetName: 'Invoice List'
      };

      $.extend(true, options, params);

      $(selector).tableExport(options);
}
function doExportChalan(selector, params) {
    var options = {
      //ignoreRow: [1,11,12,-2],
      //ignoreColumn: [0,-1],
      //pdfmake: {enabled: true},
      tableName: 'chalanListExport',
      worksheetName: 'Invoice List'
    };

    $.extend(true, options, params);

    $(selector).tableExport(options);
}
function DoOnCellHtmlData(cell, row, col, data) {
    var result = "";
    if (data != "") {
      var html = $.parseHTML( data );

      $.each( html, function() {
        if ( typeof $(this).html() === 'undefined' )
          result += $(this).text();
        else if ( $(this).is("input") )
          result += $('#'+$(this).attr('id')).val();
        else if ( $(this).is("select") )
          result += $('#'+$(this).attr('id')+" option:selected").text();
        else if ( $(this).hasClass('no_export') !== true )
          result += $(this).html();
      });
    }
    return result;
  }

  function DoOnCsvCellData(cell, row, col, data) {
    var result = data;
    if (result != "" && row > 0 && col == 0) {
      result = "\x1F" + data;
    }
    return result;
  }

  function DoOnXlsxCellData(cell, row, col, data) {
    var result = data;
    if (result != "" && (row < 1 || col != 0)) {
      if ( result == +result )
        result = +result;
    }
    return result;
  }

  function DoOnMsoNumberFormat(cell, row, col) {
    var result = "";
    if (row > 0 && col == 0)
      result = "\\@";
    return result;
  }
  
// ########################################## End	Excel ###########################################
//===============================================PRINT========================================
	function printDataChalan()
	{
		var from=document.getElementById("fromDateChalan").value;
		var to=document.getElementById("toDateChalan").value;
		
		if (from=="") {
			alert("Select From Date!");
			return;
		}
		if (to=="") {
			alert("Select To Date!");
			return;
		}
		from=from.split("-");
		from=from[2]+"-"+from[1]+"-"+from[0];
		to=to.split("-");
		to=to[2]+"-"+to[1]+"-"+to[0];
	   var divToPrint=document.getElementById("chalanList");
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
    		'font-size: smaller;'+
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
       htmlToPrint +="<table style=\"margin: 0 auto;\" id=\"createBillTable\"><thead><tr><th  colspan=\"10\"><h3 style=\"color: #ff704d\">SAMRUDDHI EARTHMOVERS</h3></th></tr><tr><th colspan=\"10\"><h3 style=\"font-size: medium;\">EARTH WORK CONTRACTORS</h3></th></tr><tr><th colspan=\"10\" style=\"vertical-align: bottom;\"><h6 style=\"float: right;\">From : <var style=\"color: #ff704d;\">"+from+"</var>  To : <var style=\"color: #ff704d;\">"+to+"</var> Chalan List </h6></th></tr><tr style=\"border-top: 1px; border-top-style: groove;\"><th colspan=\"10\"><h6>A/P-Naigaon(Shivalaya Bunglow),Tal-Haveli,Dist-Pune.Con-No:98814907070/9921267070 E-mail:sbchoudhari11@gmail.com</h6></th></tr></thead><tbody><tr><th>Sr No</th><th>Customer Name</th><th>Chalan No</th><th>Date</th><th>Vehicle</th><th>Project</th><th>Bucket Hr</th><th>Breaker Hr</th><th>Deposit</th><th>Diesel Amount</th></tr></tbody>";
       htmlToPrint += divToPrint.outerHTML+"</table>";
	   newWin= window.open("");
	   newWin.document.write(htmlToPrint);
	 //  newWin.print();
// 	   newWin.close();
	}
	function printData()
	{
		var from=document.getElementById("fromDate").value;
		var to=document.getElementById("toDate").value;
		
		if (from=="") {
			alert("Select From Date!");
			return;
		}
		if (to=="") {
			alert("Select To Date!");
			return;
		}
		from=from.split("-");
		from=from[2]+"-"+from[1]+"-"+from[0];
		to=to.split("-");
		to=to[2]+"-"+to[1]+"-"+to[0];
	   var divToPrint=document.getElementById("billList");
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
       htmlToPrint +="<table style=\"margin: 0 auto;\" id=\"createBillTable\"><thead><tr><th  colspan=\"8\"><h2 style=\"color: #ff704d\">SAMRUDDHI EARTHMOVERS</h2></th></tr><tr><th colspan=\"6\"><h3 style=\"margin-left: 35%;    font-size: larger;\">EARTH WORK CONTRACTORS</h3></th><th colspan=\"2\" style=\"vertical-align: bottom;\"><h6>From : <var style=\"color: #ff704d;\">"+from+"</var>  To : <var style=\"color: #ff704d;\">"+to+"</var></h6></th></tr><tr style=\"border-top: 1px; border-top-style: groove;\"><th colspan=\"8\"><h6>A/P-Naigaon(Shivalaya Bunglow),Tal-Haveli,Dist-Pune.Con-No:98814907070/9921267070 E-mail:sbchoudhari11@gmail.com</h6></th></tr></thead><tbody><tr><th>Invoice No</th><th>Customer Name</th><th>Date</th><th>Taxable Amount</th><th>GST</th><th>CGST Amount</th><th>SGST Amount</th><th>Total Amount</th></tr></tbody>";
       htmlToPrint += divToPrint.outerHTML+"</table>";
	   newWin= window.open("");
	   newWin.document.write(htmlToPrint);
	 //  newWin.print();
// 	   newWin.close();
	}
	//===================================End PRINT=================================================
</script>
<!-- 	<script src="/SAMERP/config/js/jquery.min.js"></script> -->
<script src="/SAMERP/config/reportExport/libs/jquery-3.2.1.min.js"></script>
	<script src="/SAMERP/config/js/jquery.ui.custom.js"></script>
	<script src="/SAMERP/config/js/bootstrap.min.js"></script>
	<script src="/SAMERP/config/js/jquery.uniform.js"></script>
	<script src="/SAMERP/config/js/select2.min.js"></script>
	<script src="/SAMERP/config/js/jquery.dataTables.min.js"></script>
	<script src="/SAMERP/config/js/matrix.js"></script>
	<script src="/SAMERP/config/js/matrix.tables.js"></script>
	
<!-- ###########################	Report Export################################## -->
  <script type="text/javascript" src="/SAMERP/config/reportExport/libs/js-xlsx/xlsx.core.min.js"></script>
  <script type="text/javascript" src="/SAMERP/config/reportExport/libs/FileSaver/FileSaver.min.js"></script>
 
  <script type="text/javascript" src="/SAMERP/config/reportExport/libs/jsPDF/jspdf.min.js"></script>
  <script type="text/javascript" src="/SAMERP/config/reportExport/libs/jsPDF-AutoTable/jspdf.plugin.autotable.js"></script>
  <script type="text/javascript" src="/SAMERP/config/reportExport/libs/html2canvas/html2canvas.min.js"></script>
  <script type="text/javascript" src="/SAMERP/config/reportExport/libs/tableExport.js"></script>
<!-- ########################### End	Report Export################################## -->
	
</body>
</html>
