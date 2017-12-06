<%@page import="utility.RequireData"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>SAMERP PROJECT</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/fullcalendar.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
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
    <div id="breadcrumb"> <a href="/SAMERP/index.jsp" title="Go to Home" class="tip-bottom"><i class="fa fa-home"></i> Home</a> <a href="#" class="current">Sale/Supply</a> </div>
  	<h1>Sale / Supply</h1>
  </div>
<!--End-breadcrumbs-->


<!--Action boxes-->
  <div class="container-fluid"> 
    <hr>
    <%
          	 RequireData rd = new RequireData();
    %>
    
    <form class="form-inline">
    <div class="alert alert-info" style="height: 35px; " align="center">
		<label class="control-label"><Strong>Search Customer : </Strong></label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="text" placeholder="Customer Name" style="width: 230px; margin-top:2.5px;" class="span2" onkeyup="CustomerSearch(this.value)" onkeydown="CustomerPrint()" autocomplete="off" required> 
		<datalist id="browsers">
		</datalist>
	</div>
	</form>
			
			
    <div class="widget-box">
        <div class="widget-title"> <span class="icon"> <i class="fa fa-align-justify"></i> </span>
          <h5> Customer Details </h5>
        </div>
        <div class="widget-content nopadding" >
        
          <form action="" method="post" class="form-inline" name="form1">
         
			<div class="control-group" >
              <div class="controls" align="center" style="margin-top: 10px;">
                <div class="input-append">
                  <label class="control-label" >Customer Name : </label>
                  <input type="text" placeholder="Customer Name" required class="span2" style="width: 230px; " >
                  
                  <label class="control-label">Contact Number : </label>
                  <input type="text" placeholder="Contact Number" required class="span2" style="width: 230px;">
                </div>
              </div>
            </div>
 
          </form>
          
        </div>
    </div>
     
     
    <div class="widget-box">
        <div class="widget-title"> <span class="icon"> <i class="fa fa-align-justify"></i> </span>
          <h5> Supply Details </h5>
        </div>
        <div class="widget-content nopadding" >
        
          <form action="" method="post" class=form-horizontal name="form2">
         	
         	<div class="control-group">
              <label class="control-label"><span id="required1" style="color: red;"></span>Material Name : </label>
              <div class="controls">
              	<div class="input-append">
                  <select class="span3" name="vehicle_type" id="vehicle_type" onchange="getRateText()" required >
                	<option value=""> Select </option>
                	<option value=""></option>
                	<option value=""></option>
                	<option value=""></option>
                </select>
				</div>
                
              </div>
            </div>
         	
         	<div class="control-group">
              <label class="control-label"><span id="required1" style="color: red;"></span>Quantity : </label>
              <div class="controls">
                <div class="input-append">
                  <input type="text" placeholder="Quantity" required class="span2" style="width: 255px;">
				</div>
              </div>
            </div>
            
            <div class="control-group">
              <label class="control-label"><span id="required1" style="color: red;"></span>From : </label>
              <div class="controls">
                <div class="input-append">
                  <input type="text" placeholder="From" required class="span2" style="width: 255px;">
				</div>
              </div>
            </div>
         	
         	<div class="control-group">
              <label class="control-label">Date : </label>
              <div class="controls">
                <div  data-date="12-02-2012" class="input-append date datepicker" style="margin-top: -3px;">
                  <input type="text" placeholder="MM-DD-YYYY"  data-date-format="mm-dd-yyyy" style="width: 225px;" class="span2" >
                  <span class="add-on"><i class="fa fa-th"></i></span> </div>
              </div>
            </div>
         	
         	<div class="control-group">
              <label class="control-label"><span id="required1" style="color: red;"></span>By Vehicle : </label>
              <div class="controls">
              	<div class="input-append">
                  <select class="span3" name="vehicle_type" id="vehicle_type" onchange="getRateText()" required >
                	<option value=""> Select </option>
                	<option value=""></option>
                	<option value=""></option>
                	<option value=""></option>
                </select>
				</div>
                
              </div>
            </div>
         	
         	<div class="form-actions" align="center">
              <button type="submit" id="submitbtn" name="insertSubmitBtn" class="btn btn-success">Submit</button> &nbsp;&nbsp;&nbsp;&nbsp;
              <a href="/SAMERP/index.jsp" id="cancelbtn"  class="btn btn-danger">Exit</a>
            </div>
         	
          </form>
          
        </div>
    </div> 
     
    
	<div class="widget-box">
          <div class="widget-title"> <span class="icon"><i class="fa fa-th"></i></span>
         <h5>Sale / Supply List</h5>
        
          </div>
          <div class="widget-content nopadding">
           <form name="form2" id="dealerTable" method="post">
            <table class="table table-bordered data-table">
              <thead>
                <tr>
                  <th>Sr. No.</th>
                  <th>Vehicle Type</th>
                  <th>Vehicle Number</th>
                  <th>Rate</th>
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
                	String vehicleRate = itr.next().toString();
              %>            
                    	<tr class="gradeX">
  							<td> <%=i %></td>
	                      	<td id="<%=vehicleId%>"><%=vehicleType%></td>
	                        <td><%=vehicleNumber%></td>
	                        <td> <%=vehicleRate%> </td>
	                        <td> <a href="/SAMERP/AddVehicles?deleteid=<%=vehicleId%>" >Delete</a> / <a href="#update" data-toggle="modal"  onclick="searchName(<%=vehicleId%>)">Update</a></td>
                     	</tr>
             <%
                     	i++;
                 }
             }
             %>
              
              </tbody>
            </table>
            </form>
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
          
				            <div class="control-group">
				              <label class="control-label"><span style="color: red;">*</span>Vehicle Type :</label>
				              <div class="controls">
				              		<input type="hidden" name="Updatevehicle_id" id="Updatevehicle_id" />
				              		<input type="hidden" name="oldvehicle_type" id="oldvehicle_type" />
				<!--                 <input type="text" class="span3" placeholder="Vehicle Type" onkeyup="this.value=this.value.toUpperCase()" name="vehicle_type" id="vehicle_type" required  /> -->
				                <select class="span3" name="Updatevehicle_type" id="Updatevehicle_type" onchange="getRateText1()" required >
				                	<option value=""> Select </option>
				                	<option value="JCB">JCB</option>
				                	<option value="POCLAIN">POCLAIN</option>
				                	<option value="TRUCK">TRUCK</option>		
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
				              <label class="control-label"><span id="required2" style="color: red;"></span>Rate : </label>
				              <div class="controls">
				                <div class="input-append">
				                <input type="hidden" name="oldRate" id="oldRate"/>
				                  <input type="text" placeholder="0000" required class="span2" style="width: 230px;" id="UpdateRateText" name="UpdaterateText" disabled="disabled">
				                  <span class="add-on"><i class="fa fa-inr" style="font-size: 1.5em;"></i></span> </div>
				              </div>
				            </div>
			            
				            <div class="modal-footer">
									<input type="submit" id="submitbtn" name="updateSubmitBtn" class="btn btn-primary" value="Update" />
									<input type="button" id="cancelbtn" class="btn btn-danger" data-dismiss="modal" value="Cancel"/>
							</div>
						</div>
					</div>
				</form>
			</div>
				
			</div>
		</div>
	</div>

            


<script type="text/javascript">

function CustomerSearch(str) {

	var xhttp;
	if (str == "") {
		return;
	}
	xhttp = new XMLHttpRequest();

	try {
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				//document.getElementById("imeino").innerHTML = this.responseText;
				var demoStr = this.responseText.split(",");
				var text = "";
				var i = 0
				for (; demoStr[i];) {
					text += "<option id="+demoStr[i];
					i++;
					text += " value="+demoStr[i]+">"+ demoStr[i] + "</option>";
					i++;
				}
				document.getElementById("browsers").innerHTML = text;
			}

		};

		xhttp.open("POST", "/SAMERP/JcbPocDetails.do?q=" + str, true);
		xhttp.send();
	} catch (e) {
		alert("Unable to connect to server");
	}
}



function showModal(){
	var someVarName = localStorage.getItem("someVarName");
	 
	if(someVarName>0)
	{
		$('#update').modal('show');
		
		
	}
	localStorage.setItem('someVarName', null);
}

function setFocusToTextBox() {
	document.getElementById("vehicle_type").focus();
	showModal();
	myFunction();
}

function myFunction() {
    var x = document.getElementById("snackbar")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
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

<script src="/SAMERP/config/js/excanvas.min.js"></script> 
<script src="/SAMERP/config/js/jquery.min.js"></script> 
<script src="/SAMERP/config/js/jquery.ui.custom.js"></script> 
<script src="/SAMERP/config/js/bootstrap.min.js"></script> 
<script src="/SAMERP/config/js/bootstrap-datepicker.js"></script>
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
<script src="/SAMERP/config/js/matrix.popover.js"></script> 
<script src="/SAMERP/config/js/jquery.dataTables.min.js"></script> 
<script src="/SAMERP/config/js/matrix.tables.js"></script> 
<script src="/SAMERP/config/js/select2.min.js"></script> 
</body>
</html>
