<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="utility.RequireData"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="utility.SysDate"%>
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
<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">
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

#uniform-dieselCheckbox{
margin-top: 5px;
}

#s2id_organizationid{
    margin-left: 200px;
}

/* .select2-choice{
	margin-top: -67px;
    margin-left: 425px;
    width: 250px;
	
} */

#saleDetails td{ 
	text-align: -webkit-center;
}

.table td {
   text-align: center;   
}

</style>
</head>
<body onload="setFocusToTextBox()">

<!--Header-part-->
<div id="header">
  <h1><a href="/SAMERP/index.jsp">SAMERP</a></h1>
</div>

<!--start-top-serch-->
<div id="search">

<% if(request.getAttribute("status")!=null){ %>
<div id="snackbar"><%=request.getAttribute("status")%></div>
<%} %>

<%
	String error = "";

	if (request.getAttribute("error") != null) {
		error = request.getAttribute("error").toString();
	}
%>
	<input type="hidden" name="error" id="error" value="<%=error%>" />

  <button type="submit" class="tip-bottom" style="margin-top: -1px;">LOGOUT</button>
</div>
<!--close-top-serch-->
<!--sidebar-menu-->
<jsp:include page="../common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->

<!--main-container-part-->
<div id="content">
<!--breadcrumbs-->
  <div id="content-header">
    <div id="breadcrumb"> <a href="/SAMERP/index.jsp" title="Go to Home" class="tip-bottom"><i class="fa fa-home"></i> Home</a> <a href="#" class="current">Sales</a> </div>

  </div>
<!--End-breadcrumbs-->

<!--Action boxes-->
  <div class="container-fluid"> 

    
   <div class="row-fluid">
    <div class="span12">
      <div class="widget-box">
        <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
          <h5>Sales</h5>
        </div>
        <div class="widget-content nopadding">
          <form action="/SAMERP/Sales" method="post" class="form-horizontal" name="sales">
            <!-- action="/SAMERP/Sales" -->
			<div class="control-group" style="height: 50px;">
              <label class="control-label"><span style="color: red;">*</span>Select Client : </label>
                <div class="controls">
                <select  name="clientid" id="clientid" style="width:315px;" autofocus required >
                	<%
                		RequireData rd = new RequireData();
            			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            			String currentDate = df.format(new Date()).toString();
                		List clientList = rd.getClientList();
	          			Iterator itr1 = clientList.iterator();
	              		while(itr1.hasNext()){
	              %>
		                	<option value="<%=itr1.next()%>"><%=itr1.next()%></option>
		           <%
	              		}
		           %>   
                </select>
                <a href="#add-client" data-toggle="modal" style="    position: absolute; margin-left: 15px; margin-top: 5px;">
					<span class="badge badge-inverse"><i class="icon-plus"></i></span>
			  	</a>
              	</div>
              	              
              <label class="control-label" style="margin-top: -50px; margin-left: 490px;"><span style="color: red;">*</span>Date :</label>
              <div class="controls">
                <input type="date" name="saleDate" value="<%=currentDate %>" style="width: 300px; margin-top: -50px; margin-left: 490px;" />
              </div>                 
            </div>
            
            <div class="control-group" style="height: 50px;">
              <label class="control-label"><span style="color: red;">*</span>Chalan No :</label>
              <div class="controls">
                <input type="text" placeholder="Chalan Number" style="width: 300px;" name="chalanNo" onkeyup="this.value=this.value.toUpperCase()" required />
              </div>
              
              <label class="control-label" style="margin-top: -50px; margin-left: 485px;">Loading By :</label>
              <div class="controls" style="margin-top: -50px; margin-left: 488px;">
              <select name="organizationid" id="organizationid" style="width:120px;" >
              	<option value="">select</option>
                	<%
                		List teamlist = rd.getOrganizationList();
	          			Iterator itr = teamlist.iterator();
	              		while(itr.hasNext()){
	              %>
		                	<option value="<%=itr.next()%>"><%=itr.next()%></option>
		           <%
	              		}
		           %>   
                </select>
<!--                 <input type="text" name="loadingBy" placeholder="Loading By" style="width: 100px; margin-top: -50px; margin-left: 488px;"/> -->
              </div>

              <label class="control-label" style="margin-top: -50px; margin-left: 700px;">Chrages :</label>
              <div class="controls">
                <input type="text" name="Chrages" placeholder="Loading Chrages" style="width: 106px; margin-top: -50px; margin-left: 685px;" />
              </div>  
           
            </div>
            
            <div class="control-group" style="height: 50px;">              
              <label class="control-label"><span style="color: red;">*</span>Vehicle Details :</label>
              <div class="controls">          
                <!-- <input type="text" placeholder="MH-12-MM-1234" style="width: 300px;" onkeyup="this.value=this.value.toUpperCase()" name="vehicleNo" required /> -->
                <input list="browsers" name="vehicleNo" onkeyup="VehicleSearch(this.value)" placeholder="MH-12-MM-1234" autocomplete="off" required style="width: 309px;height: 23px; margin-top: -1px; text-transform: uppercase;"/>
				<datalist id="browsers"></datalist>
              </div>
              
              <label class="control-label" style="margin-top: -50px; margin-left: 490px;">Deposit :</label>
              <div class="controls">
                <input type="number" placeholder="Deposit" style="width: 300px; margin-top: -50px; margin-left: 490px;" name="deposit" />
              </div>               
            </div>
            
            <div class="control-group" style="height: 50px;">              
              <label class="control-label">Purchase Order No :</label>
              <div class="controls">
                <input type="text" placeholder="Purchase Order Number" style="width: 300px;" name="poNo" onkeyup="this.value=this.value.toUpperCase()"/>
              </div>
              
<!--               <label class="control-label" style="margin-top: -50px; margin-left: 490px;">Helper Chargers :</label>
              <div class="controls">
                <input type="number" placeholder="Helper Chargers" style="width: 300px; margin-top: -50px; margin-left: 490px;" name="helperChargers" />
              </div> -->
            </div>  
            
            <div class="control-group" style="height: 50px;">              
              <label class="control-label">Diesel :</label>
              <div class="controls">
                <input type="checkbox" id="dieselCheckbox" name="dieselCheckbox" />
              </div>
              
              <div class="controls" id="dieselDivId" style="height: 32px; width: 755px; background-color: rgb(238, 238, 238);margin-top: -45px; margin-left: 250px; display: none"  >
              	
              <label class="control-label" style="margin-top: -9px; margin-left: -115px;">Reading :</label>
              <div class="controls">
                <input type="number" placeholder="Reading" style="width: 150px; margin-top: -10px; margin-left: -120px;" name="reading" />
              </div>
              
              <label class="control-label" style="margin-top: -50px; margin-left: 125px;">Diesel :</label>
              <div class="controls">
                <input type="number" placeholder="Diesel (In Ltr)" style="width: 150px; margin-top: -50px; margin-left: 125px;" name="diesel" />
              </div>              
              
              <label class="control-label" style="margin-top: -70px; margin-left: 385px;">Amount :</label>
              <div class="controls">
                <input type="number" placeholder="Amount" style="width: 150px; margin-top: -70px; margin-left: 380px;" name="amount" />
              </div>              	
              	
              </div>
            </div>

            <div class="control-group" style="height: 50px;">              
              <label class="control-label">Material From :</label>
              <div class="controls">
                SARTHAK &nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" id="ownerRadio" name="material" style="position: relative; opacity: 0; left: 19px; bottom: 4px;"/>
                THIRD PARTY &nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" id="thirdRadio" name="material" style="position: relative; opacity: 0; left: 19px; bottom: 4px;" />
              </div>
            </div>  
            
            <div class="control-group" style="height: 100px;" id="ownerDiv">              
              <label class="control-label">Product Name :</label>
              <div class="controls">
              	<input list="productList" type="text" autocomplete="off" id="productNameSarthak" oninput="selectProduct(this.value)" name="productNameSarthak" placeholder="Product Name" style=" width: 140px; text-transform:uppercase;"/>
  				<datalist id="productList"></datalist>
                <!-- <input type="text"  name="productNameSarthak" id="productNameSarthak" placeholder="Product Name" style="width: 200px;" onkeyup="this.value=this.value.toUpperCase()"/> -->
              </div>
              
              <label class="control-label" style="margin-top: -50px; margin-left: 265px;">Quantity :</label>
              <div class="controls">
                <input type="number" name="qtySarthak" id="qtySarthak" placeholder="Quantity" style="width: 70px; margin-top: -50px; margin-left: 265px;"/>
              </div>

              <label class="control-label" style="margin-top: -70px; margin-left: 435px;">Rate :</label>
              <div class="controls">
                <input type="number" name="rateSarthak" id="rateSarthak" placeholder="Rate" style="width: 70px; margin-top: -70px; margin-left: 435px;"/>
              </div>

              <label class="control-label" style="margin-top: -90px; margin-left: 600px;">GST :</label>
              <div class="controls">
                <input type="text" name="gstSarthak" id="gstSarthak" placeholder="GST" style="width: 70px; margin-top: -90px; margin-left: 600px;"/>
              </div>  
              
              <button type="button" id="submitbtn" name="addMaterialFromSarthakSubmitBtn" onclick="addMaterial()" class="btn btn-success" style="margin-top: -40px; margin-left: 450px;">Add Materials</button>
                          
            </div>              
            
            <div class="control-group" style="height: 160px;" id="thirdPartyDiv">              
              <label class="control-label">Product Name :</label>
              <div class="controls">
                <input list="productList" type="text" autocomplete="off" id="productName" onkeyup="selectProduct(this.value)" name="productName" placeholder="Product Name" style=" width: 140px; text-transform:uppercase;"/>
  				<datalist id="productList"></datalist>
                <!-- <input type="text" name="productName" id="productName" placeholder="Product Name" style="width: 200px;" onkeyup="this.value=this.value.toUpperCase()"/> -->
              </div>
              
              <label class="control-label" style="margin-top: -50px; margin-left: 265px;">Quantity :</label>
              <div class="controls">
                <input type="number" name="qty" id="qty" placeholder="Quantity" style="width: 70px; margin-top: -50px; margin-left: 265px;" />
              </div>

              <label class="control-label" style="margin-top: -70px; margin-left: 435px;">Rate :</label>
              <div class="controls">
                <input type="number" name="rate" id="rate" placeholder="Rate" style="width: 70px; margin-top: -70px; margin-left: 435px;" />
              </div>
              
              <label class="control-label" style="margin-top: -90px; margin-left: 600px;">GST :</label>
              <div class="controls">
                <input type="text" name="gst" id="gst" placeholder="GST" style="width: 70px; margin-top: -90px; margin-left: 600px;"/>
              </div>
              
              <label class="control-label" style="margin-top: -50px;">Chalan No :</label>
              <div class="controls">
                <input type="text" name="chalanNo_third" id="chalanNo_third" placeholder="Chalan Number" style="width: 250px; margin-top: -50px;" onkeyup="this.value=this.value.toUpperCase()"/>
              </div>
              
              <label class="control-label" style="margin-top: -65px; margin-left: 420px;">Select Supplier :</label>
              <div class="controls" style="    margin-left: 57%; width: 166%; margin-top: -6%; position: absolute;">
              		<select class="span2" name="supplierName" id="supplierName" autofocus   >
	                	
           	  			<%
           	  				List supplierList = rd.getSupplierList1();
		           	  		if(!supplierList.isEmpty()){
		          			Iterator itrS = supplierList.iterator();
			              		while(itrS.hasNext()){
			              			Object supplierName=itrS.next();
	          			%>
		                <option value="<%=supplierName%>"><%=supplierName%></option>
		      			<%
	              				}
           	  			}
	           			%>   
	           		</select> 
<!--                 <input type="text" name="supplierName" id="supplierName" placeholder="Supplier Name" style="width: 250px; margin-top: -65px; margin-left: 420px;" onkeyup="this.value=this.value.toUpperCase()"/> -->
              </div><br>              
                  <button type="button" id="submitbtn" name="addMaterialFromTPSubmitBtn" onclick="addMaterialByThirdParty()" class="btn btn-success" style="margin-top: -20px; margin-left: 450px;">Add Materials</button>
            </div>              
            
            <div class="control-group">
              <div class="span11">
		   		<div class="widget-box" style="margin-left: 80px;">
		   		<div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
				    <h5>Sales Material</h5>
		         </div>
		          <div class="widget-content nopadding">
		            <table class="table table-bordered table-striped" id="tempMaterialTable">
		              <thead>
		                <tr>
		                  <th>No.</th>
		                  <th>Product Name</th>
		                  <th>From</th>
		                  <th>Chalan No</th>
		                  <th>Quantity</th>
		                  <th>Rate</th>
		                  <th>GST</th>
		                </tr>
		              </thead>
		              <tbody>	
		                <tr class="odd gradeX">
		                </tr>
		              </tbody>
		            </table>
		          </div>
		        </div>
		       </div>                 
    
            </div>  
            
            <input type="hidden" name="counter" id="counter" />            
            
            <div class="form-actions" align="center">
              <button type="submit" name="insertSaleDataSubmitBtn" class="btn btn-success">Done</button> &nbsp;&nbsp;&nbsp;&nbsp;
              <a href="/SAMERP/dashboard.jsp" id="cancelbtn"  class="btn btn-danger">Exit</a>
            </div>
            
          </form>
        </div>
      </div>
    </div>
  </div>

<!-- ************************************* DATA TABLE START ************************************* -->
	<div class="row-fluid">
		<div class="span12">

			<div class="widget-box">
				<div class="widget-title">
					<span class="icon"><i class="icon-th"></i></span>
					<h5>Sale Details</h5>
					<input type="text" id="myInput" onkeyup="searchTableData()" style=" float: right; margin-right: 0.4%; margin-top: 0.3%; height: 18px;" placeholder="Search for Sale..." title="Type in a Supplier name">
				</div>
				<div class="widget-content nopadding">
					<table class="table table-bordered " id="saleDetails">
						<thead>
							<tr>
								<th>Sr.No</th>
								<th>Client Name</th>
								<th>Chalan No</th>
								<th>Date</th>
								<th>Vehicle No</th>
								<th>Deposit</th>
								<th>Product Name</th>
								<th>Qty</th>
								<th>Rate</th>
								<th>Supplier Name</th>
								<th>Chalon No(TP)</th>													
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<%
								List purchaseProductList = rd.getSalesDetails();
								Iterator itr2 = purchaseProductList.iterator();
								
								int i = 1;

								while (itr2.hasNext()) {

									String sid = itr2.next().toString();
									String span = itr2.next().toString();
							%>
							<tr id="tdId<%=i%>">
								<td rowspan="<%=span%>" id="<%=sid%>"><%=i%></td>
								<td id="mytd<%=i%>" rowspan="<%=span%>"><%=itr2.next()%></td>
								<td rowspan="<%=span%>"><%=itr2.next()%></td>
								<td rowspan="<%=span%>"><%=itr2.next()%></td>
								<%
								String vehicleNo= itr2.next().toString();
								
								String debtorID= itr2.next().toString();
								if(!debtorID.equals("0")){
									vehicleNo=rd.getVehicleNumber(Integer.parseInt(debtorID));
								}
								
								%>
								<td rowspan="<%=span%>"><%=vehicleNo%></td>
								<td rowspan="<%=span%>"><%=itr2.next()%></td>
								
								
								<%
									List l = rd.getSaleDetailsMaster(sid);
									
									Iterator itr3=l.iterator();
								%>

								<td><%=itr3.next()%></td>
								<td><%=itr3.next()%></td>
								<td><%=itr3.next()%></td>
								<td><%=itr3.next()%></td>
								<td><%=itr3.next()%></td>
								<td rowspan="<%=span%>" > <a class="tip" title="Update" href="#update" data-toggle="modal" onclick="getUpdateData(<%=sid%>)"><i class="icon-pencil"></i></a> <%-- |
														<a class="tip" title="Delete" onclick="getDeleteId('<%=sid%>')" href="#DeleteConfirmBox" data-toggle='modal'><i class="icon-remove"></i></a> --%>
								</td>

								<%
									while (itr3.hasNext()) {
								%>
							
							<tr>
								<td><%=itr3.next()%></td>
								<td><%=itr3.next()%></td>
								<td><%=itr3.next()%></td>
								<td><%=itr3.next()%></td>
								<td><%=itr3.next()%></td>
								<%
									if (itr3.hasNext()) {
								%>
							</tr>
							<%
								}
									}
							%>
							</tr>
							<%
								i++;
								}
							%>
						</tbody>
					</table>
				</div>
			</div>

		</div>
	</div>
<!-- ************************************* DATA TABLE END ************************************* -->	

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


<!--end-Footer-part-->
<!-- ************************************* MODEL START ************************************* -->

<div class="modal hide fade" id="DeleteConfirmBox" role="dialog">
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
				<form action="/SAMERP/Sales">
				<input type="hidden" id="deleteId" name="deleteId">
					<a href=""></a><input type="submit" class="btn btn-primary" id="okButton" value="OK" name="ok" />
					<input type="button" class="btn btn-danger" data-dismiss="modal" on value="Cancel"/>
				</form>
			</div>
		</div>	
	</div>
</div>
<!-- ************************************* MODEL END ************************************* -->

<!-- ************************************* MODEL START ************************************* -->
<!-- <div class="modal hide fade" id="update" role="dialog" style="width: 65%; margin-left:-33%; margin-top: 20px; ">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Update Sale Details</h4>
			</div>
			<div class="modal-body" style="max-height: 550px;">
				<form class="form-horizontal" action="/SAMERP/Sales" method="post" name="updateSale">
					<div class="form-group">
						<div class="widget-content nopadding">
          

				            
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
</div> -->

<div class="modal hide fade zoom-out" id="update" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
   <form class="form-horizontal" action="/SAMERP/Sales" method="post">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Update Data</h4>
      </div>
      <div class="modal-body" id="showModal">
	     
	        <div class="form-group">
			<div class="widget-content nopadding">
	        	<div class="control-group">
	                  <label class="control-label">Date</label>
	                  <div class="controls">
	                	<input type="hidden" id="uId" name="uId"/>
	                    <input type="date" id="uDate" name="uDate" disabled="disabled"/>
	         			</div>
	        	</div>
	        	
	        	<div class="control-group">
	                  <label class="control-label">Organisation Name</label>
	                  <div class="controls">
	                    <input type="text" id="uOrgName"  disabled="disabled"/>
	         			</div>
	        	</div>
	        	<div class="control-group">
	                  <label class="control-label">Self Chalan No</label>
	                  <div class="controls">
	                    <input type="text" id="uSelfChalan" name="uSelfChalan" />
	         			</div>
	        	</div>
	        	<div class="control-group">
	                  <label class="control-label">Vehicle Details</label>
	                  <div class="controls">
	                    <input type="text" id="uVehDetails" name="uVehDetails" readonly="readonly" />
	         			</div>
	        	</div>
	        	
	        	<div class="control-group">
	                  <label class="control-label">Deposit Amount</label>
	                  <div class="controls">
	                     <input type="text" id="uAmount" name="uAmount" readonly="readonly"/>
	                      <input type="hidden" id="oldAmount" name="oldAmount" value="0" />
	                     <input type="checkbox" id="revertCheck" onclick="onUamount()">Reverted
	         			</div>
	        	</div>
	        	
		      </div>
	      	</div>
      </div> 
      <div class="modal-footer">
        <button type="submit" name="UpdateData" class="btn btn-primary" style="margin-right:5px;">Save changes</button> 
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>    
          </div>
    </div>
   </form>
  </div>
</div>
<!-- ************************************* MODEL END ************************************* -->


<!-- ************************************* MODEL START ************************************* -->
<div class="modal fade" id="error-msg" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 style="color: red;" class="modal-title">Error</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="#" method="post" >
					<div class="form-group">
						<div class="widget-content nopadding">
							<div class="control-group">

								<h4>Add Balance in Petty Cash...</h4>
							</div>
						</div>
						<div class="modal-footer">
							<input type="button" class="btn btn-primary"
								id="submitbtn" data-dismiss="modal" value="OK" />
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- ************************************* MODEL END ************************************* -->	

<!--  add client modal start -->
<div class="modal hide fade zoom-out" id="add-client" role="dialog" style="width: 40%; margin-left: -21%;">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Add New Client:</h4>
			</div>
			<div class="modal-body" style="max-height: 454px;">
				<form action="/SAMERP/AddClient" method="Post"
					class="form-horizontal" onsubmit="return validateForm()">
					<div class="control-group">
						<label class="control-label">Client Orgnization Name:</label>
						<div class="controls">
							<input type="text" id="coname" name="coname" autofocus class="span3"  onkeyup="this.value=this.value.toUpperCase()" placeholder="Client Orgnization Name" pattern="[a-z A-Z0-9]*" required />
							
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">Client Name:</label>
						<div class="controls">
							<input type="text" name="cname" class="span3" onkeyup="this.value=this.value.toUpperCase()" placeholder="Client Name" pattern="[a-z A-Z0-9]*" required />
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">Client Contact No1:</label>
						<div class="controls">
							<input type="text" name="contactno1" id="validateno1" class="span3" placeholder="Client ContactNo1 " onkeyup="this.value=this.value.toUpperCase()" pattern="[0-9]*" maxlength="10" required />
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">Client Contact No2:</label>
						<div class="controls">
							<input type="text" name="contactno2" id="validateno2" class="span3" placeholder="Client ContactNo2 " onkeyup="this.value=this.value.toUpperCase()" pattern="[0-9]*" maxlength="10" required />
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">Client EmailId:</label>
						<div class="controls">
							<input type="email" class="span3" name="email" placeholder="Client Email Id" required />
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">Client Address:</label>
						<div class="controls">
							<textarea type="text" class="span3" name="address" onkeyup="this.value=this.value.toUpperCase()" placeholder="Client Address" pattern="[a-z A-Z]*" maxlength="200" required></textarea>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">Client Balance Amount:</label>
						<div class="controls">

							<input type="text" name="bamount"  placeholder="Client Balance Amount" class="span3" onkeyup="this.value=this.value.toUpperCase()" pattern="[0-9]*" required />
						</div>
					</div>
					
					<input type="hidden" name="productPurchasePage1" value="productPurchase" />
					
					<div class="modal-footer">
						<button type="submit" name="insert" class="btn btn-success">Submit</button>
						&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-danger" data-dismiss="modal" style="margin-right: 20px">Cancel</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>	
<!--  add client modal end -->
	

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

function onUamount()
{
	if(document.getElementById('uAmount').readOnly==false)
 	{
 		document.getElementById('uAmount').value=firstAmount;
  		document.getElementById('oldAmount').value="0";
     	document.getElementById('uAmount').readOnly=true;
    }
    else
    {
    	window.firstAmount=document.getElementById('uAmount').value;
    	document.getElementById('oldAmount').value=firstAmount;
    	document.getElementById('uAmount').readOnly=false;
    }
}

function getUpdateData(id)
{
	document.getElementById('oldAmount').value="0";
	document.getElementById('uAmount').readOnly=true;
	document.getElementById('revertCheck').checked=false;
	document.getElementById('uniform-revertCheck').children[0].setAttribute("class","");
	var xhttp;
	xhttp = new XMLHttpRequest();

	xhttp.onreadystatechange = function() {
  	
		if (this.readyState == 4 && this.status == 200) 
		{
  			var demoStr = this.responseText.split(",");
  			if(demoStr[0]==1)
  			{
  				document.getElementById('uId').value=id;
  				document.getElementById('uDate').value=demoStr[1];
  				document.getElementById('uOrgName').value=demoStr[2];
  				document.getElementById('uSelfChalan').value=demoStr[3];
     			document.getElementById('uVehDetails').value=demoStr[4];
     			document.getElementById('uAmount').value=demoStr[5];
     		}
     	}
     };
     
     xhttp.open("POST", "/SAMERP/Sales?getUpdateData=1&id=" + id, true);
     xhttp.send();
}

</script>


<script type="text/javascript">

window.counter = 0;

$('#vehicleNo').keyup(function(){
    this.value = this.value.toUpperCase();
});

$(function(){
    $("div#ownerDiv").hide();
	$("div#thirdPartyDiv").hide();
});

$('input:radio[id=ownerRadio]').click(function(){
    displayOwnerDiv()
});

function displayOwnerDiv()
{
	$("div#ownerDiv").show();
    $("div#thirdPartyDiv").hide();
}

$('input:radio[id=thirdRadio]').click(function(){
    displayThirdPartyDiv()
});

function displayThirdPartyDiv()
{
	$("div#thirdPartyDiv").show();
    $("div#ownerDiv").hide();
}

$(function () {
	$("#dieselCheckbox").click(function () {
	    if ($(this).is(":checked")) {
	        $("#dieselDivId").show();
	    } else {
	        $("#dieselDivId").hide();
	    }
	});
});

function getDeleteId(deleteid)
{	
	document.getElementById("deleteId").value=deleteid;
}


//****************************************** Vehicle Search START ******************************************
function VehicleSearch(str) {

	str = str.toUpperCase();
	var xhttp;
	if (str == "") {
		return;
	}

	xhttp = new XMLHttpRequest();

	try {
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var demoStr = this.responseText.split(",");
				var text = "";
				var i = 0
				for (; demoStr[i];) {
					text += "<option id="+demoStr[i];
					i++;
					text += " value="+demoStr[i]+"> </option>";
					i++;
				}
				document.getElementById("browsers").innerHTML = text;
			}
		};

		xhttp.open("POST", "/SAMERP/Sales?searchVehicle=" + str, true);
		xhttp.send();
	} catch (e) {
		alert("Unable to connect to server");
	}
}
//****************************************** Vehicle Search END ******************************************


//*********************************** ADD MATERIAL FROM SARTHAK START ************************************
function addMaterial()
{  	
	var productName = document.getElementById("productNameSarthak").value;
	var qty = document.getElementById("qtySarthak").value;
	var rate = document.getElementById("rateSarthak").value;	
	var ChalanNo="-";
	var supplierName="SARTHAK";
	var gst=document.getElementById("gstSarthak").value;
	
	productName = productName.toUpperCase();
	
	if(productName && qty && rate){
		var table = document.getElementById("tempMaterialTable");
		
		counter++;
		var rowCount = table.rows.length;
		
		var row = table.insertRow(rowCount);
		
		var cell1 = row.insertCell(0);
		var cell2 = row.insertCell(1);
		var cell3 = row.insertCell(2);
		var cell4 = row.insertCell(3);
		var cell5 = row.insertCell(4);
		var cell6 = row.insertCell(5);
		var cell7 = row.insertCell(6);
		
		cell1.innerHTML = "<td style='text-align: center;'>" +  counter +"</td>";
		cell2.innerHTML = "<td style='text-align: center;'>" +  productName +"<input type='hidden' name='productName1"+counter+"' id='productName1"+counter+"' value='"+productName+"' /> </td>";
		cell3.innerHTML = "<td style='text-align: center;'>" + supplierName +" <input type='hidden' name='supplierName1"+counter+"' id='supplierName1"+counter+"' value='"+supplierName+"' /> </td>";
		cell4.innerHTML = "<td style='text-align: center;'>" + ChalanNo +" <input type='hidden' name='chalanNo_third1"+counter+"' id='chalanNo_third1"+counter+"' value='"+ChalanNo+"' /> </td>";
		cell5.innerHTML = "<td style='text-align: center;'>" + qty +" <input type='hidden' name='qty1"+counter+"' id='qty1"+counter+"' value='"+qty+"' /> </td>";
		cell6.innerHTML = "<td style='text-align: center;'>" + rate +" <input type='hidden' name='rate1"+counter+"' id='rate1"+counter+"' value='"+rate+"' /> </td>";
		cell7.innerHTML = "<td style='text-align: center;'>" + gst +" <input type='hidden' name='gst1"+counter+"' id='gst1"+counter+"' value='"+gst+"' /> </td>";
		
		//alert(productName+" "+qty+" "+rate+" "+ChalanNo+" "+supplierName);
	}
	
	document.getElementById("counter").value = counter;
	
	document.getElementById("productNameSarthak").value="";
	document.getElementById("qtySarthak").value="";
	document.getElementById("rateSarthak").value="";
	document.getElementById("gstSarthak").value="";
	document.getElementById("gst").value="";
	
	document.getElementById("productNameSarthak").focus();
	
} 
//*********************************** ADD MATERIAL FROM SARTHAK END ************************************

//************************************* ADD MATERIAL FROM TP START *************************************
function addMaterialByThirdParty()
{  	
	var productName = document.getElementById("productName").value;
	var qty = document.getElementById("qty").value;
	var rate = document.getElementById("rate").value;	
	var ChalanNo=document.getElementById("chalanNo_third").value;
	var supplierName=document.getElementById("supplierName").value;
	var gst=document.getElementById("gst").value;
    productName = productName.toUpperCase();
	
	if(productName && qty && rate && ChalanNo){
		var table = document.getElementById("tempMaterialTable");
		
		counter++;
		var rowCount = table.rows.length;
		
		var row = table.insertRow(rowCount);
		
		var cell1 = row.insertCell(0);
		var cell2 = row.insertCell(1);
		var cell3 = row.insertCell(2);
		var cell4 = row.insertCell(3);
		var cell5 = row.insertCell(4);
		var cell6 = row.insertCell(5);
		var cell7 = row.insertCell(6);
	    
		cell1.innerHTML = "<td style='text-align: center;'>" +  counter +"</td>";
		cell2.innerHTML = "<td style='text-align: center;'>" +  productName +"<input type='hidden' name='productName1"+counter+"' id='productName1"+counter+"' value='"+productName+"' /> </td>";
		cell3.innerHTML = "<td style='text-align: center;'>" + supplierName +" <input type='hidden' name='supplierName1"+counter+"' id='supplierName1"+counter+"' value='"+supplierName+"' /> </td>";
		cell4.innerHTML = "<td style='text-align: center;'>" + ChalanNo +" <input type='hidden' name='chalanNo_third1"+counter+"' id='chalanNo_third1"+counter+"' value='"+ChalanNo+"' /> </td>";
		cell5.innerHTML = "<td style='text-align: center;'>" + qty +" <input type='hidden' name='qty1"+counter+"' id='qty1"+counter+"' value='"+qty+"' /> </td>";
		cell6.innerHTML = "<td style='text-align: center;'>" + rate +" <input type='hidden' name='rate1"+counter+"' id='rate1"+counter+"' value='"+rate+"' /> </td>";
		cell7.innerHTML = "<td style='text-align: center;'>" + gst +" <input type='hidden' name='gst1"+counter+"' id='gst1"+counter+"' value='"+gst+"' /> </td>";
		
		//alert(productName+" "+qty+" "+rate+" "+ChalanNo+" "+supplierName);
	}
	
	document.getElementById("counter").value = counter;
	document.getElementById("productName").value="";
	document.getElementById("qty").value="";
	document.getElementById("rate").value="";
	document.getElementById("gstSarthak").value="";
	document.getElementById("gst").value="";
	
	document.getElementById("productName").focus();
}
//************************************* ADD MATERIAL FROM TP END *************************************

//************************************* SEARCH TABLE DATA START *************************************
function searchTableData() {
	  var input, filter, table, tr, td, i, j, index, num, span1, t;
	  input = document.getElementById("myInput");
	  filter = input.value.toUpperCase();
	  table = document.getElementById("saleDetails");
	  tr = table.getElementsByTagName("tr");
	  for (i = 0; i < tr.length; i++) {
		  
		index = tr[i].getElementsByTagName("td")[0];
	    td = tr[i].getElementsByTagName("td")[1];
	    

	    if (td) {
	      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
	    	  
	    	  num = index.innerHTML;
	    	  
	    	  if(isFinite(num)){
	    		//alert("mytd"+num);
	    		var x=document.getElementById("tdId"+num.trim()).children;
	    		span1 = x[1].rowSpan;
	    		//alert("span"+span1);
	    		var count=0;
	    		while(span1>0){
	    			//alert("tr"+i);
	    			tr[i].style.display = "";
	    			span1--;
	    			
	    			if(span1>0){
		    			i++;
	    			} 
	    			
	    		}
	    	  }
		        
	      } else {
	    	//alert("tr"+i);
	        tr[i].style.display = "none";
	      }
	    }       
	  }
}
//************************************* SEARCH TABLE DATA END *************************************

//******************************** setFocusToTextBox Function START ********************************
function setFocusToTextBox() {
	document.sales.clientid.focus();
	document.getElementById("clientid").focus();
	showModal();
	myFunction();	
}

$('#add-client').on('shown.bs.modal', function () {
    $('#coname').focus();
})
//******************************** setFocusToTextBox Function END ********************************

//*********************************** SNACKBAR Function START ************************************
function myFunction() {
    var x = document.getElementById("snackbar")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}
//*********************************** SNACKBAR Function END ************************************

//*********************************** selectProduct Function START ************************************
function selectProduct(str)
{
	var request=new XMLHttpRequest();
	var url="/SAMERP/Sales?q="+str;  

	try{  
			request.onreadystatechange=function()
			{  
				if(request.readyState==4)
				{  
					var val=request.responseText;
					var demoStr = val.split(",");
					var i=0, text ="",gst="";
					
					for (; demoStr[i];) {
						text += "<option id="+demoStr[i]+" value="+demoStr[i+1]+">"+ demoStr[i+1] + "</option>";
						gst=demoStr[i+2];
						i=i+3;	
					}
					document.sales.gstSarthak.value=gst;
					document.sales.gst.value=gst;
					document.getElementById("productList").innerHTML = text;
					document.getElementById("productList1").innerHTML = text;
				}
			}
			request.open("POST",url,true);  
			request.send();  
	}catch(e){
		alert("Unable to connect to server");
	}  
}
//*********************************** selectProduct Function END ************************************

function showModal(){

	var error = document.getElementById("error").value;
	
	if(error==1)
	{
		$('#error-msg').modal('show');
	}
}

</script>
</body>
</html>