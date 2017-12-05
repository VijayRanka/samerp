<%@page import="utility.SysDate"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="utility.RequireData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SAMERP PROJECT</title>

<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- <link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/colorpicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />
<link rel="stylesheet" href="/SAMERP/config/css/select2.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-wysihtml5.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bs_modal_transition.css" /> -->



<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link href="/SAMERP/config/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/colorpicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />
<link rel="stylesheet" href="/SAMERP/config/css/select2.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bs_modal_transition.css" />
<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
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

</style>
<body onload="myFunction()">

	<!--Header-part-->
	<div id="header">
		<h1>
			<a href="dashboard.html">Matrix Admin</a>
		</h1>
	</div>

	<!--start-top-serch-->
	<%
		if (request.getAttribute("status") != null) {
	%>
	<div id="snackbar"><%=request.getAttribute("status")%></div>
	<%
		}
	%>
	
	<%RequireData rq=new RequireData();%>
	
	<div id="search">
		<button type="submit" class="tip-bottom">LOGOUT</button>
	</div>
	<!--close-top-serch-->
	<!--sidebar-menu-->
	<jsp:include page="../common/left_navbar.jsp"></jsp:include>
	<!--sidebar-menu-->

	<!--main-container-part-->
	<div id="content">
		<!--breadcrumbs-->
		<div id="content-header">
			<div id="breadcrumb">
				<a href="/SAMERP/dashboard.jsp" class="tip-bottom"
					data-original-title="Go to Home"><i class="icon-home"> </i>
					Home</a> <a href="#" class="current">Petty Cash</a>
			</div>
		</div>
		<!--End-breadcrumbs-->
		<div class="container-fluid">
			<hr>
			<div class="row-fluid">
				<div class="span12">
				
		<div class="widget-box">
          <div class="widget-title">
            <ul class="nav nav-tabs" id="myTab">
              <li class="active"><a data-toggle="tab" href="#tab1">Petty Cash</a></li>
              <li><a data-toggle="tab" href="#tab2">Hand Loan Bank</a></li>
            </ul>
          </div>
          <div class="widget-content tab-content">
            <div id="tab1" class="tab-pane active">
            <!-- tab 1 start -->
					<div class="widget-box">
					<div class="widget-title">
							<span class="icon"> <i class="icon-align-justify"></i>
							</span>
							<h5>Petty Cash</h5>
						</div>
						
						<div class="widget-content nopadding">
							<form action="/SAMERP/PTCash" method="Post"
								class="form-horizontal" onsubmit="return validatePetty()">
								<div class="control-group">
									<label class="control-label">Date :</label>
									<div class="controls">
										<%
											SysDate date = new SysDate();
											String[] demo = date.todayDate().split("-");
											String requireddate = demo[2] + "-" + demo[1] + "-" + demo[0];
										%>
										<input type="date" name="date" value="<%=requireddate%>"
											class="span4">
											<input type="hidden" id="changeTab" value="<%=request.getAttribute("tab")%>">
									</div>
								</div>
								<%
								
								List list=rq.getPreviousBal();
								Iterator itr2=list.iterator();
								while(itr2.hasNext())
								{
									
									String pre_balance=itr2.next().toString();								
								%>

								<div class="control-group">
									<label class="control-label">Previous Balance:</label>
									<div class="controls">
										<input type="text" id="previous_balance" name="previous_balance" value="<%=pre_balance%>" class="span4" onkeyup="this.value=this.value.toUpperCase()"
											placeholder="Previous Balance" pattern="[0-9]*" readonly required />
									</div>
								</div>
								<%
								
								}
								
								%>
								

						<table id="HandLoan-details-table" style="margin-top: -10px;">
															
								<tr>
								
								<td><label class="control-label">Hand Loan:</label></td>
								<div class="controls controls-row">
           								 <td><input type="text"  list="getName" autocomplete="off" placeholder="HandLoan Name" id="hlName,0" name="hlName,0" <%if(request.getAttribute("hName")!=null) {%> value="<%=request.getAttribute("hName") %>" <%} %> onfocus="searchName(this.value)" style="width: 170px;margin-left:15px;margin-right: 10px;" class="span2"></td>
           								 <datalist id="getName"></datalist>
           								 <td><input type="text" name="hlAmt,0" id="hlAmt,0" <%if(request.getAttribute("amt")!=null) {%> value="<%=request.getAttribute("amt") %>" <%} %> placeholder="Amount" style="width: 100px;" class="span2">&nbsp;&nbsp;</td>
           								 <td><span class="badge badge-inverse" id="addH" onclick="InsertRow()"><i class="icon-plus"></i></span></td>
           								 <td>
           								 <div id="removeH" style="display: none;">
           								 <span class="badge badge-inverse" id="removeH" onclick="RemoveRow()"><i class="icon-minus"></i></span>
           								 </div></td>
           								 <td><a href="#paymentEntry" data-toggle="modal">
											<span class="badge badge-inverse">Add New HandLoan</span>
										 </a></td>
           							</div>
     						  
        						  
										<!-- <div class="controls" style="display:none;">
											<select name="entName" id="entName">
												<option></option>
											</select>
										</div> -->
								</tr>
						</table>
					
							
							<table id="bank-details-table" style="margin-top: -10px;">
															
								<tr>
								
								<td><label class="control-label">ATM Cash:</label></td>
								<div class="controls controls-row">
           								<td> <input type="text"  list="getBankName" autocomplete="off" placeholder="Bank Name" id="bName,0" name="bName,0" <%if(request.getAttribute("bName")!=null) {%> value="<%=request.getAttribute("bName") %>" <%} %> onfocus="searchBankName(this.value)" style="width: 170px;margin-left:15px;margin-right: 10px;" class="span2"></td>
           								 <datalist id="getBankName"></datalist>
           								 <td><input type="text" name="bAmt,0" id="bAmt,0" <%if(request.getAttribute("bAmt")!=null) {%> value="<%=request.getAttribute("bAmt") %>" <%} %> placeholder="Amount" style="width: 100px;" class="span2">&nbsp;&nbsp;</td>
           								 
           								 
           								 	 <td><span class="badge badge-inverse" id="addB" onclick="InsertBankRow()"><i class="icon-plus"></i></span></td>
	           								 <td><div id="removeBank" style="display: none;">
	           								 	<span class="badge badge-inverse"  id="removeB" onclick="RemoveBankRow()"><i class="icon-minus"></i></span>
	           								 </div></td>
	           							
           						 	</div>
        						  
        						  
								</tr>
						</table>
							
						
	
								<div class="control-group">
									<div class="controls">
										<input type="hidden" class="span4" name="count" id="count" placeholder="Total" value="0" readonly />
										<input type="hidden" class="span4" name="bankCount" id="bankCount" placeholder="Total" value="0" readonly />
										<span class="help-inline error" id="validationError" style="color: red; font-weight: bold;	float: center;"></span>
									</div>
								</div>

								<!-- <div class="control-group">
									<label class="control-label">Total:</label>
									<div class="controls">
										<input type="text" id="tAmt" class="span4" name="total" placeholder="Total" required />
											
									</div>
								</div> -->

								<div class="form-actions" style="padding-left: 350px">
									<button type="submit" name="insertPetty" onclick="" class="btn btn-success">Add Petty Cash</button>&nbsp;&nbsp;&nbsp;
									<a type="button" href="/SAMERP/index.jsp" class="btn btn-danger" style="margin-right: 20px">Exit</a>
								</div>
							</form>
						</div>
					</div>
					
					
								<div class="row-fluid">
				<div class="span14">

					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"><i class="icon-th"></i></span>
							<h5>Petty Cash Details</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered data-table">
								<thead>
									<tr>
										<th>Sr.No</th>
										<th>Date</th>
										<th>Particulars</th>
										<th>Debit</th>
										<th>Credit</th>
										<th>Balance</th>
									</tr>
								</thead>
								<%
									RequireData rd=new RequireData();
									List pettyDetails=rd.getPettyCashDetails();
									Iterator itr=pettyDetails.iterator();
									int count=1;
								%>
								<tbody>
								<% 
								while(itr.hasNext())
								{itr.next();%>
									<tr>
										<td><%=count %></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
									</tr>
								<%count++; }%>
								</tbody>
							</table>
						</div>
					</div>

				</div>
			</div>            
            
            <!-- tab 1 end -->  
            </div>
            
            <div id="tab2" class="tab-pane">
             <!-- tab 2 start -->
             
             <div class="widget-box">
					<div class="widget-title">
							<span class="icon"> <i class="icon-align-justify"></i>
							</span>
							<h5>Hand Loan From Bank</h5>
						</div>
						
						<div class="widget-content nopadding">
							<form class="form-horizontal" action="/SAMERP/PTCash" method="post" name="handloan">
								<div class="form-group">
									<div class="widget-content nopadding">
				
										<div class="control-group" style="">
											<label class="control-label">Name: </label>
											<div class="controls">
												<input type="text" id="namep" name="namep" list="getHandLoanName" autocomplete="off" placeholder="Name" onfocus="handLoanName(this.value)" oninput="getDetails(this.value)" onkeyup="this.value=this.value.toUpperCase()"  required />
												<input type="text" id="namepnew" name="namepnew"  autocomplete="off" placeholder="Name" onkeyup="this.value=this.value.toUpperCase()"  style="display:none;"/>
												<input type="hidden" id="status" name="status"  value="Old" placeholder="Name" />
												<datalist id="getHandLoanName"></datalist>
												<span class="badge badge-inverse" id="addNewH" onclick="newHandLoaner()" title="Add New"><i class="icon-plus"></i></span>
			
			
											</div>
										</div>
										
										<div class="control-group" style="">
											<label class="control-label">Mobile No: </label>
											<div class="controls">
												<input type="text" id="mobilenop" name="mobilenop" placeholder="Mobile No"	maxlength="10" readonly required />
											</div>
										</div>
				
										<div class="control-group">
											<label class="control-label">Date :</label>
											<div class="controls">
												<input type="date" name="datep" value="<%=requireddate%>">
											</div>
										</div>
				
										<div class="control-group" style="">
											<label class="control-label">Amount : </label>
											<div class="controls">
												<input type="text" id="paidAmtp" name="paidAmtp" placeholder="Amount" 	required />
											</div>
										</div>
				
										<div class="control-group" style="">
											<label class="control-label">Payment Mode : </label>
											<div class="controls">
												 <input type="radio" value="CHEQUE" style="margin-left: 1%;" name="payModep"	onclick="displayBank('bankDetails', 'chequeDetails')" checked/>
												Cheque <input type="radio" value="TRANSFER"	style="margin-left: 1%;" name="payModep"	onclick="displayBank('bankDetails')" /> Transfer
											</div>
										</div>
				
										<div class="control-group" id="chequeDetails" style="">
											<label class="control-label">Cheque Number : </label>
											<div class="controls">
												<input type="text" placeholder="Cheque Number" maxlength="6" name="chequeNop" id="chequeNo" />
											</div>
										</div>
				
				
										<div class="control-group" id="bankDetails" style="">
											<label class="control-label">Bank Details : </label>
											<div class="controls" style=" width: 220px";">
												<input type="text"  list="getBankName" autocomplete="off" placeholder="Bank Name" id="bName,0" name="bNamep" <%if(request.getAttribute("bName")!=null) {%> value="<%=request.getAttribute("bName") %>" <%} %> onfocus="searchBankName(this.value)" style="" class="span12"></td>
           								 	<datalist id="getBankName"></datalist>
											</div>
										</div>
				
									</div>
								</div>
				
								<input type="hidden" name="supid2" id="supid2" />
				
								<div class="modal-footer" style="120px;">
									<input type="submit" id="handloanbtn" name="handloanpagebtn" class="btn btn-primary" value="Submit" style="margin-right: 10px;"/> 
									<a href="/SAMERP/dashboard.jsp" class="btn btn-danger" data-dismiss="modal" style="margin-right: 404px;">Exit</a>
								</div>
				
							</form>
						</div>
						
						
			</div>
			
			<div class="row-fluid">
				<div class="span14">

					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"><i class="icon-th"></i></span>
							<h5>Hand Loan Details</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered data-table">
								<thead>
									<tr>
										<th>Sr.No</th>
										<th>Date</th>
										<th>Name</th>
										<th>Debit</th>
										<th>Credit</th>
										<th>Mode</th>
										<th>Cheque No.</th>
										<th>Balance</th>
										<th>Action</th>
									</tr>
								</thead>
								<%
									List handLoanDetails=rd.getHandLoanDetailsInPetty();
									Iterator handLoan=handLoanDetails.iterator();
									int hCount=1;
								%>
								<tbody>
								<% 
								while(handLoan.hasNext())
								{Object id=handLoan.next();%>
									<tr>
										<td><%=hCount %></td>
										<td><%=handLoan.next()%></td>
										<td><%=handLoan.next()%></td>
										<td><%=handLoan.next()%></td>
										<td><%=handLoan.next()%></td>
										<td><%=handLoan.next()%></td>
										<td><%=handLoan.next()%></td>
										<td><%=handLoan.next()%></td>
										<td style="text-align: center"><a class="tip" title="Update" href="#updateModal" onclick="getInfo(<%=id %>)" data-toggle="modal"><i class="icon-pencil"></i></a></td>
									</tr>
								<%hCount++; }%>
								</tbody>
							</table>
						</div>
					</div>

				</div>
			</div>  
			
			
             
             <!-- tab 2 end -->
            </div>
            
          </div>
        </div>
				
				
				

				</div>
			</div>
			
			


		</div>
	</div>


<!-- update modal start -->
<div class="modal hide fade zoom-out" id="updateModal" role="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h4 style="color: red;" class="modal-title">Update HandLoan Details</h4>
							</div>
							<form class="form-horizontal" action="/SAMERP/PTCash" method="post" name="form4">
							<div class="modal-body">
									<div class="form-group">
										<div class="widget-content nopadding">
											<div class="control-group">
												<label class="control-label">Date</label>
	    										<div class="controls">
	                                				<input type="text" id="uDate" name="uDate" readonly>
	                                				<input type="hidden" id="detailsId" name="detailsId">
	                                			</div>
											</div>
											<div class="control-group">
												<label class="control-label">Name</label>
	    										<div class="controls">
	                                				<input type="text" id="uName" name="uName" readonly>
	                                				<input type="hidden" id="handLoanId" name="handLoanId">
	                                			</div>
											</div>
											<div class="control-group">
												<label class="control-label">Debit</label>
	    										<div class="controls">
	                                				<input type="number" id="dr" name="dr">
	                                				<input type="hidden" id="oldDr" name="oldDr">
	                                			</div>
											</div>
											<div class="control-group">
												<label class="control-label">Credit</label>
	    										<div class="controls">
	                                				<input type="number" id="cr" name="cr">
	                                				<input type="hidden" id="oldCr" name="oldCr">
	                                			</div>
											</div>
											<div class="control-group">
												<label class="control-label">Mode</label>
	    										<div class="controls">
	                                				<input type="text" id="uMode" name="uMode" readonly>
	                                			</div>
											</div>
											<div class="control-group">
												<label class="control-label">Cheque No</label>
	    										<div class="controls">
	                                				<input type="text" id="chqNo" name="chqNo">
	                                			</div>
											</div>
											<div class="control-group">
												<label class="control-label">Balance</label>
	    										<div class="controls">
	                                				<input type="text" id="uBalance" name="uBalance" readonly>
	                                			</div>
											</div>
										</div>
									</div>
								</div>
										<div class="modal-footer">			
											<input type="submit" class="btn btn-success" id="" name="updateHandLoan" value="Update" />
											<input type="button" class="btn btn-danger" data-dismiss="modal" id="submitbtn" value="Cancel" />
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
<!-- update modal end -->
	
	<div class="modal hide fade zoom-out" id="paymentEntry" role="dialog">
		<div class="modal-header">
			<a class="close" data-dismiss="modal"></a>
			<h5>Hand Loan Details</h5>
		</div>

		<div class="modal-body" style="padding: 0;">
			<form class="form-horizontal" action="/SAMERP/PTCash" method="post" name="ptcash">
				<div class="form-group">
					<div class="widget-content nopadding">

						

						<div class="control-group" style="">
							<label class="control-label">Name: </label>
							<div class="controls">
								<input type="text" name="name" placeholder="Name" onkeyup="this.value=this.value.toUpperCase()" required />
							</div>
						</div>
						
						<div class="control-group" style="">
							<label class="control-label">Mobile No: </label>
							<div class="controls">
								<input type="text" name="mobileno" placeholder="Mobile No"	maxlength="10" required />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">Date :</label>
							<div class="controls">
								<%
									SysDate date1 = new SysDate();
									String[] demo1 = date.todayDate().split("-");
									String reqdate = demo[2] + "-" + demo[1] + "-" + demo[0];
								%>
								<input type="date" name="date" value="<%=reqdate%>">
							</div>
						</div>

						<div class="control-group" style="">
							<label class="control-label">Amount : </label>
							<div class="controls">
								<input type="text" name="paidAmt" placeholder="Amount" 	required />
							</div>
						</div>

						<div class="control-group" style="">
							<label class="control-label">Payment Mode : </label>
							<div class="controls">
								<input type="radio" value="CASH" style="margin-left: 1%;" name="payMode" onclick="displayBank()" checked="checked" />Cash
							</div>
						</div>

						<div class="control-group" id="chequeDetails"
							style="display: none;">
							<label class="control-label">Cheque Number : </label>
							<div class="controls">
								<input type="text" placeholder="Cheque Number" name="chequeNo"
									id="chequeNo" />
							</div>
						</div>


						<div class="control-group" id="bankDetails" style="display: none;">
							<label class="control-label">Bank Details : </label>
							<div class="controls" style="width: 44%;">
								<select name="bankInfo" id="bankInfo">
									<option value="">Select Bank Account</option>
									<%
										List List2 = rq.getBank();
										Iterator itr7 = List2.iterator();
										while (itr7.hasNext()) {
									%>
									<option value="<%=itr7.next()%>"><%=itr7.next()%></option>
									<%
										}
									%>
								</select>
							</div>
						</div>

					</div>
				</div>

				<input type="hidden" name="supid2" id="supid2" />

				<div class="modal-footer">
					<input type="submit" id="handloanbtn" name="handloanbtn"
						class="btn btn-primary" value="Add Petty Cash" /> <a href="/SAMERP/index.jsp"
						class="btn btn-danger" data-dismiss="modal">Cancel</a>
				</div>

			</form>
		</div>
	</div>

	<!--end-main-container-part-->

	<!--Footer-part-->

	<div class="row-fluid">
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a
				href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
	</div>



<script type="text/javascript">

var nameCount=1;
var bankNameCount=1;
var counter=0;
var bankCounter=0;

function validatePetty()
{
	var hName=document.getElementById("hlName,0").value;
	var hAmt=document.getElementById("hlAmt,0").value;
	var bName=document.getElementById("bName,0").value;
	var bAmt=document.getElementById("bAmt,0").value;
	if ((hName == "" || hAmt=="") && (bName=="" || bAmt=="")) 
	{
		document.getElementById("validationError").innerHTML="* Fill atleast Handloan or Cash Details"
		return false;
	}
	
}

function getInfo(val)
{
	var xhttp;
	
	xhttp = new XMLHttpRequest();
	
	xhttp.onreadystatechange = function() {
		
		if (this.readyState == 4 && this.status == 200) {
			
			var demoStr = this.responseText.split(",");
			//alert(demoStr);
			document.getElementById("uDate").value = demoStr[0];
			document.getElementById("uName").value = demoStr[1];
			if(demoStr[2]==0)
			{
				document.getElementById("dr").readOnly=true;
			}
			else
			{
				document.getElementById("dr").readOnly=false;
			}
			document.getElementById("dr").value = demoStr[2];
			document.getElementById("oldDr").value = demoStr[2];
			if(demoStr[3]==0)
			{
				document.getElementById("cr").readOnly=true;
			}
			else
			{
				document.getElementById("cr").readOnly=false;
			}
			document.getElementById("cr").value = demoStr[3];
			document.getElementById("oldCr").value = demoStr[3];
			
			document.getElementById("uMode").value = demoStr[4];
			if(demoStr[5]=="")
			{
				document.getElementById("chqNo").readOnly=true;
			}
			else
			{
				document.getElementById("chqNo").readOnly=false;
			}
			document.getElementById("chqNo").value = demoStr[5];
			document.getElementById("uBalance").value = demoStr[6];
			document.getElementById("handLoanId").value = demoStr[7];
			document.getElementById("detailsId").value = demoStr[8];
			
			
			
			}
		};
	xhttp.open("POST", "/SAMERP/PTCash?forUpdate="+val, true);
	xhttp.send();
}

function newHandLoaner()
{
	var newName=document.getElementById('namepnew');
	newName.style="display:block";
	newName.required = true;
	document.getElementById('namep').removeAttribute("required");
	document.getElementById('namep').style="display:none";
	document.getElementById('status').value="New";
	document.getElementById('mobilenop').removeAttribute("readonly");
	document.getElementById('addNewH').style="display:none";
	
}

function getDetails(val)
{
	var opts = document.getElementById('getHandLoanName').childNodes;
	for (var i = 0; i < opts.length; i++) {
		 if (opts[i].value === val) 
		 {
			 var xhttp;
				xhttp = new XMLHttpRequest();
				
				xhttp.onreadystatechange = function() {
					
					if (this.readyState == 4 && this.status == 200) 
					{
						
							var demoStr = this.responseText/* .split(",") */;
							
							//alert(demoStr);
							 document.getElementById("mobilenop").value = demoStr;
							document.getElementById("paidAmtp").focus(); 
					}
						
					
				};
				xhttp.open("POST", "/SAMERP/PTCash?details="+val, true);
				xhttp.send(); 
				break;
		 }
	}
	
}
function handLoanName(val)
{
	var xhttp;
	
	xhttp = new XMLHttpRequest();
	
	xhttp.onreadystatechange = function() {
		
		if (this.readyState == 4 && this.status == 200) {
			
			var demoStr = this.responseText;
			//alert(demoStr);
			document.getElementById("getHandLoanName").innerHTML = demoStr;
			}
		};
	xhttp.open("POST", "/SAMERP/PTCash?findHanLoanName="+val, true);
	xhttp.send();
	
}
function totalPetty(val)
{
	var prevBalance=document.getElementById('previous_balance').value;
	/* var atmCash=document.getElementById('atmCash').value; */
	var lastTotal=document.getElementById('tAmt').value;
	if (val == "")
         val = 0;
	if (prevBalance == "")
		prevBalance = 0;
	
	if(lastTotal=="")
	{
		var total=parseInt(prevBalance)+parseInt(val);
		
		if (!isNaN(total)) {
	           document.getElementById('tAmt').value = total;
	       }	
	}
	else
	{
		var total=parseInt(val)+parseInt(lastTotal);
		if (!isNaN(total)) {
	           document.getElementById('tAmt').value = total;
	       }	
	}
	
	
}

function getAmt(name,id)
{
	var amtId=id.split(",");
	var opts = document.getElementById('getName').childNodes;
	for (var i = 0; i < opts.length; i++) {
		 if (opts[i].value === name) 
		 {
			 var xhttp;
				xhttp = new XMLHttpRequest();
				
				xhttp.onreadystatechange = function() {
					
					if (this.readyState == 4 && this.status == 200) {
						
						var demoStr = this.responseText;
						
						var demoStr = this.responseText;
						if(amtId[1]==0)
						{
							document.getElementById("hlAmt,"+amtId[1]).value = demoStr;	
						}
						else
						{
							document.getElementById("hlAmt"+amtId[1]).value = demoStr;
						}
						
						//document.getElementById("").focus();	
					}
				};
				xhttp.open("POST", "/SAMERP/PTCash?eName="+name, true);
				xhttp.send(); 
				break;
		 }
	}
}
function myFunction() {
	
	var checkTab=document.getElementById("changeTab").value;
	if(checkTab=="tab2")
	{
		$('#myTab a:last').tab('show');
	}
	
	if(document.getElementById("snackbar")!=null)
		{
		    var x = document.getElementById("snackbar")
		    x.className = "show";
		    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
		}
		
		document.getElementById("addH").style.cursor = "pointer";
		document.getElementById("addB").style.cursor = "pointer";
		
	
	//for shownig insufficient balance error
	<%-- var bankExit = <%=request.getAttribute("bankExit") %>
	var pettyExit = <%=request.getAttribute("pettyExit") %>
	
	if(bankExit==0 || bankExit==-1){
		$('#bankBalanceError').modal('show');
	}
	
	if(pettyExit==0 || pettyExit==-1){
		$('#pettyCashError').modal('show');
	} --%>
}


function InsertBankRow()
{
	
	document.getElementById("removeBank").style="display:block";
	document.getElementById("removeB").style.cursor = "pointer";
	var insertTable = document.getElementById("bank-details-table");
    var Row = insertTable.rows;
    var numRows = Row.length;
    var row = insertTable.insertRow(numRows);
    var cell1 = row.insertCell(0);
    var cell2 = row.insertCell(1);
    var cell3 = row.insertCell(2);
    
  
    cell2.innerHTML = "<input type='text'  list='getBankName' autocomplete='off' placeholder='Bank Name' id='bName,"+bankNameCount+"' name='bName,"+bankNameCount+"' onfocus='searchBankName(this.value)' class='span2' style='width: 170px;margin-top: 10px;margin-left:15px;margin-right: 10px;' required>";
    cell3.innerHTML = "<input type='text' style='width:83px;margin-top: 10px;' name='bAmt,"+bankNameCount+"' id='bAmt"+bankNameCount+"' placeholder='Amount' required/>";
    bankNameCount++; 
    bankCounter++;
    document.getElementById("bankCount").value=bankCounter;
}

function RemoveBankRow() {
	var removeTable = document.getElementById("bank-details-table");
	var Rows = removeTable.rows;
    var numRows = Rows.length;
    if(numRows>1){
		removeTable.deleteRow(numRows-1);
    }
    bankNameCount--;
    bankCounter--;
    if(bankCounter==0)
    {
    	document.getElementById("removeBank").style="display:none";
    	
    }
    document.getElementById("bankCount").value=bankCounter;
}


function InsertRow() {
	document.getElementById("removeH").style="display:block";
	document.getElementById("removeH").style.cursor = "pointer";
	
	var insertTable = document.getElementById("HandLoan-details-table");
    var Row = insertTable.rows;
    var numRows = Row.length;
    var row = insertTable.insertRow(numRows);
    var cell1 = row.insertCell(0);
    var cell2 = row.insertCell(1);
    var cell3 = row.insertCell(2);
    
  
    cell2.innerHTML = "<input type='text'  list='getName' autocomplete='off' placeholder='HandLoan Name' id='hlName,"+nameCount+"' name='hlName,"+nameCount+"' onfocus='searchName(this.value)' class='span2' style='width: 170px;margin-top:10px;margin-left:15px;margin-right: 10px;' required>";
    cell3.innerHTML = "<input type='text' style='width:83px;margin-top:10px;' name='hlAmt,"+nameCount+"' id='hlAmt,"+nameCount+"' placeholder='Amount' required/>";
    nameCount++; 
    counter++;
    document.getElementById("count").value=counter;
}

function RemoveRow() {
	var removeTable = document.getElementById("HandLoan-details-table");
	var Rows = removeTable.rows;
    var numRows = Rows.length;
    if(numRows>1){
		removeTable.deleteRow(numRows-1);
    }
    nameCount--;
    counter--;
    if(counter==0)
    {
    	document.getElementById("removeH").style="display:none";
    	
    }
    document.getElementById("count").value=counter;
}


function displayBank(id, id1){
	var x = document.getElementById(id);
	var y = document.getElementById(id1);
	
	if( x==null ){
		document.getElementById("chequeNo").required=false;
		document.getElementById("bankInfo").required=false;
		
		document.getElementById("chequeDetails").style.display = "none";
		document.getElementById("bankDetails").style.display = "none";
		
	}
	else if(x!=null && y!=null){
		x.style.display = "block";
		y.style.display = "block";
		
		document.getElementById("chequeNo").required=true;
		document.getElementById("bankInfo").required=true;
	}
	else{	

		document.getElementById("chequeNo").required=false;
		document.getElementById("chequeDetails").style.display = "none";
		
		x.style.display = "block";
		document.getElementById("bankInfo").required=true;
	}
}

function searchName(valu)
{  	
	var xhttp;
			
			xhttp = new XMLHttpRequest();
			
			xhttp.onreadystatechange = function() {
				
				if (this.readyState == 4 && this.status == 200) {
					
					var demoStr = this.responseText;
					//alert(demoStr);
					document.getElementById("getName").innerHTML = demoStr;
					}
				};
			xhttp.open("POST", "/SAMERP/PTCash?findName="+valu, true);
			xhttp.send();
					
}

function searchBankName(valu)
{  	
	var xhttp;
			
			xhttp = new XMLHttpRequest();
			
			xhttp.onreadystatechange = function() 
			{
				
				if (this.readyState == 4 && this.status == 200) 
				{
					
					var demoStr = this.responseText;
					//alert(demoStr);
					document.getElementById("getBankName").innerHTML = demoStr;
				}
			};
			xhttp.open("POST", "/SAMERP/PTCash?findBankName="+valu, true);
			xhttp.send();
					
}
</script>


	<script src="/SAMERP/config/js/jquery.min.js"></script>
	<script src="/SAMERP/config/js/jquery.ui.custom.js"></script>
	<script src="/SAMERP/config/js/bootstrap.min.js"></script>
	<script src="/SAMERP/config/js/bootstrap-colorpicker.js"></script>
	<script src="/SAMERP/config/js/bootstrap-datepicker.js"></script>
	<script src="/SAMERP/config/js/jquery.uniform.js"></script>
	<script src="/SAMERP/config/js/select2.min.js"></script>
	<script src="/SAMERP/config/js/jquery.dataTables.min.js"></script>
	<script src="/SAMERP/config/js/matrix.js"></script>
	<script src="/SAMERP/config/js/matrix.tables.js"></script>
	<script src="/SAMERP/config/js/wysihtml5-0.3.0.js"></script>
	<script src="/SAMERP/config/js/jquery.peity.min.js"></script>
	<script src="/SAMERP/config/js/bootstrap-wysihtml5.js"></script>
	<script src="/SAMERP/config/js/jquery.toggle.buttons.js"></script>
</html>
