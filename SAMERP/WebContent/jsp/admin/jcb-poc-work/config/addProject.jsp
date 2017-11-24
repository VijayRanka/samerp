<!--***************************************************** Add Project *******************************************************-->
	
	<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="utility.RequireData"%>
<div id="addProject" class="modal hide fade" role="dialog"
		style="width: 55%; margin-left: -28%;">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header" style="    height: 30px;">
					<h4 class="modal-title">Add Customer Project</h4>
				</div>
				<div class="alert alert-info" style="padding-left: 25px;">
							<strong>Enter Party/Customer Name <span class="badge badge-info">OR</span> Contact No : </strong>
							<input list="browsersProject" name="browser" id="editdataProject"	onkeyup="CustomerSearchProject(this.value)" onkeydown="CustomerPrintProject()" autocomplete="off" required>
							<datalist id="browsersProject"></datalist>
							<span class="help-inline error" id="selectCustError" style="color: red; font-weight: bold;"></span>

					</div>

<!-- 					<form name="form2"	class="form-horizontal"> -->
						<div class="modal-body">
							<table id="display-textfeild" style="margin: 0 auto;">
								<tr>
									<td>
										Project Name :
										<input type="text" name="projectname1" id="project_name1" onkeyup="this.value=this.value.toUpperCase()" required>
										<input type="hidden" name="custid_project" id="custid_project" >
										<span class="help-inline error" id="selectProjectError" style="color: red; font-weight: bold;"></span>
									</td>
								</tr>
								<tr>
									<td>
										Opening Balance :<input type="text" name="openingBal" id="openingBal" onkeypress="return isNumber(event)" placeholder="Opening Balance">
										<var class="control-group hide" >
										<input type="radio" name="radios" id="radios1" value="1" checked="checked" onclick="showBankProject(this.value)" style="margin-left: 0px;" /> Cash
										<input type="radio" name="radios" id="radios2" value="2" onclick="showBankProject(this.value)" style="margin-left: 0px;" /> Cheque
										<input type="radio" name="radios" id="radios3" value="3" onclick="showBankProject(this.value)" style="margin-left: 0px;" /> Transfer
										</var>
									</td>
								</tr>
								<tr>
									<td style="float: right;">
										
										<var class="control-group hide" id="selectBankProject">
											Select Bank :
												<%
													RequireData rd = new RequireData();
													List bank = rd.getBank();
													Iterator itr = bank.iterator();
												%>
												<select class="span2" name="payBank" id="payBank">
													<option></option>
														<%
															while (itr.hasNext()) {
														%>
														<option value="<%=itr.next()%>"><%=itr.next()%></option>
														<%
															}
														%>
												</select>
												<span class="help-inline error" id="payBankError" style="color: red; font-weight: bold;"></span>
										</var>
									</td>
								</tr>
								<tr>
									<td>
										<var class="control-group hide" id="selectBankChequeProject">
											Cheque No :<input type="text" name="payCheque" id="payCheque" placeholder="Cheque No" />
										<span class="help-inline error" id="payChequeError" style="color: red; font-weight: bold;"></span>
										</var>
									</td>
								</tr>
								<tr>
									<td>
										<button type="submit" name="save" id="" onclick="paySubmit()" class="btn btn-success">Add</button>
							<button type="button" class="btn btn-danger" id="closeProject" data-dismiss="modal">Close</button>
									</td>
								</tr>
							</table>
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"><i class="icon-th"></i></span>
						<h5>Customer Project List</h5>
					</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered data-table">
							<thead>
								<tr>
									<th>Sr No</th>
									<th>Project Name</th>
									<th>Opening Balance</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody id="ProjectList">
								
							</tbody>

						</table>
					</div>
					</div>
						
<!-- 					</form> -->
				</div>

			</div>

		</div>
		</div>
<!--*****************************************************END Add Project *******************************************************-->
<!--***************************************************** Update Project *******************************************************-->
	<div id="updateProject" class="modal hide fade" role="dialog"
		style="width: 55%; margin-left: -28%;">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header" style="    height: 30px;">
					<h4 class="modal-title">Add Customer Project</h4>
				</div>
						<div class="modal-body">
							<table id="display-textfeild" style="margin: 0 auto;">
								<tr>
									<td>
										Project Name :
										<input type="text" name="projectname1Update" id="project_name1Update" onkeyup="this.value=this.value.toUpperCase()" required>
										<input type="hidden" name="custid_projectUpdate" id="custid_projectUpdate" >
									</td>
								</tr>
								
							</table>
				
						<div class="modal-footer" style="padding-left: 450px">
							<button type="submit" name="save" id="" onclick="UpdateProject()" class="btn btn-success">Update</button>
							<button type="button" class="btn btn-danger" id="closeProjectUpdate" data-dismiss="modal">Close</button>
						</div>
<!-- 					</form> -->
				</div>

			</div>

		</div>
		</div>
		<!--***************************************************** END Update Project *******************************************************-->
	<!--***************************************************** Delete Project *******************************************************-->
	<div class="modal fade" id="DeleteConfirmBoxProject" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 style="color: red;" class="modal-title">Error</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" action="/SAMERP/AddCustomer.do" method="post" name="form4">
						<div class="form-group">
							<div class="widget-content nopadding">
								<div class="control-group">
									<input type="hidden" id="deleteProjectId" name="deleteProjectId" />
									<h4>Are you sure want to delete the selected row...!!</h4>
								</div>
							</div>
							<div class="modal-footer">
								<input type="submit" class="btn btn-primary" id="submitbtn"
									value="OK" />
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal hide fade" id="error-msg-delete" role="dialog">
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
									<h4>Cannot delete the Selected record as it is linked with
										some other records..!!</h4>
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
	<!--***************************************************** END Delete Project *******************************************************-->
		
	<!-- 	Add Form End -->
	
	<script type="text/javascript">

	
function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && ( charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}
function paySubmit(){
	var x=validationCheck();
	
	if(x != false){
		addProject();
	}
}

//*************************************** DEPOSIT *******************************
function showBankProject(str) {
	if(str==1){
		//document.getElementById("openingBal").style.display = 'inline-block';;
		document.getElementById("selectBankProject").className="control-group hide";
		document.getElementById("selectBankChequeProject").className="control-group hide";
	}
	if(str==2){
		//document.getElementById("openingBal").style.display = "none";
		document.getElementById("selectBankProject").className="control-group";
		document.getElementById("selectBankChequeProject").className="control-group";
	}
	if(str==3){
		//document.getElementById("openingBal").style.display = "none";
		document.getElementById("selectBankProject").className="control-group";
		document.getElementById("selectBankChequeProject").className="control-group hide";
	}
	
}
//*************************************** END DEPOSIT *******************************
//******************************************END validationCheck******************************************************************
function validationCheck(){
	var radios2=document.getElementById("radios2").checked;
	var radios3=document.getElementById("radios3").checked;
	
	if(radios2 == true){
		var payBank = document.getElementById("payBank").value;
		var payCheque = document.getElementById("payCheque").value;;
		if(payBank == ""){
			document.getElementById("payBankError").innerHTML ="Select Bank!";
			return false;
		}else{
			document.getElementById("payBankError").innerHTML ="";
		}
		if(payCheque == ""){
			document.getElementById("payChequeError").innerHTML ="Enter Cheque No!";
			return false;
		}else{
			document.getElementById("payChequeError").innerHTML ="";
		}
		
	}
	if(radios3 == true){
		var payBank = document.getElementById("payBank").value;
		
		if(payBank == ""){
			document.getElementById("payBankError").innerHTML ="Select Bank!";
			return false;
		}
		
	}
}
//******************************************END validationCheck******************************************************************
//***************************************addProject********************************
function addProject() {
	var custid_project=document.getElementById("custid_project").value;
	var projectname=document.getElementById("project_name1").value;
	var openingBal=document.getElementById("openingBal").value;
	var radios=document.querySelector('input[name="radios"]:checked').value;;
	var payBank=document.getElementById("payBank").value;
	var payCheque=document.getElementById("payCheque").value;
	
	
	
	var xhttp;
	if (custid_project == "") {
		
		document.getElementById("selectCustError").innerHTML ="Select Customer!";
		return;
	}
	if (projectname == "") {
		
		document.getElementById("selectProjectError").innerHTML ="Add Project Name!";
		document.getElementById("selectCustError").innerHTML ="";
		return;
	}
	
	xhttp = new XMLHttpRequest();

	try {
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var demoStr = this.responseText;
				alert(demoStr);
				document.getElementById("closeProject").click();
				document.getElementById("custid_project").value="";
				document.getElementById("project_name1").value="";
				document.getElementById("openingBal").value="";
				document.getElementById("editdata").value="";
				document.getElementById("ProjectList").innerHTML ="";
			}

		};
		xhttp.open("POST", "/SAMERP/AddCustomer.do?custid_project=" +custid_project+"&projectname="+projectname+"&openingBal="+openingBal+"&radios="+radios+"&payBank="+payBank+"&payCheque="+payCheque, true);
		xhttp.send();
	} catch (e) {
		alert("Unable to connect to server");
	}
}
//***************************************END addProject****************************
//**********************Customer Search******************************************


function CustomerSearchProject(str) {

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
					text += " value="+demoStr[i]+">";
					i++
					text += demoStr[i] + "</option>";
					i++;
				}
				document.getElementById("browsersProject").innerHTML = text;
			}

		};

		xhttp.open("POST", "/SAMERP/JcbPocDetails.do?q=" + str, true);
		xhttp.send();
	} catch (e) {
		alert("Unable to connect to server");
	}
}
//********************************END Search***********************************
//********************************Print Customer Data**************************
function  CustomerPrintProject() {
	var val = document.getElementById('editdataProject').value;
      var str = $('#browsersProject').find('option[value="' + val + '"]').attr('id');
      //alert(str);
      var xhttp;
		if (str == "undefined") {
			return;
		}else {
			if(event.keyCode == 13 || event.keyCode == 9) {
				document.getElementById('custid_project').value=str;
				projectList();
	    	}
		}
}
//******************************************END Cutomer Print******************************************************************
//******************************************Project List******************************************************************
function projectList() {
	var str=document.getElementById('custid_project').value;
	var xhttp;
	if (str == "") {
		return;
	}
	xhttp = new XMLHttpRequest();

	try {
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var demoStr = this.responseText.split("~");
				var i = 0;
				var j =1;
				var text=""
				for (; demoStr[i];) {
					var id=demoStr[i];
					text +="<tr><td style=\"width: 32px;\">"+(j);
					i++;
					j++;
					text += "</td><td>"+demoStr[i];
					i++;
					text += "</td><td>"+demoStr[i];
					i++;
					text += "</td><td><a href=\"#updateProject\" data-toggle='modal'	onclick='getProjectUpdate("+id;
					text +=")'>Update</a> / <a onclick=\"getDeleteIdProject("+id+")\" href=\"#DeleteConfirmBoxProject\" data-toggle=\"modal\">Delete</a></td></tr>";
					
				}
				document.getElementById("ProjectList").innerHTML = text;
			}

		};
		xhttp.open("POST", "/SAMERP/AddCustomer.do?projectList=" +str, true);
		xhttp.send();
	} catch (e) {
		alert("Unable to connect to server");
	}
}
//******************************************Update Project******************************************************************
function getProjectUpdate(str) {
	var xhttp;
	if (str == "") {
		return;
	}
	xhttp = new XMLHttpRequest();

	try {
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var demoStr = this.responseText.split("~");
				document.getElementById("custid_projectUpdate").value=demoStr[0];
				document.getElementById("project_name1Update").value=demoStr[1];
				//document.getElementById("openingBalUpdate").value=demoStr[2];
				
			}

		};
		xhttp.open("POST", "/SAMERP/AddCustomer.do?getProjectUpdate=" +str, true);
		xhttp.send();
	} catch (e) {
		alert("Unable to connect to server");
	}
	
}
function UpdateProject() {
	var custid_project=document.getElementById("custid_projectUpdate").value;
	var projectname=document.getElementById("project_name1Update").value;
	//var openingBal=document.getElementById("openingBalUpdate").value;
	var xhttp;
	if (custid_project == "") {
		alert("Select Customer!")
		return;
	}
	if (projectname == "") {
		alert("Add Project Name!")
		return;
	}
	
	xhttp = new XMLHttpRequest();

	try {
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var demoStr = this.responseText;
				alert(demoStr);
				document.getElementById("closeProjectUpdate").click();
				document.getElementById("custid_projectUpdate").value="";
				document.getElementById("project_name1Update").value="";
				//document.getElementById("openingBalUpdate").value="";
				projectList();
			}

		};
		xhttp.open("POST", "/SAMERP/AddCustomer.do?custid_projectUpdate=" +custid_project+"&project_name1Update="+projectname, true);
		xhttp.send();
	} catch (e) {
		alert("Unable to connect to server");
	}
}
</script>