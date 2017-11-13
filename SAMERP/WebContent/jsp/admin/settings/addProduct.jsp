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
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />
<link rel="stylesheet" href="/SAMERP/config/css/select2.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="/SAMERP/config/css/fullcalendar.css" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
	
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
</head>



<body onload=" setFocusToTextBox()">

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

<!--main-container-part-->
	<div id="content">
		<!--breadcrumbs-->

		<div id="content-header">
			<div id="breadcrumb">
				<a href="/SAMERP/index.jsp" title="Go to Home" class="tip-bottom"><i
					class="fa fa-home"></i> Home</a> <a href="#" class="current">Add Product</a>
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
							<h5>Add New Product</h5>
						</div>
						<div class="widget-content nopadding">
							<form action="/SAMERP/AddProduct" method="Post"
								class="form-horizontal" onsubmit="return validateForm()">
								<div class="control-group">
									<label class="control-label">Product Name:</label>
									<div class="controls">
										<input type="text" id="productname" name="productname"
											class="span6" onkeyup="this.value=this.value.toUpperCase()"
											placeholder="Product Name" pattern="[a-z A-Z 0-9]*" required />
									</div>
								</div>
								
								<div class="control-group">
									<label class="control-label">Contracter Name:</label>
									<div class="controls">
										<select name="contractor_name" class="span6">
									
										<%
							
								List details=rq.getContracterName();
								if(details!=null)
								{
									Iterator itr=details.iterator();
									while(itr.hasNext())
									{
										String id=itr.next().toString();
										String work_with=itr.next().toString();
									%>
										<option value="<%=id%>"><%=work_with%></option>
									<%
									}
									%>
										</select>
									</div>
									<%
								}
									%>
								</div>

								<div class="control-group">
									<label class="control-label">HSN Code:</label>
									<div class="controls">
										<input type="text" id="hsncode" name="hsn_code" class="span6"
											placeholder="HSN Code" pattern="[0-9]*" required />
									</div>
								</div>
								
								<div class="control-group">
									<label class="control-label">GST(%):</label>
									<div class="controls">
										<input type="text" id="gstper" name="gst_per" class="span6"
											placeholder="GST(%)" pattern="[0-9]*" required />
									</div>
								</div>
								
							<div class="form-footer">
								<div class="form-actions" style="padding-left: 350px">
									<button type="submit" name="submit" class="btn btn-success">Submit</button>&nbsp;&nbsp;&nbsp;
									 <a href="/SAMERP/index.jsp" id="cancelbtn"  class="btn btn-danger">Exit</a>
								</div>
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
							<h5>Product Details</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered data-table">
								<thead>
									<tr>
										<th>Product Id</th>
										<th>Contracter Name</th>
										<th>Product Name</th>										
										<th>HSN Code</th>
										<th>GST(%)</th>
										<th>Action</th>
									</tr>
								</thead>
								<%
									int id = 0, count = 1;
									
									List l = rq.getProductDetails();
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
										<td><%=itr.next() %></td>
										<%-- <td><%=constid%></td> --%>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><a href="#myModal" data-toggle="modal" onclick="searchName(<%=id1%>)">Update</a> / 
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

	<!-- Modal -->
	<div id="myModal" class="modal hide fade" role="dialog"
		style="width: 50%; margin-left: -28%;">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Update Product Details</h4>
				</div>
				<div class="modal-body">

					<form action='/SAMERP/AddProduct' name="form2" method="Post" class="form-horizontal">
						<div class="control-group">
							<label class="control-label">Name:</label>
							<div class="controls">
								<input type="hidden" id="Updateid" name="Updateid" />
								 <input	type="text" name="name" id="updatepname" class="span4" placeholder="Product Name"  onkeyup="this.value=this.value.toUpperCase()" style="width: 385px;" />
							</div>
						</div>
					
						<div class="control-group">
							<label class="control-label">HSN Code</label>
							<div class="controls">
							 <input	type="text" name="hsn_code" id="updatehsncode" class="span4" placeholder="HSN Name" pattern="[a-z A-Z 0-9]*" onkeyup="this.value=this.value.toUpperCase()" style="width: 385px;" />
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">GST(%)</label>
							<div class="controls">
							 <input	type="text" name="gst_per" id="updategstper" class="span4" placeholder="GST(%)" pattern="[0-9]*" style="width: 385px;" />
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Contractor Name:</label>
									<div class="controls">
										<select name="contractor_name" id="updatecontractorname">
									
										<%
							
								List list=rq.getContracterName();
								if(list!=null)
								{
									Iterator itr=list.iterator();
									while(itr.hasNext())
									{
										String id1=itr.next().toString();
										String alias_name=itr.next().toString();
									%>
										<option value="<%=id1%>"><%=alias_name%></option>
									<%
									}
									%>
										</select>
									</div>
									<%
								}
									%>
						</div>
						
						<div class='modal-footer' >
							<button type="submit" name="save" class="btn btn-success">Update</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
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
								<form class="form-horizontal" action="/SAMERP/AddProduct" method="post" name="form4">
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
  <div id="footer" class="span12"> 2013 &copy; Matrix Admin. Brought to you by <a href="http://themedesigner.in">Themedesigner.in</a> </div>
</div>
	
<script type="text/javascript">

function searchName(id1) {
	
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			
			var demoStr = this.responseText.split(",");
			"WebContent/jsp/admin/settings/AddProduct.jsp"
			document.getElementById("Updateid").value = demoStr[0];
			document.getElementById("updatepname").value = demoStr[1];
			document.getElementById("updatehsncode").value=demoStr[2];
			document.getElementById("updategstper").value=demoStr[3];
			document.getElementById("updatecontractorname").value = demoStr[4];
			
			var dd = document.getElementById('updatecontractorname');
			
			for (var i = 0; i < dd.options.length; i++) {
			    if (dd.options[i].text === demoStr[4]) {
			        dd.selectedIndex = i;
			        //alert(demoStr[4]);
			        getSetSelect('s2id_updatecontractorname', demoStr[4]);
			        break;
			    }
			}
			
			}
		};
	xhttp.open("POST","/SAMERP/AddProduct?Updateid="+id1, true);
	xhttp.send();
	
	
}

function getSetSelect(id,value)
{
	var x=document.getElementById(id).children;
	var xx=x[0].children;
	xx[0].innerHTML=value;
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
			$('#myModal').modal('show');
		}
	localStorage.setItem('someVarName', null);
}

function setFocusToTextBox()
{
	document.getElementById("updatepname").focus();
	showModal();   	
	 myFunction();
}


</script>

	<!--end-Footer-part-->

<script src="/SAMERP/config/js/jquery.min.js"></script> 
<script src="/SAMERP/config/js/jquery.ui.custom.js"></script> 
<script src="/SAMERP/config/js/bootstrap.min.js"></script> 
<script src="/SAMERP/config/js/bootstrap-datepicker.js"></script> 
<script src="/SAMERP/config/js/jquery.toggle.buttons.js"></script> 
<script src="/SAMERP/config/js/jquery.uniform.js"></script> 
<script src="/SAMERP/config/js/select2.min.js"></script> 
<script src="/SAMERP/config/js/jquery.dataTables.min.js"></script> 
<script src="/SAMERP/config/js/matrix.js"></script> 
<script src="/SAMERP/config/js/matrix.tables.js"></script>
<script src="/SAMERP/config/js/wysihtml5-0.3.0.js"></script> 
<script src="/SAMERP/config/js/jquery.peity.min.js"></script> 
<script src="/SAMERP/config/js/bootstrap-wysihtml5.js"></script> 
<script src="/SAMERP/config/js/fullcalendar.min.js"></script>

<script type="text/javascript">
	function getDeleteId(id1)
	{
	 document.getElementById("deleteid").value=id1;
	}
	 </script>
</body>
</html>