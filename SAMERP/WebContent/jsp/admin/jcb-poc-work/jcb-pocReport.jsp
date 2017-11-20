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
				<a href="/SAMERP/jsp/admin/jcb-poc-work/jcb_pokland_dashboard.jsp" class="tip-bottom">JCB & POKLAND Dashboard</a>  
				<a href="#" class="current">JCB & POKLAND Report </a>
			</div>
		</div>
		
		<div class="container-fluid">
			<hr>
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
									<button class="btn btn-danger" onClick="doExport('#billListExport',{type: 'pdf',jspdf: {orientation: 'l',margins: {right: 10, left: 10, top: 40, bottom: 40},autotable: {tableWidth: 'auto'}}});">PDF</button>
									<button class="btn btn-inverse" onclick="printData()">Print</button>
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
// ##########################################	Grt Data For Report ###########################################
function getBillReportData() {
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
	xhttp.open("POST", "/SAMERP/JcbPocReport.do?formDate="+from+"&toDate="+to, true);
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
