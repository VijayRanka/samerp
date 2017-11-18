<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
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

#s2id_supplierid{
	s
    margin-left: 20px;
    width: 315px;
}
	
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

</head>
<body onload="setFocusToTextBox()">
<!--Header-part-->
<div id="header">
  <h1><a href="/SAMERP/index.jsp">SAMERP</a></h1>
</div>
<!--close-Header-part--> 

<% if(request.getAttribute("status")!=null){ %>
<div id="snackbar"><%=request.getAttribute("status")%></div>
<%} %>


<!--top-Header-menu-->
	<!--start-top-serch-->
		<div id="search">
			<button type="submit" class="tip-bottom" style="margin-top: -1px;">LOGOUT</button>
		</div>
	<!--close-top-serch--> 
<!--close-top-Header-menu-->

<!--sidebar-menu-->
<jsp:include page="/jsp/admin/common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->

<div id="content">

	<div id="content-header">
	  	<div id="breadcrumb"> <a href="index.html" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Product Purchase</a>  </div>
	</div>
	
	<div class="container-fluid">
  	<hr>
  	
  	<div class="widget-box">
        <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
          <h5>Product Purchase Details </h5>
        </div>
        <div class="widget-content nopadding" >
          <form action="/SAMERP/ProductPurchase" method="post" class="form-horizontal" name="form1">
            
            <%
            
            	RequireData rd = new RequireData();
            	List supplierList = rd.getSupplierList();
            	List clientList = rd.getClientList();
            	
            %>
            <table style="width:100%">
            <tr>
             
             <td style="">
             <div class="control-group" style="height: 50px;">
              <label class="control-label" style=" margin-left: -5%;  margin-right: -2%;"><span style="color: red;">*</span>Select Supplier :</label>
           
              <div class="controls" style=" margin-left: -5%; ">
              
	                <select class="span2" name="supplierid" id="supplierid" autofocus  required >
	                	<option value="" > Select Supplier</option>
	                	
           	  <%
           	  		if(!supplierList.isEmpty()){
          			Iterator itr = supplierList.iterator();
	              		while(itr.hasNext()){
	          %>
		                	<option value="<%=itr.next()%>"><%=itr.next()%></option>
		      <%
	              		}
           	  		}
	           %>   
	           		</select> 
	           		
              </div>
              </div> 
            </td>
           <a href="#add-supplier" data-toggle="modal" style=" position: absolute; margin-left: 46%; margin-top: 1.4%;">
				<span class="badge badge-inverse"><i class="icon-plus"></i></span>
			  </a>
            <td style="">
            
            <div class="control-group" style="">
              <label style=" float: right; right: 38%; width: 9%; position: absolute" class="control-label"><span style="color: red;">*</span>Select Client :</label>
           
              <div class="controls" style=" margin-left: 28%;">
                <select  name="clientid" id="clientid" style="width:315px;  " required >
                	<option value=""> Select Client</option>
                	<%
                		
                		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                		String requiredDate = df.format(new Date()).toString();
                	
                		if(!clientList.isEmpty()){
		          			Iterator itr1 = clientList.iterator();
		              		while(itr1.hasNext()){
		            %>
			                	<option value="<%=itr1.next()%>"><%=itr1.next()%></option>
			        <%
		              		}
                		}
		           %>   
                </select>
              </div>
              </div>
               <a href="#add-client" data-toggle="modal" style="    position: absolute; margin-left: 45%; margin-top: -3%;">
				<span class="badge badge-inverse"><i class="icon-plus"></i></span>
			  </a>
             </td>
             </tr>
             
             <tr>
             <td>
              	<div class="control-group">
	               <label class="control-label" style="margin-left: -5%;" ><span style="color: red;">*</span>Chalan No. : </label>
	               <div class="controls" style="">
	                 <input type="text" id="chalanno" name="chalanno" style=" width: 300px; margin-left: -8%;" placeholder="Chalan Number"  onkeyup="this.value=this.value.toUpperCase()" 	 required />
	               </div>
               </div>
             </td>
             
             <td>
             	<div class="control-group">
             		<label class="control-label" style=" float: right; right: 38%; position: absolute;"><span style="color: red;">*</span>Vehicle Number :</label>
		              <div class="controls" style=" margin-left: 28%; ">
		                <input type="text" class="span1" placeholder="XX" style="width: 40px;"  name="vehicleno1" id="vehicleno1"  pattern="[A-Za-z]+" maxlength="2" required />  &ndash; 
		                <input type="text" class="span1" placeholder="XX" style="width: 40px;" name="vehicleno2" id="vehicleno2" pattern="[0-9]+" maxlength="2" required />  &ndash; 
		                <input type="text" class="span1" placeholder="XX" style="width: 40px;"  name="vehicleno3" id="vehicleno3" pattern="[A-Za-z]+" maxlength="2" required />  &ndash;
		                <input type="text" class="span2" placeholder="XXXX" style="width: 100px;" name="vehicleno4" id="vehicleno4" pattern="[0-9a-zA-Z]+" maxlength="4" required />
		              </div>
             	</div>
             </td>
             </tr>
             
             
             <tr>
             <td>
             	<div class="control-group" style="">
             		<label class="control-label"  style=" margin-left: -5%;">Date : </label>
		               <div class="controls">
		                 <input type="date" id="date" name="date" value="<%=requiredDate %>" style=" width: 300px; margin-left: -8%;"/>
		               </div>
             	</div>
             </td>
             
             
             <td>
             	<div class="control-group" style="">
             		<label class="control-label" style=" float: right; right: 38%; position: absolute;" ><span style="color: red;">*</span>Select Product :</label>
		              <div class="controls">
		                <input list="productList" type="text" autocomplete="off" id="productname" onkeyup="makeCaps(this.value, this.id)" name="productname" placeholder="Product Name" style=" width: 300px; margin-left: -11%; " />
		              	<datalist id="productList"></datalist>
		              </div>
             	</div>
             </td>
             </tr>
             
             <tr>
             <td>
             	<div class="control-group" style="">
             		<label class="control-label" style=" margin-left: -5%;"><span style="color: red;">*</span>Quantity : </label>
		               <div class="controls">
		                 <input type="number" id="qty"  name="qty" placeholder="Quantity" style=" width: 300px; margin-left: -8%;" onkeyup="this.value=this.value.toUpperCase()" />
		               </div>
             	</div>
             </td>
             
             <td>
             	<div class="control-group" style="">
             		<label class="control-label" style="float: right; right: 38%; position: absolute;"><span style="color: red; ">*</span>Rate : </label>
		              <div class="controls">
		                  <input type="number" placeholder="Rate" name="rate" id="rate" class="span2" style=" width: 300px; margin-left: -11%;" >
		                  <span class="add-on" style="width: 20px;"><i class="icon-inr" style="font-size: 1.5em;"></i></span>
		              </div>
             	</div>
             </td>
             </tr> 
       	</table>
       	
       		<div class="control-group" align="center" style="height: 50px;">
            	<button type="button" id="addbtn" name="addbtn" onclick="addProduct()" style=" margin-top: 10px;" class="btn btn-success">Add Product</button> 
            </div>
       		
       		<div class="control-group">
		   		<div class="span10">
		   		<div class="widget-box" style="margin-left: 15%;  margin-right: 4%;">
		          <div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
				      <h5>Current Product Purchasing</h5>
		          </div>
		          <div class="widget-content nopadding">
		            <table class="table table-bordered table-striped" id="tempPurchaseTables">
		              <thead>
		                <tr>
		                  <th>Sr.No.</th>
		                  <th>Product Name</th>
		                  <th>Quantity</th>
		                  <th>Rate</th>
		                </tr>
		              </thead>
		              <tbody>	
		                <tr class="odd gradeX">  </tr>
		             </tbody>
		           </table>
		          </div>
		        </div>
		      </div>  
	        </div>
       	
       		<input type="hidden" name="counter" id="counter" /> 
       		
            <div class="form-actions" align="center">
              <button type="submit" id="insertSubmitBtn" name="insertSubmitBtn" class="btn btn-success">Submit</button> &nbsp;&nbsp;&nbsp;&nbsp;
              <a href="/SAMERP/index.jsp" id="cancelbtn"  class="btn btn-danger">Exit</a>
            </div>
          </form>        
        </div>
  	</div>
  
  	
  	<div class="widget-box">
          <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
            <h5>Past Purchase Record</h5> <p style="float: right; position: relative; right: 21%; font-size: 125%; margin: 0.7%;">Search : </p>
            <input type="text" id="myInput" onkeyup="myFunction1()" style=" float: right; margin-right: -6%; margin-top: 0.3%;" placeholder="Search Supplier..." title="Type in a Supplier name">
          </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered" id="pastPurchaseTable">
            <div class="controls" style="float: right;position: relative;right: 68px; bottom: 33px">
              <span  style="position: relative;bottom: 5px;"><b id="dateFun">From Date:</b></span>
              <% SysDate sd=new SysDate(); String[] sdDemo; sdDemo=sd.todayDate().split("-");
              %>
                <input id="fromDate" type="date" value="<%=sdDemo[2]+"-"+sdDemo[1]+"-"+sdDemo[0] %>" onchange="getData(this.value,1)" style="width: 130px">
                  <span  style="position: relative;bottom: 5px;"><b id="dateFun">To Date:</b></span>
                 <input id="toDate" type="date" value="<%=sdDemo[2]+"-"+sdDemo[1]+"-"+sdDemo[0] %>" onchange="getData(this.value,2)" style="width: 130px">
                </div> 
              <thead>
                <tr>
                  <th>Sr.No.</th>
                  <th>Supplier Name</th>
                  <th>Client Name</th>
                  <th>Chalan Number</th>
                  <th>Vehicle Number</th>
                  <th>Date</th>
                  <th>Product Name</th>
                  <th>Quantity</th>
                  <th>Rate</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
              <% 
              	List purchaseProductList = rd.getPurchaseProduct();
              	Iterator itr2 = purchaseProductList.iterator();
              	
              	int i=1;
              	
              	while(itr2.hasNext()){
              		
              		String pid = itr2.next().toString();
              		String span = itr2.next().toString();
              %>
                <tr id="tdId<%=i%>">
                  <td rowspan="<%=span%>" id="<%= pid%>"> <%=i%> </td>
                  <td id="mytd<%=i%>" rowspan="<%= span%>"><%=itr2.next() %></td>
                  <td rowspan="<%= span%>"><%=itr2.next() %></td>
                  <td rowspan="<%= span%>"><%=itr2.next() %></td>
                  <td rowspan="<%= span%>"><%=itr2.next() %></td>
                  <td rowspan="<%= span%>"><%=itr2.next() %></td>
     			  <%
   			  		List l = rd.getProductDetails(pid);
   			 		Iterator itr3 = l.iterator();
   			 	  %>
   			 	  	
	   			 	<td><%=itr3.next() %></td>
	                <td><%=itr3.next() %></td>
	                <td><%=itr3.next() %></td>
     			  	<td rowspan="<%= span%>"><a href="#update" data-toggle="modal"  onclick="updateRecord(<%=pid%>)">Update</a> | <a onclick="getDeleteId('<%=pid %>')" href="#DeleteConfirmBox" data-toggle='modal'>Delete</a></td>	
                
   			 	  <%
   			 		while(itr3.hasNext()){
     			  %>	
     				<tr>
     				<td><%=itr3.next() %></td>
	                <td><%=itr3.next() %></td>
	                <td><%=itr3.next() %></td>
	                
	                <%
	                	if(itr3.hasNext()){
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

<!--Footer-part-->
<div class="row-fluid">
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a
				href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
	</div>

<!--end-Footer-part-->


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
				<form action="/SAMERP/ProductPurchase">
				<input type="hidden" id="deleteId" name="deleteId">
					<a href=""></a><input type="submit" class="btn btn-primary" id="okButton" value="OK" name="ok" />
					<input type="button" class="btn btn-danger" data-dismiss="modal" on value="Cancel"/>
				</form>
			</div>
		</div>	
	</div>
</div>

<div class="modal hide fade" id="DeleteError" role="dialog" style="width: 44%; margin-left: -310px;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title"><span style="color:red">Confirm Delete</span></h4>
			</div>
			
			<div class="modal-body">
				<div class="alert alert-error" style="margin-top: 18px;">
  				<i class="icon-remove-circle" style="font-size: 2em;"></i> &nbsp; <strong style="font-size: 15px;">Cannot Delete selected products as it is linked with other Records...</strong>
				</div>
			</div>
			<div class="modal-footer">
					<input type="button" class="btn btn-danger" data-dismiss="modal" on value="OK"/>
				</form>
			</div>
		</div>	
	</div>
</div>

<div class="modal hide fade zoom-out" id="update" role="dialog" style="width: 75%; margin-left:-38%; margin-top: -15px; ">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Update Product Purchase Details</h4>
			</div>
			<div class="modal-body" style="max-height: 450px;">
				<form class="form-horizontal" action="/SAMERP/ProductPurchase" method="post" id="updateForm" name="updateProductPurchase">
					<div class="form-group">
						<div class="widget-content nopadding">
          					
          					
          					
          					<div class="alert alert-error"  id="updateError" style="margin-top: 18px; display: none;">
          						<span>
          							<i class="icon-remove-circle" style="font-size: 2em;"></i> &nbsp; <strong style="font-size: 15px;">Bill already generated for this order, You Cannot Update or Delete this Purchase Order...</strong>
          						</span>
          					</div>
          					
          					
				            <%
            
				            	List supplierList1 = rd.getSupplierList();
				            	List clientList1 = rd.getClientList();
				            	
				            %>
				            
				             <div class="control-group" style="height: 50px;">
				              <label class="control-label" style="margin-left: -5%;"><span style="color: red;">*</span>Select Supplier :</label>
				           
				              <div class="controls" style=" margin-left: -5%;">
				              
					                <select class="span2" name="updateSupplierid" id="updateSupplierid" autofocus style=" width: 305px; "  required >
					                	<option value=""> Select Supplier</option>
					                	
				           	  <%
				          			Iterator itr3 = supplierList1.iterator();
				              		while(itr3.hasNext()){
				              %>
					                	<option value="<%=itr3.next()%>"><%=itr3.next()%></option>
					           <%
				              		}
					           %>   
					           		</select>  
				              </div>
				              
				              
				              <label style=" float: right; right: 38%; margin-top: -2.2%; position: absolute;" class="control-label"><span style="color: red;">*</span>Select Client :</label>
				           
				              <div class="controls" style=" float: right; width: 35%; margin-top: -2.2%;">
				                <select  name="updateClientid" id="updateClientid" style="width:315px;  " required >
				                	<option value=""> Select Client</option>
				                	<%
				                		
					          			Iterator itr4 = clientList1.iterator();
					              		while(itr4.hasNext()){
					              %>
						                	<option value="<%=itr4.next()%>"><%=itr4.next()%></option>
						           <%
					              		}
						           %>   
				                </select>
				              </div>
				              </div>
				            
				              	<div class="control-group">
					               <label class="control-label" style=" margin-left: -5%;" ><span style="color: red;">*</span>Chalan No. : </label>
					               <div class="controls">
					                 <input type="text" id="updateChalanno" name="updateChalanno" style="width: 290px; margin-left: -5%;" placeholder="Chalan Number"  onkeyup="this.value=this.value.toUpperCase()" 	 required />
					               </div>
				               

				             		<label class="control-label" style="float: right; right: 38%; margin-top: -5%; position: absolute;"><span style="color: red;">*</span>Vehicle Number :</label>
						              <div class="controls" style=" float: right; position: absolute; right: 5.7%; margin-top: -5%;">
						                <input type="text" class="span1" placeholder="XX" style="width: 40px;"  name="updateVehicleno1" id="updateVehicleno1"  pattern="[A-Za-z]+" maxlength="2" required />  &ndash; 
						                <input type="text" class="span1" placeholder="XX" style="width: 40px;" name="updateVehicleno2" id="updateVehicleno2"  pattern="[0-9]+" maxlength="2" required />  &ndash; 
						                <input type="text" class="span1" placeholder="XX" style="width: 40px;" name="updateVehicleno3" id="updateVehicleno3"  pattern="[A-Za-z]+" maxlength="2" required />  &ndash;
						                <input type="text" class="span2" placeholder="XXXX" style="width: 100px;" name="updateVehicleno4" id="updateVehicleno4" pattern="[0-9a-zA-Z]+" maxlength="4" required />
						              </div>
				             	</div>
				            
				             	<div class="control-group" style="">
				             		<label class="control-label" style="margin-left: -5%;" >Date : </label>
						               <div class="controls">
						                 <input type="date" id="updateDate" name="updateDate" value="<%=requiredDate %>" style=" width: 290px; margin-left: -5%;"/>
						               </div>
				             	</div>
				            
				            
				            <div class="control-group">
				              
					              <label class="control-label" style=" margin-left: -5%;">Product Details :</label>
					              <label class="control-label" style=" margin-left: -1%;"><strong> Name</strong></label>
							      <label class="control-label" style=" margin-left: 6%;"><strong> Quantity</strong></label>
								  <label class="control-label" style=" margin-left: 5%;"><strong> Rate</strong></label>
								  
					              <div class="controls" style=" margin-left: 16%;">
					              <input type="hidden" name="proList" id="proList" />
					              <table id="updateTable">
					              <tbody>
					              <tr>
									
					              	<!-- <input type="text" name="productPId1" id="productPId1"/>
					                <input type="text" list="productList1" class="span11" name="productName1"  onkeyup="makeCaps(this.value)" id="productName1" style="width: 200px;" required />
					                <datalist id="productList1"></datalist>
					                <input type="text" class="span11" name="productQty1" id="productQty1" style="width: 200px;" required />
					                <input type="text" class="span11" name="productRate1" id="productRate1" style="width: 200px;" required />
 -->
					              <tr>
					              </tbody> 
					              </table>
					              
					              </div>
				              
				            </div>
				            
				            <input type="hidden" name="newCount" id="newCount" /> 
				            <input type="hidden" name="updateQty" id="updateQty" />
				            <input type="hidden" name="updatepid" id="updatepid" />
				            
				            <div class="modal-footer" id="billCheckFalse">
				            		<button type="button" id="plusBtn" style=" position: relative; float: right; margin-top: -5.5%; margin-right: 5%; width: 3%;" class="btn btn-primary" onclick="insertRow()"> <span class='icon'><i style="margin-left: -4px;" class='icon-plus'></i></span> </button>
									<input type="submit" id="submitbtn" name="updateSubmitBtn" class="btn btn-primary" value="Update" />
									<input type="button" id="cancelbtn" class="btn btn-danger" data-dismiss="modal" value="Cancel"/>
							</div>
							
							<div class="modal-footer" id="billCheckTrue" style="display: none;">
									<button type="button" class="btn btn-danger" data-dismiss="modal" style="margin-right: 20px">OK</button>
							</div>
							
						</div>
					</div>
				</form>
			</div>
				
			</div>
		</div>
	</div>


<!-- supplier Modal  -->

	<div class="modal hide fade zoom-out" id="add-supplier" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Add New Supplier:</h4>
				</div>
				<div class="modal-body">
					
					<form class="form-horizontal" id="supForm" action="/SAMERP/AddSupplyMaterial" method="post">
						<div class="control-group">
							<label class="control-label">Supplier Business Name</label>
							<div class="controls">
								<input type="text" id="supBname" name="suppbusinesname"  onkeyup="this.value=this.value.toUpperCase()" pattern="[a-z A-Z]*" class="span3" placeholder="Supplier Business Name" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Supplier Name</label>
							<div class="controls">
								<input type="text" id="supName" name="suppname" onkeyup="this.value=this.value.toUpperCase()" pattern="[a-z A-Z]*" class="span3" placeholder="Supplier Name" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Supplier Address</label>
							<div class="controls">
								<!-- <input type="text" id="supAdd" name="address" onkeyup="this.value=this.value.toUpperCase()" class="span3" placeholder="Supplier Address" /> -->
								<textarea type="text" class="span3" id="supAdd" name="address" onkeyup="this.value=this.value.toUpperCase()" pattern="[a-z A-Z 0-9]*" placeholder="Supplier Address" pattern="[a-z A-Z0-9]*" maxlength="200" required></textarea>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Supplier Contact</label>
							<div class="controls">
								<input type="text" id="supCn" name="contact" pattern="[0-9]*" maxlength="10" onkeyup="this.value=this.value.toUpperCase()" class="span3" placeholder="Supplier Contact" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Supplier Balance</label>
							<div class="controls">
								<input type="text" id="supBal" name="openingbalance" onkeyup="this.value=this.value.toUpperCase()" pattern="[0-9]*" class="span3" placeholder="Supplier Balance" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" >Supplier Type</label>
							<div class="controls" style="width: 57%;">
								<select id="supTyp" name="material_type">
									<option value="1">Raw Material</option>
									<option value="2">Product</option>
								</select>
							</div>
						</div>
						
						<input type="hidden" name="productPurchasePage" value="productPurchase" />
						
						<div class="modal-footer">
							<button type="submit" id="submitbtn" name="insertsupply" class="btn btn-success" onclass="btn btn-primary">Submit</button> 
							<button type="button" id="cancelbtn" class="btn btn-danger" data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>
				
			</div>
		</div>

	</div>

	<!-- 	end supplier modal -->


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
								<input type="text" id="coname" name="coname" class="span3" onkeyup="this.value=this.value.toUpperCase()" placeholder="Client Orgnization Name" pattern="[a-z A-Z0-9]*" required />
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
							<button type="submit" name="insert" class="btn btn-success">Submit</button>	&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn btn-danger" data-dismiss="modal" style="margin-right: 20px">Close</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
		
	
	<!--  add client modal end -->
	
	

	
	<div class="modal fade" id="insertError" role="dialog">
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
								<input type="button" class="btn btn-primary" id="submitbtn" data-dismiss="modal" value="OK" />
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>



<script type="text/javascript">

window.counter = 0;

//vijay data ajax b/w dates

function getData(value,id)
{
	if(document.getElementById("fromDate").value=="" || document.getElementById("toDate").value=="")
		{
		alert("Choose Right Date Format");
		}
	else{
		/* var firstDate="";
		var lastDate="";
		if(id==1)
		{
			firstDate=value;
			lastDate=document.getElementById("toDate").value;
		}
	    else if(id==2)
		{
			firstDate=document.getElementById("fromDate").value;
			lastDate=value;
		}
			var xhttp;
			xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var demoStr = this.responseText.split(",");
					if(demoStr=="")
						document.getElementById("wholeDataList").innerHTML="<tr><td colspan='10'>No Records Found!</td></tr>"
					else{
					var a="";
					var count=1;
					for(var i=0;i<demoStr.length-1;i=i+11)
						{
						 a+= "<tr>"+
						"<td style='text-align: center'>"+count+"</td>"+
						"<td style='text-align: center'>"+demoStr[i+1]+"</td>"+
						"<td style='text-align: center'>"+demoStr[i+2]+"</td>"+
						"<td style='text-align: center'>"+demoStr[i+3]+"</td>"+
						"<td style='text-align: center' >"+demoStr[i+4]+"</td>"+
						"<td style='text-align: center'>"+demoStr[i+5]+"</td>"+
						"<td style='text-align: center'>"+demoStr[i+6]+"</td>"+
						"<td style='text-align: center'' >"+demoStr[i+7]+"</td>"+
						"<td style='text-align: center'>"+demoStr[i+8]+"</td>"+
						"<td style='text-align: center'>"+demoStr[i+9]+"</td>"+
						"<td style='text-align: center'>"+demoStr[i+10]+"</td>"+
						" <td style='text-align: center'>"+
						"<a data-toggle='modal' href='#update' onclick='getUpdateData("+demoStr[i]+")'>Update</a></td>"+
						"<tr>";
						count++;
						}
					document.getElementById("wholeDataList").innerHTML=a;
					}
				
				}
					
				};
			xhttp.open("POST", "/SAMERP/ProductPurchase?getDateData=1&fromDate="+firstDate+"&toDate="+lastDate, true);
			xhttp.send();*/
		} 
}

function myFunction1() {
	  var input, filter, table, tr, td, i, j, index, num, span1, t;
	  input = document.getElementById("myInput");
	  filter = input.value.toUpperCase();
	  table = document.getElementById("pastPurchaseTable");
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
	        
	        tr = table.getElementsByTagName("tr");
	      }
	    }       
	  }
}


function getDeleteId(deleteid)
{	
	document.getElementById("deleteId").value=deleteid;
}


function updateRecord(id) {
	
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
		
			var demoStr = this.responseText.split(",");
			
			window.billCheck = demoStr[1];
			
			if(window.billCheck==1){
				document.getElementById("updateError").style.display="block";
				document.getElementById("billCheckTrue").style.display="block";
				document.getElementById("billCheckFalse").style.display="none";
				document.getElementById("submitbtn").disabled=true;
				document.getElementById("plusBtn").style.display="none";
				$('#updateForm :input').attr('readonly','readonly');
			}
			else{	
				
				document.getElementById("updateError").style.display="none";
				document.getElementById("billCheckTrue").style.display="none";
				document.getElementById("billCheckFalse").style.display="block";
				document.getElementById("submitbtn").disabled=false;
				document.getElementById("plusBtn").style.display="block";
				$('#updateForm :input').removeAttr('readonly');
			}
			
			var qty = demoStr[3];
			document.getElementById("updatepid").value = demoStr[2];
			document.getElementById("updateQty").value = demoStr[3];
			
			document.getElementById("updateSupplierid").value = demoStr[4];
			var dd = document.getElementById('updateSupplierid');
			for (var i = 0; i < dd.options.length; i++) {
			    if (dd.options[i].text === demoStr[4]) {
			        dd.selectedIndex = i;
			        getSetSelect('s2id_updateSupplierid', demoStr[4]);
			        break;
			    }
			}
			
			document.getElementById("updateClientid").value = demoStr[5];
			var dd1 = document.getElementById('updateClientid');
			for (var i = 0; i < dd1.options.length; i++) {
			    if (dd1.options[i].text === demoStr[5]) {
			        dd1.selectedIndex = i;
			        getSetSelect('s2id_updateClientid', demoStr[5]);
			        break;
			    }
			}
			
			document.getElementById("updateChalanno").value = demoStr[6];
			
			var vno = demoStr[7].split("-");
			document.getElementById("updateVehicleno1").value=vno[0];
			document.getElementById("updateVehicleno2").value=vno[1];
			document.getElementById("updateVehicleno3").value=vno[2];
			document.getElementById("updateVehicleno4").value=vno[3];
			
			document.getElementById("updateDate").value = demoStr[8];
			

			/* document.getElementById("productPId1").value = demoStr[8];
			document.getElementById("productName1").value = demoStr[9];
			document.getElementById("productQty1").value = demoStr[10];
			document.getElementById("productRate1").value = demoStr[11]; */
			
			
			
			var table = document.getElementById("updateTable");
			var counter=8; //
			var rowCount1 = table.rows.length;
			var tableHeaderRowCount = 0;
			
			if(rowCount1>0){
				for (var i = tableHeaderRowCount; i < rowCount1; i++) {
				    table.deleteRow(tableHeaderRowCount);
				}
			}
			
			var prolist="";
			for(var i=1; i<=qty; i++)
			{
				var rowCount = table.rows.length;

				var row = table.insertRow(rowCount);
				
				var cell1 = row.insertCell(0);
				var cell2 = row.insertCell(1);
				var cell3 = row.insertCell(2);
				var cell4 = row.insertCell(3);
				
				var proid = demoStr[++counter];
				prolist = prolist + "," + proid;
				
				cell1.innerHTML = "<tr rowId='"+i+"'><td><input type='hidden' name='productPId"+i+"' id='productPId"+i+"'  value='"+proid+"' /><input type='text' style='width: 220px;' list='productList1' autocomplete='off' onkeyup='makeCaps(this.value, this.id)'  id='productName"+i+"'  name='productName"+i+"'  value='"+demoStr[++counter]+"' required /><datalist id='productList1'></datalist>"
				cell2.innerHTML = "<input type='number' style='width: 220px;'   id='productQty"+i+"'   name='productQty"+i+"' value='"+demoStr[++counter]+"' pattern='[0-9]*' required />"
				cell3.innerHTML = "<input type='text' style='width: 220px;   id='productRate"+i+"'  name='productRate"+i+"' value='"+demoStr[++counter]+"' pattern='[0-9]*' required /> </td>"
				if(!(window.billCheck==1)){
					cell4.innerHTML = "<a onclick='+deletePaticularRow(this)'> <span class='icon'><i id='removeBtn' style=' color: red; font-size: 1.7em;' class='icon-remove'></i></span> </a></td></tr>"
				}
				
				
			}
			document.getElementById("proList").value=prolist;
			document.getElementById("newCount").value=qty;
		}
	};
	xhttp.open("POST","/SAMERP/ProductPurchase?updateid="+id, true);
	xhttp.send();
	
	
}
 
function getSetSelect(id,value)
{
	var x=document.getElementById(id).children;
	var xx=x[0].children;
	xx[0].innerHTML=value;
}

function showdata(id){
	document.getElementById(id).style.display='block';
}

function setFocusToTextBox() {
	
	document.getElementById("supplierid").focus();
	
	var error = <%=request.getAttribute("error") %>
	
	if(error==2)
	{
		$('#insertError').modal('show');
	}
	else if(error==3){
		$('#DeleteError').modal('show');
	}
	
	myFunction();
}

function myFunction() {
    var x = document.getElementById("snackbar")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}



function insertRow()
{
	var table=document.getElementById("updateTable");
	var Row=table.rows;
	var numrows=Row.length;
	var row = table.insertRow(numrows);
	
    var cell1 = row.insertCell(0);
    var cell2 = row.insertCell(1);
    var cell3 = row.insertCell(2);
    var cell4 = row.insertCell(3);
    
    cell1.innerHTML = "<tr id='rowId"+ (numrows+1) +"'><td><input type='text' style='width:220px;' id='productName"+ (numrows+1) +"' name='productName"+ (numrows+1) +"' list='productList2' onkeyup='makeCaps(this.value, this.id)' autocomplete='off'  placeholder='Product Name' required /><datalist id='productList2'></datalist>";
    cell2.innerHTML = "<input type='text' style='width:220px;' id='productQty"+ (numrows+1) +"' name='productQty"+ (numrows+1) +"' placeholder='Product Quantity' pattern='[0-9]*' required />";
    cell3.innerHTML = "<input type='text' style='width:220px;' id='productRate"+ (numrows+1) +"' name='productRate"+ (numrows+1) +"' placeholder='Product Rate' pattern='[0-9]*' required /> </td>";
    cell4.innerHTML = "<a onclick='+deletePaticularRow(this)' > <span class='icon'><i id='removeBtn' style=' color: red; font-size: 1.7em;' class='icon-remove'></i></span> </a></td></tr>";
	
    document.getElementById("newCount").value=numrows+1;
}

function deleteRow()
{
	var deleteRows=document.getElementById("updateTable");
	var Rows = table.rows;
    var numRows = Rows.length;
    if(numRows>1){
    	table.deleteRow(numRows-1);
    }
    var cnt = document.getElementById("newCount").value;
    document.getElementById("newCount").value
}


function deletePaticularRow(r)
{   
	var table=document.getElementById("updateTable");
	var Rows = table.rows;
    var numRows = Rows.length;
    if(numRows>1){
		var i = r.parentNode.parentNode.rowIndex;
		table.deleteRow(i);
		//document.getElementById("newCount").value=numRows-1;
    }
    
}

function addProduct()
{  	
	var productName = document.getElementById("productname").value;
	var qty = document.getElementById("qty").value;
	var rate = document.getElementById("rate").value;	
	
	
	if(productName && qty && rate){
		var table = document.getElementById("tempPurchaseTables");
		
		counter++;
		var rowCount = table.rows.length;
		var row = table.insertRow(rowCount);
		
		var cell1 = row.insertCell(0);
		var cell2 = row.insertCell(1);
		var cell3 = row.insertCell(2);
		var cell4 = row.insertCell(3);
	    
		cell1.innerHTML = "<td>" +  counter +"</td>";
		cell2.innerHTML = "<td>" +  productName +"<input type='hidden' name='productName"+counter+"'  id='productName"+counter+"' value='"+productName+"' /> </td>";
		cell3.innerHTML = "<td>"+ qty +" <input type='hidden' name='qty"+counter+"' id='qty"+counter+"' value='"+qty+"' /> </td>";
		cell4.innerHTML = "<td>"+ rate +" <input type='hidden' name='rate"+counter+"' id='rate"+counter+"' value='"+rate+"' /> </td>";
	}
	
	document.getElementById("counter").value = counter;
	
	document.getElementById("productname").value="";
	document.getElementById("qty").value="";
	document.getElementById("rate").value="";	
	document.getElementById("productname").focus();
	
} 

function makeCaps(str, id) {
	document.getElementById(id).value=str.toUpperCase();
	selectProduct(str);
}

function selectProduct(str)
{
	var request=new XMLHttpRequest();
	var url="/SAMERP/ProductPurchase?q="+str;  

	try{  
			request.onreadystatechange=function()
			{  
				if(request.readyState==4)
				{  
					var val=request.responseText;
					var demoStr = val.split(",");
					var i=0, text ="";
					
					for (; demoStr[i];) {
						text += "<option id="+demoStr[i]+" value="+demoStr[i+1]+">"+ demoStr[i+1] + "</option>";
						i=i+2;	
					}
					
					document.getElementById("productList").innerHTML = text;
					document.getElementById("productList1").innerHTML = text;
					document.getElementById("productList2").innerHTML = text;
					
				}
			}
			
			request.open("POST",url,true);  
			request.send();  
	}catch(e){
		alert("Unable to connect to server");
	}  
	
}


var a = document.getElementById("vehicleno1");
var b = document.getElementById("vehicleno2");
var c = document.getElementById("vehicleno3");
var	d = document.getElementById("vehicleno4");

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

var e = document.getElementById("updateVehicleno1");
var f = document.getElementById("updateVehicleno2");
var g = document.getElementById("updateVehicleno3");
var	h = document.getElementById("updateVehicleno4");

e.onkeyup = function() {
	this.value=this.value.toUpperCase();
    if (this.value.length === parseInt(this.attributes["maxlength"].value)) {
        f.focus();
    }
}

f.onkeyup = function() {
    if (this.value.length === parseInt(this.attributes["maxlength"].value)) {
        g.focus();
    }
}

g.onkeyup = function() {
	this.value=this.value.toUpperCase();
	if (this.value.length === parseInt(this.attributes["maxlength"].value)) {
        h.focus();
    }
}


</script>

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
$('#add-supplier').on('shown.bs.modal', function () {
    $('#suppbusinesname').focus();
})

$('#add-client').on('shown.bs.modal', function () {
    $('#coname').focus();
})

</script>
</body>
</html>