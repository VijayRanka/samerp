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
<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">
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
					               <%SysDate sd=new SysDate(); 
					               String lDate=sd.todayDate().split("-")[2]+"-"+sd.todayDate().split("-")[1]+"-"+sd.todayDate().split("-")[0];
					               String fDate=sd.todayDate().split("-")[2]+"-"+sd.todayDate().split("-")[1]+"-01"; %>
										<input type="date" name="fromDate" id="fromDate" value="<%=fDate%>"> &nbsp;&nbsp;&nbsp;
										<strong>To : </strong>
										<input type="date" name="toDate" id="toDate" value="<%=lDate%>">
									</div>
				             	</div>
			          
			          
			            <div class="control-group">
			              <label class="control-label">Report Type :</label>
			              <div class="controls">
			                <select id="reportType" style="width: 220px;" onchange="generateName(this.value)">
			                <option >Select Report Type</option>
			                <option value="BANKSTATEMENT">Bank Statement</option>
			                <option value="EXPENSES">Expenses</option>
			                <option value="HANDLOAN">Hand-Loan</option>
			                <option value="JCBPOKLAND">JCB-Pokland</option>
			                <option value="PAYMENTSTATEMENT">Payment Statement</option>
			                <option value="PIPEPURCHASE">Pipe Purchase</option>
			                <option value="RAWPURCHASE">Raw Material Purchase</option>
			                <option value="PRODUCTDETAILS">Production Details</option>
			                <option value="SALE">Sale</option>
			                <option value="VEHICLEREPAIR">Vehicle Repair</option>
			                </select>
			              </div>
			            </div>
			             <div class="control-group" style="display:none" id="payTypes">
				             	   <label class="control-label">Select Type : </label>
					               <div class="controls">
					                 <input type="radio" id="type1" value="clients" name="types" onclick="onPayType(this.value)" checked="checked"/> <span>Clients</span> 
					                &nbsp;&nbsp;&nbsp;&nbsp;
					                 <input type="radio" id="type2" value="contractors" name="types" onclick="onPayType(this.value)" /><span>Contractor</span> 
					                 &nbsp;&nbsp;&nbsp;&nbsp;
					                 <input type="radio" id="type3" value="suppliers" name="types" onclick="onPayType(this.value)" /><span>Supplier</span> 
					                  
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
					                 <input type="text" list="getList" id="individualName"
					                 autocomplete="off"  placeholder="Individual Name" />
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
							<table class="table table-bordered" id="wholeDataList" style="font-size: 12px">
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
 	
//for payment radio options
function onPayType(value)
 	{
 		if(value=="clients"){
 			document.getElementById("wholeDataList").innerHTML="";
 			//changing datalist for individual Clients for Sarang
 			
 			}
 		else if(value=="suppliers"){
 			document.getElementById("wholeDataList").innerHTML="";
 			//changing datalist for individual Suppliers for Mukesh and Omkar
 			
 		}
 		else if(value=="contractors"){
 			document.getElementById("wholeDataList").innerHTML="";
 			//changing datalist for individual Contractors for Vijay
 			
 		}
 			
 	}
 	
// to display list of individuals
function generateName(value){
	//for removing the data list and value of individual input
	document.getElementById("getList").innerHTML = "";
	document.getElementById("individualName").value = "";
	document.getElementById("wholeDataList").value = "";
	
	if(value!=='PAYMENTSTATEMENT'){
		document.getElementById("payTypes").style.display="none";
	}
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var demoStr = this.responseText;
				document.getElementById("getList").innerHTML = demoStr;
				}
			};
			
			if(value=='EXPENSES')
				xhttp.open("POST", "/SAMERP/Expenses.do?findNameByReport=1", true);
			else if(value=='BANKSTATEMENT')
				xhttp.open("POST", "/SAMERP/AddAccountDetails?findNameByReport=1", true);
			else if(value=='SALE')
				xhttp.open("POST", "/SAMERP/Sales?findSaleClient=1", true);
			else if(value=='HANDLOAN')
				xhttp.open("POST", "/SAMERP/PTCash?findNameByReport=1", true);
			else if(value=='RAWPURCHASE')
				xhttp.open("POST", "/SAMERP/PurchaseRawMaterial?findNameByReport=1", true);
			else if(value=='PAYMENTSTATEMENT'){
				document.getElementById("payTypes").style.display="block";
				if(document.getElementById("type1").checked==true){
					// generating Name List for Clients for SARANG
				}
				else if(document.getElementById("type2").checked==true){
					// generating Name List for Contractors for VIJAY
					xhttp.open("POST", "/SAMERP/ContractorPayment?findList=1", true);
					
				}
				else if(document.getElementById("type3").checked==true){
					// generating Name List for Suppliers for OMKAR and Mukesh
					xhttp.open("POST", "/SAMERP/RawSupplier?allSupplier=1", true);
				}
			}
		xhttp.send();
		
	}
// ##########################################	Grt Data For Report ###########################################
function getBillReportData() {
	
	if(document.getElementById("fromDate").value=="" || document.getElementById("toDate").value==""){
		alert("Enter right format Date");
	}
	else{
	// for Expense of Vijay
	if(document.getElementById("reportType").value=='EXPENSES')
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
		//Sarang
		else if(document.getElementById("reportType").value=='SALE'){
			 
			if(document.getElementById("mode1").checked==true)
			{
				getSaleData();
			}
			else{
			
					if(document.getElementById("individualName").value=="")
					{
						alert("Please select any individual first");
						document.getElementById("individualName").focus();
					}
					else{
						getSaleDataByClient();
					}
			}			
		}
	//Omkar 1
	else if(document.getElementById("reportType").value=='BANKSTATEMENT')
	{
		 if(document.getElementById("mode1").checked==true)
			{
				getBankData();
			}
		else{
			if(document.getElementById("individualName").value=="")
				{
					alert("Please select any individual first");
					document.getElementById("individualName").focus();
				}
			else
			{
					getBankDataByName();
			}
		} 
	}
	//Omkar 2
	else if(document.getElementById("reportType").value=='HANDLOAN')
	{
		 if(document.getElementById("mode1").checked==true)
			{
				getHandLoanData();
			}
		else{
			if(document.getElementById("individualName").value=="")
				{
					alert("Please select any individual first");
					document.getElementById("individualName").focus();
				}
			else
			{
					getHandLoanByName();
			}
		} 
	}
	//Omkar 3
	else if(document.getElementById("reportType").value=='RAWPURCHASE')
	{
		 if(document.getElementById("mode1").checked==true)
			{
				getRawPurchaseData();
			}
		else{
			if(document.getElementById("individualName").value=="")
				{
					alert("Please select any individual first");
					document.getElementById("individualName").focus();
				}
			else
			{
					getRawPurchaseByName();
			}
		} 
	}
	
	
	// for payment of OMKAR, MUKESH, VIJAY and SARANG
	if(document.getElementById("reportType").value=='PAYMENTSTATEMENT')
	{
		 if(document.getElementById("type1").checked==true)
			{
			 // for SARANG clients list
			 if(document.getElementById("mode1").checked==true){
					//whole data of clients ()
					}
				else{
					if(document.getElementById("individualName").value=="")
					{
						alert("Please select any individual first");
						document.getElementById("individualName").focus();
					}
					else{
						//individual client data ()
					}
				}
				 
			}
		else if(document.getElementById("type2").checked==true){
			// for VIJAY contractor list
			if(document.getElementById("mode1").checked==true){
				//whole data of contractors ()
				getContData();
				}
			else{
				if(document.getElementById("individualName").value=="")
				{
					alert("Please select any individual first");
					document.getElementById("individualName").focus();
				}
				else{
					//individual contractor data ()
					getSingleContData();
					
				}
			}
	
			}
			else if(document.getElementById("type3").checked==true){
				// for OMKAR and MUKESH suppliers list
				if(document.getElementById("mode1").checked==true){
					//whole data of suppliers ()
					getSupplierData();
					}
				else{
					if(document.getElementById("individualName").value=="")
					{
						alert("Please select any individual first");
						document.getElementById("individualName").focus();
					}
					else{
						getSingleSupplierData();
						//individual supplier data ()
					}
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
       'body{padding:0px 20px 0px 0px}</style>';
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
	  					alert(demoStr.length);
	  					if(demoStr=="")
	  						document.getElementById("wholeDataList").innerHTML="<tr><td colspan='10'>No Records Found!</td></tr>"
	  					else{
	  					var a="<thead>"+
	  					"<tr><th colspan='12' id='reportDetails' style='font-size:15px;text-align: center'></th></tr>"+
	  					"<tr><th>S.No.</th>"+
	  					"<th style='width:80px;text-align: center'>Date</th>"+
	  					"<th style='text-align: center'>Name</th>"+
	  					"<th style='text-align: center'>Amount</th>"+
	  					"<th style='text-align: center'>Payment Mode</th>"+
	  					"<th style='text-align: center'>Vehicle Reading</th>"+
	  					"<th style='text-align: center'>Qty In Litres(s)</th>"+
	  					"<th style='text-align: center'>Expenses Type</th>"+
	  					"<th style='text-align: center'>Debtor Type</th>"+
	  					"<th style='text-align: center'>Cheque Details</th>"+
	  					"<th style='text-align: center'>Bank Info</th>"+
	  					"<th style='text-align: center'>Reason</th>"+
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
	  					var reportFirstDate=document.getElementById("fromDate").value.split("-")[2]+"-"+document.getElementById("fromDate").value.split("-")[1]+"-"+document.getElementById("fromDate").value.split("-")[0];
	  					var reportLastDate=document.getElementById("toDate").value.split("-")[2]+"-"+document.getElementById("toDate").value.split("-")[1]+"-"+document.getElementById("toDate").value.split("-")[0];
	  					document.getElementById("wholeDataList").innerHTML=a;
	  					document.getElementById("reportDetails").innerHTML="<span style='color:#f73838'>PAYMENT STATEMENT</span> REPORT FROM: <span style='color:#f73838'>"+reportFirstDate +"</span> TO: <span style='color:#f73838'>"+ reportLastDate+"</span>";
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
				"<tr><th colspan='11' id='reportDetails' style='font-size:15px;text-align:center'></th></tr>"+
				"<tr><th style='text-align: center'>S.No.</th>"+
				"<th style='width:80px;text-align:center'>Date</th>"+
				"<th style='text-align: center'>Amount</th>"+
				"<th style='text-align: center'>Payment Mode</th>"+
				"<th style='text-align: center'>Vehicle Reading</th>"+
				"<th style='text-align: center'>Qty In Litres(s)</th>"+
				"<th style='text-align: center'>Expenses Type</th>"+
				"<th style='text-align: center'>Debtor Type</th>"+
				"<th style='text-align: center'>Cheque Details</th>"+
				"<th style='text-align: center'>Bank Info</th>"+
				"<th style='text-align: center'>Reason</th>"+
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
				var reportFirstDate=document.getElementById("fromDate").value.split("-")[2]+"-"+document.getElementById("fromDate").value.split("-")[1]+"-"+document.getElementById("fromDate").value.split("-")[0];
				var reportLastDate=document.getElementById("toDate").value.split("-")[2]+"-"+document.getElementById("toDate").value.split("-")[1]+"-"+document.getElementById("toDate").value.split("-")[0];
				
				document.getElementById("reportDetails").innerHTML="<span style='color:#f73838'>"+document.getElementById("reportType").value+"</span> REPORT OF: <span style='color:#f73838'>"+document.getElementById("individualName").value+"</span> FROM: <span style='color:#f73838'>"+reportFirstDate +"</span> TO: <span style='color:#f73838'>"+ reportLastDate+"</span>";
				
				}
			}
				
			};
		xhttp.open("POST", "/SAMERP/Expenses.do?getDateData=1&individualName="+name+"&fromDate="+firstDate+"&toDate="+lastDate, true);
		xhttp.send();
     }
     //single contractor Data
     function getSingleContData()
     {
    	var firstDate=document.getElementById("fromDate").value;
   		var lastDate=document.getElementById("toDate").value;
     	var contName=document.getElementById("individualName").value;
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var demoStr = this.responseText.split(",");
				if(demoStr[0]==0)
					document.getElementById("wholeDataList").innerHTML="<tr><td colspan='13'>No Records Found!</td></tr>"
				else
				{
				var a="<thead><tr>"+
			    "<tr><th colspan='13' id='reportDetails' style='font-size:15px;text-align:center'></th></tr>"+
			 	"<th>S.No.</th>"+
			    "<th>Paid Date</th>"+
				"<th>From-Date</th>"+
				"<th>To Date</th>"+
				"<th>Loading Charges</th>"+
				"<th>Deposit</th>"+
				"<th>Work Amount</th>"+
				"<th>Total Bill Amount</th>"+
				"<th>Paid Amount</th>"+
				"<th>Mode</th>"+
				"<th>Cheque Details</th>"+
				"<th>Bank Info</th>"+
				"<th>Balance</th></tr></thead><tbody>";
				var count=1;
				for(var i=0;i<demoStr.length-2;i=i+14)
					{
					 a+= "<tr>"+
					"<td style='text-align: center'>"+count+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+1]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+3]+"</td>"+
					"<td style='text-align: center' >"+demoStr[i+4]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+5]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+6]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+7]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+8]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+9]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+10]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+11]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+12]+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+12]+"</td>"+
					"<tr>";
					count++;
					}
				a+="</tbody>";
				document.getElementById("wholeDataList").innerHTML=a; 
				var reportFirstDate=document.getElementById("fromDate").value.split("-")[2]+"-"+document.getElementById("fromDate").value.split("-")[1]+"-"+document.getElementById("fromDate").value.split("-")[0];
				var reportLastDate=document.getElementById("toDate").value.split("-")[2]+"-"+document.getElementById("toDate").value.split("-")[1]+"-"+document.getElementById("toDate").value.split("-")[0];
				
				document.getElementById("reportDetails").innerHTML="<span style='color:#f73838'>"+document.getElementById("reportType").value+
				"</span> REPORT OF: <span style='color:#f73838'>"+document.getElementById("individualName").value+
				"</span> FROM: <span style='color:#f73838'>"+reportFirstDate +"</span> TO: <span style='color:#f73838'>"+
				reportLastDate+"</span>";
				}
			
			}
				
			};
		xhttp.open("POST", "/SAMERP/ContractorPayment?getDateData=1&fromDate="+firstDate+"&toDate="+lastDate+"&contName="+contName, true);
		xhttp.send();
    	 
     }
     function getContData(){
    	var firstDate=document.getElementById("fromDate").value;
    	var lastDate=document.getElementById("toDate").value;
 		var xhttp;
 		xhttp = new XMLHttpRequest();
 		xhttp.onreadystatechange = function() {
 			if (this.readyState == 4 && this.status == 200) {
 				var demoStr = this.responseText.split(",");
 				if(demoStr[0]==0)
 					document.getElementById("wholeDataList").innerHTML="<tr><td colspan='14'>No Records Found!</td></tr>"
 				else
 				{
 				var a="<thead><tr>"+
 			    "<tr><th colspan='14' id='reportDetails' style='font-size:15px;text-align:center'></th></tr>"+
 			 	"<th>S.No.</th>"+
 			 	"<th>Contractor</th>"+
 			    "<th>Paid Date</th>"+
 				"<th>From-Date</th>"+
 				"<th>To Date</th>"+
 				"<th>Loading Charges</th>"+
 				"<th>Deposit</th>"+
 				"<th>Work Amount</th>"+
 				"<th>Total Bill Amount</th>"+
 				"<th>Paid Amount</th>"+
 				"<th>Mode</th>"+
 				"<th>Cheque Details</th>"+
 				"<th>Bank Info</th>"+
 				"<th>Balance</th></tr></thead><tbody>";
 				var count=1;
 				for(var i=0;i<demoStr.length-2;i=i+14)
 					{
 					 a+= "<tr>"+
 					"<td style='text-align: center'>"+count+"</td>"+
 					"<td style='text-align: center'>"+demoStr[i+1]+"</td>"+
 					"<td style='text-align: center'>"+demoStr[i+2]+"</td>"+
 					"<td style='text-align: center'>"+demoStr[i+3]+"</td>"+
 					"<td style='text-align: center' >"+demoStr[i+4]+"</td>"+
 					"<td style='text-align: center'>"+demoStr[i+5]+"</td>"+
 					"<td style='text-align: center'>"+demoStr[i+6]+"</td>"+
 					"<td style='text-align: center'>"+demoStr[i+7]+"</td>"+
 					"<td style='text-align: center'>"+demoStr[i+8]+"</td>"+
 					"<td style='text-align: center'>"+demoStr[i+9]+"</td>"+
 					"<td style='text-align: center'>"+demoStr[i+10]+"</td>"+
 					"<td style='text-align: center'>"+demoStr[i+11]+"</td>"+
 					"<td style='text-align: center'>"+demoStr[i+12]+"</td>"+
 					"<td style='text-align: center'>"+demoStr[i+13]+"</td>"+
 					"<tr>";
 					count++;
 					}
 				a+="</tbody>";
 				document.getElementById("wholeDataList").innerHTML=a; 
 				var reportFirstDate=document.getElementById("fromDate").value.split("-")[2]+"-"+document.getElementById("fromDate").value.split("-")[1]+"-"+document.getElementById("fromDate").value.split("-")[0];
 				var reportLastDate=document.getElementById("toDate").value.split("-")[2]+"-"+document.getElementById("toDate").value.split("-")[1]+"-"+document.getElementById("toDate").value.split("-")[0];
 				
 				document.getElementById("reportDetails").innerHTML="<span style='color:#f73838'>"+document.getElementById("reportType").value+
 				"</span> REPORT OF: <span style='color:#f73838'>"+document.getElementById("individualName").value+
 				"</span> FROM: <span style='color:#f73838'>"+reportFirstDate +"</span> TO: <span style='color:#f73838'>"+
 				reportLastDate+"</span>";
 				}
 			
 			}
 				
 			};
 		xhttp.open("POST", "/SAMERP/ContractorPayment?getDateData=1&fromDate="+firstDate+"&toDate="+lastDate+"&wholeData=1", true);
 		xhttp.send();
     	 
    	 
     }
	//--------------------ends (vijay)-----------------------
	

	
	//----------------------Start(Omkar)----------------------
	
	function getBankData()
	{
		var firstDate=document.getElementById("fromDate").value;
 		var lastDate=document.getElementById("toDate").value;
 		var xhttp;
	  	xhttp = new XMLHttpRequest();
	  	xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var demoStr = this.responseText.split(",");
					
					if(demoStr=="")
						document.getElementById("wholeDataList").innerHTML="<tr><td colspan='8'>No Records Found!</td></tr>"
					else{
						
						var a="<thead>"+
						"<tr><th colspan='8' id='reportDetails' style='font-size:15px;text-align:center'></th></tr>"+
						"<tr><th style='text-align: center'>S.No.</th>"+
						"<th style='width:80px;text-align:center'>Date</th>"+
						"<th style='text-align: center'>Bank Name</th>"+
						"<th style='text-align: center'>Debit</th>"+
						"<th style='text-align: center'>Credit</th>"+
						"<th style='text-align: center'>Reason</th>"+
						"<th style='text-align: center'>Paid/Received From</th>"+
						"<th style='text-align: center'>Balance</th>"+
						"</tr></thead><tbody>";
						
						var count=1;
	  					for(var i=0;i<demoStr.length-2;i=i+7)
	  						{
		  						 a+= "<tr>"+
		  						"<td style='text-align: center'>"+count+"</td>"+
		  						"<td style='text-align: center'>"+demoStr[i]+"</td>"+
		  						"<td style='text-align: center'>"+demoStr[i+1]+"</td>"+
		  						"<td style='text-align: center'>"+demoStr[i+2]+"</td>"+
		  						"<td style='text-align: center'>"+demoStr[i+3]+"</td>"+
		  						"<td style='text-align: center'>"+demoStr[i+4]+"</td>"+
		  						"<td style='text-align: center'>"+demoStr[i+5]+"</td>"+
		  						"<td style='text-align: center'>"+demoStr[i+6]+"</td>"+
		  						"<tr>";
		  						count++;
	  						}
	  					a+="</tbody>";
	  					
	  					var reportFirstDate=document.getElementById("fromDate").value.split("-")[2]+"-"+document.getElementById("fromDate").value.split("-")[1]+"-"+document.getElementById("fromDate").value.split("-")[0];
	  					var reportLastDate=document.getElementById("toDate").value.split("-")[2]+"-"+document.getElementById("toDate").value.split("-")[1]+"-"+document.getElementById("toDate").value.split("-")[0];
	  					document.getElementById("wholeDataList").innerHTML=a;
	  					document.getElementById("reportDetails").innerHTML="<span style='color:#f73838'>"+document.getElementById("reportType").value+"</span> REPORT FROM: <span style='color:#f73838'>"+reportFirstDate +"</span> TO: <span style='color:#f73838'>"+ reportLastDate+"</span>";

	  					//alert(demoStr);
					}
				}
	  		};
			
	  		xhttp.open("POST", "/SAMERP/AddAccountDetails?getDateData=1&fromDate="+firstDate+"&toDate="+lastDate, true);
			xhttp.send();
	  	
	  		
		//alert('all working');
	}
  function getBankDataByName()
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
						document.getElementById("wholeDataList").innerHTML="<tr><td colspan='7'>No Records Found!</td></tr>"
					else{
						
						var a="<thead>"+
						"<tr><th colspan='7' id='reportDetails' style='font-size:15px;text-align:center'></th></tr>"+
						"<tr><th style='text-align: center'>S.No.</th>"+
						"<th style='width:80px;text-align:center'>Date</th>"+
						"<th style='text-align: center'>Debit</th>"+
						"<th style='text-align: center'>Credit</th>"+
						"<th style='text-align: center'>Reason</th>"+
						"<th style='text-align: center'>Paid/Received From</th>"+
						"<th style='text-align: center'>Balance</th>"+
						"</tr></thead><tbody>";
						
						var count=1;
	  					for(var i=0;i<demoStr.length-2;i=i+6)
	  						{
		  						 a+= "<tr>"+
		  						"<td style='text-align: center'>"+count+"</td>"+
		  						"<td style='text-align: center'>"+demoStr[i]+"</td>"+
		  						"<td style='text-align: center'>"+demoStr[i+1]+"</td>"+
		  						"<td style='text-align: center'>"+demoStr[i+2]+"</td>"+
		  						"<td style='text-align: center'>"+demoStr[i+3]+"</td>"+
		  						"<td style='text-align: center'>"+demoStr[i+4]+"</td>"+
		  						"<td style='text-align: center'>"+demoStr[i+5]+"</td>"+
		  						"<tr>";
		  						count++;
	  						}
	  					a+="</tbody>";
	  					
	  					document.getElementById("wholeDataList").innerHTML=a;
	  					var reportFirstDate=document.getElementById("fromDate").value.split("-")[2]+"-"+document.getElementById("fromDate").value.split("-")[1]+"-"+document.getElementById("fromDate").value.split("-")[0];
	  					var reportLastDate=document.getElementById("toDate").value.split("-")[2]+"-"+document.getElementById("toDate").value.split("-")[1]+"-"+document.getElementById("toDate").value.split("-")[0];
	  					document.getElementById("reportDetails").innerHTML="<span style='color:#f73838'>"+document.getElementById("reportType").value+"</span> REPORT OF: <span style='color:#f73838'>"+document.getElementById("individualName").value+"</span> FROM: <span style='color:#f73838'>"+reportFirstDate +"</span> TO: <span style='color:#f73838'>"+ reportLastDate+"</span>";
	  					
						//alert(demoStr);
					}

	
				}
	  		};

	  		xhttp.open("POST", "/SAMERP/AddAccountDetails?getDateData=1&individualName="+name+"&fromDate="+firstDate+"&toDate="+lastDate, true);
			xhttp.send();
    	
    	
		//alert('individual working');
	}
  
  function getHandLoanData()
  {
	  //alert('all working');
	var firstDate=document.getElementById("fromDate").value;
	var lastDate=document.getElementById("toDate").value;
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var demoStr = this.responseText.split(",");
			
			if(demoStr=="")
				document.getElementById("wholeDataList").innerHTML="<tr><td colspan='8'>No Records Found!</td></tr>"
			else{
				
				var a="<thead>"+
				"<tr><th colspan='8' id='reportDetails' style='font-size:15px;text-align:center'></th></tr>"+
				"<tr><th style='text-align: center'>S.No.</th>"+
				"<th style='width:80px;text-align:center'>Date</th>"+
				"<th style='text-align: center'>HandLoan Name</th>"+
				"<th style='text-align: center'>Debit</th>"+
				"<th style='text-align: center'>Credit</th>"+
				"<th style='text-align: center'>Mode</th>"+
				"<th style='text-align: center'>Particulars</th>"+
				"<th style='text-align: center'>Balance</th>"+
				"</tr></thead><tbody>";
				
				var count=1;
					for(var i=0;i<demoStr.length-2;i=i+7)
						{
  						 a+= "<tr>"+
  						"<td style='text-align: center'>"+count+"</td>"+
  						"<td style='text-align: center'>"+demoStr[i]+"</td>"+
  						"<td style='text-align: center'>"+demoStr[i+1]+"</td>"+
  						"<td style='text-align: center'>"+demoStr[i+2]+"</td>"+
  						"<td style='text-align: center'>"+demoStr[i+3]+"</td>"+
  						"<td style='text-align: center'>"+demoStr[i+4]+"</td>"+
  						"<td style='text-align: center'>"+demoStr[i+5]+"</td>"+
  						"<td style='text-align: center'>"+demoStr[i+6]+"</td>"+
  						"<tr>";
  						count++;
						}
					a+="</tbody>";
					
					var reportFirstDate=document.getElementById("fromDate").value.split("-")[2]+"-"+document.getElementById("fromDate").value.split("-")[1]+"-"+document.getElementById("fromDate").value.split("-")[0];
					var reportLastDate=document.getElementById("toDate").value.split("-")[2]+"-"+document.getElementById("toDate").value.split("-")[1]+"-"+document.getElementById("toDate").value.split("-")[0];
					document.getElementById("wholeDataList").innerHTML=a;
					document.getElementById("reportDetails").innerHTML="<span style='color:#f73838'>"+document.getElementById("reportType").value+"</span> REPORT FROM: <span style='color:#f73838'>"+reportFirstDate +"</span> TO: <span style='color:#f73838'>"+ reportLastDate+"</span>";

					//alert(demoStr);
			}
		}
		};
	
		xhttp.open("POST", "/SAMERP/PTCash?getDateData=1&fromDate="+firstDate+"&toDate="+lastDate, true);
		xhttp.send();

}
  function getHandLoanByName()
  {
	  //alert('indi working');
	var firstDate=document.getElementById("fromDate").value;
	var lastDate=document.getElementById("toDate").value;
  	var name=document.getElementById("individualName").value;
  	
  	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var demoStr = this.responseText.split(",");
			
			if(demoStr=="")
				document.getElementById("wholeDataList").innerHTML="<tr><td colspan='7'>No Records Found!</td></tr>"
			else{
				
				var a="<thead>"+
				"<tr><th colspan='7' id='reportDetails' style='font-size:15px;text-align:center'></th></tr>"+
				"<tr><th style='text-align: center'>S.No.</th>"+
				"<th style='width:80px;text-align:center'>Date</th>"+
				"<th style='text-align: center'>Debit</th>"+
				"<th style='text-align: center'>Credit</th>"+
				"<th style='text-align: center'>Mode</th>"+
				"<th style='text-align: center'>Particulars</th>"+
				"<th style='text-align: center'>Balance</th>"+
				"</tr></thead><tbody>";
				
				var count=1;
					for(var i=0;i<demoStr.length-2;i=i+6)
						{
  						 a+= "<tr>"+
  						"<td style='text-align: center'>"+count+"</td>"+
  						"<td style='text-align: center'>"+demoStr[i]+"</td>"+
  						"<td style='text-align: center'>"+demoStr[i+1]+"</td>"+
  						"<td style='text-align: center'>"+demoStr[i+2]+"</td>"+
  						"<td style='text-align: center'>"+demoStr[i+3]+"</td>"+
  						"<td style='text-align: center'>"+demoStr[i+4]+"</td>"+
  						"<td style='text-align: center'>"+demoStr[i+5]+"</td>"+
  						"<tr>";
  						count++;
						}
					a+="</tbody>";
					
					document.getElementById("wholeDataList").innerHTML=a;
  					var reportFirstDate=document.getElementById("fromDate").value.split("-")[2]+"-"+document.getElementById("fromDate").value.split("-")[1]+"-"+document.getElementById("fromDate").value.split("-")[0];
  					var reportLastDate=document.getElementById("toDate").value.split("-")[2]+"-"+document.getElementById("toDate").value.split("-")[1]+"-"+document.getElementById("toDate").value.split("-")[0];
  					document.getElementById("reportDetails").innerHTML="<span style='color:#f73838'>"+document.getElementById("reportType").value+"</span> REPORT OF: <span style='color:#f73838'>"+document.getElementById("individualName").value+"</span> FROM: <span style='color:#f73838'>"+reportFirstDate +"</span> TO: <span style='color:#f73838'>"+ reportLastDate+"</span>";
  					
					//alert(demoStr);
			}
		}
		};
	
		xhttp.open("POST", "/SAMERP/PTCash?getDateData=1&individualName="+name+"&fromDate="+firstDate+"&toDate="+lastDate, true);
		xhttp.send();
  	
  }
  
  function getSupplierData()
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
					"<tr><th colspan='10' id='reportDetails' style='font-size:15px;text-align:center'></th></tr>"+
					"<tr><th style='text-align: center'>S.No.</th>"+
					"<th style='width:80px;text-align:center'>Date</th>"+
					"<th style='text-align: center'>Supplier Name</th>"+
					"<th style='text-align: center'>Bill No</th>"+
					"<th style='text-align: center'>Bill Amount</th>"+
					"<th style='text-align: center'>Paid Amount</th>"+
					"<th style='text-align: center'>Mode</th>"+
					"<th style='text-align: center'>Cheque No</th>"+
					"<th style='text-align: center'>Bank Details</th>"+
					"<th style='text-align: center'>Total Remaining</th>"+
					"</tr></thead><tbody>";
					
					var count=1;
					var billNo="";
					var mode="";
					var chqNo="";
					var bDetails="";
						for(var i=0;i<demoStr.length-2;i=i+9)
							{
								if(demoStr[i+2]=="null")
								{
									billNo="-";		
								}
								else
								{
									billNo=demoStr[i+2];
								}
								//
								if(demoStr[i+5]=="null")
								{
									mode="-";	
								}
								else
								{
									mode=demoStr[i+5];	
								}
								//
								if(demoStr[i+6]=="null")
								{
									chqNo="-";
								}
								else
								{
									chqNo=demoStr[i+6];
								}
								//
								if(demoStr[i+7]=="null")
								{
									bDetails="-";
								}
								else
								{
									bDetails=demoStr[i+7];
								}
	  						 a+= "<tr>"+
	  						"<td style='text-align: center'>"+count+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+1]+"</td>"+
	  						"<td style='text-align: center'>"+billNo+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+3]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+4]+"</td>"+
	  						"<td style='text-align: center'>"+mode+"</td>"+
	  						"<td style='text-align: center'>"+chqNo+"</td>"+
	  						"<td style='text-align: center'>"+bDetails+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+8]+"</td>"+
	  						"<tr>";
	  						count++;
							}
						a+="</tbody>";
						
						var reportFirstDate=document.getElementById("fromDate").value.split("-")[2]+"-"+document.getElementById("fromDate").value.split("-")[1]+"-"+document.getElementById("fromDate").value.split("-")[0];
						var reportLastDate=document.getElementById("toDate").value.split("-")[2]+"-"+document.getElementById("toDate").value.split("-")[1]+"-"+document.getElementById("toDate").value.split("-")[0];
						document.getElementById("wholeDataList").innerHTML=a;
						document.getElementById("reportDetails").innerHTML="<span style='color:#f73838'>"+document.getElementById("reportType").value+" OF SUPPLIER</span> REPORT FROM: <span style='color:#f73838'>"+reportFirstDate +"</span> TO: <span style='color:#f73838'>"+ reportLastDate+"</span>";

						//alert(demoStr);
				}
			}
			};
		
			xhttp.open("POST", "/SAMERP/RawSupplier?getDateData=1&fromDate="+firstDate+"&toDate="+lastDate, true);
			xhttp.send();

	
  }
  function getSingleSupplierData()
  {
	  //alert('indo working');  
	var firstDate=document.getElementById("fromDate").value;
	var lastDate=document.getElementById("toDate").value;
	var name=document.getElementById("individualName").value;
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var demoStr = this.responseText.split(",");
			if(demoStr=="")
				document.getElementById("wholeDataList").innerHTML="<tr><td colspan='9'>No Records Found!</td></tr>"
			else{
				
				var a="<thead>"+
				"<tr><th colspan='9' id='reportDetails' style='font-size:15px;text-align:center'></th></tr>"+
				"<tr><th style='text-align: center'>S.No.</th>"+
				"<th style='width:80px;text-align:center'>Date</th>"+
				"<th style='text-align: center'>Bill No</th>"+
				"<th style='text-align: center'>Bill Amount</th>"+
				"<th style='text-align: center'>Paid Amount</th>"+
				"<th style='text-align: center'>Mode</th>"+
				"<th style='text-align: center'>Cheque No</th>"+
				"<th style='text-align: center'>Bank Details</th>"+
				"<th style='text-align: center'>Total Remaining</th>"+
				"</tr></thead><tbody>";
				
				var count=1;
				var billNo="";
				var mode="";
				var chqNo="";
				var bDetails="";
					for(var i=0;i<demoStr.length-2;i=i+8)
						{
							if(demoStr[i+1]=="null")
							{
								billNo="-";		
							}
							else
							{
								billNo=demoStr[i+1];
							}
							//
							if(demoStr[i+4]=="null")
							{
								mode="-";	
							}
							else
							{
								mode=demoStr[i+4];	
							}
							//
							if(demoStr[i+5]=="null")
							{
								chqNo="-";
							}
							else
							{
								chqNo=demoStr[i+5];
							}
							//
							if(demoStr[i+6]=="null")
							{
								bDetails="-";
							}
							else
							{
								bDetails=demoStr[i+6];
							}
  						 a+= "<tr>"+
  						"<td style='text-align: center'>"+count+"</td>"+
  						"<td style='text-align: center'>"+demoStr[i]+"</td>"+
  						"<td style='text-align: center'>"+billNo+"</td>"+
  						"<td style='text-align: center'>"+demoStr[i+2]+"</td>"+
  						"<td style='text-align: center'>"+demoStr[i+3]+"</td>"+
  						"<td style='text-align: center'>"+mode+"</td>"+
  						"<td style='text-align: center'>"+chqNo+"</td>"+
  						"<td style='text-align: center'>"+bDetails+"</td>"+
  						"<td style='text-align: center'>"+demoStr[i+7]+"</td>"+
  						"<tr>";
  						count++;
						}
					a+="</tbody>";
					
					document.getElementById("wholeDataList").innerHTML=a;
  					var reportFirstDate=document.getElementById("fromDate").value.split("-")[2]+"-"+document.getElementById("fromDate").value.split("-")[1]+"-"+document.getElementById("fromDate").value.split("-")[0];
  					var reportLastDate=document.getElementById("toDate").value.split("-")[2]+"-"+document.getElementById("toDate").value.split("-")[1]+"-"+document.getElementById("toDate").value.split("-")[0];
  					document.getElementById("reportDetails").innerHTML="<span style='color:#f73838'>"+document.getElementById("reportType").value+" SUPPLIER</span> REPORT OF: <span style='color:#f73838'>"+document.getElementById("individualName").value+"</span> FROM: <span style='color:#f73838'>"+reportFirstDate +"</span> TO: <span style='color:#f73838'>"+ reportLastDate+"</span>";
  			//alert(demoStr);
			}
		}
		};
	
		xhttp.open("POST", "/SAMERP/RawSupplier?getDateData=1&individualName="+name+"&fromDate="+firstDate+"&toDate="+lastDate, true);
		xhttp.send();

	  	
  }
  function getRawPurchaseData()
  {
	  var firstDate=document.getElementById("fromDate").value;
		var lastDate=document.getElementById("toDate").value;
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var demoStr = this.responseText.split(",");
				
				if(demoStr=="")
					document.getElementById("wholeDataList").innerHTML="<tr><td colspan='7'>No Records Found!</td></tr>"
				else{
					
					var a="<thead>"+
					"<tr><th colspan='7' id='reportDetails' style='font-size:15px;text-align:center'></th></tr>"+
					"<tr><th style='text-align: center'>S.No.</th>"+
					"<th style='width:80px;text-align:center'>Date</th>"+
					"<th style='text-align: center'>Supplier Name</th>"+
					"<th style='text-align: center'>Chalan No</th>"+
					"<th style='text-align: center'>Vehicle No</th>"+
					"<th style='text-align: center'>Material</th>"+
					"<th style='text-align: center'>Quantity</th>"+
					"</tr></thead><tbody>";
					
					var count=1;
						for(var i=0;i<demoStr.length-2;i=i+6)
							{
	  						 a+= "<tr>"+
	  						"<td style='text-align: center'>"+count+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+1]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+2]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+3]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+4]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+5]+"</td>"+
	  						"<tr>";
	  						count++;
							}
						a+="</tbody>";
						
						var reportFirstDate=document.getElementById("fromDate").value.split("-")[2]+"-"+document.getElementById("fromDate").value.split("-")[1]+"-"+document.getElementById("fromDate").value.split("-")[0];
						var reportLastDate=document.getElementById("toDate").value.split("-")[2]+"-"+document.getElementById("toDate").value.split("-")[1]+"-"+document.getElementById("toDate").value.split("-")[0];
						document.getElementById("wholeDataList").innerHTML=a;
						document.getElementById("reportDetails").innerHTML="<span style='color:#f73838'>"+document.getElementById("reportType").value+"</span> REPORT FROM: <span style='color:#f73838'>"+reportFirstDate +"</span> TO: <span style='color:#f73838'>"+ reportLastDate+"</span>";

						//alert(demoStr);
				}
			}
			};
		
			xhttp.open("POST", "/SAMERP/PurchaseRawMaterial?getDateData=1&fromDate="+firstDate+"&toDate="+lastDate, true);
			xhttp.send();

	  //alert('all working');
  }
  function getRawPurchaseByName()
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
					document.getElementById("wholeDataList").innerHTML="<tr><td colspan='6'>No Records Found!</td></tr>"
				else{
					
					var a="<thead>"+
					"<tr><th colspan='6' id='reportDetails' style='font-size:15px;text-align:center'></th></tr>"+
					"<tr><th style='text-align: center'>S.No.</th>"+
					"<th style='width:80px;text-align:center'>Date</th>"+
					"<th style='text-align: center'>Chalan No</th>"+
					"<th style='text-align: center'>Vehicle No</th>"+
					"<th style='text-align: center'>Material</th>"+
					"<th style='text-align: center'>Quantity</th>"+
					"</tr></thead><tbody>";
					
					var count=1;
						for(var i=0;i<demoStr.length-2;i=i+5)
							{
	  						 a+= "<tr>"+
	  						"<td style='text-align: center'>"+count+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+1]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+2]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+3]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i+4]+"</td>"+
	  						"<tr>";
	  						count++;
							}
						a+="</tbody>";
						
						document.getElementById("wholeDataList").innerHTML=a;
	  					var reportFirstDate=document.getElementById("fromDate").value.split("-")[2]+"-"+document.getElementById("fromDate").value.split("-")[1]+"-"+document.getElementById("fromDate").value.split("-")[0];
	  					var reportLastDate=document.getElementById("toDate").value.split("-")[2]+"-"+document.getElementById("toDate").value.split("-")[1]+"-"+document.getElementById("toDate").value.split("-")[0];
	  					document.getElementById("reportDetails").innerHTML="<span style='color:#f73838'>"+document.getElementById("reportType").value+"</span> REPORT OF: <span style='color:#f73838'>"+document.getElementById("individualName").value+"</span> FROM: <span style='color:#f73838'>"+reportFirstDate +"</span> TO: <span style='color:#f73838'>"+ reportLastDate+"</span>";
	  					
						//alert(demoStr);
				}
			}
			};
		
			xhttp.open("POST", "/SAMERP/PurchaseRawMaterial?getDateData=1&individualName="+name+"&fromDate="+firstDate+"&toDate="+lastDate, true);
			xhttp.send();
		
	  //alert('indi working');
  }
  
	//----------------------End(Omkar)----------------------
	
  
  		//************************* SARANG *****************
	
	function getSaleData()
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
	  					"<tr><th colspan='11' id='reportDetails' style='font-size:15px;text-align: center'></th></tr>"+
	  					"<tr><th>S.No.</th>"+
	  					"<th style='text-align: center'>Client Name</th>"+
	  					"<th style='text-align: center'>Chalan No.</th>"+
	  					"<th style='width:80px;text-align: center'>Date</th>"+
	  					"<th style='text-align: center'>Vehicle No.</th>"+
	  					"<th style='text-align: center'>Deposit</th>"+
	  					"<th style='text-align: center'>Product Name</th>"+
	  					"<th style='text-align: center'>Qty</th>"+
	  					"<th style='text-align: center'>Rate</th>"+
	  					"<th style='text-align: center'>Supplier Name</th>"+
	  					"<th style='text-align: center'>Chalon No(TP)</th>"+
	  					"</tr></thead><tbody>";
	  					var count=1;
	  					for(var i=0;i<demoStr.length-1;)
	  					{
	  						var pCount=demoStr[i++];
	  						
	  						 a+= "<tr>"+
	  						"<td rowspan='"+pCount+"' style='text-align: center'>"+count+"</td>"+
	  						"<td rowspan='"+pCount+"' style='text-align: center'>"+demoStr[i++]+"</td>"+
	  						"<td rowspan='"+pCount+"' style='text-align: center'>"+demoStr[i++]+"</td>"+
	  						"<td rowspan='"+pCount+"' style='text-align: center'>"+demoStr[i++]+"</td>"+
	  						"<td rowspan='"+pCount+"' style='text-align: center' >"+demoStr[i++]+"</td>"+
	  						"<td rowspan='"+pCount+"' style='text-align: center'>"+demoStr[i++]+"</td>";
  						 
	  					a+="<td style='text-align: center'>"+demoStr[i++]+"</td>"+
	  						"<td style='text-align: center'' >"+demoStr[i++]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i++]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i++]+"</td>"+
	  						"<td style='text-align: center'>"+demoStr[i++]+"</td></tr>";
	  					
	  						for(var k=0; k<(pCount-1)*5;k+=5){
	  							
			  					 a+="<tr>"+
			  						"<td style='text-align: center'>"+demoStr[i++]+"</td>"+
			  						"<td style='text-align: center'' >"+demoStr[i++]+"</td>"+
			  						"<td style='text-align: center'>"+demoStr[i++]+"</td>"+
			  						"<td style='text-align: center'>"+demoStr[i++]+"</td>"+
			  						"<td style='text-align: center'>"+demoStr[i++]+"</td>";
	  						}
			  						
	  						
	  						
	  					 a+="</tr>";
	  						count++;
	  					}
	  					
	  					a+="</tbody>";
	  					var reportFirstDate=document.getElementById("fromDate").value.split("-")[2]+"-"+document.getElementById("fromDate").value.split("-")[1]+"-"+document.getElementById("fromDate").value.split("-")[0];
	  					var reportLastDate=document.getElementById("toDate").value.split("-")[2]+"-"+document.getElementById("toDate").value.split("-")[1]+"-"+document.getElementById("toDate").value.split("-")[0];
	  					document.getElementById("wholeDataList").innerHTML=a;
	  					document.getElementById("reportDetails").innerHTML="<span style='color:#f73838'>"+document.getElementById("reportType").value+"</span> REPORT FROM: <span style='color:#f73838'>"+reportFirstDate +"</span> TO: <span style='color:#f73838'>"+ reportLastDate+"</span>";
	  					}
	  					
	  				}
	  					
	  				};
	  			xhttp.open("POST", "/SAMERP/Sales?getDateData=1&fromDate="+firstDate+"&toDate="+lastDate, true);
	  			xhttp.send();
     }
	
	
    function getSaleDataByClient()
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
  					"<tr><th colspan='11' id='reportDetails' style='font-size:15px;text-align: center'></th></tr>"+
  					"<tr><th>S.No.</th>"+
  					"<th style='text-align: center'>Client Name</th>"+
  					"<th style='text-align: center'>Chalan No.</th>"+
  					"<th style='width:80px;text-align: center'>Date</th>"+
  					"<th style='text-align: center'>Vehicle No.</th>"+
  					"<th style='text-align: center'>Deposit</th>"+
  					"<th style='text-align: center'>Product Name</th>"+
  					"<th style='text-align: center'>Qty</th>"+
  					"<th style='text-align: center'>Rate</th>"+
  					"<th style='text-align: center'>Supplier Name</th>"+
  					"<th style='text-align: center'>Chalon No(TP)</th>"+
  					"</tr></thead><tbody>";
  					var count=1;
  					for(var i=0;i<demoStr.length-1;)
  					{
  						var pCount=demoStr[i++];
  						
  						 a+= "<tr>"+
  						"<td rowspan='"+pCount+"' style='text-align: center'>"+count+"</td>"+
  						"<td rowspan='"+pCount+"' style='text-align: center'>"+demoStr[i++]+"</td>"+
  						"<td rowspan='"+pCount+"' style='text-align: center'>"+demoStr[i++]+"</td>"+
  						"<td rowspan='"+pCount+"' style='text-align: center'>"+demoStr[i++]+"</td>"+
  						"<td rowspan='"+pCount+"' style='text-align: center' >"+demoStr[i++]+"</td>"+
  						"<td rowspan='"+pCount+"' style='text-align: center'>"+demoStr[i++]+"</td>";
						 
  					a+="<td style='text-align: center'>"+demoStr[i++]+"</td>"+
  						"<td style='text-align: center'' >"+demoStr[i++]+"</td>"+
  						"<td style='text-align: center'>"+demoStr[i++]+"</td>"+
  						"<td style='text-align: center'>"+demoStr[i++]+"</td>"+
  						"<td style='text-align: center'>"+demoStr[i++]+"</td></tr>";
  					
  						for(var k=0; k<(pCount-1)*5;k+=5){
  							
		  					 a+="<tr>"+
		  						"<td style='text-align: center'>"+demoStr[i++]+"</td>"+
		  						"<td style='text-align: center'' >"+demoStr[i++]+"</td>"+
		  						"<td style='text-align: center'>"+demoStr[i++]+"</td>"+
		  						"<td style='text-align: center'>"+demoStr[i++]+"</td>"+
		  						"<td style='text-align: center'>"+demoStr[i++]+"</td>";
  						}
	  					 a+="</tr>";
  						 count++;
  					}
  					
  					a+="</tbody>";
  					
  					document.getElementById("wholeDataList").innerHTML=a;
  					var reportFirstDate=document.getElementById("fromDate").value.split("-")[2]+"-"+document.getElementById("fromDate").value.split("-")[1]+"-"+document.getElementById("fromDate").value.split("-")[0];
  					var reportLastDate=document.getElementById("toDate").value.split("-")[2]+"-"+document.getElementById("toDate").value.split("-")[1]+"-"+document.getElementById("toDate").value.split("-")[0];			
  					document.getElementById("reportDetails").innerHTML="<span style='color:#f73838'>"+document.getElementById("reportType").value+"</span> REPORT OF: <span style='color:#f73838'>"+document.getElementById("individualName").value+"</span> FROM: <span style='color:#f73838'>"+reportFirstDate +"</span> TO: <span style='color:#f73838'>"+ reportLastDate+"</span>";

				}
			}
				
			};
		xhttp.open("POST", "/SAMERP/Sales?getDateData=1&individualName="+name+"&fromDate="+firstDate+"&toDate="+lastDate, true);
		xhttp.send();
     }
     

			//************************* SARANG END *****************
						
						
	
	

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
