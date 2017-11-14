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
		float:right;
		 position: relative;
		 bottom:135px; 
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
#loginbox form {
    width: 100%;}
    
#loginbox .control-group {
    padding: 2px 0;
    margin-bottom: 0px;
}
#loginbox .main_input_box input {
    background-color: rgba(0, 0, 0, 0.29);
    height: 30px;
    vertical-align: top;
    border: 0px;
    display: inline-block;
    width: 75%;
    line-height: 22px;
    margin-bottom: 3px;
    border-radius: 50px;
    text-align: center;
}

#loginbox .main_input_box input {
    color: #090909;
    background-color: rgba(188, 185, 185, 0.23);
    height: 30px;
    vertical-align: top;
    border: 1px solid;
    display: inline-block;
    width: 75%;
    line-height: 22px;
    margin-bottom: 3px;
    border-radius: 50px;
    text-align: center;
    font-size: 16px;
}
#loginbox .form-actions {
    position: relative;
    padding: 0px 0px 0px;
    border: none;
    bottom: 10px;
}
#loginbox .controls {
    padding: 0px 45px;
}



	</style>


    </head>
<body onload="startFun()">
<% if(request.getAttribute("status")!=null){ if(session.getAttribute("sAdmin")!=null){session.removeAttribute("sAdmin");}%>
		<div id="snackbar"><%=request.getAttribute("status")%></div>
	<%} %>
        <div id="loginbox" > 
        <%System.out.println("In Login.jsp"); %>           
            <form id="loginform"  class="form-vertical" action="/SAMERP/checkInfo" method="post" style="background: none; border: black; ">
				 <div class="control-group normal_text"  style="background: none;position: relative; left: 130px">
				  <h3 style="border-radius: 10px; width: 165px; background-color: #fef121; color: #000000;">Login Here</h3></div>
                <div class="control-group input1">
                    <div class="controls" >
                        <div class="main_input_box"  >
                            <input type="text" autocomplete="off" name="username" id="usernameid" placeholder="Username" required style="font-size: 16px;"/>
                        </div>
                    </div>
                </div>
                <div class="control-group input2">
                    <div class="controls">
                        <div class="main_input_box">
                            <input type="password" autocomplete="off" name="userpass" id="userpassid" placeholder="Password" required/>
                        </div>
                    </div>
                </div>
                <div class="form-actions">
                  <span class ="pull-center"><input type="button" onclick="hello()" class="btn btn-success" name="Login"  value="Login" style=" background-color: #fef121; position: relative; float: right; right: 250px; border-radius: 50px;color: black;" /> </span>
                    <span class ="pull-center"><a href="#" class="flip-link btn btn-info" id="to-recover" style="position: relative; float: right; right: 50px; border-radius: 50px;color: black;background-color: #fef121;">Lost password?</a></span>
                    </div>
            </form>
        </div>
	<script type="text/javascript">
	function hello()
	{
		var uName=document.getElementById("usernameid").value;
		var uPass=document.getElementById("userpassid").value;
			var xhttp = new XMLHttpRequest();
			
			xhttp.onreadystatechange = function() {
				
				if (this.readyState == 4 && this.status == 200) {
					
					var demoStr = this.responseText;
					if(demoStr=="activation")
						 $("#activation").modal();
					else if(demoStr=="wUser")
						 $("#loginfail").modal();
					else if(demoStr=="dnp")
						 $("#ServiceProvider").modal();
					else if(demoStr=="missingKey")
						 $("#ServiceProvider").modal();
					else if(demoStr=="success")
						{
						var input=document.createElement("input");
						input.type="hidden";
						input.name="fullyCheck";
						input.value="fullyCheck";
						document.getElementById("loginform").appendChild(input);
						document.getElementById("loginform").submit();
						}
				}
				};
			xhttp.open("POST", "/SAMERP/checkInfo?checkDetails=1&uName="+uName+"&uPass="+uPass, true);
			xhttp.send(); 
		
	}
	
	
	
	
	</script>
	
		<div class="modal hide fade" id="loginfail" role="dialog">
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
			<input type="button" class="btn btn-primary" data-dismiss="modal"
				value="OK" id="ok" name="ok" />
		</form>
	</div>
	</div>
	</div>
	</div>
	
	<div class="modal hide fade" id="ServiceProvider" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Wrong Authorization</h4>
				</div>

				<div class="modal-body">
					<div class="alert alert-danger" style="margin-top: 18px;">
						<i class="fa fa-times-circle-o" style="font-size: 2em;"></i><strong
							style="font-size: 1.2em;"> Not Registerd any user.
							Please contact to Vendor ! or Please contact to Support
							department of Vertical Software <br> Contact No. - 8390859090.
						</strong>
					</div>
				</div>
				<div class="modal-footer">
					<form>
						<input type="button" class="btn btn-primary" data-dismiss="modal"
							value="OK" id="ok" name="ok" />
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal hide fade" id="activation" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Activation Phase:</h4>
				</div>

				<div class="modal-body">
					<div class="control-group" id="Block">
						<label class="control-label offset1">Enter Activation Key
							:</label>
						<div class="controls">
							<input type="text" class="span4" id="actKey" name="activationKey"
								style="position: relative; left: 10px;"
								onblur=document.getElementById( 'actId').innerHTML="" />
							<p id="actId"
								style="color: red; float: right; position: relative; right: 75px; top: 5px; font-weight: bold;"></p>
						</div>
					</div>
				</div>
				<div class="modal-footer" id="mdFoot">

					<button type="button" onclick="checkKey()" name="Activate"
						class="btn btn-success">Activate</button>
					<button type="button" class="btn btn-danger pull-center"
						data-dismiss="modal">Cancel</button>
				</div>
			</div>
		</div>
	</div>
	 <script src="/MSaleERP/config/js/jquery.min.js"></script> <script
		src="/MSaleERP/config/js/matrix.login.js"></script> <script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
<script type="text/javascript">

function setFocusToTextBox() {
	document.getElementById("usernameid").focus();
	window.history.forward();
	window.location.hash="no-back-button";
	window.location.hash="Again-No-back-button";//again because google chrome don't insert first hash into history
	window.onhashchange=function(){window.location.hash="no-back-button";}

}

function startFun()
{
	showsnack();
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
	var url="/SAMERP/checkInfo?Activate=1&activationKey="+key;  

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