<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PAYMENT</title>
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />
<link rel="stylesheet" href="/SAMERP/config/css/select2.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
</head>
<body>
<!--Header-part-->
<div id="header">
  <h1><a href="/SAMERP/index.jsp">Matrix Admin</a></h1>
</div>
<!--close-Header-part--> 
<!--top-Header-menu-->
<!--start-top-serch-->
<div id="search">
  <input type="text" placeholder="Search here..."/>
  <button type="submit" class="tip-bottom" title="Search"><i class="icon-search icon-white"></i></button>
</div>
<!--close-top-serch--> 


<!--sidebar-menu-->

<div id="sidebar"><a href="#" class="visible-phone"><i class="icon icon-home"></i> Dashboard</a>
  <ul>
    <li><a href="/SAMERP/index.jsp"><i class="icon icon-home"></i> <span>Dashboard</span></a> </li>
    <li class="submenu"> <a href="#"><i class="icon icon-th-list"></i> <span>Settings</span> <span class="label label-important">7</span></a>
      <ul>
        <li><a href="/SAMERP/jsp/admin/settings/addMaterialSuppliers.jsp">Add Material Supplier</a></li>
        <li><a href="/SAMERP/jsp/admin/settings/addEmployee.jsp">Add Employee</a></li>
        <li><a href="/SAMERP/jsp/admin/settings/addOrganization.jsp">Add Organization</a></li>
        <li><a href="/SAMERP/jsp/admin/settings/addAccountDetails.jsp">Add Account Details</a></li>
        <li><a href="/SAMERP/jsp/admin/settings/addVehicles.jsp">Add Vehicles</a></li>
        <li><a href="/SAMERP/jsp/admin/settings/addClient.jsp">Add Clients</a></li>
</ul>
    <li> <a href="/SAMERP/jsp/admin/settings/expenses.jsp"><i class="icon icon-money"></i> <span>Expenses</span></a> </li>
    <li class="active"> <a href="/SAMERP/jsp/admin/payment/payment.jsp"><i class="icon icon-inbox"></i> <span>Payment</span></a> </li>
    <li><a href="tables.html"><i class="icon icon-th"></i> <span>Tables</span></a></li>
    <li><a href="grid.html"><i class="icon icon-fullscreen"></i> <span>Full width</span></a></li>
    <li class="submenu"> <a href="#"><i class="icon icon-th-list"></i> <span>Forms</span> <span class="label label-important">3</span></a>

      <ul>
        <li><a href="form-common.html">Basic Form</a></li>
        <li><a href="form-validation.html">Form with Validation</a></li>
        <li><a href="form-wizard.html">Form with Wizard</a></li>
      </ul>
    </li>
    <li><a href="buttons.html"><i class="icon icon-tint"></i> <span>Buttons &amp; icons</span></a></li>
    <li><a href="interface.html"><i class="icon icon-pencil"></i> <span>Eelements</span></a></li>
    <li class="submenu"> <a href="#"><i class="icon icon-file"></i> <span>Addons</span> <span class="label label-important">5</span></a>
      <ul>
        <li><a href="index2.html">Dashboard2</a></li>
        <li><a href="gallery.html">Gallery</a></li>
        <li><a href="calendar.html">Calendar</a></li>
        <li><a href="invoice.html">Invoice</a></li>
        <li><a href="chat.html">vijay option</a></li>
        <li><a href="chat.html">ranka option</a></li>
        <li><a href="chat.html">OM option</a></li>
      </ul>
    </li>
  </ul>
</div>

<!--close-left-menu-stats-sidebar-->

<div id="content">
<div id="content-header">
  <div id="breadcrumb"> <a href="index.html" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Form elements</a> <a href="#" class="current">Common elements</a> </div>
  <!--Action boxes-->
  <div class="container-fluid offset2">
    <div class="quick-actions_homepage">
      <ul class="quick-actions">
      <!-- loop for all of them goes here -->
        <li class="bg_ls"> <a href="buttons.html"> <i class="icon-user"></i><span class="label label-success">1</span> Suppliers</a> </li>
		<li class="bg_ls"> <a href="buttons.html"> <i class="icon-user"></i><span class="label label-success">2</span> Pipes Client</a> </li>
		<li class="bg_ls"> <a href="buttons.html"> <i class="icon-user"></i><span class="label label-success">3</span> JCB/POC Customers</a> </li>
      </ul>
    </div>
<!--End-Action boxes-->    
</div>
</div>
<div class="container-fluid">
  <hr>
  <div class="control-group">
              <label class="control-label">Date picker (dd-mm)</label>
              <div class="controls">
                <input type="text" data-date="01-02-2013" data-date-format="dd-mm-yyyy" value="01-02-2013" class="datepicker span3">
                <span class="help-block">Date with Formate of  (dd-mm-yy)</span> </div>
            </div>
  <div class="row-fluid">
  	<div class="span12">
  	<div class="widget-box">
          <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
            <h5>Data table</h5>
          </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
              <thead>
                <tr>
                  <th>S.No.</th>
                  <th>Names</th>
                  <th>Amount(s)</th>
                  <th>Mode</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
                <tr class="gradeX">
                  <td style="text-align: center; width:50px">1</td>
                  <td style="text-align: center">Supplier</td>
                  <td style="text-align: center">5000</td>
                  <td style="text-align: center"><a data-toggle="modal" data-target="#payit"><input type="submit" onclick="" class="btn btn-primary" value="PAY"></a></td>
                  <td style="text-align: center">Update/Delete</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
  	</div>
  </div>
</div>
</div>
<!--Footer-part-->
<div class="row-fluid">
  <div id="footer" class="span12"> 2013 &copy; Matrix Admin. Brought to you by <a href="http://themedesigner.in">Themedesigner.in</a> </div>
</div>
<!--end-Footer-part--> 
<!-- modal toggle starts here -->
<div class="modal hide fade" id="payit" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title"> Details :</h4>
			</div>
			<form action="#" method="get" class="form-horizontal">
			<div class="modal-body">
        <div class="widget-content nopadding">
            <div class="control-group">
              <label class="control-label">Name :</label>
              <div class="controls">
                <input type="text" class="span3" placeholder="Name" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">Total Balance :</label>
              <div class="controls">
                <input type="text" class="span3" placeholder="Total Balance" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">Pay Amount</label>
              <div class="controls">
                <input type="text" class="span3" placeholder="Amount" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">Date picker (dd-mm)</label>
              <div class="controls">
                <input type="text" data-date="01-02-2013" data-date-format="dd-mm-yyyy" value="01-02-2013" class="datepicker span3">
                <span class="help-block">Date with Formate of  (dd-mm-yy)</span> </div>
            </div>
            <div class="control-group">
              <label class="control-label">Message</label>
              <div class="controls">
                <textarea class="span3" ></textarea>
              </div>
            </div>
        	</div>
        	</div>
        <div class="modal-footer">
        <button type="button" class="btn btn-success" data-dismiss="modal">Pay</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
        </div>
        </form>
        </div>
	</div>
</div>
<!-- modal toggle ends here -->
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
	$('.textarea_editor').wysihtml5();
</script>
</body>
</html>