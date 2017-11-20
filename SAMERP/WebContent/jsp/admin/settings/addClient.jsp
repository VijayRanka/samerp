<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.mysql.jdbc.ResultSet"%>
<%@page import="dao.General.GenericDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.*"%>
<%@ page import="utility.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SAMERP PROJECT</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />
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
		<h1>
			<a href="dashboard.html">Matrix Admin</a>
		</h1>
	</div>

	<!--start-top-serch-->
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
	<!--close-top-serch-->
<!--sidebar-menu-->
<jsp:include page="../common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->

	<!--main-container-part-->
	<div id="content">
		<!--breadcrumbs-->

		<div id="content-header">
			<div id="breadcrumb">
				<a href="/SAMERP/index.jsp" title="Go to Home" class="tip-bottom"><i
					class="fa fa-home"></i> Home</a> <a href="#" class="current">Add
					Client</a>
			</div>
		
		</div>
		<div class="container-fluid">
			<hr>
			<%
				RequireData rq = new RequireData();
			%>
			<div class="row-fluid">
				<div class="span15">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-align-justify"></i>
							</span>
							<h5>Add Client</h5>
						</div>
						<div class="widget-content nopadding">
							<form action="/SAMERP/AddClient" method="Post"
								class="form-horizontal" onsubmit="return validateForm()">
								<div class="control-group">
									<label class="control-label">Client Orgnization Name:</label>
									<div class="controls">
										<input type="text" id="coname" name="coname" class="span6"
											onkeyup="this.value=this.value.toUpperCase()"
											placeholder="Client Orgnization Name" pattern="[a-z A-Z]*"
											required />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Client Name:</label>
									<div class="controls">
										<input type="text" name="cname" class="span6"
											onkeyup="this.value=this.value.toUpperCase()"
											placeholder="Client Name" pattern="[a-z A-Z]*" required />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Client Contact No:</label>
									<div class="controls">
										<input type="text" name="contactno1" id="validateno1"
											class="span6" placeholder="Client ContactNo1 "
											onkeyup="this.value=this.value.toUpperCase()"
											pattern="[0-9]*" maxlength="10" required />
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">GSTIN:</label>
									<div class="controls">
										<input type="text" name="gstin" id="gstinid"
											class="span6" placeholder="GSTIN "
											onkeyup="this.value=this.value.toUpperCase()"
											pattern="[a-z A-Z 0-9]*" required />
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">Client EmailId:</label>
									<div class="controls">
										<input type="email" class="span6" name="email"
											placeholder="Client Email Id" required />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Client Address:</label>
									<div class="controls">
										<textarea type="text" class="span6" name="address"
											onkeyup="this.value=this.value.toUpperCase()"
											placeholder="Client Address" pattern="[a-z A-Z]*"
											maxlength="200" required></textarea>

									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Client Balance Amount:</label>
									<div class="controls">

										<input type="text" name="bamount"
											placeholder="Client Balance Amount" class="span6"
											onkeyup="this.value=this.value.toUpperCase()"
											pattern="[0-9]*" required />
									</div>
								</div>
								<div class="form-actions" style="padding-left: 350px">
									<button type="submit" name="insert" class="btn btn-success">Submit</button>&nbsp;&nbsp;&nbsp;
									 <a href="/SAMERP/dashboard.jsp" id="cancelbtn"  class="btn btn-danger">Exit</a>
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
										<th>client_id</th>
										<th>client_orgnization_name</th>
										<th>client_name</th>
										<th>client_contactno</th>
										<th>gstin</th>
										<th>client_email</th>
										<th>client_address</th>
										<th>client_balance_amount</th>
										<th>Action</th>
									</tr>
								</thead>
								<%
									int id = 0, count = 1;
									RequireData rd = new RequireData();
									List l = rd.getClientDetails();
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
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><a href="#update" data-toggle="modal" onclick="searchName(<%=id1%>)"><i class="icon-pencil"></i></a> / 
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


	<!-- Modal -->
	<div id="update" class="modal hide fade" role="dialog"
		style="width: 55%; margin-left: -28%;">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Update Client Details</h4>
				</div>
					<form action='/SAMERP/AddClient' name="form2" method="Post"
						class="form-horizontal">
						<div class="modal-body">
						<div class="control-group">
							<label class="control-label">Client Orgnization Name:</label>
							<div class="controls">
								<input type="hidden" id="Updateid" name="Updateid" />
								<input type="hidden" id="old_coname" name="old_coname" />
								 
								<input type="text" name="coname" id="Updateconame" class="span4" placeholder="Client Orgnization Name" onkeyup="this.value=this.value.toUpperCase()" required />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Client Name:</label>
							<div class="controls">
								<div class="input-append">
									<input type="text" name="cname" id="Updatecname" class="span4"
										placeholder="Client Name" maxlength="10"
										onkeyup="this.value=this.value.toUpperCase()" required />
								</div>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Client Contact No:</label>
							<div class="controls">
								<input type="text" name="contactno1" id="Updatecontactno1"
									class="span4" placeholder="Client ContactNo1 "
									onkeyup="this.value=this.value.toUpperCase()" required />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">GSTIN:</label>
							<div class="controls">
								<input type="text" name="gstin" id="gstinid"
									class="span4" placeholder="GSTIN " pattern="[a-z A-Z 0-9]*"
									onkeyup="this.value=this.value.toUpperCase()" required />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">Client EmailId:</label>
							<div class="controls">
								<input type="email" class="span4" name="email" id="Updateemail"
									placeholder="Enter Client Email Id" required />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Client Address:</label>
							<div class="controls">
								<textarea type="text" class="span4" name="address"
									id="Updateaddress" placeholder="Client Address"
									requonkeyup="this.value=this.value.toUpperCase()" required></textarea>

							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Client Balance Amount:</label>
							<div class="controls">

								<input type="text" name="bamount" id="Updatebamount"
									placeholder="Client Balance Amount" class="span4"
									onkeyup="this.value=this.value.toUpperCase()" required />
							</div>
						</div>
						</div>
						<div class="modal-footer" style="padding-left: 450px">
							<button type="submit" name="save" class="btn btn-success">Update</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						</div>
						
					</form>
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

									<h4>Organization Name already Exist...</h4>
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
								<form class="form-horizontal" action="/SAMERP/AddClient" method="post" name="form4">
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
	<!--  modal end -->
	
	<div class="row-fluid">
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a
				href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
	</div>
	
	<script type="text/javascript">

function searchName(id1) {
	
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			
			var demoStr = this.responseText.split(",");
			document.getElementById("Updateid").value = demoStr[0];
			document.getElementById("Updateconame").value = demoStr[1];
			document.getElementById("old_coname").value = demoStr[1];
			document.getElementById("Updatecname").value = demoStr[2];
			document.getElementById("Updatecontactno1").value = demoStr[3];
			document.getElementById("gstinid").value = demoStr[4];
			document.getElementById("Updateemail").value = demoStr[5];
			document.getElementById("Updateaddress").value = demoStr[6];
			document.getElementById("Updatebamount").value = demoStr[7];
			
			
			}
		};
	xhttp.open("POST","/SAMERP/AddClient?Updateid="+id1, true);
	xhttp.send();
	
	
}

function myFunction() {
    var x = document.getElementById("snackbar")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}

function showModal(){
	var someVarName = localStorage.getItem("someVarName");

	var error = <%=request.getAttribute("error")%>;

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
			$('#update').modal('show');
		}
	localStorage.setItem('someVarName', null);
}

function setFocusToTextBox()
{
	document.getElementById("coname").focus();
	showModal();   	
	 myFunction();
}


</script>

	<!--end-Footer-part-->

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
	 document.getElementById("deleteid").value=id1;
	}
	 </script>
</body>
</html>