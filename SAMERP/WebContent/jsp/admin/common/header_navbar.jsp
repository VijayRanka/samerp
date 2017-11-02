<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function clock(){
	var time = new Date()
	var hr = time.getHours()
	var min = time.getMinutes()
	var sec = time.getSeconds()
	var ampm = " PM "
	if (hr < 12){
	ampm = " AM "
	}
	if (hr > 12){
	hr -= 12
	}
	if (hr < 10){
	hr = " " + hr
	}
	if (min < 10){
	min = "0" + min
	}
	if (sec < 10){
	sec = "0" + sec
	}
	document.getElementById("clockButton").innerHTML= hr + ":" + min + ":" + sec + ampm;
	currentDate
	//document.clockForm.clockButton.value = hr + ":" + min + ":" + sec + ampm
	setTimeout("clock()", 1000);
	showDate();
	}
	function showDate(){
	var date = new Date()
	var year = date.getYear()
	if(year < 1000){
	year += 1900
	}
	var monthArray = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")
	var currentDate=monthArray[date.getMonth()] + " " + date.getDate() + ", " + year;
	document.getElementById("currentDate").innerHTML = currentDate;
	
	}
	//window.onload=clock;
	function func()
	{
		var strconfirm = confirm("Are you sure you want to Logout?");
		if (strconfirm == true) 
		{
			var f=document.logOut;
	        f.method="get";
	        f.action='/MSaleERP/LogoutAction.do';
	        f.submit();
		}
		     
	}
</script>
</head>
<body onload="clock()">

<div id="header">
  <h1><a href="dashboard.html">Vertical Software</a></h1>
</div>
<!--close-Header-part-->


<!--top-Header-menu-->
<div id="user-nav" class="navbar navbar-inverse" style=" margin-top: 10px; z-index: 0; */">
  <ul class="nav">
	<li class="dropdown" id="menu-messages">
		<i class="icon icon-globe"></i> 
		<span class="badge badge-inverse" id="clockButton"></span>
		<span id="currentDate" class="badge badge-inverse"></span> 
	</li>
	<li class=""><a title="" href="#"><i class="icon icon-cog"></i> <span class="text">Opening Cash</span></a></li>
  </ul>
</div>
<!--close-top-Header-menu-->
<!--start-top-serch-->
<div id="search">
<form name="logOut">
  <a type="button" href="#logOutPopup" data-toggle="modal" class="btn btn-danger"><i class="icon-signout"></i> Logout</a></span>
</form>
</div>
<!--close-top-serch-->

<div class="modal hide fade" id="logOutPopup" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Logout</h4>
			</div>
			
			<div class="modal-body">
				<div class="alert alert-warning" style="margin-top: 18px;">
  				<strong>Are you sure you want to Logout?</strong> 
				</div>
			</div>
					<div class="modal-footer">
					<form action="/MSaleERP/LogoutAction.do">
					<input type="submit" class="btn btn-primary" value="OK" name="ok" />
					<input type="button" class="btn btn-danger" data-dismiss="modal" on value="Cancel"/>
					</form>
					</div>
					
				</form>
			</div>
				
			</div>
		</div>



</body>
</html>