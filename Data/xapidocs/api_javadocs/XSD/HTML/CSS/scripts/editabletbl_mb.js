/*******************************************************************************
   IBM Confidential 
   OCO Source Materials 
   IBM Sterling Selling and Fullfillment Suite
   (c) Copyright IBM Corp. 2001, 2013 All Rights Reserved.
   The source code for this program is not published or otherwise divested of its trade secrets, 
   irrespective of what has been deposited with the U.S. Copyright Office. 
 *******************************************************************************/
///----------------------------------------------------------------------------------
///This javascript file is used for dynamic add / remove of rows in an editable
///table.
///----------------------------------------------------------------------------------



////////////////////////////////////////////////////////////////////////////////////
//Function Type: Public Deprecated
//--------------------------------
//Use getParentObject_mb() instead.  Takes same parameters, and it is in list.js as part of infrastructure.
////////////////////////////////////////////////////////////////////////////////////
function getParentTag_mb(tblObj, tag) {
    var obj = tblObj;
    while (obj.tagName != tag) {
        obj = obj.parentNode;
    }

    //If no parent was found, return null.
    if (obj.tagName != tag)
        obj = null;

    return obj;
}

////////////////////////////////////////////////////////////////////////////////////
//Function Type: Public
//----------------------
//This function is called whenever number of rows in a table changes.
//The function fires an IE event that we dont normally use.  In response to this event
//the table.htc recolors the table for odd and even rows.
////////////////////////////////////////////////////////////////////////////////////
function fireRowsChanged_mb(oTable) {
    if (oTable){

			if (typeof document.fireEvent != 'undefined'){
				oTable.fireEvent("onfilterchange");
			}
			else {
			yfcOnRowsChanged(oTable);
		}
	}
}

////////////////////////////////////////////////////////////////////////////////////
//Function Type: Public
//--------------------------------
//Called when the + is clicked in a editable table.  Assumes standard table structure.
////////////////////////////////////////////////////////////////////////////////////
function addRows_mb(element) {

	if (!yfcFindErrorsOnPage_mb()) {
		if(!validateCopyAdd_mb(element))
			return;

		var otFoot = getParentObject_mb(element, "TFOOT");
		
		if (!otFoot)
			return;
			
		var otbl = getParentObject_mb(otFoot, "TABLE");
		
		if (!otbl)
			return;
		
		var tbody = otbl.tBodies[0];
		
		var templateRow = getTemplateRow_mb(otFoot);
		
		//Find out how many lines need to be added.
		var oInput = getParentObject_mb(element, "TABLE").getElementsByTagName("INPUT").item(0);
		
		if (oInput) {
			lines = oInput.value;
		}
		
		if (!lines)
			lines = 1;
		
		//in firefox if tbody==null create 1
		if(tbody == null)
{
			tbody = document.createElement("tbody");
			otbl.insertBefore(tbody,otbl.tfoot);
    }

		//Now, add that many number of lines.
		addCopyLines_mb(templateRow, lines, tbody);
	}
}

////////////////////////////////////////////////////////////////////////////////////
//Function Type: Public
//--------------------------------
//Called when the - is clicked in a editable table.  Assumes standard table structure.
////////////////////////////////////////////////////////////////////////////////////
function deleteRow_mb(element) {
	if (!yfcFindErrorsOnPage_mb()) {
		var row = getParentObject_mb(element, "TR");
		
		var oTable = getParentObject_mb(row, "TABLE");
		
		row.parentNode.deleteRow(row.rowIndex - 1);
		
		fireRowsChanged_mb(oTable);
	}
    return false;
}

////////////////////////////////////////////////////////////////////////////////////
//Function Type: Private
//--------------------------------
//Called when the delete button is clicked in a editable table.  Assumes standard table structure.
////////////////////////////////////////////////////////////////////////////////////
function setDeleteOperationForRow_mb(element,completebinding) {
	if (!yfcFindErrorsOnPage_mb()) {
		var sOperation = window.document.getElementById("userOperation");
		if(sOperation)
			sOperation.value="DELETE";
		var row = getParentObject_mb(element, "TR");
		var rowIndex = "";
		var deleteRowIndex = row.getAttribute("DeleteRowIndex");
		if(deleteRowIndex != null){
			rowIndex = deleteRowIndex;
		} 
		else{
			rowIndex = row.rowIndex;
		}
		var deleteRowFlag = window.document.all(completebinding + "_"+ rowIndex+ "/@DeleteRow");
		if(deleteRowFlag)
		{
			deleteRowFlag.value='Y';
			document.body.detachEvent("onunload", processSaveRecordsForChildNode_mb);
			IgnoreChangeNames_mb();
			yfcDoNotPromptForChanges_mb(true);
			yfcChangeDetailView_mb(getCurrentViewId_mb());
		}
	}
}

///////////////////////////////////////////////////////////////////////////////
//Function Type: Private
///////////////////////////////////////////////////////////////////////////////
function setAddRowFlagAndRefresh_mb(element)
{
	if (!yfcFindErrorsOnPage_mb()) {
		if(!validateCopyAdd_mb(element))
			return;


		var addRow = window.document.getElementById("userOperation");
		var numRowsToAdd = window.document.getElementById("numRowsToAdd");
		//var numCopyAdd = window.document.getElementById("numCopyAdd");
		var parTable = getParentObject_mb(element, "TABLE");
	var cNodes= parTable.getElementsByTagName("input");
	var numCopyAdd=null;
	//var numCopyAdd =document.all('numCopyAdd');//document.all("numCopyAdd");// document.getElementsByName('numCopyAdd');//document.getElementById('numCopyAdd');
	for (var i=0; i< cNodes.length; i++)
	{
		if (cNodes[i].type=="text" && cNodes[i].className=="tablefooterinput")
		{
			numCopyAdd = cNodes[i];
		}
	}

		if(numCopyAdd && numRowsToAdd)
			numRowsToAdd.value=numCopyAdd.value;
		if(addRow)
		{
			addRow.value="Y";
			document.body.detachEvent("onunload", processSaveRecordsForChildNode_mb);
			IgnoreChangeNames_mb();
			yfcDoNotPromptForChanges_mb(true);
			yfcChangeDetailView_mb(getCurrentViewId_mb());
		}
	}
}

////////////////////////////////////////////////////////////////////////////////////
//Function Type: Private
////////////////////////////////////////////////////////////////////////////////////
function addCopyLines_mb(templateRow, lines, tbody) {
	var inputs = tbody.getElementsByTagName("INPUT");
	var input;
	var row;
	var found = false;

	for (var i = 0; i < inputs.length; i ++) {
		input = inputs.item(i);
		
		if ((input.type == "checkbox") && (input.name == "chkEntityKey")) {
			if (input.checked == true) {
				found = true;
				row = getParentObject_mb(input, "TR");
				addLines_mb(tbody, templateRow, row, lines);
			}
		}
	}
	
	if (found == false) {
		addLines_mb(tbody, templateRow, null, lines);
	}
}

////////////////////////////////////////////////////////////////////////////////////
//Function Type: Private
////////////////////////////////////////////////////////////////////////////////////
function addLines_mb(tbody, fromRow, dataTemplateRow, linestobeadded) {
    var tmp = tbody;
    var newRow;
    var rows =  tmp.rows;
    var copyAllowed = "";

    var addConsecutiveRow = tmp.parentNode.getAttribute("addConsecutiveRow");

    //At at time, you can create multiple rows.

    for (var i=0;i<linestobeadded;i++) {

        if ((addConsecutiveRow == "true") && (dataTemplateRow != null)) {
            newRow = tmp.insertRow(dataTemplateRow.rowIndex);
        }
        else {
            newRow = tmp.insertRow(tmp.rows.length);
        }
        newRow.align= fromRow.align;
        newRow.style.cssText = fromRow.style.cssText;
        newRow.style.display = '';
        newRow.id = tmp.rows.length;
        newRow.setAttribute("Action","ADD");

        processNewRow_mb(tbody, fromRow, dataTemplateRow, newRow);
    }

    var tblHead = tbody.parentNode.getAttribute("HeadTable");

    if (!tblHead) {
        tblHead = tbody.parentNode;
    }

    fireRowsChanged_mb(tblHead);

    return false;
}
////////////////////////////////////////////////////////////////////////////////////
//Function Type: Private
////////////////////////////////////////////////////////////////////////////////////
function processNewRow_mb(tbody, fromRow, dataTemplateRow, newRow) {
    var fromCell;
    var newCell;
    var action;
    var img;

    for (var j =0; j < fromRow.cells.length; j++) {
        fromCell = fromRow.cells[j];
    	newCell = fromCell.cloneNode(true);
    	newRow.appendChild(newCell);	
	    if (dataTemplateRow) {
	        performDefaulting_mb(newCell, dataTemplateRow);
	    }
        
        if (fromCell.className == "checkboxcolumn") {
        	hideCheckBox_mb(newCell);
        	newCell.width = "23px";
        	newCell.style.paddingLeft = "5px";
            img = document.createElement("IMG");
        	img.setAttribute("class","icon");
        	img.setAttribute("src","../console/icons/delete.gif");
        	img.setAttribute("title",removeRowString);
        	//img.setAttribute("onclick", "deleteRow_mb(this);");
        	img.setAttribute("style","width:12px;");
            newCell.appendChild(img);
			img.onclick = function()
            				{ deleteRow_mb(this); }
            img.style.cursor = "pointer";
            newCell.nowrap = true;
        }
    }

    processSequenceNoForRow_mb(newRow);
}
////////////////////////////////////////////////////////////////////////////////////
//Function Type: Private
////////////////////////////////////////////////////////////////////////////////////
function hideCheckBox_mb(newCell) {
	var inputs = newCell.getElementsByTagName("INPUT");
	var inp;
	
	for (var i = 0; i < inputs.length; i ++) {
		inp = inputs.item(i);
		if ((inp.type == "checkbox") && (inp.name == "chkEntityKey")) {
			inp.style.display = 'none';
			break;
		}
	}
}

////////////////////////////////////////////////////////////////////////////////////
//Function Type: Private
////////////////////////////////////////////////////////////////////////////////////
function performDefaulting_mb(newCell, dataTemplateRow) {

    defaultForControl_mb(newCell, dataTemplateRow, "input");
    defaultForControl_mb(newCell, dataTemplateRow, "select");
    defaultForControl_mb(newCell, dataTemplateRow, "textarea");
}

////////////////////////////////////////////////////////////////////////////////////
//Function Type: Private
////////////////////////////////////////////////////////////////////////////////////
function defaultForControl_mb(newCell, dataTemplateRow, tag) {
    var child;
	var textValue;

    if (!dataTemplateRow)
        return;
    
    var ci = newCell.cellIndex;

    var list = newCell.getElementsByTagName(tag);

    for (var k = 0; k < list.length; k++ ) {
        child = list.item(k);
        if (child.nodeName == "INPUT") {
			textValue = getFromText_mb(dataTemplateRow.cells[ci], child.nodeName, "type", child.type);
			if( textValue != null){
				child.value = textValue;
			}
        }
        else if ((child.nodeName == "SELECT") || (child.nodeName == "TEXTAREA")) {
            child.value = getFromText_mb(dataTemplateRow.cells[ci], child.nodeName, null, null);
        }
    }
}

////////////////////////////////////////////////////////////////////////////////////
//Function Type: Private
////////////////////////////////////////////////////////////////////////////////////
function getFromText_mb(cell, tag, attrToCompare, attrValue) {
    var text = null;

    if (!cell)
        return;
	if (attrValue != "hidden") {
		text = trim(cell.innerText);
	}
    var list = cell.getElementsByTagName(tag);

    for (var i = 0; i < list.length; i++) {
        if ((attrToCompare == null) || (list.item(i).getAttribute(attrToCompare) == attrValue)) {
                text = list.item(i).value;
                break;
        }
    }

    return text;
}


////////////////////////////////////////////////////////////////////////////////////
//Function Type: Private
////////////////////////////////////////////////////////////////////////////////////
function processSequenceNoForRow_mb(newRow) {
    // Determine the highest unique index for all of the rows.
	var highestIndex = newRow.rowIndex;
	var tableObj = getParentObject_mb(newRow, "TABLE");
	var tableHighestIndex = tableObj.getAttribute("yfcHighestRowIndex");
	if (tableHighestIndex) {
		highestIndex = parseInt(tableHighestIndex) + 1;
	}
    processControl_mb(newRow.getElementsByTagName("input"), newRow, highestIndex);
    processControl_mb(newRow.getElementsByTagName("select"), newRow, highestIndex);
    processControl_mb(newRow.getElementsByTagName("textarea"), newRow, highestIndex);

	tableObj.setAttribute("yfcHighestRowIndex", highestIndex);
}

////////////////////////////////////////////////////////////////////////////////////
//Function Type: Private
////////////////////////////////////////////////////////////////////////////////////
function processControl_mb(children, newRow, highestIndex) {

    var child;
    var ind;
    var newString;
    var seqField;
    var name;
	var flag = shouldIDsBeGenerated_mb(newRow);
	
    for (var i = 0; i<children.length; i++) {
        child = children.item(i);
        name = child.getAttribute("yName");
        if (name) {
            ind = name.lastIndexOf("_");

			tmp1 = name.substring(ind + 1, name.length);
			if(tmp1 != null && (tmp1.toUpperCase() == "YFCDATE" || tmp1.toUpperCase() == "YFCTIME")){
				tmpstring = name.substring(0, ind);
				ind = tmpstring.lastIndexOf("_");
			}

            newString = name.substring(0, ind + 1);
			// Set the name of the control with the appropriate index
            newString = newString + highestIndex + name.substring(ind + 1, name.length);
            child.name = newString;
			if (flag) {
				child.id = newString;
			}
            seqField = child.getAttribute("seqField");
            if ((seqField) && (seqField == "true")) {
                child.value = highestIndex;
            }
        }
    }
}

////////////////////////////////////////////////////////////////////////////////////
//Function Type: Private
////////////////////////////////////////////////////////////////////////////////////
function shouldIDsBeGenerated_mb(newRow) {
		var otbl = getParentObject_mb(newRow, "TABLE");
	    var isIdReqd;
        isIdReqd = otbl.getAttribute("GenerateID");
        if ((isIdReqd) && (isIdReqd == "true")) {
			return true;
		}
		return false;

}

////////////////////////////////////////////////////////////////////////////////////
//Function Type: Private
////////////////////////////////////////////////////////////////////////////////////
function getTemplateRow_mb(tfoot)
{
    var templRow = null;
    var isTemplateRow;

    for (var j=0; j< tfoot.rows.length; j++ ) {
        isTemplateRow = tfoot.rows[j].getAttribute("TemplateRow");
        if ((isTemplateRow) && (isTemplateRow == "true")) {
            templRow = tfoot.rows[j];
            break;
        }
    }

    if (templRow == null) {
        templRow = oHead.rows(0);
    }

    return templRow;
}

////////////////////////////////////////////////////////////////////////////////////
//Function Type: Private
////////////////////////////////////////////////////////////////////////////////////

function setDeleteOperationShipment_mb(element) {
	var sOperation = window.document.getElementById("userOperation");
	if(sOperation)
		sOperation.value="DELETE";
	var row = getParentObject_mb(element, "TR");
	var rowIndex = "";
	var deleteRowIndex = row.getAttribute("DeleteRowIndex");
	if(deleteRowIndex != null){
		rowIndex = deleteRowIndex;
	} 
	else{
		rowIndex = row.rowIndex;
	}
	var deleteRowFlag = window.document.getElementById("xml:/Shipment/ShipmentLines/ShipmentLine_"+ rowIndex+ "/@DeleteRow");
	if(deleteRowFlag)
	{
		deleteRowFlag.value='Y';
		document.body.detachEvent("onunload", processSaveRecordsForShipmentLines_mb);
		IgnoreChangeNames_mb();
		yfcDoNotPromptForChanges_mb(true);
		yfcChangeDetailView_mb(getCurrentViewId_mb());
	}
}
///////////////////////////////////////////////////////////////////////////////
//Function Type: Private
///////////////////////////////////////////////////////////////////////////////
function setAddRowFlagAndRefreshShipment_mb(element)
{
	var addRow = window.document.getElementById("userOperation");
	var numRowsToAdd = window.document.getElementById("numRowsToAdd");
	var numCopyAdd = window.document.getElementById("numCopyAdd");


	if(numCopyAdd && numRowsToAdd)
		numRowsToAdd.value=numCopyAdd.value;
	if(addRow)
	{
		addRow.value="Y";
		document.body.detachEvent("onunload", processSaveRecordsForShipmentLinesForAddRow_mb);
		IgnoreChangeNames_mb();
		yfcDoNotPromptForChanges_mb(true);
		yfcChangeDetailView_mb(getCurrentViewId_mb());	
	}
}
///////////////////////////////////////////////////////////////////////////////
//Function Type: Private
///////////////////////////////////////////////////////////////////////////////
function setAddRowFlagAndRefreshSerials_mb(element)
{
	var addRow = window.document.getElementById("userOperation");
	var numRowsToAdd = window.document.getElementById("numRowsToAdd");
	var numCopyAdd = window.document.getElementById("numCopyAdd");


	if(numCopyAdd && numRowsToAdd)
		numRowsToAdd.value=numCopyAdd.value;
	if(addRow)
	{
		addRow.value="Y";
		document.body.detachEvent("onunload", processSaveRecords_mb);
		IgnoreChangeNames_mb();
		yfcDoNotPromptForChanges_mb(true);
		yfcChangeDetailView_mb(getCurrentViewId_mb());	
	}
}
////////////////////////////////////////////////////////////////////////////////////
//Function Type: Private
////////////////////////////////////////////////////////////////////////////////////

function setDeleteOperationSerials(element) {
	var sOperation = window.document.getElementById("userOperation");
	if(sOperation)
		sOperation.value="DELETE";
	var row = getParentObject_mb(element, "TR");
	var rowIndex = "";
	var deleteRowIndex = row.getAttribute("DeleteRowIndex");
	if(deleteRowIndex != null){
		rowIndex = deleteRowIndex;
	} 
	else{
		rowIndex = row.rowIndex;
	}
	var deleteRowFlag = window.document.getElementById("xml:/AdjustLocationInventory/Source/Inventory/SerialList/SerialDetail_"+ rowIndex+ "/@DeleteRow");
	if(deleteRowFlag)
	{
		deleteRowFlag.value='Y';
		document.body.detachEvent("onunload", processSaveRecords_mb);
		IgnoreChangeNames_mb();
		yfcDoNotPromptForChanges_mb(true);
		yfcChangeDetailView_mb(getCurrentViewId_mb());
	}
}

///////////////////////////////////////////////////////////////////////////////
//Function Type: Public
///////////////////////////////////////////////////////////////////////////////
function validateCopyAdd_mb(element)
{
	//var numCopyAdd = window.document.getElementById("numCopyAdd");
	var parTable = getParentObject_mb(element, "TABLE");
	var cNodes= parTable.getElementsByTagName("input");
	var i;
	var numCopyAdd;
	for(i=0;i<cNodes.length;i++)
	{
	if (cNodes[i].type=="text" && cNodes[i].className=="tablefooterinput"){
		var numCopyAdd =cNodes[i];
		break;
		}
	}
	var error = yfcValidateNumber_mb(numCopyAdd.value, numCopyAdd.maxValue,numCopyAdd.minValue,numCopyAdd.maxValueString,numCopyAdd.minValueString);
	if(error != null && error != ""){
		alert(YFCMSG044);
		return false;
	}
	return true;
}

