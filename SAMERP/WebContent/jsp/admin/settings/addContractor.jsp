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
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">

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
.table td {
   text-align: center;   
}
</style>
</head>

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
<jsp:include page="../common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->	

	<div id="content">
		<!--breadcrumbs-->
		<div id="content-header">
			<div id="breadcrumb">
				<a href="index.html" class="tip-bottom"
					data-original-title="Go to Home"><i class="icon-home"> </i>
					Home</a> <a href="#" class="current">Add Contractor </a>
			</div>
		</div>
		<!--End-breadcrumbs-->
		<div class="container-fluid">
			<hr>
			<div class="row-fluid">
				<div class="span14">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-align-justify"></i>
							</span>
							<h5>Add Contractor </h5>
						</div>
						<div class="widget-content nopadding">
							<form action="/SAMERP/AddContractor" method="post"
								onsubmit="return Submit()" class="form-horizontal">

								<div class="control-group">
									<label class="control-label">Name:</label>
									<div class="controls">
										<input type="text" name="name" class="span6" id="name"
											placeholder="Name"
											onkeyup="this.value=this.value.toUpperCase()"
											pattern="[a-z A-Z ]*" required />
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">Contact No:</label>
									<div class="controls">
										<input type="text" name="contact_no" class="span6"
											placeholder="Contact No" maxlength="10"
											onkeyup="this.value=this.value.toUpperCase()"
											pattern="[0-9]*" required />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Address:</label>
									<div class="controls">
										<textarea type="text" class="span6" name="address"
											onkeyup="this.value=this.value.toUpperCase()"
											placeholder="Address" pattern="[a-z A-Z 0-9]*"
											 required></textarea>

									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Due Balance:</label>
									<div class="controls">
										<input type="number" name="due_balance" class="span6"
											placeholder="Due Balance"
											onkeyup="this.value=this.value.toUpperCase()"
											pattern="[0-9]*" required />
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">Alias Name:</label>
									<div class="controls">
										<input type="text" name="alias_name" class="span6"
											placeholder="Alias Name"
											onkeyup="this.value=this.value.toUpperCase()"
											pattern="[a-z A-Z _ 0-9]*" required />
									</div>
								</div>

								<div class="form-actions" style="padding-left: 350px">
									<button type="submit" name="submit" id="submitbtn" class="btn btn-success" >Submit</button>&nbsp;&nbsp;&nbsp;
									 <a href="/SAMERP/dashboard.jsp" id="cancelbtn"  class="btn btn-danger">Exit</a>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="row-fluid">
				<div class="span14">

					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"><i class="icon-th"></i></span>
							<h5>Contractor Details</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered data-table">
								<thead>
									<tr>
										<th>Contractor Id</th>
										<th>Name</th>
										<th>Contact No</th>
										<th>Address</th>
										<th>Due Balance</th>
										<th>Alias Name</th>
										<th>Action</th>
									</tr>
								</thead>
								<%
									int id = 0, count = 1;
									RequireData rd = new RequireData();
									List l = rd.getContractorDetails();
									if (l != null) {
										Iterator itr = l.iterator();
								%>
								<tbody>
									<%
										while (itr.hasNext()) {
												String id1 = itr.next().toString();
									%>
									<tr class="gradeX">
										<td id="<%=id1%>"><%=count%></td>
										<td ><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><a href="#myModal" data-toggle="modal" onclick="searchName(<%=id1%>)"><i class="icon-pencil"></i></a> / 
											<a onclick="getDeleteId(<%=id1%>)" href="#DeleteConfirmBox" data-toggle='modal'><i class="icon-remove"></i></a></td>
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
	<div id="myModal" class="modal hide fade" role="dialog"
		style="width: 50%; margin-left: -28%;">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Update Contractor Details</h4>
				</div>
				<div class="modal-body">

					<form action='/SAMERP/AddContractor' onsubmit="return Submit()"
						name="form2" method="Post" class="form-horizontal">
						<div class="control-group">
							<label class="control-label">Name:</label>
							<div class="controls">
								<input type="hidden" id="Updateid" name="Updateid" /> 
								<input	type="text" name="name" id="updatecname" class="span4"
									placeholder="Name" pattern="[a-z A-Z]*"
									onkeyup="this.value=this.value.toUpperCase()" required />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">Contact No:</label>
							<div class="controls">
								<input type="text" id="updatecontactno" name="contact_no"
									class="span4" maxlength="10" placeholder="Contact No" pattern="[0-9]*"
									required />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Address:</label>
							<div class="controls">
								<textarea type="text" id="updateaddress" class="span4"
									name="address" onkeyup="this.value=this.value.toUpperCase()"
									placeholder="Address" pattern="[a-z A-Z 0-9]*" maxlength="200"
									required></textarea>

							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Due Balance:</label>
							<div class="controls">
								<input type="text" id="updateduebalance" name="due_balance"
									class="span4" placeholder="Due Balance" pattern="[0-9]*"
									required />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Alias Name:</label>
							<div class="controls">
								<input type="text" id="updatealiasname" name="alias_name"
									class="span4" placeholder="Alias Name" pattern="[a-z A-Z 0-9]*" readonly
									required />
							</div>
						</div>
						<div class="form-actions" style="padding-left: 450px">
						<button type="submit" name="save" id="submitbtn" class="btn btn-success">Update</button>
						<button type="button" class="btn btn-danger" style="margin-left: 10px;" data-dismiss="modal">Close</button>
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

									<h4>Team is already Exist...</h4>
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
								<form class="form-horizontal" action="/SAMERP/AddContractor" method="post" name="form4">
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
	
	

	<script type="text/javascript">
	
	function myFunction() {
	    var x = document.getElementById("snackbar")
	    x.className = "show";
	    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
	}

function searchName(id1) {
	
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			
			var demoStr = this.responseText.split(",");
			document.getElementById("Updateid").value = demoStr[0];
			document.getElementById("updatecname").value = demoStr[1];
			document.getElementById("updatecontactno").value = demoStr[2];
			document.getElementById("updateaddress").value = demoStr[3];
			document.getElementById("updateduebalance").value = demoStr[4];
			document.getElementById("updatealiasname").value = demoStr[5];
			}
		};
	xhttp.open("POST","/SAMERP/AddContractor?Updateid="+id1, true);
	xhttp.send();
	
	
}

function submit()
{
	
	var aliasname=document.getElementById("error").value;
	return ;
}



function showModal(){
	var someVarName = localStorage.getItem("someVarName");
	
	var error =<%=request.getAttribute("error")%>;

	if(error==2)
	{
		$('#Insert_time').modal('show');
	}
	else if(error==3)
	{
		$('#error-msg-delete').modal('show');
	}
	
	if(someVarName>0)
		{
			$('#myModal').modal('show');
		}
	localStorage.setItem('someVarName', null);
}

function setFocusToTextBox()
{
	document.getElementById("name").focus();
	document.getElementById("updatecname").focus();
	
	showModal();   	
	 myFunction();
}


</script>

<div class="row-fluid">
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a
				href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
	</div>
<script src="/SAMERP/config/js/jquery.min.js"></script>
	<script src="/SAMERP/config/js/jquery.ui.custom.js"></script>
	<script src="/SAMERP/config/js/bootstrap.min.js"></script>
	<script src="/SAMERP/config/js/jquery.uniform.js"></script>
	<script src="/SAMERP/config/js/select2.min.js"></script>
	<script src="/SAMERP/config/js/jquery.dataTables.min.js"></script>
	<script src="/SAMERP/config/js/matrix.js"></script>
	<script src="/SAMERP/config/js/matrix.tables.js"></script>
	
	<script type="text/javascript">
	function getDeleteId(id1)
	{
	 document.getelementById("deleteid").value=id1;
	}
	
	$('#myModal').on('shown.bs.modal', function () {
	    $('#updatecname').focus();
	})
	 </script>
</body>
</html>
