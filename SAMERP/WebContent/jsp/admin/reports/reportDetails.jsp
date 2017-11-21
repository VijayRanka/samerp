<%@page import="utility.SysDate"%>
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
				<a href="index.html" class="tip-bottom"
					data-original-title="Go to Home"><i class="icon-home"></i> Home</a>
				<a href="#" class="current">Data Report</a>
				
			</div>
		</div>
		
		<div class="container-fluid">
			<hr>
			<div class="row-fluid">
				<div class="span12">
              <div class="widget-box">
			        <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
			          <h5>Reports</h5>
			        </div>
			        <div class="widget-content nopadding">
			          <form action="#" method="post" class="form-horizontal">
			          <div class="control-group" >
				             	   <label class="control-label">From : </label>
					               <div class="control" style="top: 5px; position: relative; left: 20px;">
										<input type="date" name="fromDate" id="fromDate" value="2017-11-09"> &nbsp;&nbsp;&nbsp;
										<strong>To : </strong>
										<input type="date" name="toDate" id="toDate" value="2017-11-19">
									</div>
				             	</div>
			          
			          
			            <div class="control-group">
			              <label class="control-label">Report Type :</label>
			              <div class="controls">
			                <select id="reportType" style="width: 220px;"  onchange="generateName(this.value)">
			                <option value="bankStatement">Bank Statement</option>
			                <option value="expenses">Expenses</option>
			                <option value="handLoad">Hand-Loan</option>
			                <option value="jcbPokland">JCB-Pokland</option>
			                
			                <option value="pipePurchase">Pipe Purchase</option>
			                <option value="productDetails">Production Details</option>
			                <option value="sale">Sale</option>
			                <option value="vehicleRepair">Vehicle Repair</option>
			                </select>
			              </div>
			            </div>
			            <div class="control-group" style="">
				             	   <label class="control-label">Select Mode : </label>
					               <div class="controls">
					                 <input type="radio" id="mode1" value="ALL" name="type" onclick="onIndividual(this.value)" checked="checked"/> <span>All</span> 
					                 &nbsp;&nbsp;&nbsp;&nbsp;
					                 <input type="radio" id="mode2" value="INDIVIUAL" name="type" onclick="onIndividual(this.value)" /><span>Individual</span> 
					               </div>
				             	</div>
				             	<div class="control-group" id="selectIndividual" style="display: none">
				             	   <label class="control-label">Select Individual : </label>
					               <div class="controls">
					                 <input type="text" list="getList" id="individualName" onkeyup="searchName(this.value,this.id,this.list.id)"
					                 autocomplete="off"  placeholder="Individual Name"/>
              							<datalist id="getList"></datalist>
					               </div>
				             	</div>
				             	
				             	
				             	<div class="control-group centered" id="selectIndividual">
					               <div id="" class="controls" style="position: relative; left: 50px">
											<button type="button" class="btn btn-primary" onclick="getBillReportData()">Create</button>
											<button type="button" class="btn btn-success" onClick="doExport('#wholeDataList', {type: 'excel', numbers: {output: false}, onMsoNumberFormat: DoOnMsoNumberFormat, worksheetName: 'MSO-FORMATS', excelstyles: ['background-color', 'color']});">Excel</button>
											<button type="button" class="btn btn-warning" onclick="printData()">Print</button>
										</div>
				             	</div>
			          </form>
			        </div>
			      </div>
			      <script type="text/javascript">
			     
			      
			      </script>
					<!-- <div class="widget-box">
						<div class="alert alert-info" style="    padding-left: 140px;">
								<strong>From : </strong>
								<input type="date" name="fromDate" id="fromDate">
								<strong>To : </strong>
								<input type="date" name="toDate" id="toDate">
								<div id="" style="float: right; margin-right: 140px">
									<button class="btn btn-primary" onclick="getBillReportData()">Create</button>
									<button class="btn btn-success" onClick="doExport('#billListExport', {type: 'excel', numbers: {output: false}, onMsoNumberFormat: DoOnMsoNumberFormat, worksheetName: 'MSO-FORMATS', excelstyles: ['background-color', 'color']});">Excel</button>
									<button class="btn btn-danger" onClick="doExport('#billListExport',{type: 'pdf',jspdf: {orientation: 'l',margins: {right: 10, left: 10, top: 40, bottom: 40},autotable: {tableWidth: 'auto'}}});">PDF</button>
									<button class="btn btn-inverse" onclick="printData()">Print</button>
								</div>
						</div>
						
					</div> -->
				</div>
			</div>

			<div class="row-fluid">
				<div class="span12">

					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"><i class="icon-th"></i></span>
							<h5>Data List</h5>
						</div>
						<div class="widget-content nopadding" id="myTable">
							<table class="table table-bordered data-table" id="wholeDataList">
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
	


//to display the individual input
	function onIndividual(value)
 	{
 		if(value=="INDIVIUAL")
 			{
 			document.getElementById("selectIndividual").style.display="block";
 			document.getElementById("individualName").value="";
 			document.getElementById("individualName").focus();
 			document.getElementById("wholeDataList").innerHTML="";
 			}
 		else if(value=="ALL"){
 			document.getElementById("selectIndividual").style.display="none";
 			document.getElementById("wholeDataList").innerHTML="";
 			
 		}
 			
 	}
 	
// to display list of individuals
function generateName(value){
	if(value=='expenses')
		{
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var demoStr = this.responseText;
				document.getElementById("getList").innerHTML = demoStr;
				}
			};
		xhttp.open("POST", "/SAMERP/Expenses.do?findNameByReport=1", true);
		xhttp.send();
		}
	
	else{
		document.getElementById("getList").innerHTML = "";
		document.getElementById("individualName").value = "";
	}
		
		
}
// ##########################################	Grt Data For Report ###########################################
function getBillReportData() {
	
	if(document.getElementById("fromDate").value=="" || document.getElementById("toDate").value==""){
		alert("Enter right format Date");
	}
	else{
		
	if(document.getElementById("reportType").value=='expenses')
		{
			 if(document.getElementById("mode1").checked==true)
				{
				getExpData();
				}
			else{
				if(document.getElementById("individualName").value=="")
					{
						alert("Please select any individual first");
						document.getElementById("individualName").focus();
					}
				else{
					getExpDataByName();
				}
			} 
		}
	}
}
// ########################################## End	Grt Data For Report ###########################################

// ########################################## Excel ###########################################
function doExport(selector, params) {
      var options = {
        //ignoreRow: [1,11,12,-2],
        //ignoreColumn: [0,-1],
        //pdfmake: {enabled: true},
        tableName: 'wholeDataList',
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
	   var divToPrint=document.getElementById("wholeDataList");
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
       htmlToPrint += divToPrint.outerHTML+"</table>";
	   newWin= window.open("");
	   newWin.document.write(htmlToPrint);
	 //  newWin.print();
// 	   newWin.close();
	}
	//===================================End PRINT=================================================
		
		//--------------------starts (vijay)-----------------------
	 function getExpData(value)
     {
   		  var firstDate=document.getElementById("fromDate").value;
   		  var lastDate=document.getElementById("toDate").value;
   		  var xhttp;
	  			xhttp = new XMLHttpRequest();
	  			xhttp.onreadystatechange = function() {
	  				if (this.readyState == 4 && this.status == 200) {
	  					var demoStr = this.responseText.split(",");
	  					if(demoStr=="")
	  						document.getElementById("wholeDataList").innerHTML="<tr><td colspan='10'>No Records Found!</td></tr>"
	  					else{
	  					var a="<thead>"+
	  					"<tr><th>S.No.</th>"+
	  					"<th style='width:80px'>Date</th>"+
	  					"<th>Name</th>"+
	  					"<th>Amount</th>"+
	  					"<th>Payment Mode</th>"+
	  					"<th>Vehicle Reading</th>"+
	  					"<th>Qty In Litres(s)</th>"+
	  					"<th>Expenses Type</th>"+
	  					"<th>Debtor Type</th>"+
	  					"<th>Cheque Details</th>"+
	  					"<th>Bank Info</th>"+
	  					"<th>Reason</th>"+
	  					"</tr></thead><tbody>";
	  					var count=1;
	  					for(var i=0;i<demoStr.length-1;i=i+12)
	  						{
	  						 a+= "<tr>"+
	  						"<td style='text-align: center'>"+count+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+1]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+2]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+3]+"</td>"+
	  						"<td style='text-align: center' >"+demoStr[i+4]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+5]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+6]+"</td>"+
	  						"<td style='text-align: center'' >"+demoStr[i+7]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+8]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+9]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+10]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+11]+"</td>"+
	  						"<tr>";
	  						count++;
	  						}
	  					a+="</tbody>";
	  					document.getElementById("wholeDataList").innerHTML=a;
	  					}
	  				}
	  					
	  				};
	  			xhttp.open("POST", "/SAMERP/Expenses.do?getDateData=1&fromDate="+firstDate+"&toDate="+lastDate, true);
	  			xhttp.send();
     }
     
     function getExpDataByName()
     {
    	var firstDate=document.getElementById("fromDate").value;
  		var lastDate=document.getElementById("toDate").value;
    	var name=document.getElementById("individualName").value;
   	    var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var demoStr = this.responseText.split(",");
				if(demoStr=="")
					document.getElementById("wholeDataList").innerHTML="<tr><td colspan='10'>No Records Found!</td></tr>"
				else{
				var a="<thead>"+
				"<tr><th>S.No.</th>"+
				"<th style='width:80px'>Date</th>"+
				"<th>Amount</th>"+
				"<th>Payment Mode</th>"+
				"<th>Vehicle Reading</th>"+
				"<th>Qty In Litres(s)</th>"+
				"<th>Expenses Type</th>"+
				"<th>Debtor Type</th>"+
				"<th>Cheque Details</th>"+
				"<th>Bank Info</th>"+
				"<th>Reason</th>"+
				"</tr></thead><tbody>";
				var count=1;
				for(var i=0;i<demoStr.length-1;i=i+12)
					{
					 a+= "<tr>"+
					"<td style='text-align: center'>"+count+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+1]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+3]+"</td>"+
					"<td style='text-align: center' >"+demoStr[i+4]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+5]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+6]+"</td>"+
					"<td style='text-align: center'' >"+demoStr[i+7]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+8]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+9]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+10]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+11]+"</td>"+
					"<tr>";
					count++;
					}
				a+="</tbody>";
				document.getElementById("wholeDataList").innerHTML=a;
				}
			}
				
			};
		xhttp.open("POST", "/SAMERP/Expenses.do?getDateData=1&individualName="+name+"&fromDate="+firstDate+"&toDate="+lastDate, true);
		xhttp.send();
     }
	//--------------------ends (vijay)-----------------------
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
