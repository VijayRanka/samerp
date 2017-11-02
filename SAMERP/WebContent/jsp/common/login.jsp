<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
        <title>Vertical Software</title><meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
		<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="/SAMERP/config/css/matrix-login.css" />
        <link rel="stylesheet" href="/SAMERP/config/font-awesome/css/font-awesome.css"  />
        <link rel="shortcut icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">
		<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">
		<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>


	<style type="text/css">
	body {
	    background-image: url("/SAMERP/config/img/secure.jpg");
	    background-size: 100% 100%;
	    background-position : center;
	    height: 200px;
	    
	}

	#loginbox{
		background-image: url("/SAMERP/config/img/secure3.jpg");	 
	    background-size:cover;
	    background-position : center;
	   
		 float: left;
		 position: relative;
		 left:120px; 
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

<script type="text/javascript">

function setFocusToTextBox() {
	document.getElementById("usernameid").focus();
	window.history.forward();
	window.location.hash="no-back-button";
	window.location.hash="Again-No-back-button";//again because google chrome don't insert first hash into history
	window.onhashchange=function(){window.location.hash="no-back-button";}

}
function showActivation(){

	if(document.getElementById("activation")!=null)
		$('#activation').modal('show');
}

function showModal(){

	setFocusToTextBox();
	var error = document.getElementById("error").value;
		
		if(error==1)
		{
			//alert("Sasasa");
			$('#lofinfail').modal('show');
		}	
}
function showWrongAuthentication(){
	
	if(document.getElementById("ServiceProvider")!=null)
			$('#ServiceProvider').modal('show');
}

</script>

    </head>
<body onload="startFun()">
<% if(request.getAttribute("status")!=null){ if(session.getAttribute("sAdmin")!=null){session.removeAttribute("sAdmin");}%>
		<div id="snackbar"><%=request.getAttribute("status")%></div>
	<%} %>
        <div id="loginbox" > 
        <%System.out.println("In Login.jsp"); %>           
            <form id="loginform"  class="form-vertical" action="LoginAction.do" method="post" >
				 <div class="control-group normal_text"> <h3 style="color: white;">Login Here</h3></div>
                <div class="control-group">
                    <div class="controls" >
                        <div class="main_input_box"  >
                            <span class="add-on bg_lg" style="height:20px"><i class="icon-user" > </i></span><input type="text" autocomplete="off" name="username" id="usernameid" placeholder="Username" required/>
                            
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <div class="main_input_box">
                            <span class="add-on bg_ly" style="height:20px"><i class="icon-lock"></i></span><input type="password" autocomplete="off" name="userpass" id="userpassid" placeholder="Password" required/>
                        </div>
                    </div>
                </div>
                <div class="form-actions">
                  <span class ="pull-center"><input type="submit"  class="btn btn-success" name="Login"  value="Login" style="position: relative; float: right; right: 250px;" /> </span>
                    <span class ="pull-center"><a href="#" class="flip-link btn btn-info" id="to-recover" style="position: relative; float: right; right: 50px;">Lost password?</a></span>
                    
                    <%
                    	
                    String error = "";
                    
          			if(request.getAttribute("fail")!=null){
          				error = request.getAttribute("fail").toString();
          			}
                    
                    %>
                    <input type="hidden" name="error" id="error" value="<%=error %>" /> 
                   
                </div>
            </form>
            <form id="recoverform" action="#" class="form-vertical">
				<p class="normal_text">Enter your e-mail address below and we will send you instructions how to recover a password.</p>
				
                    <div class="controls">
                        <div class="main_input_box">
                            <span class="add-on bg_lo" style="height: 20px;" ><i class="icon-envelope" ></i></span><input type="text" placeholder="E-mail address" />
                        </div>
                    </div>
               
                <div class="form-actions">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="pull-center"><a href="#" class="flip-link btn btn-success" id="to-login">&laquo; Back to login</a></span>
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="pull-center"><a class="btn btn-info"/>Reecover</a></span>
                </div>
            </form>
        </div>
        
        
        
<div class="modal hide fade" id="lofinfail" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
					<h4 class="modal-title">LogIn</h4>
				</div>
			
			<div class="modal-body">
				<div class="alert alert-danger"  style="margin-top: 18px;">
  				 <i class="fa fa-times-circle-o" style="font-size:2em;"></i><strong style="font-size:1.2em;"> Incorrect Username & Password...</strong> 
				</div>
			</div>
			<div class="modal-footer">
			<form>
			<input type="button" class="btn btn-primary" data-dismiss="modal" value="OK" id="ok" name="ok" />
			</form>
			</div>
		</div>		
	</div>
</div> 
<%if(request.getAttribute("expires")!=null){ %>
<div class="modal hide fade" id="ServiceProvider" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
					<h4 class="modal-title">Wrong Authorization</h4>
				</div>
			
			<div class="modal-body">
				<div class="alert alert-danger"  style="margin-top: 18px;">
  				 <i class="fa fa-times-circle-o" style="font-size:2em;"></i><strong style="font-size:1.2em;"> Not Registerd any user.  Please contact to Vendor ! or Please contact to Support department of Vertical Software  <br> Contact No. - 77 68 92 5050.</strong> 
				</div>
			</div>
			<div class="modal-footer">
			<form>
			<input type="button" class="btn btn-primary" data-dismiss="modal" value="OK" id="ok" name="ok" />
			</form>
			</div>
		</div>		
	</div>
</div> 
   <%} %>
   <%if(request.getAttribute("activateKey")!=null){ %>
<div class="modal hide fade" id="activation" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
					<h4 class="modal-title">Activation Phase:</h4>
				</div>
			
			<div class="modal-body">
				<div class="control-group" id="Block">
              <label class="control-label offset1">Enter Activation Key :</label>
              <div class="controls">
                <input type="text" class="span4" id="actKey" name="activationKey" style="position:relative; left:10px;" onblur=document.getElementById('actId').innerHTML="" />
              <p id="actId" style="color: red;float: right; position: relative;right: 75px;top:5px;font-weight: bold;"></p>
              </div>
            </div>
			</div>
			<div class="modal-footer" id="mdFoot">
			
			<button type="button" onclick="checkKey()"  name="Activate" class="btn btn-success">Activate</button>
              <button type="button" class="btn btn-danger pull-center" data-dismiss="modal">Cancel</button>
			</div>
		</div>		
	</div>
</div> 
   <%} %>
        
        
        <script src="/MSaleERP/config/js/jquery.min.js"></script>  
        <script src="/MSaleERP/config/js/matrix.login.js"></script> 
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
        
    </body>
<script type="text/javascript">
function startFun()
{
	showsnack();
	showModal();
	showActivation();
	showWrongAuthentication();
	}

$('#lofinfail').on('shown.bs.modal', function () {
    $('#ok').focus();
}) 
$('#ServiceProvider').on('shown.bs.modal', function () {
    $('#ok').focus();
}) 
$('#activation').on('shown.bs.modal', function () {
    $('#actKey').focus();
}) 
function showsnack()
{
	if(document.getElementById("snackbar")==null)
		{
			
		}
	else{
		var x = document.getElementById("snackbar");
	    x.className = "show";
	    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
	}
	}
function checkKey()
{
	if(document.getElementById("actKey").value=="")
	{
	document.getElementById("actId").innerHTML="Fill It First";
		document.getElementById("actKey").focus();
	}
else
{
	var key=document.getElementById("actKey").value;
	var request=new XMLHttpRequest();
	var url="/SAMERP/LoginAction.do?Activate=1&activationKey="+key;  

	try{  
			request.onreadystatechange=function()
			{  
				if(request.readyState==4)
				{  
					var val=request.responseText;
					if(val==1)
						{
						document.getElementById("Block").innerHTML="<h2>Congratulation! <br> You Successfully Activated By Vertical Soft</h2>";
						document.getElementById("mdFoot").innerHTML="<button type='button' class='btn btn-success pull-center' data-dismiss='modal'>OK</button>";
						}
					else
						{
						document.getElementById("actId").innerHTML="Wrong Key!";
						document.getElementById("actKey").focus();
						}
						
				}  
			}
			request.open("POST",url,true);  
			request.send();  
	}
	catch(e)
	{
		alert("Unable to connect to server");
	}  
	
	}
}
	

	
	


</script>
</html>