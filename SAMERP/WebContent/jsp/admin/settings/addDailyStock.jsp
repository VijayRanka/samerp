<%@page import="utility.SysDate"%>
<%@page import="dao.General.GenericDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="utility.RequireData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Daily Stock</title>
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
<link rel="icon" href="/SAMERP/config/img/icons/favicon.ico" type="image/x-icon">

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
.table td {
   text-align: center;   
}

</style>
</head>

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
    </i> Home</a> <a href="/SAMERP/jsp/admin/settings/addDailyStock.jsp" class="current">Add Daily Stock</a> </div>
  </div>
<!--End-breadcrumbs-->
<div class="container-fluid">
  <hr>
      <div class="row-fluid">
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-pencil"></i> </span>
            <h5> Daily Stock List </h5>
            <input type="hidden" id="countDown"/>
          </div>
          <div class="widget-content nopadding">
            <form id="form-wizard" class="form-horizontal" action="#" method="post">
                 <div class="control-group span5">
	              <label class="control-label">Select Contractor</label>
	              <div class="controls">
	                <select name="contractor" id="contractor" onchange="getProductList(this.value)">
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

                <div class="control-group span5">
                  <label class="control-label">Date</label>
                  <div class="controls">
                  <%SysDate sd=new SysDate();%>
                    <input type="date" name="" value="<%=sd.todayDate().toString().split("-")[2]+"-"+sd.todayDate().toString().split("-")[1]+"-"+sd.todayDate().toString().split("-")[0] %>" id="partDate"/>
                  </div>
                </div>
                <div class="control-group">
                  <table class="table table-bordered table-striped">
              <thead>
                <tr>
                  <th>S.No.</th>
                  <th>Product Name</th>
                  <th>Daily Qty</th>
                  <th>Querying Qty</th>
                  <th>Final Stock</th>
                </tr>
              </thead>
              <tbody id="myDataTable">
              </tbody>
            </table>
                </div>
         		
              <div class="form-actions" id="addCancel" align="center" style="display: none">
                <input class="btn btn-success" name="insertAccDetails" type="button" style="background:#1196c1;" value="Add Stock" onclick="getInsertData()" />
                <input class="btn btn-danger" type="button" value="Cancel" />
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
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a
				href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
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
		document.getElementById("productId"+i).value=document.getElementById("productId"+i).value.split(",")[0];
		if(document.getElementById("dailyQty"+i).innerHTML.trim()=="")
			{
			if(document.getElementById("querQty"+i).innerHTML.trim()=="")
				document.getElementById("productId"+i).value+=",-,-";
			else	
				document.getElementById("productId"+i).value+=",-,"+document.getElementById("querQty"+i).innerHTML.trim();
			}
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
	var partDate=document.getElementById("partDate").value;
	
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var demoStr = this.responseText.split(",");
			if(demoStr[0]==1)
				{
				alert("Updated Successfully");
				getProductList(document.getElementById("contractor").value);
				}
			if(demoStr[0]==3)
				{
				alert("Data Already Present");
				getProductList(document.getElementById("contractor").value);
					
				}
			else if(demoStr[0]==4)
				{
				alert("Assign Rates First");
				getProductList(document.getElementById("contractor").value);
				}
				
		}
		};
	xhttp.open("POST","/SAMERP/AddDailyStock?insertData="+allValue+"&partDate="+partDate, true);
	xhttp.send(); 
	}
function selectText() {
	containerid="demoId";
    if (document.selection) {
        var range = document.body.createTextRange();
        range.moveToElementText(document.getElementById(containerid));
        range.select();
    } else if (window.getSelection) {
        var range = document.createRange();
        range.selectNode(document.getElementById(containerid));
        window.getSelection().removeAllRanges();
        window.getSelection().addRange(range);
    }
}

function getProductList(value){
	if(value=='select'){
		document.getElementById("myDataTable").innerHTML="";
	}
		
	else{
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var demoStr = this.responseText.split(",");
				if(demoStr[0]==0){
					alert("Insert Data First");
					document.getElementById("myDataTable").innerHTML="";
				}
				else if(demoStr[0]==2)
					{
					}
				else if(demoStr[0]==1)
				{
					var tableStr="";
					document.getElementById("myDataTable").innerHTML="";
					var j=1;
					for(var i=1;i<demoStr.length-2;i=i+3)
					{
						tableStr+="<tr id='tRowId"+j+"'><td style='text-align: center'><input type='hidden' id='productId"+j+"' value='"+demoStr[i]+"'>"+j+"</td>"+
						"<td style='text-align: center'>"+demoStr[i+1]+"</td>"+
						"<td style='text-align: center' contenteditable='true' id='dailyQty"+j+"' onfocus='getS(this.id);' onkeypress='if(event.keyCode==13) return false;'></td>"+
						"<td style='text-align: center' contenteditable='true' id='querQty"+j+"' onfocus='getS(this.id);' onkeypress='if(event.keyCode==13) return false;'></td>"+
						"<td style='text-align: center'>"+demoStr[i+2]+"</td><tr>";
						j++;
					}
					document.getElementById("addCancel").setAttribute("style","display:block");
					document.getElementById("countDown").value=j-1;
					document.getElementById("myDataTable").innerHTML=tableStr;
					document.getElementById("dailyQty1").focus();
				}
				}
			};
		xhttp.open("POST","/SAMERP/AddDailyStock?getPrdctData="+value, true);
		xhttp.send();
	}
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
