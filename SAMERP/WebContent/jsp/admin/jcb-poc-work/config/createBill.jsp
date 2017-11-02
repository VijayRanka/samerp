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
	<div class="modal hide fade" id="createBill" role="dialog" style="width: 920px; margin-left: -460px;">
		<div class="modal-dialog">
			<div class="alert alert-info" style="padding-left: 180px;">
				<strong>Enter Party/Customer Name <span class="badge badge-info">OR</span> Contact No : </strong>
				<input list="browsers" name="browser" id="editdata"	onkeyup="CustomerSearch(this.value)" onkeydown="" autocomplete="off" required>
				<datalist id="browsers"></datalist>
			</div>
			<table style="margin: 0 auto;" id="createBillTable">
				<thead>
					<tr>
						<th  colspan="8"><h2 style="color: #ff704d">SAMRUDDHI EARTHMOVERS</h2></th>
					</tr>
					<tr>
						<th colspan="8"><h3>EARTH WORK CONTRACTORS</h3></th>
					</tr>
					<tr style="border-top: 1px; border-top-style: groove;">
						<th colspan="8">A/P-Naigaon(Shivalaya Bunglow),Tal-Haveli,Dist-Pune.Con-No:98814907070/9921267070 E-mail:sbchoudhari11@gmail.com</h2></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="6">To,</td>
						<td colspan="2">Bill No:</td>
					</tr>
					<tr>
					<td colspan="6"></td>
						<td colspan="2">Date:</td>
					</tr>
					<tr>
					<td colspan="6"></td>
						<td colspan="2">GSTIN:</td>
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
					<tr>
						<td>1</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>2</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>3</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<th colspan="4" style="text-align: right;">Total</th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
					</tr>
					<tr>
						<th colspan="4" style="text-align: right;">Rate</th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
					</tr>
					<tr>
						<th colspan="4" style="text-align: right;">Grand Total</th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
					</tr>
					<tr>
						<th colspan="5" style="text-align: right;">Bill Amount</th>
						<th></th>
						<th>(-)</th>
						<th>(-)</th>
					</tr>
					<tr>
						<th colspan="5" style="text-align: right;">CGST(9%)</th>
						<th></th>
						<th colspan="2" rowspan="2">Pay Amount</th>
					</tr>
					<tr>
						<th colspan="5" style="text-align: right;">SGST(9%)</th>
						<th></th>
					</tr>
					<tr>
						<th colspan="8" style="text-align: right; height: 70px;" valign="bottom">For Samruddhi Earthmovers</th>
					</tr>
				</tbody>
			</table>
			
			<br><br>
			<button id="btnPrint" onclick="printData()">Print Preview</button>
			
			
			
			<div class="modal-footer">
				<div class="form-actions">
							<button type="submit" name="insertorganizer"
								class="btn btn-success"
								style="float: right;">Submit</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ========================================Model End=========================================== -->
	
	<script type="text/javascript">
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
       '</style>';
	   htmlToPrint += divToPrint.outerHTML;
	   newWin= window.open("");
	   newWin.document.write(htmlToPrint);
	   newWin.print();
// 	   newWin.close();
	}
	</script>
	
	
	
	
	
	
	