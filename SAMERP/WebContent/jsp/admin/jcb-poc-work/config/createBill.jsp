<style>
#createBillTable tbody {
	border: 1px;
	border-style: groove;
}
#createBillTable tbody tr td{
	border: 1px;
	border-style: groove;
}
#createBillTable tbody tr th{
	border: 1px;
	border-style: groove;
}
@media print
{
  table { page-break-after:auto }
  tr    { page-break-inside:avoid; page-break-after:auto }
  td    { page-break-inside:avoid; page-break-after:auto }
  thead { display:table-header-group }
  tfoot { display:table-footer-group }
}
@media print {
        table td, table th {
          border:block;
        }
</style>


<!--===================================== Model================================================== -->
		<form id="submitBill" action="/SAMERP/JcbPocBill.do" method="post">
			<table style="margin: 0 auto;" id="createBillTable">
				<thead>
					<tr>
						<th  colspan="8"><h2 style="color: #ff704d">SAMRUDDHI EARTHMOVERS</h2></th>
					</tr>
					<tr>
						<th colspan="8"><h3>EARTH WORK CONTRACTORS</h3></th>
					</tr>
					<tr style="border-top: 1px; border-top-style: groove;">
						<th colspan="8"><h6>A/P-Naigaon(Shivalaya Bunglow),Tal-Haveli,Dist-Pune.Con-No:98814907070/9921267070 E-mail:sbchoudhari11@gmail.com</h6></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="6">To,<var id="customerBill"></var><input type="hidden" id="customerInvoice" name="customerInvoice"></td>
						<td colspan="2">Bill No : <var id="billNo" style="font-weight: bold;"></var> <input type="hidden" id="invoiceId" name="invoiceId" value=""></td>
					</tr>
					<tr>
					<td colspan="6"><!-- Site:-<var id="projectBill"></var>  --></td>
						<td colspan="2">Date : <var id="billDate"></var> <input type="hidden" id="invoiceDate" name="invoiceDate"></td>
					</tr>
					<tr>
					<td colspan="6"></td>
						<td colspan="2">GSTIN : <var id="billGSTIN"></var> <input type="hidden" id="invoiceGSTIN" name="invoiceGSTIN"></td>
					</tr>
					<tr>
						<th>Sr.No</th>
						<th>Date</th>
						<th>Challan No</th>
						<th>HSN Code</th>
						<th>Bucket hr</th>
						<th>Breaker hr</th>
						<th>Deposit</th>
						<th>Diesel Amount</th>
					</tr>
				</tbody>
				<tbody id="customerBillDetailPrint">
					
				</tbody>
				<tbody>
					<tr>
						<th colspan="4" style="text-align: right;">Total</th>
						<th id="totalBucketHrPrint"></th>
						<th id="totalBreakerHrPrint"></th>
						<th><input type="hidden" id="rowCounterPrint" name="rowCounterPrint" value="0" > </th>
						<th></th>
					</tr>
					<tr>
						<th colspan="4" style="text-align: right;">Rate</th>
						<th id="bucketRatePrint"> </th>
						<th id="breakerRatePrint"></th>
						<th></th>
						<th></th>
					</tr>
					<tr>
						<th colspan="4" style="text-align: right;">Grand Total</th>
						<th id="bucketGrandTotPrint"></th>
						<th id="breakerGrandTotPrint"></th>
						<th id="depositGrandTotPrint"></th>
						<th id="dieselGrandTotPrint"></th>
					</tr>
					<tr>
						<th colspan="5" style="text-align: right;">Bill Amount</th>
						<th id="billAmountPrint"> </th>
						<th>(-)</th>
						<th>(-)</th>
					</tr>
					<tr>
						<th colspan="5" style="text-align: right;">CGST(9%)</th>
						<th id="cgstPrint"></th>
						<th colspan="2" rowspan="2">
							Pay Amount <br> 
							<span id="payAmtPrint" style="font-size: large;"></span>
							<input type="hidden" id="payAmtPrintTxt" name="payAmtPrintTxt">
						</th>
					</tr>
					<tr>
						<th colspan="5" style="text-align: right;">SGST(9%)</th>
						<th id="sgstPrint"></th>
					</tr>
					<tr>
						<th colspan="8" style="text-align: right; height: 70px;" valign="bottom">For Samruddhi Earthmovers</th>
					</tr>
				</tbody>
			</table>
		</form>
<!-- ========================================Model End=========================================== -->
	
	<script type="text/javascript">
	//============================================SUBMIT BILL======================================
	function submintBill(){
		printData();
		document.getElementById("submitBill").submit();
	}
	//============================================END SUBMIT BILL======================================
	//==========================================GET BILL NO============================================
	function getBillNo() {

		var today=new Date();
		var day = today.getDate();
		var month = today.getMonth()+1;
		var year = today.getFullYear();
		var todayIS=day+"-"+month+"-"+year;
		document.getElementById("billDate").innerHTML=todayIS;
		document.getElementById("invoiceDate").value = year+"-"+month+"-"+day;
		
		var val = document.getElementById('editdata').value;
	    var str = $('#browsers').find('option[value="' + val + '"]').attr('id');
	    document.getElementById("customerBill").innerHTML=val;
	    document.getElementById("customerInvoice").value = str;
	    
			
			var xhttp;
			xhttp = new XMLHttpRequest();
			try {
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						var demoStr = this.responseText.split("~");
						
						document.getElementById("billNo").innerHTML=demoStr[0];
						document.getElementById("invoiceId").value = demoStr[0];	
						
						document.getElementById("billGSTIN").innerHTML=demoStr[1];
					}

				};

				xhttp.open("POST", "/SAMERP/JcbPocBill.do?autoIncrement="+str, true);
				xhttp.send();
			} catch (e) {
				alert("Unable to connect to server");
			}
			
		   // document.getElementById("projectBill").innerHTML=document.getElementById("cust_project").innerHTML;
		}
	function getBillNoUpdate() {

		
	    var str =document.getElementById("invoiceId").value;
	    
	    
			
			var xhttp;
			xhttp = new XMLHttpRequest();
			try {
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						var demoStr = this.responseText.split("~");
						var updateDate = demoStr[0].split("-");
						document.getElementById("billDate").innerHTML=updateDate[2]+"-"+updateDate[1]+"-"+updateDate[0];
						//document.getElementById("invoiceDate").value = year+"-"+month+"-"+day;
						
						document.getElementById("customerBill").innerHTML=demoStr[2];
					    document.getElementById("customerInvoice").value = demoStr[1];
						
						document.getElementById("billGSTIN").innerHTML=demoStr[3]	;
					}

				};

				xhttp.open("POST", "/SAMERP/JcbPocBill.do?getInvoiceDataUpdate="+str, true);
				xhttp.send();
			} catch (e) {
				alert("Unable to connect to server");
			}
			
		   // document.getElementById("projectBill").innerHTML=document.getElementById("cust_project").innerHTML;
		}

//==================================================END BILL NO====================================
	//===============================================PRINT========================================
	function printData()
	{
	   var divToPrint=document.getElementById("createBillTable");
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
    	'}'+
    	'h2,h3,h6{'+
    		'margin:-3px 0;'+
    	'}'+
       '</style>';
	   htmlToPrint += divToPrint.outerHTML;
	   newWin= window.open("");
	   newWin.document.write(htmlToPrint);
	 //  newWin.print();
// 	   newWin.close();
	}
	//===================================End PRINT=================================================
	//===================================create Bill==============================================
		function createBill(){
			var billEntry=document.getElementById("newBillEntry").style.display;
			alert(billEntry);
			if(billEntry == "block"){
				getBillNo();
			}else {
				getBillNoUpdate();
			}
		
			document.getElementById("customerBillDetailPrint").innerHTML ="";
			var str=document.getElementById("rowCounter").value;
			var text = "";
			var checkId;
			var j=1;
				for(var i=1; i<str; i++){
					var chackBox=document.getElementById("chalanId"+i);
					if(chackBox.checked === true){
						text +="<tr><td>"+j+"<input type=\"hidden\" id=\"jcbpocIdPrint"+j+"\" name=\"jcbpocIdPrint"+j+"\" value=\""+document.getElementById("jcbpocId"+i).value+"\"></td>";
						text +="<td>"+document.getElementById("challanDate"+i).innerHTML+"</td>";
						text +="<td>"+document.getElementById("challanNo"+i).innerHTML+"</td>";
						text +="<td>123456</td>";
						text +="<td>"+document.getElementById("bucketHr"+i).innerHTML+"</td>";
						text +="<td>"+document.getElementById("breakerHr"+i).innerHTML+"</td>";
						text +="<td>"+document.getElementById("deposit"+i).innerHTML+"</td>";
						text +="<td>"+document.getElementById("diesel"+i).innerHTML+"</td>";
						j++;
					}
				}
				document.getElementById("customerBillDetailPrint").innerHTML += text;
				
				document.getElementById("totalBucketHrPrint").innerHTML=document.getElementById("totalBucketHr").innerHTML;
				document.getElementById("totalBreakerHrPrint").innerHTML=document.getElementById("totalBreakerHr").innerHTML;
				
				document.getElementById("bucketRatePrint").innerHTML = document.getElementById("bucketRate").innerHTML;
				document.getElementById("breakerRatePrint").innerHTML = document.getElementById("breakerRate").innerHTML;
				
				document.getElementById("depositGrandTotPrint").innerHTML=document.getElementById("depositGrandTot").innerHTML;
				document.getElementById("dieselGrandTotPrint").innerHTML=document.getElementById("dieselGrandTot").innerHTML;
				
				
				document.getElementById("bucketGrandTotPrint").innerHTML=document.getElementById("bucketGrandTot").innerHTML;
				document.getElementById("breakerGrandTotPrint").innerHTML=document.getElementById("breakerGrandTot").innerHTML;
				
				document.getElementById("billAmountPrint").innerHTML=document.getElementById("billAmount").innerHTML;
				
				document.getElementById("cgstPrint").innerHTML=document.getElementById("cgst").innerHTML;
				document.getElementById("sgstPrint").innerHTML=document.getElementById("sgst").innerHTML;
				
				document.getElementById("payAmtPrint").innerHTML=document.getElementById("payAmt").innerHTML;
				
				document.getElementById("rowCounterPrint").value=j;
		}
	//====================================end Create Bill=========================================
	</script>
	
	
	
	
	