<!DOCTYPE html>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="utility.RequireData"%>
<%@page import="utility.SysDate"%>
<html lang="en">
<head>
<title>SAMERP PROJECT</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/colorpicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />
<link rel="stylesheet" href="/SAMERP/config/css/select2.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-wysihtml5.css" />
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>

<style type="text/css">
#s2id_autogen3, #s2id_cust_project{
	float: inherit;
    margin-left: 615px;
    margin-top: -27px;
}
#DataTables_Table_0_length{
	width: 15%;
}
</style>
</head>
<body onload="setMonth()">

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
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				<a href="/SAMERP/dashboard.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> 
				<a href="/SAMERP/jsp/admin/jcb-poc-work/jcb_pokland_dashboard.jsp" title="Go to JCB & POKLAND Dashboard" class="tip-bottom">JCB & POKLAND Dashboard</a>  
				<a href="#" class="current">JCB & POKLAND Bill</a>
			</div>
			<h1>JCB & POKLAND Bill</h1>
		</div>
		<div class="container-fluid">
			<hr>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box" id="addWork" style="display: block;">
						<div class="alert alert-info">
							<var id="newBillEntry" style=" display: block; font-style: normal">
								<strong>Enter Customer Name <span class="badge badge-info">OR</span> Contact No : </strong>
								<input list="browsers" name="browser" id="editdata"	onkeyup="CustomerSearch(this.value)" onkeydown="CustomerPrint()" autocomplete="off" required>
								<datalist id="browsers"></datalist>
								<strong>Select Customer Project : </strong>
								<select	name="cust_project" id="cust_project" onchange="getCustomerBillData(this.value)" class="span3">
									<option></option>
								</select>
							</var>
							<var id="updateBillEntry" style="display: none; font-style: normal; height: 28px;">
								<h4>Update Bill</h4>
							</var>
							<a href="#createBill" data-toggle="modal" onclick="createBill()" class="btn btn-primary" style="float: right; margin-right: -20px; margin-top: -31px;">Create Bill</a>
							<strong style="float: right; margin-right: 170px; margin-top: -24px;">GST(%) : </strong>
							<input type="text" name="gst" id="gst" onkeyup="countTotalHr()" value="0" class="span1" style="float: right; margin-right: 100px; margin-top: -31px;">
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered table-striped with-check">
								<thead>
									<tr>
										<th><input type="checkbox" id="allCheck" onclick="checkAllBox()"> </th>
										<th>Date</th>
										<th>Challan No</th>
										<th>Bucket hr</th>
										<th>Breaker hr</th>
										<th>Deposit</th>
										<th>Diesel Amount</th>
									</tr>
								</thead>
								<tbody id="customerBillDetail">
								</tbody>
								<tbody>
									<tr>
										<th colspan="3" style="text-align: right;">Total</th>
										<th><label id="totalBucketHr"></label> </th>
										<th><label id="totalBreakerHr"></label></th>
										<th></th>
										<th></th>
									</tr>
									<tr>
										<th colspan="3" style="text-align: right;">Rate</th>
										<th><label id="bucketRate"></label> </th>
										<th><label id="breakerRate"></label></th>
										<th> <input type="hidden" id="rowCounter"> </th>
										<th></th>
									</tr>
									<tr>
										<th colspan="3" style="text-align: right;">Grand Total</th>
										<th><label id="bucketGrandTot"></label></th>
										<th><label id="breakerGrandTot"></label></th>
										<th><label id="depositGrandTot"></label></th>
										<th><label id="dieselGrandTot"></label></th>
									</tr>
									<tr>
										<th colspan="4" style="text-align: right;">Bill Amount</th>
										<th><label id="billAmount"></label> </th>
										<th>(-)</th>
										<th>(-)</th>
									</tr>
									<tr>
										<th colspan="4" style="text-align: right;">CGST(<var id="cgstPer">0</var>%)</th>
										<th><label id="cgst"></label></th>
										<th colspan="2" rowspan="2">Pay Amount <br> <span class="label label-success" id="payAmt" style="font-size: large;"></span></th>
									</tr>
									<tr>
										<th colspan="4" style="text-align: right;">SGST(<var id="sgstPer">0</var>%)</th>
										<th><label id="sgst"></label></th>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					
				</div>
			</div>

<!-- ============================================== DATA TABLE ================================================ -->
			<div class="row-fluid">
				<div class="span12">

					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"><i class="icon-th"></i></span>
							<h5>Data table</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered data-table">
								<div class="controls"style="float: right;position: relative;right: 280px;">
					              <span  style="position: relative;bottom: 5px;">
					              	<b>From Date:</b>
					              </span>
					               	<input type="date" name="" id="dataTableFrom" data-date-format="dd-mm-yyyy" value="" onchange="getDataForTable()" onclick="getDataForTable()">
					               	<b>To Date:</b>
					               	<input type="date" name="" id="dataTableTo" data-date-format="dd-mm-yyyy" value="" onchange="getDataForTable()" onclick="getDataForTable()">
					            </div> 
								<thead>
									<tr>
										<th>Sr No</th>
										<th>Bill No</th>
										<th>Customer Name</th>
										<th>Date</th>
										<th>Amount</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody id="jcbpocDataTable">
								</tbody>
								
							</table>
						</div>
					</div>

				</div>
			</div>
<!-- ============================================== END DATA TABLE ================================================ -->
		</div>
	</div>
		
<!-- ============================================== CREATE BILL MODAL ================================================ -->
	<div id="createBill" class="modal hide fade" role="dialog" style="width: 65%; margin-left: -28%;">
		<div class="modal-dialog">
			<div class="modal-header" style="height: 30px;">
				<h4 class="modal-title">Create Customer Bill</h4>
			</div>
			<div class="modal-content">
				<div class="modal-body">
					<jsp:include page="config/createBill.jsp"></jsp:include>
				</div>
			</div>
			<div class="modal-footer" style="padding-left: 450px">
				<button type="submit" name="save" onclick="submintBill()" class="btn btn-success">Create</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
	<!-- ============================================== END CREATE BILL MODAL ================================================ -->
	
	
	
	<div class="row-fluid">
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a
				href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
	</div>

	<!--end-Footer-part-->
	<script type="text/javascript">
// 	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@DATA TABLE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	function setMonth() {
		var thisYear = new Date().getFullYear();
		var thisMonth = new Date().getMonth();
		thisMonth=thisMonth+1;
		document.getElementById("dataTableFrom").value =thisYear+"-"+thisMonth+"-"+"01";
		document.getElementById("dataTableTo").value =thisYear+"-"+thisMonth+"-"+"30";
		getDataForTable();
	}
	function getDataForTable() {
		var fromDate=document.getElementById("dataTableFrom").value;
		var toDate=document.getElementById("dataTableTo").value;
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var demoStr = this.responseText.split("~");
				if(demoStr=="")
				document.getElementById("jcbpocDataTable").innerHTML="<tr><	td colspan='10'>No Records Found!</td></tr>"
				else{
					var count=1;
					var wholeData="";
					
					for(var i=0;i<demoStr.length-2;i=i+5){
							
						wholeData+="<tr>"+
						"<td style=\"width: 32px;\">"+count+"</td>"+
						"<td>"+demoStr[i]+"</td>";
						
						var billNo=demoStr[i];
						var custId=demoStr[i+1];
						
						wholeData+="<td><var id=\"custId"+billNo+"\" style=\"visibility: hidden;\"></var><var id=\"custNameUpdate"+custId+""+billNo+"\" style=\"font-style: normal;\">"+demoStr[i+2]+"</var></td>"+
						"<td>"+demoStr[i+3]+"</td>"+
						"<td>"+demoStr[i+4]+"</td>"+
						"<td>"+"<a href=\"#update\" data-toggle='modal' onclick='getCustomerBillDataUpdate("+billNo+")'>Update</a> / <a href=\"/SAMERP/JcbPocDetails.do?deleteid="+billNo+"\">Delete</a></td>"+
						"<tr>";
						
						count++;
					}
				
				document.getElementById("jcbpocDataTable").innerHTML=wholeData;
				}
			}
		};
		xhttp.open("GET", "/SAMERP/JcbPocBill.do?fromDate=" + fromDate+"&toDate="+toDate, true);
		xhttp.send();
	}

//	 	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@END DATA TABLE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
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
		//********************************Print Project Data**************************
		function  CustomerPrint() {
			var val = document.getElementById('editdata').value;
		      var str = $('#browsers').find('option[value="' + val + '"]').attr('id');
		      var xhttp;
				if (str == "") {
					return;
				}
				if(event.keyCode == 13 || event.keyCode == 9) {
					xhttp = new XMLHttpRequest();
					try{ 
					xhttp.onreadystatechange = function() {
						if (this.readyState == 4 && this.status == 200) {
							document.getElementById("cust_project").innerHTML = "";
							var textf=document.getElementById("cust_project").innerHTML = "<option value=''></option>";
							var demoStr = this.responseText.split("~");
							var text = "";
							for (var i = 0; i < demoStr.length-1; i++) {
								text += "<option value="+demoStr[i]+">";
										i++;
								text += demoStr[i]+ "</option>";
							}
							
							document.getElementById("cust_project").innerHTML =textf + text;
						}

					};
					
					xhttp.open("POST", "/SAMERP/JcbPocBill.do?CustomerPoject=" + str, true);
					xhttp.send();
					}
					catch(e)
					{
						alert("Unable to connect to server");
					}     
			    }
		}
		//******************************************END Project Print******************************************************************
//************************************************ Customer Print ****************************************************************
function getCustomerBillData(str) {
			var xhttp;
			if (str == "") {
				return;
			}
			xhttp = new XMLHttpRequest();
			try {
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						document.getElementById("customerBillDetail").innerHTML ="";
						var demoStr = this.responseText.split("~");
						var text = "";
						var i = 0;
						var checkId;
						var j=1;
						for (; demoStr[i];) {
							text +="<tr><td><input type=\"checkbox\" id='chalanId"+j+"' onclick=\"countTotalHr()\"><input type=\"hidden\" id=\"jcbpocId"+j+"\" name=\"jcbpocId"+j+"\" value=\""+demoStr[i]+"\"> </td>";
							i++;
							text +="<td><label id=\"challanDate"+j+"\">"+demoStr[i]+"</label></td>";
							i++;
							text +="<td><label id=\"challanNo"+j+"\">"+demoStr[i]+"</label></td>";
							i++;
							text +="<td><label id=\"bucketHr"+j+"\">"+demoStr[i]+"</label></td>";
							i++;
							text +="<td><label id=\"breakerHr"+j+"\">"+demoStr[i]+"</label></td>";
							i++;
							text +="<td><label id=\"deposit"+j+"\">"+demoStr[i]+"</label></td>";
							i++;
							text +="<td><label id=\"diesel"+j+"\">"+demoStr[i]+"</label></td></tr>";
							i++;
							document.getElementById("bucketRate").innerHTML = demoStr[i];
							i++;
							document.getElementById("breakerRate").innerHTML = demoStr[i];
							i++;
							j++;
						}
						document.getElementById("customerBillDetail").innerHTML += text;
						document.getElementById("rowCounter").value=j;
						document.getElementById("allCheck").checked=true;
						checkAllBox();
						countTotalHr();
					}
				};
				xhttp.open("POST", "/SAMERP/JcbPocBill.do?projectId=" + str, true);
				xhttp.send();
			} catch (e) {
				alert("Unable to connect to server");
			}
}
		
function checkAllBox(){
	var str=document.getElementById("rowCounter").value;
	var allCheck=document.getElementById("allCheck");
	
	if(allCheck.checked === true){
		for(var i=1; i<str; i++){
			document.getElementById("chalanId"+i).checked = true;
		}
	}else{
		for(i=1; i<str; i++){
			var chackBox=document.getElementById("chalanId"+i).checked = false;
		}
	}
	countTotalHr();
}

function countTotalHr(){
	
	var str=document.getElementById("rowCounter").value;
	
	var totBucketHr=0;
	var totBucketMin=0;
	
	var totBreakerHr=0;
	var totBreakerMin=0;
	
	var grandTotDeposite=0;
	var grandTotDiesel=0;
	
	for(i=1; i<str; i++){
		var chackBox=document.getElementById("chalanId"+i);
		if(chackBox.checked === true){
			var getBucketHr=document.getElementById("bucketHr"+i).innerHTML.split(":");
			totBucketHr=parseInt(totBucketHr)+parseInt(getBucketHr[0]);
			totBucketMin=parseInt(totBucketMin)+parseInt(getBucketHr[1]);
			
			var getBreakerHr=document.getElementById("breakerHr"+i).innerHTML.split(":");
			totBreakerHr=parseInt(totBreakerHr)+parseInt(getBreakerHr[0]);
			totBreakerMin=parseInt(totBreakerMin)+parseInt(getBreakerHr[1]);
			
			//Deposit & Diesel Amount
			var getDeposit=document.getElementById("deposit"+i).innerHTML;
			if(getDeposit != ""){
				grandTotDeposite=parseInt(grandTotDeposite)+parseInt(getDeposit);	
			}
			
			var getDiesel=document.getElementById("diesel"+i).innerHTML;
			if(getDiesel != ""){
				grandTotDiesel=parseInt(grandTotDiesel)+parseInt(getDiesel);	
			}
		}
	}
	document.getElementById("totalBucketHr").innerHTML=totBucketHr+":"+totBucketMin;
	document.getElementById("totalBreakerHr").innerHTML=totBreakerHr+":"+totBreakerMin;
	
	document.getElementById("depositGrandTot").innerHTML=grandTotDeposite;
	document.getElementById("dieselGrandTot").innerHTML=grandTotDiesel;
	
	//GRAND TOTAL======================================================================
		var grandTotBucketMin=(totBucketHr*60)+totBucketMin;
		var bucketRateInMin=document.getElementById("bucketRate").innerHTML;
		bucketRateInMin=bucketRateInMin/60;
		
		var grandTotBucket=grandTotBucketMin*bucketRateInMin;
		var bucketRound=Math.round(grandTotBucket * 100) / 100;
		document.getElementById("bucketGrandTot").innerHTML=bucketRound;
		
		var grandTotBreakerMin=(totBreakerHr*60)+totBreakerMin;
		var breakerRateInMin=document.getElementById("breakerRate").innerHTML;
		breakerRateInMin=breakerRateInMin/60;
		
		var grandTotBreaker=grandTotBreakerMin*breakerRateInMin;
		var breakerRound=Math.round(grandTotBreaker * 100) / 100;
		document.getElementById("breakerGrandTot").innerHTML=breakerRound;
		
	//BILL AMOUNT========================================================================
		var billAmount=bucketRound + breakerRound;
		document.getElementById("billAmount").innerHTML=billAmount;
	
	//GST ================================================================================
		var gst=document.getElementById("gst").value;
		gst=gst/2;
		document.getElementById("cgstPer").innerHTML=gst;
		document.getElementById("sgstPer").innerHTML=gst;
		document.getElementById("cgstPerPrint").innerHTML=gst;
		document.getElementById("sgstPerPrint").innerHTML=gst;
		gst=gst/100;
		
	//CGST & SGST =======================================================================
		var cgst=Math.round((billAmount*gst) * 100) / 100;
		var sgst=Math.round((billAmount*gst) * 100) / 100;
		document.getElementById("cgst").innerHTML=cgst;
		document.getElementById("sgst").innerHTML=sgst;
	
	//PAY AMOUNT ========================================================================
		var payAmount=billAmount + cgst + sgst - grandTotDeposite - grandTotDiesel;
		document.getElementById("payAmt").innerHTML=payAmount;
		document.getElementById("payAmtPrintTxt").value=payAmount;
}

//*********************************************** End Customer Print**************************************************************
</script>
<jsp:include page="config/jcb-pocBillUpdate.jsp"></jsp:include>



	<script src="/SAMERP/config/js/jquery.min.js"></script>
	<script src="/SAMERP/config/js/jquery.ui.custom.js"></script>
	<script src="/SAMERP/config/js/bootstrap.min.js"></script>
	<script src="/SAMERP/config/js/bootstrap-colorpicker.js"></script>
	<script src="/SAMERP/config/js/bootstrap-datepicker.js"></script>
	<script src="/SAMERP/config/js/masked.js"></script>
	<script src="/SAMERP/config/js/jquery.uniform.js"></script>
	<script src="/SAMERP/config/js/select2.min.js"></script>
	<script src="/SAMERP/config/js/jquery.dataTables.min.js"></script>
	<script src="/SAMERP/config/js/matrix.js"></script>
	<script src="/SAMERP/config/js/matrix.tables.js"></script>
	<script src="/SAMERP/config/js/matrix.form_common.js"></script>
	<script src="/SAMERP/config/js/wysihtml5-0.3.0.js"></script>
	<script src="/SAMERP/config/js/jquery.peity.min.js"></script>
	<script src="/SAMERP/config/js/bootstrap-wysihtml5.js"></script>
	


</body>
</html>
