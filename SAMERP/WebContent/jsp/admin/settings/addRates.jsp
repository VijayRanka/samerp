<%@page import="dao.General.GenericDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="utility.RequireData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Add Rates</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap.min.css" />
<link href="/SAMERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="/SAMERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/SAMERP/config/css/colorpicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/uniform.css" />
<link rel="stylesheet" href="/SAMERP/config/css/select2.css" />
<link rel="stylesheet" href="/SAMERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/SAMERP/config/css/matrix-media.css" />
<link rel="stylesheet" href="/SAMERP/config/css/bs_modal_transition.css" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
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
    top: 30px;
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
    to {top: 30px; opacity: 1;}
}

@keyframes fadein {
    from {top: 0; opacity: 0;}
    to {top: 30px; opacity: 1;}
}

@-webkit-keyframes fadeout {
    from {top: 30px; opacity: 1;} 
    to {top: 0; opacity: 0;}
}

@keyframes fadeout {
    from {top: 30px; opacity: 1;}
    to {top: 0; opacity: 0;}
}
</style>
<body onload="myFunction()">

<!--Header-part-->
<div id="header">
  <h1><a href="#">Matrix Admin</a></h1>
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
    <div id="breadcrumb"> <a href="/SAMERP/dashboard.jsp" class="tip-bottom" data-original-title="Go to Home"><i class="icon-home">
    </i> Home</a> <a href="/SAMERP/jsp/admin/settings/addDailyStock.jsp" class="current">Add Rates</a> </div>
  </div>
<!--End-breadcrumbs-->
<div class="container-fluid">
  <hr>
      <div class="row-fluid">
      <div class="span12">
      <input type="hidden" id="countDown"/>
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-pencil"></i> </span>
            <h5>Material Rates </h5>
          </div>
          <div class="widget-content nopadding">
            <form id="form-wizard" class="form-horizontal" action="#" method="post">
                 <div class="control-group span5">
	              <label class="control-label">Select Contractor</label>
	              <div class="controls">
	                <select name="company" onchange="getProductList(this.value)">
	                <option  value="select" selected">Select</option>
	                <%
	                RequireData rd=new RequireData();
	                List demoList=rd.getContractorList();
	                if(demoList!=null){
	                Iterator itr=demoList.iterator();
	                while(itr.hasNext()){
	                	Object id=itr.next();
	                %>
	                  <option value="<%=id%>"><%=itr.next()%></option>
	                  <%} 
	                  }%>
	                  </select>
	                  
	              </div>
            </div>
                <div class="control-group">
                  <table class="table table-bordered table-striped">
                  
              <thead>
                <tr>
                  <th>S.No.</th>
                  <th>Product Name</th>
                  <th>Production Rate</th>
                  <th>Querying Rate</th>
                  <th>Last Updated</th>
                   <th>Action</th>
                </tr>
              </thead>
              <tbody id="myDataTable">
              </tbody>
            </table>
                </div>
              
            </form>
          </div>
        </div>
      </div>
    </div>
  
</div>

</div>

<!--end-main-container-part-->


<!--Footer-part-->

<div class="row-fluid">
  <div id="footer" class="span12"> 2013 &copy; Matrix Admin. Brought to you by <a href="http://themedesigner.in">Themedesigner.in</a> </div>
</div>

<!--end-Footer-part-->
<script>
function myFunction() {
	//focus on particular name box();
	
	if(document.getElementById("snackbar")!=null){
    var x = document.getElementById("snackbar")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
	}
}
function getInsertData()
{
	var x=document.getElementById("countDown").value;
	for(var i=1;i<=x;i++)
	{
		document.getElementById("productId"+i).value=document.getElementById("productId"+i).value.charAt(0);
		if(document.getElementById("dailyQty"+i).innerHTML.trim()=="")
			document.getElementById("productId"+i).value+=",-,"+document.getElementById("querQty"+i).innerHTML.trim();
		else if(document.getElementById("querQty"+i).innerHTML.trim()=="")
			document.getElementById("productId"+i).value+=","+document.getElementById("dailyQty"+i).innerHTML.trim()+",-";
		else
		document.getElementById("productId"+i).value+=","+document.getElementById("dailyQty"+i).innerHTML.trim()+","+document.getElementById("querQty"+i).innerHTML.trim();
	}
	var allValue="";
	for(var i=1;i<=x;i++)
		{
			allValue+=document.getElementById("productId"+i).value+",";
		}
	
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var demoStr = this.responseText;
			alert("Inserted Successfully");
		}
		};
	xhttp.open("POST","/SAMERP/AddDailyStock?insertData="+allValue, true);
	xhttp.send();
	}


function getProductList(value){
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var demoStr = this.responseText.split(",");
			if(demoStr[0]==0)
				alert("Insert Data First")
			else if(demoStr[0]==2)
				{
				}
			else if(demoStr[0]==1)
			{
				var tableStr="";
				document.getElementById("myDataTable").innerHTML="";
				var j=1;
				for(var i=1;i<demoStr.length-2;i=i+5)
				{
					tableStr+="<tr id='tRowId"+j+"'><td style='text-align: center'><input type='hidden' id='productId"+j+"' value='"+demoStr[i]+"'>"+j+"</td>"+
					"<td style='text-align: center'>"+demoStr[i+1]+"</td>"+
					"<td style='text-align: center' contenteditable='false' id='prodQty"+j+"' onfocus='getS(this.id);' onkeypress='return insertDataServ("+j+")'>"+demoStr[i+2]+"</td>"+
					"<td style='text-align: center' contenteditable='false' id='queryingQty"+j+"' onfocus='selectElementContents(this.id);' onkeypress='return insertDataServ("+j+")'>"+demoStr[i+3]+"</td>"+
					"<td style='text-align: center' id='dateUpdated"+j+"' onkeypress='if(event.keyCode==13) return false;'>"+demoStr[i+4]+"</td>"+
					"<td style='text-align: center' id='"+j+"'><a id='"+j+"'style='cursor:pointer' onclick='enableTab(this.id)'><span class='badge badge-inverse'><i class='icon-pencil'></i></span></a></td><tr>";
					j++;
				}
				document.getElementById("countDown").value=j-1;
				document.getElementById("myDataTable").innerHTML=tableStr;
				document.getElementById("prodQty1").focus();
			}
			}
		};
	xhttp.open("POST","/SAMERP/AddRates?getPrdctData="+value, true);
	xhttp.send();
}
function getS(id)
{
	if(document.getElementById(id).contenteditable=="false")
	selectElementContents(id);
	else
		selectElementContents(id);
	}

//for selection of text of contenteditable in table
function selectElementContents(id) {
	var el=document.getElementById(id);
    var range = document.createRange();
    range.selectNodeContents(el);
    var sel = window.getSelection();
    sel.removeAllRanges();
    sel.addRange(range);
}

function enableTab(id)
{
	document.getElementById("prodQty"+id).setAttribute("contenteditable","true");
	document.getElementById("queryingQty"+id).setAttribute("contenteditable","true");
	document.getElementById("prodQty"+id).focus();
	
	}
function insertDataServ(id)
{
	if(event.keyCode==13)
		{
		if(!document.getElementById("prodQty"+id).innerHTML.trim()=="" && !document.getElementById("queryingQty"+id).innerHTML.trim()==""){
	    insertServelet(id);
		
		return false;
		}
		else
			return false;
		}
	else if(event.which > 31 && (event.which < 48 || event.which > 57))
		return false;
	else
		return true;
	}
	
	
function  insertServelet(id)
{
	

	var prodQty=document.getElementById("prodQty"+id).innerHTML.trim();
	var qrQty=document.getElementById("queryingQty"+id).innerHTML.trim();
	var proId=document.getElementById("productId"+id).value.trim();
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var demoStr = this.responseText.split(",");
			if(demoStr[0]==0)
				alert("Some Problem");
			else
			{
				var div=document.createElement("DIV");
				div.innerHTML="Data Updated";
				div.id="snackbar";
				document.body.appendChild(div);
		
				var x = document.getElementById("snackbar");
				x.className = "show";
				setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
				
				document.getElementById("prodQty"+id).setAttribute("contenteditable","false");
				document.getElementById("queryingQty"+id).setAttribute("contenteditable","false");
				
				document.getElementById("dateUpdated"+id).innerHTML=demoStr[1];
			}
			}
		};
	xhttp.open("POST","/SAMERP/AddRates?insertData=1&proId="+proId+"&prodQty="+prodQty+"&querQty="+qrQty, true);
	xhttp.send();
	
	}
function getContentEnable(id)
{
	alert(id);
	
	}

function getColumn(id)
{
	if(id=="team2")
		{
		document.getElementById("qQty").style.display="none";
		
		document.getElementById("qQtyData").style.display="none";
		}
	else{
		document.getElementById("qQty").style.display="block";
		document.getElementById("qQtyData").style.display="block";
	}
	}

function ajaxFunction() {
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var demoStr = this.responseText;
			}
		};
	xhttp.open("POST","/SAMERP/AddAccountDetails?", true);
	xhttp.send();
}

</script>
<script src="/SAMERP/config/js/jquery.min.js"></script> 
<script src="/SAMERP/config/js/jquery.ui.custom.js"></script> 
<script src="/SAMERP/config/js/bootstrap.min.js"></script> 
<script src="/SAMERP/config/js/bootstrap-colorpicker.js"></script> 
<script src="/SAMERP/config/js/bootstrap-datepicker.js"></script> 
<script src="/SAMERP/config/js/jquery.uniform.js"></script> 
<script src="/SAMERP/config/js/select2.min.js"></script> 
<script src="/SAMERP/config/js/jquery.dataTables.min.js"></script> 
<script src="/SAMERP/config/js/matrix.js"></script> 
<script src="/SAMERP/config/js/matrix.tables.js"></script>
<script src="/SAMERP/config/js/wysihtml5-0.3.0.js"></script> 
<script src="/SAMERP/config/js/jquery.peity.min.js"></script> 
<script src="/SAMERP/config/js/bootstrap-wysihtml5.js"></script> 
<script src="/SAMERP/config/js/jquery.toggle.buttons.js"></script>
<script>
$('#update').on('shown.bs.modal', function () {
    $('#uName').focus();
}) 
$('#addDebtor').on('shown.bs.modal', function () {
	document.getElementById("debtor").value="";
    $('#debtor').focus();
})
</script> 

</body>
</html>
