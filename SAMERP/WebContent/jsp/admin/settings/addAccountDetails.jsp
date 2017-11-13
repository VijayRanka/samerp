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
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/fullcalendar.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="/SAMERP/config/css/jquery.gritter.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bs_modal_transition.css" />
<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">

<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
<link href="https://fonts.googleapis.com/css?family=Bree+Serif" rel="stylesheet">
	
</head>
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

/* .modal.fade .modal-dialog {
  -webkit-transform: scale(0.1);
-moz-transform: scale(0.1);
-ms-transform: scale(0.1);
transform: scale(0.1);
top: 300px;
opacity: 0;
-webkit-transition: all 0.3s;
-moz-transition: all 0.3s;
transition: all 0.3s;
}
.modal.in .modal-dialog {
 -webkit-transform: scale(1);
    -moz-transform: scale(1);
    -ms-transform: scale(1);
    transform: scale(1);
    -webkit-transform: translate3d(0, -300px, 0);
    transform: translate3d(0, -300px, 0);
    opacity: 1;
} 
 */

</style>
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
	<jsp:include page="/jsp/admin/common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->

<!--main-container-part-->
<div id="content">
<!--breadcrumbs-->
  <div id="content-header">
    <div id="breadcrumb"> <a href="index.html" class="tip-bottom" data-original-title="Go to Home"><i class="icon-home">
    </i> Home</a> <a href="#" class="current">Add Account Details</a> </div>
  </div>
<!--End-breadcrumbs-->
<div class="container-fluid">
  <hr>
      <div class="row-fluid">
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-pencil"></i> </span>
            <h5>Add Account Details</h5>
          </div>
          <div class="widget-content nopadding">
            <form id="form-wizard" class="form-horizontal" action="/SAMERP/AddAccountDetails" method="post">
                <div class="control-group">
                  <label class="control-label">Bank Name</label>
                  <div class="controls">
                    <input type="text" id="bankName" placeholder="Bank Name" name="bankName" pattern="[a-z A-Z]*" onkeyup="this.value=this.value.toUpperCase()" required/>
                  </div>
                </div>
                
                <div class="control-group">
                  <label class="control-label">Branch</label>
                  <div class="controls">
                    <input type="text" name="branch" placeholder="Branch" onkeyup="this.value=this.value.toUpperCase()" pattern="[a-z A-Z]*" required/>
                  </div>
                </div>
                
                <div class="control-group">
                  <label class="control-label">Account No</label>
                  <div class="controls">
                    <input type="text" name="accNo" placeholder="Account No" pattern="[0-9]*" required/>
                  </div>
                </div>
                
                <div class="control-group" >
                  <label class="control-label">Opening Balance</label>
                  <div class="controls">
                    <input type="text" name="openingBalance" placeholder="Opening Balance" pattern="[0-9]*" required/>
                  </div>
                </div>
          
              <div class="form-actions" align="center">
                <input class="btn btn-success" name="insertAccDetails" type="submit" value="OK" />
                <a href="/SAMERP/index.jsp" id="cancelbtn"  class="btn btn-danger">Exit</a>
                
                
                <div id="status"></div>
              </div>
              
            </form>
          </div>
        </div>
      </div>
    </div>
  <div class="row-fluid">
  	<div class="span12">
  		<div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
            <h5>Bank Details</h5>
          </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
              <thead>
                <tr>
                  <th>S.No.</th>
                  <th>Bank Name</th>
                  <th>Branch</th>
                  <th>Account No</th>
                  <th>Opening Balance</th>
                  <th>Alias Name</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
              <%RequireData rd=new RequireData();
              	List getAccData=rd.getAccountDetails();
              	Object accId=0;
              	if(getAccData!=null){
            	Iterator itr=getAccData.iterator();
            	int i=1;
            	
            	while(itr.hasNext()){ accId=itr.next();
              %>
                <tr>
                  <td style="text-align: center"><%=i %><% i++; %></td>
                  <td style="text-align: center" value="<%=accId%>"><%=itr.next() %></td>
                  <td style="text-align: center"><%=itr.next() %></td>
                  <td style="text-align: center"><%=itr.next() %></td>
                  <td style="text-align: center"><%=itr.next() %></td>
                  <td style="text-align: center"><%=itr.next() %></td>
                  <td style="text-align: center"><a class="tip" title="Update" href="#updateAccDetails" onclick="searchName(<%=accId %>)" data-toggle="modal"><i class="icon-pencil"></i></a>|
                  <a onclick="getDeleteId(<%=accId%>)" href="#DeleteConfirmBox" data-toggle='modal'><i class="icon-remove"></i></a></td>
                </tr>
                <%}} %>
              </tbody>
            </table>
          </div>
        </div>
  	</div>
  </div>
</div>

</div>

<!--end-main-container-part-->

<div class="modal hide fade zoom-out" id="updateAccDetails" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Update Bank Details</h4>
      </div>
      <div class="modal-body" id="showModal">
      <form class="form-horizontal" action="/SAMERP/AddAccountDetails" method="post" name="updateAccount">
        <div class="form-group">
		<div class="widget-content nopadding">
        	<div class="control-group">
                  <label class="control-label">Bank Name</label>
                  <div class="controls">
                  <input type="hidden" id="modalId"  name="modalId"/>
                    <input type="text" id="modalName" name="modalbName" placeholder="Bank Name" pattern="[a-z A-Z]*" onkeyup="this.value=this.value.toUpperCase()" required />
         			</div>
        	</div>
        	
        	<div class="control-group">
                  <label class="control-label">Branch</label>
                  <div class="controls">
                    <input type="text" id="modalBranch"  name="modalBranch" placeholder="Branch" pattern="[a-z A-Z]*" onkeyup="this.value=this.value.toUpperCase()" required/>
         			</div>
        	</div>
        	
        	<div class="control-group">
                  <label class="control-label">Account No</label>
                  <div class="controls">
                    <input type="text" id="modalAccNo"  name="modalAccNo" placeholder="Account No" pattern="[0-9]*"  required />
         			</div>
        	</div>
        	
        	<!-- <div class="control-group">
                  <label class="control-label">Opening Balance</label>
                  <div class="controls">
                    <input type="text" id="modalBalance"  name="modalBalance" />
         			</div>
        	</div> -->
        	
        	<div class="control-group">
                  <label class="control-label">Alias Name</label>
                  <div class="controls">
                    <input type="hidden" id="modalAlias"  name="modalAlias" />
                    <input type="text" id="oldAlias"  name="oldAlias" />
         			</div>
        	</div>
      
      <div class="modal-footer">
        <button type="button"  class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="submit" name="Update" class="btn btn-primary">Save changes</button></div>
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
								<form class="form-horizontal" action="/SAMERP/AddAccountDetails" method="post" name="form4">
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

<!--Footer-part-->

<div class="row-fluid">
  <div id="footer" class="span12"> 2013 &copy; Matrix Admin. Brought to you by <a href="http://themedesigner.in">Themedesigner.in</a> </div>
</div>

<!--end-Footer-part-->

<script>
function myFunction() {
	document.getElementById("bankName").focus();
    var x = document.getElementById("snackbar")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}



function showModal(){
	var someVarName = localStorage.getItem("someVarName");

	var error=<%=request.getAttribute("error") %>;

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
			$('#updateAccDetails').modal('show');
		}
	localStorage.setItem('someVarName', null);
}

function setFocusToTextBox()
{
	document.getElementById("bankName").focus();
	showModal();   	
	 myFunction();
}


function searchName(id) {
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var demoStr = this.responseText.split(",");
			document.getElementById("modalId").value = demoStr[0];
			document.getElementById("modalName").value = demoStr[1];
			document.getElementById("modalBranch").value = demoStr[2];
			document.getElementById("modalAccNo").value = demoStr[3];
			document.getElementById("oldAlias").value = demoStr[4];
			document.getElementById("modalAlias").value = demoStr[4];
				
			}
		};
	xhttp.open("POST","/SAMERP/AddAccountDetails?updateid="+id, true);
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
<script src="/SAMERP/config/js/matrix.interface.js"></script> 
<script src="/SAMERP/config/js/matrix.chat.js"></script> 
<script src="/SAMERP/config/js/jquery.validate.js"></script> 
<script src="/SAMERP/config/js/matrix.form_validation.js"></script> 
<script src="/SAMERP/config/js/jquery.wizard.js"></script> 
<script src="/SAMERP/config/js/jquery.uniform.js"></script> 
<script src="/SAMERP/config/js/select2.min.js"></script> 
<script src="/SAMERP/config/js/matrix.popover.js"></script> 
<script src="/SAMERP/config/js/jquery.dataTables.min.js"></script> 
<script src="/SAMERP/config/js/matrix.tables.js"></script> 


<script type="text/javascript">
	function getDeleteId(id1)
	{
	 document.getelementById("deleteid").value=id1;
	}
	 </script>


</body>
</html>
