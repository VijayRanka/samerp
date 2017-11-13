<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="utility.RequireData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>sidhu SAMERP PROJECT</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/SAMERP/config/css/jquery.mobile-1.4.5.css">
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/fullcalendar.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link rel="stylesheet" href="/SAMERP/config/css/jquery.gritter.css" />
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
<body onload="setFocusToTextBox()">

<!--Header-part-->
<div id="header">
  <h1><a href="dashboard.html">Matrix Admin</a></h1>
</div>

<!--start-top-serch-->
<div id="search">
<% if(request.getAttribute("status")!=null){ %>
<div id="snackbar"><%=request.getAttribute("status")%></div>
<%} %>

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
	    <div id="breadcrumb"> <a href="index.html" class="tip-bottom" data-original-title="Go to Home"><i class="icon-home">
	    </i> Home</a> <a href="#" class="current">Add Material Suppliers</a> </div>
	  </div>
	<!--End-breadcrumbs-->
<div class="container-fluid">
  <hr>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-align-justify"></i>
							</span>
							<h5>Add Data</h5>
						</div>
						<div class="widget-content nopadding">
							<form action="/SAMERP/AddSupplyMaterial" method="post" class="form-horizontal">
								<div class="control-group">
									<label class="control-label">Suppliers-Business Name:</label>
									<div class="controls">
										<input type="text" name="suppbusinesname" class="span7"
											placeholder="Suppliers-Business Name" onkeyup="this.value=this.value.toUpperCase()" pattern="[a-z A-Z]*" required/>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Suppliers Name:</label>
									<div class="controls">
										<input type="text" name="suppname" class=span7
											placeholder="Suppliers Name" onkeyup="this.value=this.value.toUpperCase()" pattern="[a-z A-Z]*" required/>
									</div>
								</div>
								
								
								<div class="control-group">
									<label class="control-label">Suppliers Address:</label>
									<div class="controls">
										<textarea type="text" name="address" class="span7"
											onkeyup="this.value=this.value.toUpperCase()"
											placeholder="Supplier Address" pattern="[a-z A-Z]*"
											maxlength="200" required></textarea>

									</div>
								</div>
								
								<div class="control-group">
									<label class="control-label">Suppliers Contact :</label>
									<div class="controls">
										<input type="text" name="contact" class="span7"
											placeholder="Suppliers Contact" maxlength="10"  pattern="[0-9]*" required/>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Opening Balance :</label>
									<div class="controls">
										<input type="number" name="openingbalance" class="span7"
											placeholder="Opening Balance" pattern="[0-9]*" required/>
									</div>
								</div>
								
								<div class="control-group">
									<label class="control-label">Type:</label>
									<div class="controls">
										<select name="material_type" class="span7" >
											<option value="1">Raw Material</option>
											<option value="2">Product</option>
										</select>
									</div>
								</div>
								<div class="form-actions" style="padding-left: 350px">
									<button type="submit" name="insertsupply" class="btn btn-success">Submit</button>
								 <a href="/SAMERP/index.jsp" id="cancelbtn"  class="btn btn-danger">Exit</a>

								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			
			
			<div class="row-fluid">
				<div class="span12">

					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"><i class="icon-th"></i></span>
							<h5>client Details</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered data-table">
								<thead>
									<tr>
									<th>Sr.No</th>
									<th>Supplier_Business_Name</th>
									<th>Supplier_Name</th>
									<th>Supplier_Address</th>
									<th>Supplier_Contact_No</th>
									<th>Supplier_Opening_Balance</th>
									<th>Type</th>
									<th>Action</th>
									</tr>
								</thead>
								<%
								int id=0,count=1;
								
								RequireData rd=new RequireData();
								List list=rd.getMaterialSupplyData1();
								if(list!=null)
								{
									Iterator itr=list.iterator();
									
								%>
								<tbody>
									<%
									String product,RawMaterial;
										while (itr.hasNext()) {
												String id1 = itr.next().toString();		
											
									%>
									<tr class="gradeX">
										<td id="<%=id1%>"><%=count%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<% String type = itr.next().toString(); 
										if(type.equals("2")){
										%>
											<td>Product</td>
										<%}else{ %>
											<td>RawMaterial</td>
										<%} %>
														
										<td><a href="#update" data-toggle="modal" onclick="searchName(<%=id1%>)">Update</a> |
										<a onclick="getDeleteId(<%=id1%>)" href="#DeleteConfirmBox" data-toggle='modal'>Delete</a></td>
									</tr>
									<%
										count++;
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


	<div id="update" class="modal hide fade" role="dialog"
		style="width: 50%; margin-left: -28%;">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Update Suppliers Material</h4>
				</div>
				<div class="modal-body">

					<form action='/SAMERP/AddSupplyMaterial' name="form2" method="Post"	class="form-horizontal">
						<div class="control-group">
							<label class="control-label">Suppliers Business Name:</label>
							<div class="controls">
								<input type="hidden" id="Updateid" name="Updateid" />
								<input type="hidden" id="old_sup_alias" name="old_sup_alias" />
								<input type="hidden" id="update_material_type" name="material_type" />
								 
								<input type="text" name="suppbusinesname" id="update_business_name"
									class="span4" placeholder="Suppliers-Business Name"
									onkeyup="this.value=this.value.toUpperCase()"
									pattern="[a-z A-Z]*" required />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Suppliers Name:</label>
							<div class="controls">
								
									<input type="text" name="suppname" id="update_suppname" class="span4" placeholder="Suppliers Name"
										onkeyup="this.value=this.value.toUpperCase()"
										pattern="[a-z A-Z]*" required />
								
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Supplier Address:</label>
							<div class="controls">
								<textarea type="text" name="address" id="update_address"
									class="span4" onkeyup="this.value=this.value.toUpperCase()"
									placeholder="Supplier Address" pattern="[a-z A-Z]*"
									maxlength="200" required></textarea>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">Suppliers Contact:</label>
							<div class="controls">
								<input type="text" name="contact" id="update_contact"
									class="span4" placeholder="Suppliers Contact" pattern="[0-9]*"
									required />
							</div>
						</div>
						<div class="control-group">
									<label class="control-label">Opening Balance :</label>
									<div class="controls">
										<input type="number" name="openingbalance" id="opening_balance" class="span4"
											placeholder="Opening Balance" pattern="[0-9]*" required/>
									</div>
								</div>
						
						
						<div class="form-actions" style="padding-left: 450px">
							<button type="submit" name="save" class="btn btn-success">Update</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>

			</div>

		</div>
	</div>
	
	
		<div class="modal fade" id="Insert_time" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 style="color: red;" class="modal-title">Error</h4>
						</div>
						<div class="modal-body">
							<form class="form-horizontal" action="#" method="post" name="form4">
								<div class="form-group">
									<div class="widget-content nopadding">
										<div class="control-group">
		
											<h4>Supplier Business Name already Exist...</h4>
										</div>
									</div>
									<div class="modal-footer">
										<input type="button" class="btn btn-primary" id="submitbtn"
											data-dismiss="modal" value="OK" />
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" id="DeleteConfirmBox" role="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h4 style="color: red;" class="modal-title">Error</h4>
							</div>
							<div class="modal-body">
								<form class="form-horizontal" action="/SAMERP/AddSupplyMaterial" method="post" name="form4">
									<div class="form-group">
										<div class="widget-content nopadding">
											<div class="control-group">
														<input type="hidden" id="deleteid" name="delete"/>
														
												<h4> Are you sure want to delete the selected row...!!</h4>
											</div>
										</div>
										<div class="modal-footer">			
															
											<input type="submit" class="btn btn-primary" id="submitbtn" value="OK" />
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
	
			<div class="modal fade" id="error-msg-delete" role="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h4 style="color: red;" class="modal-title">Error</h4>
							</div>
							<div class="modal-body">
								<form class="form-horizontal" action="#" method="post" name="form4">
									<div class="form-group">
										<div class="widget-content nopadding">
											<div class="control-group">
			
												<h4> Cannot delete the Selected record as it is linked with some other records..!! </h4>
											</div>
										</div>
										<div class="modal-footer">
											<input type="button" class="btn btn-primary" id="submitbtn"
												data-dismiss="modal" value="OK" />
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>


	<!--end-main-container-part-->

<!--Footer-part-->

<div class="row-fluid">
  <div id="footer" class="span12"> 2013 &copy; Matrix Admin. Brought to you by <a href="http://themedesigner.in">Themedesigner.in</a> </div>
</div>

<!--end-Footer-part-->

<script type="text/javascript">

 function searchName(id1) {
 
 	var xhttp;
 	xhttp = new XMLHttpRequest();
 	xhttp.onreadystatechange = function() {
 		if (this.readyState == 4 && this.status == 200) {
 			
 			var demoStr = this.responseText.split(",");
 			
 			document.getElementById("Updateid").value = demoStr[0];
 			document.getElementById("update_business_name").value = demoStr[1];
 			document.getElementById("update_suppname").value = demoStr[2];
 			document.getElementById("update_address").value = demoStr[3];
 			document.getElementById("update_contact").value = demoStr[4];
 			document.getElementById("opening_balance").value = demoStr[5];
 			alert(demoStr[1]);
 			}	
 		};
 	xhttp.open("POST","/SAMERP/AddSupplyMaterial?UpdData="+id1, true);
 	xhttp.send();
 	
 	
 }
 
function myFunction() {
    var x = document.getElementById("snackbar")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}

function showModal(){
	var error = <%= request.getAttribute("error") %>;
	var someVarName = localStorage.getItem("someVarName");
		
	if(error==2)
	{
		$('#Insert_time').modal('show');
	}
	else if(error==3)
	{
		$('#error-msg-delete').modal('show');	
	}
	else if(someVarName>0)
	{
		$('#update').modal('show');
	}
	localStorage.setItem('someVarName', null);
}

function setFocusToTextBox()
{
	document.getElementById("update_business_name").focus();	
	showModal(); 
	myFunction();
	 
}



</script>
<script src="/SAMERP/config/js/jquery-1.11.3.js"></script>
<script src="/SAMERP/config/js/jquery.mobile-1.4.5.js"></script>
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

<script type="text/javascript">


function getDeleteId(id1)
{
	document.getElementById("deleteid").value=id1;
	
}
</script>
</body>

</html>
