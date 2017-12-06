<%@page import="java.util.LinkedHashSet"%>
<%@page import="java.util.Set"%>
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
<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
<style type="text/css">
.dataTables_filter {
    color: #878787;
    font-size: 11px;
    right: 0;
    top: 37px;
    margin: -31px 4px 2px 10px;
    position: absolute;
    text-align: left;
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
<body onload="snackBar()">
<!--Header-part-->
<jsp:include page="/jsp/admin/common/header_navbar.jsp"></jsp:include>
<!--close-Header-part-->
<!--close-Header-part--> 
<!--top-Header-menu-->
<!--start-top-serch-->
<%
			if (session.getAttribute("status") != null) {
		%>
		<div id="snackbar"><%=session.getAttribute("status")%></div>
		<%
			}
			session.removeAttribute("status");
		%>

<!--close-top-serch--> 
<!--sidebar-menu-->
	<jsp:include page="/jsp/admin/common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->

<div id="content">
<div id="content-header">
  <div id="breadcrumb"> 
  	<a href="index.html" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> 
  	<a href="#" class="tip-bottom">JCB & POKLAND Dashboard</a>  
  </div>
  <!--Action boxes-->
  <div class="container-fluid" align="center">
    <div class="quick-actions_homepage">
      <ul class="quick-actions">
      <!-- loop for all of them goes here -->
		<li class="bg_lg"> <a href="/SAMERP/jsp/admin/jcb-poc-work/jcb-pocDetails.jsp"> <i class="icon-th-list"></i><span class="label label-success"></span>Chalan Entry</a> </li>
		<li class="bg_ly"> <a href="/SAMERP/jsp/admin/jcb-poc-work/jcb-pocPayment.jsp"> <i class="icon-money"></i><span class="label label-success"></span>Payment View</a> </li>
		<li class="bg_lb"> <a href="/SAMERP/jsp/admin/jcb-poc-work/jcb-pocPaymentReceived.jsp"> <i class="icon-money"></i><span class="label label-success"></span>Payment Received</a> </li>
		<li class="bg_ls"> <a href="/SAMERP/jsp/admin/settings/addCustomer.jsp"> <i class="icon-user"></i><span class="label label-success"></span>Add Customer</a> </li>
		<li class="bg_lo"> <a href="#addProject"  data-toggle="modal" > <i class="icon-signal"></i><span class="label label-success"></span>Add Project</a> </li>
      	<li class="bg_lr"> <a href="/SAMERP/jsp/admin/jcb-poc-work/jcb-pocBill.jsp"> <i class="icon-calendar"></i><span class="label label-success"></span>Create Bill</a> </li>
      	<li class="bg_lb"> <a href="/SAMERP/jsp/admin/jcb-poc-work/jcb-pocReport.jsp"> <i class="icon-pencil"></i><span class="label label-success"></span>Report</a> </li>
      </ul>
    </div>
<!--End-Action boxes-->    
 </div>
</div>
  <div class="container-fluid">
    <hr>
        
     <div class="row-fluid">
      <div class="span12">
        <div class="widget-box collapsible">
        
        


      
          
          
          
          
      <!-- jcb - poc details start  -->
          
           <div class="widget-title"> <a href="#collapseThree" data-toggle="collapse"> <span class="icon"><i class="icon-arrow-right"></i></span>
            <h5>JCB-POC Work Details</h5>
            
            </a> 
          </div>
          <div class="collapse" id="collapseThree">
            <div class="widget-content"> This box is now open </div>
          </div>
          
      <!-- jcb poc details end -->
      
      
      
      
        </div>
      </div>
     </div>
    
    
   </div>
	
         
        
       
        
</div>
<jsp:include page="config/addProject.jsp"></jsp:include>


<!--Footer-part-->
<div class="row-fluid">
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a
				href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
	</div>

<!--end-Footer-part--> 
<script type="text/javascript">
function snackBar() {
	showModalProject();
    var x = document.getElementById("snackbar")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}
//************************************** Modele Delete
function getDeleteIdProject(id1)
{
	
 document.getElementById("deleteProjectId").value=id1;
 
}
function showModalProject(){
	
	var error=<%=session.getAttribute("error")%>;
	
	if(error==2)
	{
		$('#error-msg-delete').modal('show');
	}
	<% session.removeAttribute("error"); %>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</body>
</html>
