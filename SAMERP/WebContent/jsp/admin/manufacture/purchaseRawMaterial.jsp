
	<%@page import="utility.SysDate"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="utility.RequireData"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Purchase Raw Material</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/SAMERP/config/css/fullcalendar.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="/SAMERP/config/css/jquery.gritter.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bs_modal_transition.css" />
<link rel="shortcut icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">
<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>

<style type="text/css">

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
    border-radius:50px 50px;
}

#snackbar.show {
    visibility: visible;
    -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
    animation: fadein 0.5s, fadeout 0.5s 2.5s;
}

@-webkit-keyframes fadein {
    from {bottom: 0; opacity: 0;} 
    to {bottom: 30px; opacity: 1;}
}

@keyframes fadein {
    from {bottom: 0; opacity: 0;}
    to {bottom: 30px; opacity: 1;}
}

@-webkit-keyframes fadeout {
    from {bottom: 30px; opacity: 1;} 
    to {bottom: 0; opacity: 0;}
}

@keyframes fadeout {
    from {bottom: 30px; opacity: 1;}
    to {bottom: 0; opacity: 0;}
}
</style>

</head>
<script>
	
	
</script>


<body onload="setFocusToTextBox()">
<!--Header-part-->
<div id="header">
  <h1><a href="dashboard.html">Matrix Admin</a></h1>
</div>

<!--start-top-serch-->
<div id="search">

<% if(request.getAttribute("status")!=null){ %>
<%System.out.print(request.getAttribute("status")); %>
<div id="snackbar"><%=request.getAttribute("status")%></div>
<%} %>

  <button type="submit" class="tip-bottom">LOGOUT</button>
</div>
<!--close-top-serch-->
<!--sidebar-menu-->
<jsp:include page="../common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->

	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				<a href="index.html" title="Go to Home" class="tip-bottom"><i
					class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Form
					elements</a> <a href="#" class="current">Purchase Raw Material</a>
			</div>
			
			<div class="container-fluid">
				<hr>
				<div class="row-fluid">
				<form action="/SAMERP/PurchaseRawMaterial" method="post" id="mainForm" class="form-horizontal">
				
				<div class="span12">
						<div class="widget-box">
							<div class="widget-title">
								<span class="icon"> <i class="icon-search"></i>
								</span>
								<h5>Search</h5>
							</div>

							<div class="widget-content nopadding">

								<div class="form-horizontal">
									
									<table>
									<tr>
									<td>
									<div id="errClass" class="control-group">
									<label class="control-label">Supplier Enterprise Name:</label>
									
										<div class="controls" >
											<input type="text" list="getList" name="supSearch" id="supSearch" tabindex="1" autocomplete="off" onfocus="searchSup(this.id,this.value)" oninput="getDetails(this.value)" style="width: 237px;" placeholder="Search..." onkeyup="clearErr('sup')" <% if(request.getAttribute("notify")!=null){ %> value="<%=request.getAttribute("sbname")%>" <% }%> required/>
											<datalist id="getList"></datalist>
											<br><span class="help-inline" id="errMsg" style="display:none;">Please Select Supplier Enterprise</span>	
										</div>
										
										<div class="controls" style="display:none;">
											<select name="entName" id="entName">
												<option></option>
											</select>
										</div>
										</div></td>
									<td><a href="#add-brand" data-toggle="modal">
											<span class="badge badge-inverse"><i class="icon-plus"></i></span>
										</a></td>
									</tr>
									</table>
								
							</div>
							</div>
						</div>
					</div>
				
				


					<div class="span12" style="margin-left:0px">
						<div class="widget-box">
							<div class="widget-title">
								<span class="icon"> <i class="icon-list"></i>
								</span>
								<h5>View Details</h5>
							</div>

							<div class="widget-content nopadding">
								<div class="form-horizontal" id="subForm1">
									<table>
										<tr>
											<td><div class="control-group">
													<label class="control-label">Supplier Name:</label>
													<div class="controls">
														<input type="text" id="supName" name="supName" style="width: 237px;" placeholder="Supplier Name" <% if(request.getAttribute("notify")!=null){ %> value="<%=request.getAttribute("sname")%>" <% }%> readonly/>
														<input type="hidden" id="supId" name="supId" style="width: 237px;" placeholder="Supplier ID" <% if(request.getAttribute("notify")!=null){ %> value="<%=request.getAttribute("sid")%>" <% }%> />
													</div>
												</div></td>
											<td>
												<div class="control-group" style="margin-left: -19.5px;">
													<label class="control-label">Contact No:</label>
													<div class="controls">
														<input type="text" id="supContact" name="supContact" style="width: 237px;" placeholder="Contact No" readonly <% if(request.getAttribute("notify")!=null){ %> value="<%=request.getAttribute("cn")%>" <% }%>/>
													</div>
												</div>
											</td>
										</tr>
									</table>
								</div>
							</div>
							
						</div>
					</div>
					
				
				


					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-truck"></i>
							</span>
							<h5>Purchase Material Details</h5>
						</div>

						<div class="widget-content nopadding">
							<div class="form-horizontal" id="subForm2">
							<div class="form-group">
								<table>
									<tr>
										<td>
											<div class="control-group">
												<label class="control-label">Chalan No:</label>
												<div class="controls">
													<input type="number" tabindex="2" id="chalanNo" name="chalanNo" style="width: 237px;"
														placeholder="Chalon No" />
												</div>
											</div>
										</td>
										<td>
											<div class="control-group">
												<label class="control-label" style="margin-left: -18px;">Date:</label>
											
												<div class="controls">
												<% SysDate sd= new SysDate();
                  									String date[] =	sd.todayDate().split("-");
                  								%>
                								<input type="date" tabindex="3" name="rawDate" id ="rawDate" style="width: 237px;margin-left: -16px;" value="<%= date[2]+"-"+date[1]+"-"+date[0] %>" required>
              
						
												</div>
											</div>
										</td>
									</tr>
								</table>

								
								<table>
									<tr>
										<td>
											<div id="vNoValid" class="control-group">
												<label class="control-label">Vehicle No:</label>
												<div class="controls">
													<input type="text" tabindex="4" id="vn1" maxlength="2" name="vn1" class="span2" style="width: 48px;" placeholder="XX" title="Enter RTO Passing Alphabets" pattern="[a-z A-Z]*" onkeypress="clearErr('vNo')" required />- 
													<input type="number" tabindex="5" id="vn2" maxlength="2" name="vn2" class="span2" style="width: 48px;" placeholder="XX" onkeypress="clearErr('vNo')" required/>- 
													<input type="text" tabindex="6" id="vn3" maxlength="2" name="vn3" class="span2" style="width: 48px;" placeholder="XX" onkeypress="clearErr('vNo')" pattern="[a-z A-Z]*" title="Enter Series Aplhabets" required/>- 
													<input type="number" tabindex="7" id="vn4" maxlength="4" name="vn4" placeholder="XXXX" style="width: 73px" onkeypress="clearErr('vNo')"  required/>
													<br><span id="vNoMsg" class="help-inline" style="display:none">Enter Correct No.</span>
												</div>
											</div>	
										</td>
										<td>
										<%
											RequireData rd=new RequireData();
											List rawNames=rd.getRawNameDetails();
											Iterator itr= rawNames.iterator();
										%>
											<div id="rawErr" class="control-group">
												<label class="control-label" style="margin-left: -18px;" >Select Material :</label>
												<div class="controls">
													<select tabindex="8" style="width: 250px;margin-left: -18px;" id="rawName" name="rawName" onclick="" onchange="getUnit(this.value); clearErr('material')">
													<%if(rawNames!=null) {%>
														<option value="0">Select</option>
														<%while(itr.hasNext()){%>
														<option value="<%=itr.next() %>"><%=itr.next()%></option>
														<%} %>
													<%}else{ %>
														<option value="0">Select</option>
													<%} %>
														
													</select> 
													<a href="#add_partical" data-toggle="modal"
														style="color:  white; font-size: 10px;" width="25px">
														<span class="badge badge-inverse"><i class="icon-plus"></i></span>
													</a>
													<br><span id="rawMsg" class="help-inline" style="display:none">Select Material</span>		
												</div>
									
											</div>
										</td>
										</div>
									</tr>
									
									<tr>
										<td>
											<div id="qtyClass" class="control-group" style="padding-left: 0px">
												<label class="control-label">Quantity:</label>
												<div class="controls">
														<input type="number" tabindex="9" onkeypress="clearErr('qty')" style="width: 237px;" id="qty" name="qty" placeholder="Quantity" required />
														<br><span id="qtyMsg" class="help-inline" style="display:none">Enter quantity</span>
													</div>
											</div>
										</td>
										<td>
											<%
											RequireData rd1=new RequireData();
											List rawUnits=rd1.getRawUnitDetails();
											Iterator itr1= rawUnits.iterator();
											%>
										
											<div id="unitErr" class="control-group">
												<label class="control-label" style="margin-left:-20px">Unit:</label>
												<div  class="controls" style="margin-left: 182px">
													<select style="width: 250px" tabindex="10" id="rawUnit" name="rawUnit" onchange="clearErr('unit')" required>
														<%if(rawUnits!=null) {%>
														<option value="0">Select</option>
															<%while(itr1.hasNext()){%>
															<option value="<%=itr1.next() %>"><%=itr1.next()%></option>
														<%} %>
														<%}else{ %>
															<option value="0">Select</option>
														<%} %>
													</select>
													<br><span id="unitMsg" class="help-inline" style="display:none">Select Unit</span>
												</div>
											</div>
										</td>
										</div>
									</tr>
								</table>
								</div>
								<div class="form-actions" style="padding-left: 450px">
									<button type="button" onclick="subPurRaw()" name="purchase" class="btn btn-success">Submit</button>
									<button type="button" class="btn btn-danger">Exit</button>
								</div>
							</div>
						</div>
					</div>
				</form>
				</div>



				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"><i class="icon-th"></i></span>
						<h5>View Purchase Details</h5>
					</div>
					<div class="widget-content nopadding">
						<%RequireData dataTable=new RequireData(); 
							List pDetails=rd.getPurchaseDetails();
							Iterator itr2=pDetails.iterator();
							int count=1;
						%>
						<table id="myTable" class="table table-bordered data-table">
							<thead>
								<tr>
									<th>ID</th>
									<th>Supplier Name</th>
									<th>Chalan no</th>
									<th>Date</th>
									<th>Vehicle No.</th>
									<th>Particular Material</th>
									<th>Quantity</th>
									<th>Action</th>
								</tr>
								</thead>
								<tbody>	
								<%while(itr2.hasNext()){ %>
								<tr>
									<%Object pid = itr2.next();%>
									<td><%=count %></td>
									<td><%=itr2.next()%></td>
									<td><%=itr2.next()%></td>
									<td><%=itr2.next()%></td>
									<td><%=itr2.next()%></td>
									<td><%=itr2.next()%></td>
									<td><%=itr2.next()%></td>
									<td><a href="#updateModal" data-toggle="modal" onclick="getInfo(<%=pid%>)">Update</a> | <a href="#" onclick="deleteFun(<%=pid %>)">Delete</a></td>
								</tr>
								<%count++;} %>
							</tbody>
						</table>
					</div>
				</div>
			</div>

		</div>
	</div>

	<!-- supplier Modal  -->

	<div class="modal hide fade zoom-out" id="add-brand" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Add New Supplier:</h4>
				</div>
				
				<form class="form-horizontal" id="supForm" action="/SAMERP/AddSupplyMaterial" method="post">	
				<div class="modal-body">
					
						<div class="control-group">
							<label class="control-label">Supplier Business Name</label>
							<div class="controls">
								<input type="text" name="suppbusinesname" id="supBname" class="span3" autofocus placeholder="Supplier Business Name" onkeyup="this.value=this.value.toUpperCase()" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Supplier Name</label>
							<div class="controls">
								<input type="text" name="suppname" id="supNam" class="span3" placeholder="Supplier Name" onkeyup="this.value=this.value.toUpperCase()" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Supplier Address</label>
							<div class="controls">
								<input type="text" name="address" id="supAdd" class="span3" placeholder="Supplier Address" onkeyup="this.value=this.value.toUpperCase()" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Supplier Contact</label>
							<div class="controls">
								<input type="text" name="contact" id="supCn" class="span3" maxlength="10" placeholder="Supplier Contact" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Supplier Balance</label>
							<div class="controls">
								<input type="text" name="openingbalance" id="supBal" class="span3" placeholder="Supplier Balance" />
								<input type="hidden" name="productPurchasePage" value="RawPurchase">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Supplier Type</label>
							<div class="controls">
								<select id="supTyp" class="span3" name="material_type">
									<option value="1">Raw Material</option>
								</select>
							</div>
						</div>
					
					
				</div>
				<div class="modal-footer">
					<input type="submit" id="" class="btn btn-primary" name="insertsupply" onclick="" value="Add" /> 
					<input type="button" id="cancelbtn" class="btn btn-primary" data-dismiss="modal" value="Cancel" />
				</div>
				</form>
			</div>
		</div>

	</div>

	<!-- 	end modal -->

	<!-- 	material modal -->

	<div class="modal hide fade zoom-out" id="add_partical" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Add Raw Material</h4>
				</div>
				<form class="form-horizontal" action="#" id="rawForm" method="post">
				<div class="modal-body">
					
						<div class="control-group">
							<label class="control-label">Material Name:</label>
							<div class="controls">
								<input type="text" class="span3" id="raw" name="raw" placeholder="Enter New Raw Material" autofocus autocomplete="off" onkeyup="this.value=this.value.toUpperCase()" />
							</div>
							<label class="control-label">Unit</label>
							<div class="controls">
								<input type="text" class="span3" id="unit" name="unit" placeholder="e.g kg,brass,bag" autocomplete="off" onkeyup="this.value=this.value.toUpperCase()"/>
							</div>
						</div>
					
				</div>
				
				<div class="modal-footer">
					<input type="button" id="submitbtn" class="btn btn-primary" name="modalSubmit" data-dismiss="modal" onclick="addRawMaterial()" value="Add" /> 
						<input type="button" id="cancelbtn"
						class="btn btn-primary" data-dismiss="modal" value="Cancel" />
				</div>
				</form>
			</div>
		</div>
	</div>
			
	<!--   end modal -->
	
	
		<!--   Update modal -->	
	
		<div class="modal hide fade zoom-out" id="updateModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Update Purchase Raw Material Details</h4>
				</div>
				<form class="form-horizontal" action="/SAMERP/PurchaseRawMaterial" id="updateForm" method="post">
				<input type="hidden" name="purId" id="purId">
				<div class="modal-body">
					
						<div class="control-group">
							<label class="control-label">Supplier Name:</label>
							<div class="controls">
								<input type="text" list="getSupName" class="span3" id="upSupName" name="upSupName" autofocus autocomplete="off" onkeyup="getSupplier(this.value)" oninput="getSupId(this.value)" onchange="" onselect="" />
								<datalist id="getSupName"></datalist>
								<input type="hidden" id="upSupId" name="upSupId">
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Chalan No</label>
							<div class="controls">
								<input type="text" class="span3" id="upChalan" name="upChalan"  autocomplete="off" />
								
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Date</label>
							<div class="controls">
								<input type="date" class="span3" id="upDate" name="upDate"  autocomplete="off" />
								
							</div>
						</div>
						
						
						<div class="control-group">
							<label class="control-label">Vehicle No.</label>
							<div class="controls">
								<input type="text" class="span3" id="upVehNo" name="upVehNo"  autocomplete="off" />
								
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Particular Material</label>
							<div class="controls">
							<input type="text" list="getSupMaterial" class="span3" id="upMaterial" name="upMaterial"  autocomplete="off" onkeyup="getRawMaterial(this.value)" oninput="getRawId()" />
								<datalist id="getSupMaterial"></datalist>
								<input type="hidden" id="upRawId" name="upRawId">
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Quantity</label>
							<div class="controls">
								<input type="text" class="span3" id="upQuantity" name="upQuantity"  autocomplete="off" />
							</div>
						</div>
					
				</div>
				
				<div class="modal-footer">
					<input type="submit" id="submitbtn" class="btn btn-primary" name="modalSubmit" onclick="" value="Update" /> 
					<input type="button" id="cancelbtn" class="btn btn-primary" data-dismiss="modal" value="Cancel" />
				</div>
				</form>
			</div>
		</div>
	</div>
<!--   end modal -->

<!-- Delete Modal -->

<div class="modal hide fade" id="deleteModal" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title"><span style="color:red">Confirm Delete</span></h4>
			</div>
			
			<div class="modal-body">
				<div class="alert alert-warning" style="margin-top: 18px;">
  				<i class="icon-exclamation-sign" style="font-size: 2em;"></i> &nbsp; <strong style="font-size: 15px;">Are you sure you want to Delete this record?</strong>
				</div>
			</div>
			<div class="modal-footer">
				<form action="/SAMERP/PurchaseRawMaterial" method="POST">
				<!-- <input type="hidden" id="invoiceId" name="dInvoiceNo">
				<input type="hidden" id="brandId" name="dBrandId">
				<input type="hidden" id="dAliasName" name="dAliasName">-->
				<input type="hidden" id="deleteId" name="purId"> 
					<input type="submit" class="btn btn-primary" value="OK" name="DeleteRec" />
					<input type="button" class="btn btn-danger" data-dismiss="modal" on value="Cancel"/>
				</form>
			</div>
		</div>	
	</div>
</div>

<!--   end modal -->

	
	<div class="row-fluid">
		<div id="footer" class="span12">
			2013 &copy; Matrix Admin. Brought to you by <a
				href="http://themedesigner.in">Themedesigner.in</a>
		</div>
	</div>
	<!--end-Footer-part-->
	
<script src="/SAMERP/config/js/excanvas.min.js"></script> 
<script src="/SAMERP/config/js/jquery.min.js"></script> 
<script src="/SAMERP/config/js/jquery.ui.custom.js"></script> 
<script src="/SAMERP/config/js/bootstrap.min.js"></script> 
<script src="/SAMERP/config/js/jquery.flot.min.js"></script> 
<script src="/SAMERP/config/js/jquery.flot.resize.min.js"></script> 
<script src="/SAMERP/config/js/jquery.peity.min.js"></script> 
<script src="/SAMERP/config/js/fullcalendar.min.js"></script> 
<script src="/SAMERP/config/js/matrix.js"></script> 
<script src="/SAMERP/config/js/matrix.dashboard.js"></script> 
<script src="/SAMERP/config/js/jquery.gritter.min.js"></script> 
<script src="/SAMERP/config/js/matrix.interface.js"></script> 
<script src="/SAMERP/config/js/matrix.chat.js"></script> 
<script src="/SAMERP/config/js/jquery.validate.js"></script> 
<script src="/SAMERP/config/js/matrix.form_validation.js"></script> 
<script src="/SAMERP/config/js/jquery.wizard.js"></script> 
<script src="/SAMERP/config/js/jquery.uniform.js"></script> 
<script src="/SAMERP/config/js/select2.min.js"></script> 
<script src="/SAMERP/config/js/matrix.popover.js"></script> 
<script src="/SAMERP/config/js/jquery.dataTables.min.js"></script> 
<script src="/SAMERP/config/js/matrix.tables.js"></script> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
	

<script type="text/javascript">

function clearErr(str)
{
	if(str=='sup')
	{
		//alert('clearAll');
		var mainDiv=document.getElementById("errClass");
		var msg=document.getElementById("errMsg");
		
		mainDiv.setAttribute("class", "control-group");
		msg.setAttribute("style","display:none");
	}
	if(str=='vNo')
	{
		//alert('sdsd');
		var mainDiv=document.getElementById("vNoValid");
		var msg=document.getElementById("vNoMsg");
		
		mainDiv.setAttribute("class", "control-group");
		msg.setAttribute("style","display:none");
	}
	if(str=='qty')
	{
		var mainDiv=document.getElementById("qtyClass");
		var msg=document.getElementById("qtyMsg");
		
		mainDiv.setAttribute("class", "control-group");
		msg.setAttribute("style","display:none");	
	}
	if(str=='material')
	{
		var mainDiv=document.getElementById("rawErr");
		var msg=document.getElementById("rawMsg");
			
		mainDiv.setAttribute("class", "control-group");
		msg.setAttribute("style","display:none");	
	}
	if(str=='unit')
	{
		var mainDiv=document.getElementById("unitErr");
		var msg=document.getElementById("unitMsg");
		
		mainDiv.setAttribute("class", "control-group");
		msg.setAttribute("style","display:none");	
	}
}

/* function addSup()
{
	var bName=document.getElementById("supBname").value;
	var sname=document.getElementById("supNam").value;
	var address=document.getElementById("supAdd").value;
	var cnt=document.getElementById("supCn").value;
	var bal=document.getElementById("supBal").value;
	var typ=document.getElementById("supTyp").value;
	
	//alert(bName+"_"+sname+"_"+address+"_"+cnt+"_"+bal+"_"+typ);
	
	var xhttp;
	xhttp = new XMLHttpRequest();
	
	xhttp.onreadystatechange = function() {
		
		if (this.readyState == 4 && this.status == 200) {
			
			var demoStr = this.responseText;
			if(demoStr==0)
			{
				alert("Supplier Already Present");
			}
			else
			{
				var demoStr = this.responseText.split(",");	
				//alert(demoStr);	
				document.getElementById("supId").value=demoStr[0];
				document.getElementById("supSearch").value=demoStr[1];
				document.getElementById("supName").value=demoStr[2];
				document.getElementById("supContact").value=demoStr[3];
				
				var div=document.createElement("DIV");
				div.id="snackbar";
				document.body.appendChild(div);
				showSnackBar();
				document.getElementById('chalanNo').focus();
			}
			
		}
	};
	xhttp.open("POST", "/SAMERP/AddSupplyMaterial?bName="+bName+"&sname="+sname+"&address="+address+"&bal="+bal+"&typ="+typ+"&cnt="+cnt, true);
	xhttp.send();
	
	
}
 */
//for delete record from database
function deleteFun(id)
{
	//alert(id);
	$('#deleteModal').modal('show');
	document.getElementById("deleteId").value=id;
}
		
//AJAX dropDown for updateModal getting rawMaterial
	function getRawMaterial(raw)
	{
		//alert(raw);
		var xhttp = new XMLHttpRequest();
		
		xhttp.onreadystatechange = function() {
			
			if (this.readyState == 4 && this.status == 200) {
				
				var demoStr = this.responseText;
				//alert(demoStr);
				document.getElementById("getSupMaterial").innerHTML = demoStr;
				//document.getElementById("upSupId").value = demoStr[0];
			}
			};
		xhttp.open("POST", "/SAMERP/PurchaseRawMaterial?findRaw="+raw, true);
		xhttp.send();
	}
	
	//for getting rawmaterialid in updateModal after selecting AJAX dropDown
	function getRawId()
	{
		var val = document.getElementById("upMaterial").value;
	    var opts = document.getElementById('getSupMaterial').childNodes;
	    
		var xhttp = new XMLHttpRequest();
	    
	    for (var i = 0; i < opts.length; i++) {
	      if (opts[i].value === val) {
	        // An item was selected from the list!
	        // yourCallbackHere()
	        //opts[i].value
	        
	        xhttp.onreadystatechange = function() {
			
			if (this.readyState == 4 && this.status == 200) {
				
				var demoStr = this.responseText;
				//alert(demoStr);
				document.getElementById("upRawId").value = demoStr;
				//document.getElementById("upSupId").value = demoStr[0];
			}
			};
	        
	        //alert(opts[i].value);
	        xhttp.open("POST", "/SAMERP/PurchaseRawMaterial?getRawId="+opts[i].value, true);
			xhttp.send();
	        break;
	      }
	    }
	    
	}
	
	//AJAX dropDown for updateModal getting supplierName
	function getSupplier(name)
	{
		//alert(name);
		
		var xhttp = new XMLHttpRequest();
		
		xhttp.onreadystatechange = function() {
			
			if (this.readyState == 4 && this.status == 200) {
				
				var demoStr = this.responseText;
				//alert(demoStr);
				document.getElementById("getSupName").innerHTML = demoStr;
				//document.getElementById("upSupId").value = demoStr[0];
			}
			};
		xhttp.open("POST", "/SAMERP/PurchaseRawMaterial?findName="+name, true);
		xhttp.send();
		
	}
	
	//for getting materialsupid in updateModal after selecting AJAX dropDown
	function getSupId(name)
	{
		var val = document.getElementById("upSupName").value;
	    var opts = document.getElementById('getSupName').childNodes;
	    var xhttp = new XMLHttpRequest();
	    
	    for (var i = 0; i < opts.length; i++) {
	      if (opts[i].value === val) {
	        // An item was selected from the list!
	        // yourCallbackHere()
	        //opts[i].value
	        
	        xhttp.onreadystatechange = function() {
			
			if (this.readyState == 4 && this.status == 200) {
				
				var demoStr = this.responseText;
				//alert(demoStr);
				document.getElementById("upSupId").value = demoStr;
				//document.getElementById("upSupId").value = demoStr[0];
			}
			};
	        
	        //alert(opts[i].value);
	        xhttp.open("POST", "/SAMERP/PurchaseRawMaterial?getId="+opts[i].value, true);
			xhttp.send();
	        break;
	      }
	    }
		
		//alert(name);
	}
	
	
	$('#add-brand').on('shown.bs.modal', function (e) {
		  // do something...
		document.getElementById('supForm').reset();
		document.getElementById('supBname').focus();
	})
	
	$('#add_partical').on('shown.bs.modal', function (e) {
		  // do something...
		document.getElementById('rawForm').reset();
		document.getElementById('raw').focus();
	})
	
	$('#updateModal').on('shown.bs.modal', function (e) {
		  // do something...
		//document.getElementById('rawForm').reset();
		document.getElementById('upSupName').focus();
	})
	
	
	function searchSup(idd,valu)
	{  		var xhttp;
				document.getElementById(idd).value=valu.toUpperCase();
				
				xhttp = new XMLHttpRequest();
				
				xhttp.onreadystatechange = function() {
					
					if (this.readyState == 4 && this.status == 200) {
						
						var demoStr = this.responseText;
						//alert(demoStr);
						document.getElementById("getList").innerHTML = demoStr;
						}
					};
				xhttp.open("POST", "/SAMERP/AddSupplyMaterial?findName="+valu, true);
				xhttp.send();
						
	}
	
	//getting info for update purchase raw material
	function getInfo(id)
	{
		document.getElementById("purId").value=id;
		//alert(id);
		 var xhttp;
		xhttp = new XMLHttpRequest();
		
		xhttp.onreadystatechange = function() {
			
			if (this.readyState == 4 && this.status == 200) {
				
				var demoStr = this.responseText.split(",");
				//alert(demoStr);
				document.getElementById("upSupName").value=demoStr[1];
				document.getElementById("upSupId").value=demoStr[0];
				document.getElementById("upChalan").value=demoStr[2];
				document.getElementById("upMaterial").value=demoStr[6];
				document.getElementById("upRawId").value=demoStr[5];
				document.getElementById("upDate").value=demoStr[3];
				document.getElementById("upVehNo").value=demoStr[4];
				document.getElementById("upQuantity").value=demoStr[7];
				
				}
			};
		xhttp.open("POST", "/SAMERP/PurchaseRawMaterial?pId="+id, true);
		xhttp.send();
	}
	
	
	function getUnit(str)
	{
		//alert(str);
		var xhttp;
		//document.getElementById(idd).value=valu.toUpperCase();
		
		xhttp = new XMLHttpRequest();
		
		xhttp.onreadystatechange = function() {
			
			if (this.readyState == 4 && this.status == 200) {
				
				var demoStr = this.responseText;
				document.getElementById("rawUnit").value=demoStr;
				//document.getElementById("getList").innerHTML = demoStr;
				}
			};
		xhttp.open("POST", "/SAMERP/AddRawMaterial?changeUnit="+str, true);
		xhttp.send();
	
	}
	
	function addRawMaterial()
	{
		var rName=document.getElementById("raw").value
		var unit=document.getElementById("unit").value
		
		var xhttp;
		xhttp = new XMLHttpRequest();
		
		xhttp.onreadystatechange = function() {
			
			if (this.readyState == 4 && this.status == 200) {
				
				var demoStr = this.responseText;
				if(demoStr==0)
				{
					alert("Material Already Present");
				}
				else
				{
					var demoStr = this.responseText.split(",");
					var dropDownRaw=document.getElementById("rawName");
					var dropDownUnit=document.getElementById("rawUnit");
					var newopt=document.createElement("OPTION");
					var newopt1=document.createElement("OPTION");
					newopt.value=demoStr[0];
					newopt.text=demoStr[1];
					newopt1.value=demoStr[0];
					newopt1.text=demoStr[2];
					dropDownRaw.appendChild(newopt);
					var rawCount=dropDownRaw.length;
					dropDownRaw.selectedIndex=rawCount-1;
					dropDownUnit.appendChild(newopt1);
					var unitCount=dropDownUnit.length;
					dropDownUnit.selectedIndex=unitCount-1;
					
					var div=document.createElement("DIV");
					div.id="snackbar";
					div.innerHTML="Inserted Successfully";
					document.body.appendChild(div);
					showSnackBar();
					
					//alert(demoStr[0]+"_"+demoStr[1]+"_"+demoStr[2]);
				}
				//document.getElementById("rawName").focus();
				//alert(demoStr);
				//var demoStr = this.responseText.split(",");
				//document.getElementById("supName").value = demoStr[0];
				//document.getElementById("supContact").value = demoStr[1];
				}
			};
		xhttp.open("POST", "/SAMERP/AddRawMaterial?rName="+rName+"&unit="+unit, true);
		xhttp.send();
		
	}
	
	function subPurRaw()
	{
		var supId=document.getElementById("supId").value;
		var rawId=document.getElementById("rawName").value;
		var unitId=document.getElementById("rawUnit").value;
		var rawDate=document.getElementById("rawDate").value;
		var chalanNo=document.getElementById("chalanNo").value;
		var qty=document.getElementById("qty").value;
		var a = document.getElementById("vn1").value;
		var b = document.getElementById("vn2").value;
		var c = document.getElementById("vn3").value;
		var	d = document.getElementById("vn4").value;
		
		var vNo=a.concat(b, c, d);
		
		if(supId=="")
		{
			//alert("validation");
			document.getElementById('supSearch').focus();
			var mainDiv=document.getElementById("errClass");
			var msg=document.getElementById("errMsg");
			
			mainDiv.setAttribute("class", "control-group error");
			msg.setAttribute("style","display:block");
			
		}
		else if(a=="" || b=="" || c=="" || d=="")
		{
			//alert("v no");
			
			if(a=="")
			{
				document.getElementById("vn1").focus();
			}
			else if(b=="")
			{
				document.getElementById("vn2").focus();
			}
			else if(c=="")
			{
				document.getElementById("vn3").focus();			
			}
			else
			{
				document.getElementById("vn4").focus();
			}
			
			var mainDiv=document.getElementById("vNoValid");
			var msg=document.getElementById("vNoMsg");
			
			mainDiv.setAttribute("class", "control-group error");
			msg.setAttribute("style","display:block");
			
		}
		else if(rawId=="0")
		{
			//alert("dropdown");
				
			document.getElementById('rawName').focus();
			var mainDiv=document.getElementById("rawErr");
			var msg=document.getElementById("rawMsg");
				
			mainDiv.setAttribute("class", "control-group error");
			msg.setAttribute("style","display:block");
		}
		else if(qty=="")
		{
			//alert("quantity x");
			
			document.getElementById('qty').focus();
			var mainDiv=document.getElementById("qtyClass");
			var msg=document.getElementById("qtyMsg");
			
			mainDiv.setAttribute("class", "control-group error");
			msg.setAttribute("style","display:block");
			
		}
		else if(unitId=="0")
		{
			//alert('unit dropdown');
			
			document.getElementById('rawUnit').focus();
			var mainDiv=document.getElementById("unitErr");
			var msg=document.getElementById("unitMsg");
			
			mainDiv.setAttribute("class", "control-group error");
			msg.setAttribute("style","display:block");
		}
		else
		{
			var f=document.getElementById("mainForm");
			f.action="/SAMERP/PurchaseRawMaterial?purchase=1";
			f.submit();
		}
		
		
		//alert(supId+"_"+rawId+"_"+rawDate+"_"+chalanNo+"_"+qty+"_"+vNo);
	/* 		else
		{
			var xhttp;
			//document.getElementById(idd).value=valu.toUpperCase();
			
			xhttp = new XMLHttpRequest();
			
			xhttp.onreadystatechange = function() {
				
				if (this.readyState == 4 && this.status == 200) {
					
					var demoStr = this.responseText;
					if(demoStr==0)
					{
						alert("Not Inserted");
					}
					else
					{
						var div=document.createElement("DIV");
						div.id="snackbar";
						div.innerHTML="Raw Material Purchased Successfully";
						document.body.appendChild(div);
						purchased();
						
						document.getElementById('supSearch').focus();
						//document.getElementById('mainForm').reset();
						document.getElementById('subForm1').reset();
						document.getElementById('subForm2').reset();
						location.reload();
					}
					
					//document.getElementById("getList").innerHTML = demoStr;
					}
				};
			xhttp.open("POST", "/SAMERP/PurchaseRawMaterial?supId="+supId+"&rawId="+rawId+"&rawDate="+rawDate+"&chalanNo="+chalanNo+"&qty="+qty+"&vNo="+vNo, true);
			xhttp.send();

		} */
				
		
	}

	//AJAX dropDown for main page
	function getDetails(name)
	{
		
		var opts = document.getElementById('getList').childNodes;
		for (var i = 0; i < opts.length; i++) {
			 if (opts[i].value === name) 
			 {
				 var xhttp;
					xhttp = new XMLHttpRequest();
					
					xhttp.onreadystatechange = function() {
						
						if (this.readyState == 4 && this.status == 200) {
							
							var demoStr = this.responseText;
							if(demoStr==0)
							{
								var div=document.createElement("DIV");
								div.id="snackbar";
								div.innerHTML="Inserted Successfully";
								document.body.appendChild(div);
								//notFound();
								//document.getElementById('supSearch').focus();
							}
							else
							{
								var demoStr = this.responseText.split(",");
								document.getElementById("supId").value = demoStr[0];
								document.getElementById("supName").value = demoStr[1];
								document.getElementById("supContact").value = demoStr[2];
								document.getElementById('chalanNo').focus();	
							}
							
						}
					};
					xhttp.open("POST", "/SAMERP/AddSupplyMaterial?eName="+name, true);
					xhttp.send(); 
					break;
			 }
		}
	}
	
	function showSnackBar()
	{
		var x = document.getElementById("snackbar");
	    x.className = "show";
	    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
	    document.getElementById("snackbar").innerHTML="Inserted Successfully";
	    
	}
	
	function notFound()
	{
		var x = document.getElementById("snackbar");
	    x.className = "show";
	    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
	    document.getElementById("snackbar").innerHTML="Record Not Found";
	}
	function purchased()
	{
		var x = document.getElementById("snackbar");
	    x.className = "show";
	    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
	    document.getElementById("snackbar").innerHTML="Raw Material Purchased Successfully";
	}
	
	function setFocusToTextBox() {
		
		
		var val=document.getElementById("supContact").value;
		if(!val=="")
		{
			document.getElementById('chalanNo').focus();
		}
		else
		{
			document.getElementById('supSearch').focus();		
		}
		
		
			var x = document.getElementById("snackbar");
		    x.className = "show";
		    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
	}
	
	var a = document.getElementById("vn1");
	var b = document.getElementById("vn2");
	var c = document.getElementById("vn3");
	var	d = document.getElementById("vn4");

	a.onkeyup = function() {
		this.value=this.value.toUpperCase();
	    if (this.value.length === parseInt(this.attributes["maxlength"].value)) {
	        b.focus();
	    }
	}

	b.onkeyup = function() {
	    if (this.value.length === parseInt(this.attributes["maxlength"].value)) {
	        c.focus();
	    }
	}

	c.onkeyup = function() {
		this.value=this.value.toUpperCase();
		if (this.value.length === parseInt(this.attributes["maxlength"].value)) {
	        d.focus();
	    }
	}
	
	$(document).ready(function(){
		$('input:text[value=""]').add('input:password[value=""]').first().focus();
	});


	</script>

</body>
</html>