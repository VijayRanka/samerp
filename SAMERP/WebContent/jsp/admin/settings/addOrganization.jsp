<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="utility.RequireData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SAMERP PROJECT</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/fullcalendar.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="/SAMERP/config/css/jquery.gritter.css" />
<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">
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
<jsp:include page="/jsp/admin/common/header_navbar.jsp"></jsp:include>
<!--close-Header-part-->
<% if(request.getAttribute("status")!=null){ %>
<div id="snackbar"><%=request.getAttribute("status")%></div>
<%} %>


<!--close-top-serch-->
<!--sidebar-menu-->
<jsp:include page="../common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->

<!--main-container-part-->
<div id="content">
<!--breadcrumbs-->
  <div id="content-header">
    <div id="breadcrumb"> <a href="/SAMERP/dashboard.jsp" class="tip-bottom" data-original-title="Go to Home"><i class="icon-home"></i> Home</a> <a href="#" class="current">Add Organization</a> </div>
  </div>
<!--End-breadcrumbs-->
<div class="container-fluid">
  <hr>
  <div class="row-fluid">
    <div class="span12">
      <div class="widget-box">
        <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
          <h5>Add Organization</h5>
        </div>
        <div class="widget-content nopadding">
          <form action="/SAMERP/AddOrganization" method="post" class="form-horizontal" enctype="multipart/form-data">
            <div class="control-group">
              <label class="control-label"><span style="color: red;">*</span> Organization Name :</label>
              <div class="controls">
                <input type="text" name="organizationname" id="organizationname" class="span6" placeholder="Organization Name" onkeyup="this.value=this.value.toUpperCase()" pattern="[a-z A-Z]*"  required/>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label"><span style="color: red;">*</span>Address :</label>
              <div class="controls">
                <input type="textarea" name="address" class="span6" placeholder="Address" onkeyup="this.value=this.value.toUpperCase()" pattern="[a-z A-Z 0-9]*" required/>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label"><span style="color: red;">*</span>Contact No. :</label>
              <div class="controls">
                <input type="text" name="contactno1" class="span3" placeholder="Contact Number" onkeypress="return isNumber(event)" maxlength="10" required/> &nbsp; / &nbsp;
                <input type="text" name="contactno2" class="span3" placeholder="Contact Number" onkeypress="return isNumber(event)" maxlength="10" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">Email :</label>
              <div class="controls">
                <input type="text" name="email" class="span6" placeholder="Email" required/>
              </div>
            </div>
            
            <div class="control-group">
              <label class="control-label">Opening Balance:</label>
              <div class="controls">
                <input type="text" name="opening_balance" class="span6" placeholder="Opening Balance" pattern="[0-9]*" required/>
              </div>
            </div>
            
            <div class="form-actions" >
            <button type="submit" name="insertorganizer" class="btn btn-success" style="position:relative; right:580px; float:right;">Submit</button>
              <a href="/SAMERP/dashboard.jsp"><button type="button" class="btn btn-danger " style="position:relative; right:450px;   float:right;">Exit</button></a>
            </div>  
          </form>
        </div>
      </div>
    </div>
  </div>
  
  
    		<div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
            <h5>Organization Details</h5>
          </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered table-striped">
              <thead>
                <tr>
                  <th>S.No.</th>
                  <th>Organization Name</th>
                  <th>Contact No1</th>
                  <th>Contact No2</th>
                  <th>Address</th>
                  <th>Email ID</th>
                  <th>Opening Balance</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
              <%
                RequireData rd=new RequireData();
              	List getMSPData=rd.getOrganizationData();
              	if(getMSPData!=null){
              	Iterator itr=getMSPData.iterator();
              	int i=1;
              	while(itr.hasNext()){ Object organization_id=itr.next();
              	%>
                <tr>
                  <td style="text-align: center"><%=i %><% i++; %></td>
                  <td style="text-align: center"><%=itr.next() %></td>
                  <td style="text-align: center"><%=itr.next() %></td>
                  
                  <% Object contactno2= itr.next(); 
										if(contactno2==null){
										%>
											<td style="text-align: center">-</td>
										<%}else{ %>
											<td style="text-align: center"><%=contactno2 %></td>
										<%} %>
                  
                  <td style="text-align: center"><%=itr.next() %></td>
                  <td style="text-align: center"><%=itr.next() %></td>
                  <td style="text-align: center"><%=itr.next() %></td>
                  <td style="text-align: center"><a href="#update_organization" data-toggle="modal" class="tip-top" data-original-title="Update" onclick="searchOrganization(<%=organization_id%>)"><i class="icon-pencil"></i>
                  </a> /<a href="/SAMERP/AddOrganization?deleteId=<%=organization_id%>" class="tip-top" data-original-title="Delete"><i class="icon-remove"></i></a></td>
                </tr>
                <% }} %>
              </tbody>
            </table>
          </div>
        </div>
  
  
  
 </div>
</div>

<!--end-main-container-part-->


<div class="modal hide fade" id="update_organization" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Update Organization Details</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="/SAMERP/AddOrganization" method="post" name="#updateorganization">
					<div class="form-group">
						<div class="widget-content nopadding">
          
				            <div class="control-group">
				              <label class="control-label"><span style="color: red;">*</span>Organization Name : </label>
				              <div class="controls">
				              		<input type="hidden" name="organization_id" id="organization_id" />
				                    <input type="text" class="span3" onkeyup="this.value=this.value.toUpperCase()" name="organization_name" id="organization_name" pattern="[a-z A-Z]*" required  />
				              </div>
				            </div>
				            
				            <div class="control-group">
				              <label class="control-label"><span style="color: red;">*</span>Organization Address : </label>
				              <div class="controls">
				                    <textarea type="text" class="span3" onkeyup="this.value=this.value.toUpperCase()" name="organization_address" id="organization_address" pattern="[a-z A-Z]*" required></textarea>
				              </div>
				            </div>
				            
				            <div class="control-group">
				              <label class="control-label"><span style="color: red;">*</span>Contact No1 : </label>
				              <div class="controls">
				                    <input type="text" class="span3" onkeyup="this.value=this.value.toUpperCase()" name="contact_no1" id="contact_no1" required />
				              </div>
				            </div>
				            
				            <div class="control-group">
				              <label class="control-label">Contact No2 : </label>
				              <div class="controls">
				                    <input type="text" class="span3" onkeyup="this.value=this.value.toUpperCase()" name="contact_no2" id="contact_no2" />
				              </div>
				            </div>
				            
				            <div class="control-group">
				              <label class="control-label">Email : </label>
				              <div class="controls">
				                    <input type="text" class="span3" name="email_id" id="email_id" />
				              </div>
				            </div>	
				            
				            <div class="control-group">
					              <label class="control-label">Opening Balance:</label>
					              <div class="controls">
					                <input type="text" name="opening_balance" id="opening_balanceid" class="span3" placeholder="Opening Balance" pattern="[0-9]*" required/>
					              </div>
					            </div>
				            	            
				            <div class="modal-footer">
				            <button type="submit" name="org_submitbtn" class="btn btn-success">Update</button>
									
									<button type="button" id="cancelbtn" class="btn btn-danger" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</form>
			</div>
				
			</div>
		</div>
	</div>
<!--Footer-part-->

<div class="row-fluid">
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a
				href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
	</div>


<!--end-Footer-part-->

<script>
function myFunction() {
    var x = document.getElementById("snackbar")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && ( charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

function setFocusToTextBox() {
	document.getElementById("organizationname").focus();
	myFunction();
}

function searchOrganization(id) {
	
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			
			var demoStr = this.responseText.split(",");
			
			document.getElementById("organization_id").value = demoStr[0];
			document.getElementById("organization_name").value = demoStr[1];
			document.getElementById("organization_address").value = demoStr[2];
			document.getElementById("contact_no1").value = demoStr[3];
			document.getElementById("contact_no2").value = demoStr[4];
			document.getElementById("email_id").value = demoStr[5];
			document.getElementById("opening_balanceid").value = demoStr[6];
		
			}
		};
	xhttp.open("POST","/SAMERP/AddOrganization?organization_id="+id, true);
	xhttp.send();
}

</script>
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
<script src="/SAMERP/config//SAMERP/config/js/matrix.interface.js"></script> 
<script src="/SAMERP/config/js/matrix.chat.js"></script> 
<script src="/SAMERP/config/js/jquery.validate.js"></script> 
<script src="/SAMERP/config/js/matrix.form_validation.js"></script> 
<script src="/SAMERP/config/js/jquery.wizard.js"></script> 
<script src="/SAMERP/config/js/jquery.uniform.js"></script> 
<script src="/SAMERP/config/js/select2.min.js"></script> 
<script src="/SAMERP/config/js/matrix.popover.js"></script> 
<script src="/SAMERP/config/js/jquery.dataTables.min.js"></script> 
<script src="/SAMERP/config/js/matrix.tables.js"></script> 
</body>
</html>
