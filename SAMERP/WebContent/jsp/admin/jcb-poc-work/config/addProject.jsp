<!--***************************************************** Add Project *******************************************************-->
	
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
									

					</div>

<!-- 					<form name="form2"	class="form-horizontal"> -->
						<div class="modal-body">
							<table id="display-textfeild" style="margin: 0 auto;">
								<tr>
									<td>
										Project Name :
										<input type="text" name="projectname1" id="project_name1" onkeyup="this.value=this.value.toUpperCase()" required>
										<input type="hidden" name="custid_project" id="custid_project" >
									</td>
								</tr>
								<tr>
									<td>
										Opening Balance :
										<input type="radio" name="radios" value="1" checked="checked" onclick="showBankProject(this.value)" style="margin-left: 0px;" /> Cash
										<input type="radio" name="radios" value="2" onclick="showBankProject(this.value)" style="margin-left: 0px;" /> Cheque
									</td>
								</tr>
								<tr>
									<td style="float: right;">
										<input type="text" name="openingBal" id="openingBal" onkeypress="return isNumber(event)" placeholder="Deposit">
										<var class="control-group hide" id="selectBankProject">
											Select Bank :
												<select class="">
													<option>First option</option>
													<option>Second option</option>
													<option>Third option</option>
													<option>Fourth option</option>
													<option>Fifth option</option>
													<option>Sixth option</option>
													<option>Seventh option</option>
													<option>Eighth option</option>
												</select>
										</var>
									</td>
								</tr>
								<tr>
									<td>
										<var class="control-group hide" id="selectBankChequeProject">
											Cheque No :<input type="text" class="" placeholder="Cheque No" />
										</var>
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
						<div class="modal-footer" style="padding-left: 450px">
							<button type="submit" name="save" id="" onclick="addProject()" class="btn btn-success">Add</button>
							<button type="button" class="btn btn-danger" id="closeProject" data-dismiss="modal">Close</button>
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
								<tr>
									<td>
										Opening Balance :
										<input type="radio" name="radiosUpdate" value="1" checked="checked" onclick="showBankProjectUpdate(this.value)" style="margin-left: 0px;" /> Cash
										<input type="radio" name="radiosUpdate" value="2" onclick="showBankProjectUpdate(this.value)" style="margin-left: 0px;" /> Cheque
									</td>
								</tr>
								<tr>
									<td style="float: right;">
										<input type="text" name="openingBalUpdate" id="openingBalUpdate" onkeypress="return isNumber(event)" placeholder="Opeing Balance">
										<var class="control-group hide" id="selectBankProjectUpdate">
											Select Bank :
												<select class="">
													<option>First option</option>
													<option>Second option</option>
													<option>Third option</option>
													<option>Fourth option</option>
													<option>Fifth option</option>
													<option>Sixth option</option>
													<option>Seventh option</option>
													<option>Eighth option</option>
												</select>
										</var>
									</td>
								</tr>
								<tr>
									<td>
										<var class="control-group hide" id="selectBankChequeProject">
											Cheque No :<input type="text" class="" placeholder="Cheque No" />
										</var>
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
		
	<!-- 	Add Form End -->
	
	<script type="text/javascript">

	function loadFunction(){
		document.getElementById("custname").focus();
	}
	
function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && ( charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}
//*************************************** DEPOSIT *******************************
function showBankProject(str) {
	if(str==1){
		document.getElementById("openingBal").style.display = 'inline-block';;
		document.getElementById("selectBankProject").className="control-group hide";
		document.getElementById("selectBankChequeProject").className="control-group hide";
	}
	if(str==2){
		document.getElementById("openingBal").style.display = "none";
		document.getElementById("selectBankProject").className="control-group";
		document.getElementById("selectBankChequeProject").className="control-group";
	}
	
}
//*************************************** END DEPOSIT *******************************
//***************************************addProject********************************
function addProject() {
	var custid_project=document.getElementById("custid_project").value;
	var projectname=document.getElementById("project_name1").value;
	var openingBal=document.getElementById("openingBal").value;
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
				document.getElementById("closeProject").click();
				document.getElementById("custid_project").value="";
				document.getElementById("project_name1").value="";
				document.getElementById("openingBal").value="";
				document.getElementById("editdata").value="";
				document.getElementById("ProjectList").innerHTML ="";
			}

		};
		xhttp.open("POST", "/SAMERP/AddCustomer.do?custid_project=" +custid_project+"&projectname="+projectname+"&openingBal="+openingBal, true);
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
					text +=")'>Update</a> / <a href=\"/SAMERP/JcbPocDetails.do?deleteid=\">Delete</a></td></tr>";
					
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
				document.getElementById("openingBalUpdate").value=demoStr[2];
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
	var openingBal=document.getElementById("openingBalUpdate").value;
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
				document.getElementById("openingBalUpdate").value="";
			}

		};
		xhttp.open("POST", "/SAMERP/AddCustomer.do?custid_projectUpdate=" +custid_project+"&project_name1Update="+projectname+"&openingBalUpdate="+openingBal, true);
		xhttp.send();
	} catch (e) {
		alert("Unable to connect to server");
	}
}
</script>