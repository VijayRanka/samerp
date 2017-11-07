<script>
function getCustomerBillDataUpdate(str) {
	
	document.getElementById("newBillEntry").style.display="none";
	document.getElementById("updateBillEntry").style.display="block";
	
	var xhttp;
	if (str == "") {
		return;
	}
	xhttp = new XMLHttpRequest();
	try {
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				document.getElementById("customerBillDetail").innerHTML ="";
				var demoStr = this.responseText.split("~");
				var text = "";
				var i = 0;
				var checkId;
				var j=1;
				for (; demoStr[i];) {
					text +="<tr><td><input type=\"checkbox\" id='chalanId"+j+"' onclick=\"countTotalHr()\"><input type=\"hidden\" id=\"jcbpocId"+j+"\" name=\"jcbpocId"+j+"\" value=\""+demoStr[i]+"\"> </td>";
					i++;
					text +="<td><label id=\"challanDate"+j+"\">"+demoStr[i]+"</label></td>";
					i++;
					text +="<td><label id=\"challanNo"+j+"\">"+demoStr[i]+"</label></td>";
					i++;
					text +="<td><label id=\"bucketHr"+j+"\">"+demoStr[i]+"</label></td>";
					i++;
					text +="<td><label id=\"breakerHr"+j+"\">"+demoStr[i]+"</label></td>";
					i++;
					text +="<td><label id=\"deposit"+j+"\">"+demoStr[i]+"</label></td>";
					i++;
					text +="<td><label id=\"diesel"+j+"\">"+demoStr[i]+"</label></td></tr>";
					i++;
					document.getElementById("bucketRate").innerHTML = demoStr[i];
					i++;
					document.getElementById("breakerRate").innerHTML = demoStr[i];
					i++;
					j++;
				}
				document.getElementById("customerBillDetail").innerHTML += text;
				document.getElementById("rowCounter").value=j;
				document.getElementById("allCheck").checked=true;
				
				document.getElementById("billNo").innerHTML=str;
				document.getElementById("invoiceId").value = str;
				
				checkAllBox();
				countTotalHr();
			}
		};
		xhttp.open("POST", "/SAMERP/JcbPocBill.do?getBillId=" + str, true);
		xhttp.send();
	} catch (e) {
		alert("Unable to connect to server");
	}
}

</script>