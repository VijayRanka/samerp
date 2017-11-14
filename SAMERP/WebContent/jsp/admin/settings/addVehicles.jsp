<%@page import="utility.RequireData"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>SAMERP PROJECT</title>
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />
<link rel="stylesheet" href="/SAMERP/config/css/select2.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="/SAMERP/config/css/fullcalendar.css" />
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
    <div id="breadcrumb"> <a href="/SAMERP/index.jsp" title="Go to Home" class="tip-bottom"><i class="fa fa-home"></i> Home</a> <a href="#" class="current">Add Vehicles</a> </div>
  	<h1>Add New Vehicle</h1>
  </div>
<!--End-breadcrumbs-->


<!--Action boxes-->
  <div class="container-fluid"> 
    <hr>
    <%
          	 RequireData rd = new RequireData();
    %>
   
   <div class="row-fluid">
    <div class="span12">
      <div class="widget-box">
        <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
          <h5>Vehicle Details</h5>
        </div>
        <div class="widget-content nopadding">
          <form action="/SAMERP/AddVehicles" method="post" class="form-horizontal" name="form1">
            
			<div class="control-group" style="height: 50px;">
              <label class="control-label"><span style="color: red;">*</span>Vehicle Type :</label>
              <div class="controls">
<!--                 <input type="text" class="span3" placeholder="Vehicle Type" onkeyup="this.value=this.value.toUpperCase()" name="vehicle_type" id="vehicle_type" required  /> -->
                <select class="span3" style="width:257px;" name="vehicle_type" id="vehicle_type"  required >
                	<option value=""> Select</option>
                	<option value="JCB">JCB</option>
                	<option value="POCLAIN">POCLAIN</option>
                	<option value="TRANSPORT">TRANSPORT</option>
                </select>
              </div>
            </div>
            
            <div class="control-group">
              <label class="control-label"><span style="color: red;">*</span>Vehicle Number :</label>
              <div class="controls">
                <input type="text" class="span1" placeholder="XX" style="width: 40px;" onkeyup="this.value=this.value.toUpperCase()" name="vehicleno1"  pattern="[A-Za-z]+" maxlength="2" required />  &ndash; 
                <input type="text" class="span1" placeholder="XX" style="width: 40px;" name="vehicleno2"  pattern="[0-9]+" maxlength="2" required />  &ndash; 
                <input type="text" class="span1" placeholder="XX" style="width: 40px;" onkeyup="this.value=this.value.toUpperCase()" name="vehicleno3"  pattern="[A-Za-z]+" maxlength="2" required />  &ndash;
                <input type="text" class="span2" placeholder="XXXX" style="width: 100px;" name="vehicleno4" pattern="[0-9]+" maxlength="4" required />
              </div>
            </div>
            
            <div class="control-group">
					<label class="control-label">Trip Allowance:</label>
						<div class="controls">
							<input type="text" name="trip_allowance" class="span3" onkeyup="this.value=this.value.toUpperCase()" placeholder="Trip Allowance" style="width: 257px;" pattern="[0-9]*" required />
						</div>
					</div>
					
			<div class="control-group">
					<label class="control-label">Helper Charges:</label>
						<div class="controls">
							<input type="text" name="helper_charges" class="span3" onkeyup="this.value=this.value.toUpperCase()"	placeholder="Helper Charges" style="width: 257px;" pattern="[0-9]*" required />
						</div>
					</div>
            <div class="control-group">
							<label class="control-label">Driver Charges:</label>
								<div class="controls">
										<input type="text" name="driver_charges"  class="span3" onkeyup="this.value=this.value.toUpperCase()"	placeholder="Driver Charges" style="width: 257px;" pattern="[0-9]*" required />
								</div>
							</div>
            <div class="form-actions" align="center">
              <button type="submit" id="submitbtn" name="insertSubmitBtn" class="btn btn-success" style="background:#1196c1;">Submit</button> &nbsp;&nbsp;&nbsp;&nbsp;
              <a href="/SAMERP/index.jsp" id="cancelbtn"  class="btn btn-danger">Exit</a>
            </div>
            
          </form>
        </div>
      </div>
    </div>
  </div>
  <hr>
  <div class="widget-box">
          <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
            <h5>Vehicles List</h5>
          </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
              <thead>
                <tr>
                  <th>Sr. No.</th>
                  <th>Vehicle Type</th>
                  <th>Vehicle Number</th>
                  <th>Trip Allowance</th>
                  <th>Helper Charges</th>
                  <th>Driver Charges</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
                <%
              
             List vehicleDetailsData =rd.getVehiclesData();
             int i=1;
             
             if(vehicleDetailsData!=null)
             {
                Iterator itr = vehicleDetailsData.iterator();	 
            	 
                while(itr.hasNext())
                {
                	String vehicleId = itr.next().toString();
                	String vehicleType = itr.next().toString();
                	String vehicleNumber = itr.next().toString();
                	String tripAllowance=itr.next().toString();
                	String helperChagres=itr.next().toString();
                	String driverCharges=itr.next().toString();
              %>            
                    	<tr class="gradeX">
  							<td> <%=i %></td>
	                      	<td id="<%=vehicleId%>"><%=vehicleType%></td>
	                        <td><%=vehicleNumber%></td>
	                        <td><%=tripAllowance%></td>
	                        <td><%=helperChagres%></td>
	                        <td><%=driverCharges%></td>
	                        <td><a href="#update" data-toggle="modal"  onclick="searchName(<%=vehicleId%>)"><i class="icon-pencil"></i></a>/
                     	<a onclick="getDeleteId(<%=vehicleId%>)" href="#DeleteConfirmBox" data-toggle='modal'><i class="icon-remove"></i></a></td></tr>
             <%
                     	i++;
                 }
             }
             %>
              
     		  </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
      
      
<!--end-main-container-part-->


<div class="modal hide fade" id="update" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Update Dealer Details</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="/SAMERP/AddVehicles" method="post" name="updateVehicle">
					<div class="form-group">
						<div class="widget-content nopadding">
          
				            <div class="control-group" style="height: 50px;">
				              <label class="control-label"><span style="color: red; ">*</span>Vehicle Type :</label>
				              <div class="controls" style="width: 45.7%; margin-left: 30.3%; position: absolute;">
				              		<input type="hidden" name="Updatevehicle_id" id="Updatevehicle_id" />
				              		<input type="hidden" name="oldvehicle_type" id="oldvehicle_type" />
				              		<input type="hidden" name="oldvehicle_alias" id="oldvehicle_alias" />
				              		
				<!--                 <input type="text" class="span3" placeholder="Vehicle Type" onkeyup="this.value=this.value.toUpperCase()" name="vehicle_type" id="vehicle_type" required  /> -->
				                <select class="span3" style="width:269px;" name="Updatevehicle_type" id="Updatevehicle_type" required >
				                	<option value=""> Select </option>
				                	<option value="JCB">JCB</option>
				                	<option value="POCLAIN">POCLAIN</option>
				                	<option value="TRANSPORT">TRANSPORT</option>		
				                </select>
				              </div>
				            </div>
				            
				            <div class="control-group">
				              <label class="control-label"><span style="color: red;">*</span>Vehicle Number :</label>
				              <div class="controls">
				                <input type="text" class="span1" placeholder="XX" style="width: 35px;" onkeyup="this.value=this.value.toUpperCase()" name="Updatevehicleno1" id="Updatevehicleno1"  pattern="[A-Za-z]+" maxlength="2" required />  &ndash; 
				                <input type="text" class="span1" placeholder="XX" style="width: 35px;" name="Updatevehicleno2" id="Updatevehicleno2"  pattern="[0-9]+" maxlength="2" required />  &ndash; 
				                <input type="text" class="span1" placeholder="XX" style="width: 35px;" onkeyup="this.value=this.value.toUpperCase()" name="Updatevehicleno3" id="Updatevehicleno3"  pattern="[A-Za-z]+" maxlength="2" required />  &ndash;
				                <input type="text" class="span2" placeholder="XXXX" style="width: 70px;" name="Updatevehicleno4" id="Updatevehicleno4" pattern="[0-9]+" maxlength="4" required />
				              </div>
				            </div>
				            
				     <div class="control-group">
							<label class="control-label">Trip Allowance:</label>
								<div class="controls">
								<input type="text" name="trip_allowance" id="trip_allowanceid" class="span3" onkeyup="this.value=this.value.toUpperCase()" placeholder="Trip Allowance" pattern="[0-9]*" required />
								</div>
							</div>
					
					<div class="control-group">
							<label class="control-label">Helper Charges:</label>
								<div class="controls">
										<input type="text" name="helper_charges" id="helper_chargesid" class="span3" onkeyup="this.value=this.value.toUpperCase()"	placeholder="Helper Charges" pattern="[0-9]*" required />
								</div>
							</div>
						<div class="control-group">
							<label class="control-label">Driver Charges:</label>
								<div class="controls">
										<input type="text" name="driver_charges" id="driver_chargesid" class="span3" onkeyup="this.value=this.value.toUpperCase()"	placeholder="Driver Charges" pattern="[0-9]*" required />
								</div>
							</div>
							
							
				             
				            <div class="modal-footer">
									<input type="submit" id="submitbtn" name="updateSubmitBtn" class="btn btn-primary" style="background:#1196c1;" value="Update" />
									<input type="button" id="cancelbtn" class="btn btn-danger" data-dismiss="modal" value="Close"/>
							</div>
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
								<form class="form-horizontal" action="/SAMERP/AddVehicles" method="post" name="form4">
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


function searchName(id) {
	
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			
			var demoStr = this.responseText.split(",");
			
			document.getElementById("Updatevehicle_id").value = demoStr[0];
			document.getElementById("Updatevehicle_type").value = demoStr[1];
			document.getElementById("oldvehicle_type").value = document.getElementById("Updatevehicle_type").value;
			getSetSelect("s2id_Updatevehicle_type", demoStr[1]);			
			
			var vehicleNumber = demoStr[2].split("-");
			
			document.getElementById("Updatevehicleno1").value = vehicleNumber[0];
			document.getElementById("Updatevehicleno2").value = vehicleNumber[1];
			document.getElementById("Updatevehicleno3").value = vehicleNumber[2];
			document.getElementById("Updatevehicleno4").value = vehicleNumber[3];
			
			document.getElementById("trip_allowanceid").value = demoStr[3];
			document.getElementById("helper_chargesid").value = demoStr[4];
			document.getElementById("driver_chargesid").value = demoStr[5];
			
			document.getElementById("oldvehicle_alias").value = demoStr[6];
			
	
			
			//document.getElementById("UpdateRateText").value = demoStr[3];
			//document.getElementById("oldRate").value = document.getElementById("UpdateRateText").value;
			//getRateText1();
			}
		};
	xhttp.open("POST","/SAMERP/AddVehicles?updateid="+id, true);
	xhttp.send();
	
	
}


function showModal(){
	var someVarName = localStorage.getItem("someVarName");
	var error=<%=request.getAttribute("error")%>;
	
	if(error==2)
	{
		$('#error-msg-delete').modal('show');	
	}
	else if(someVarName>0)
	{
		$('#update').modal('show');
		
		
	}
	localStorage.setItem('someVarName', null);
}

function setFocusToTextBox() {
	document.getElementById("vehicle_type").focus();
	showModal();
	setSelectValue();
	myFunction();
}

function myFunction() {
    var x = document.getElementById("snackbar")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}


function setSelectValue(){
	
	var e = document.getElementById("Updatevehicle_type");
	var d = document.getElementById("vehicle_type");

	
	var txt = e.options[e.selectedIndex].text;
	var txt1 = d.options[d.selectedIndex].text;
	getSetSelect('s2id_vehicle_type', txt1);
	myFunction();
}

function getSetSelect(id,value)
{
	var x=document.getElementById(id).children;
	var xx=x[0].children;	
	xx[0].innerHTML=value;
}

</script>

<!--Footer-part-->
<div class="row-fluid">
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a
				href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
	</div>

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
