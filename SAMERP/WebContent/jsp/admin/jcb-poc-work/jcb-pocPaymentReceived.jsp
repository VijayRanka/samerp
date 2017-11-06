<!DOCTYPE html>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="utility.RequireData"%>
<%@page import="utility.SysDate"%>
<html lang="en">
<head>
<title>Matrix Admin</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/colorpicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />
<link rel="stylesheet" href="/SAMERP/config/css/select2.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-wysihtml5.css" />
<link href="/SAMERP/config/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800'
	rel='stylesheet' type='text/css'>

<style type="text/css">
#s2id_autogen3, #s2id_vehicle_update, #s2id_vehicle, #s2id_cust_project,
	#s2id_cust_project_update {
	float: right;
}
</style>
</head>
<body>

	<!--Header-part-->
	<div id="header">
		<h1>
			<a href="dashboard.html">Matrix Admin</a>
		</h1>
	</div>

	<!--start-top-serch-->
	<div id="search">

		<button type="submit" class="tip-bottom">LOGOUT</button>
	</div>
	<!--close-top-serch-->
	<!--sidebar-menu-->
	<jsp:include page="/jsp/admin/common/left_navbar.jsp"></jsp:include>
	<!--sidebar-menu-->
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				<a href="index.html" title="Go to Home" class="tip-bottom"><i
					class="icon-home"></i> Home</a> <a href="#" class="current">JCB/POC
					Detail</a>
			</div>
			<h1>JCB/POC Detail</h1>
		</div>
		<div class="container-fluid">
			<hr>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-align-justify"></i>
							</span>
							<h5>Receive-Payment</h5>
						</div>
						<div class="widget-content nopadding">
							<form action="#" method="get" class="form-horizontal">
								<div class="control-group">
									<label class="control-label">Date :</label>
									<div class="controls">
										<input type="date" value="dd/mm/yyyy" class="span4" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Received Amount :</label>
									<div class="controls">
										<input type="text" class="span4" placeholder="Amount" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Payment Mode :</label>
									<div class="controls">
										<input type="radio" name="radios" value="1" onclick="showBank(this.value)" style="margin-left: 0px;" /> Cash
										<input type="radio" name="radios" value="2" onclick="showBank(this.value)" style="margin-left: 0px;" /> Cheque
										<input type="radio" name="radios" value="3" onclick="showBank(this.value)" style="margin-left: 0px;" /> Transfer
									</div>
								</div>
								<div class="control-group hide" id="selectBank">
									<label class="control-label">Select Bank :</label>
									<div class="controls">
										<select class="span4">
											<option>First option</option>
											<option>Second option</option>
											<option>Third option</option>
											<option>Fourth option</option>
											<option>Fifth option</option>
											<option>Sixth option</option>
											<option>Seventh option</option>
											<option>Eighth option</option>
										</select>
									</div>
								</div>
								<div class="control-group hide" id="bankCheque">
									<label class="control-label">Cheque No :</label>
									<div class="controls">
										<input type="text" class="span4" placeholder="Cheque No" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Description :</label>
									<div class="controls">
										<input type="text" class="span4" />
									</div>
								</div>
								<div class="form-actions">
									<button type="submit" class="btn btn-success">Save</button>
								</div>
							</form>
						</div>
					</div>

				</div>
			</div>
		</div>



	</div>
	</div>
	<!--Footer-part-->
	<div class="row-fluid">
		<div id="footer" class="span12">
			2013 &copy; Matrix Admin. Brought to you by <a
				href="http://themedesigner.in">Themedesigner.in</a>
		</div>
	</div>
	<!--end-Footer-part-->
<script type="text/javascript">
function showBank(str) {
	if(str==1){
		document.getElementById("selectBank").className="control-group hide";
		document.getElementById("bankCheque").className="control-group hide";
	}
	if(str==2){
		document.getElementById("selectBank").className="control-group";
		document.getElementById("bankCheque").className="control-group";
	}
	if(str==3){
		document.getElementById("selectBank").className="control-group";
		document.getElementById("bankCheque").className="control-group hide";
	}
}
</script>


	<script src="/SAMERP/config/js/jquery.min.js"></script>
	<script src="/SAMERP/config/js/jquery.ui.custom.js"></script>
	<script src="/SAMERP/config/js/bootstrap.min.js"></script>
	<script src="/SAMERP/config/js/bootstrap-colorpicker.js"></script>
	<script src="/SAMERP/config/js/bootstrap-datepicker.js"></script>
	<script src="/SAMERP/config/js/masked.js"></script>
	<script src="/SAMERP/config/js/jquery.uniform.js"></script>
	<script src="/SAMERP/config/js/select2.min.js"></script>
	<script src="/SAMERP/config/js/jquery.dataTables.min.js"></script>
	<script src="/SAMERP/config/js/matrix.js"></script>
	<script src="/SAMERP/config/js/matrix.tables.js"></script>
	<script src="/SAMERP/config/js/matrix.form_common.js"></script>
	<script src="/SAMERP/config/js/wysihtml5-0.3.0.js"></script>
	<script src="/SAMERP/config/js/jquery.peity.min.js"></script>
	<script src="/SAMERP/config/js/bootstrap-wysihtml5.js"></script>
	<script>
	$('.textarea_editor').wysihtml5();
</script>




</body>
</html>
