/*******************************************************************************
   IBM Confidential 
   OCO Source Materials 
   IBM Sterling Selling and Fullfillment Suite
   (c) Copyright IBM Corp. 2001, 2013 All Rights Reserved.
   The source code for this program is not published or otherwise divested of its trade secrets, 
   irrespective of what has been deposited with the U.S. Copyright Office. 
 *******************************************************************************/
///*element=*/alert(document.childNodes[0].childNodes[0].childNodes.length/*nodeName*/);//('TABLE');
ele=window.document.body.getElementsByTagName('TABLE');
var element=null;
for(i=0;i<ele.length;i++){

	if(ele[i].className=='table'){
		ele[i].attachEvent("onfilterchange", onRowsChanged );
	}
	
}
document.attachEvent("ondetach",cleanup);
document.attachEvent("ondocumentready" ,fireRowsChanged);

var tbody=null;					
var theadrow=null;
var tableContextPopup;
var sortRowContextMenu;
var exportRowContextMenu;

var reverse = false;
var lastclick = -1;	// stores the object of our last used object
for(i=0;i<ele.length;i++){

	if(ele[i].className=='table'){
		//alert("sdf");	
		element=ele[i];
		init();
	}
	
}



function fireRowsChanged(oTable) {
	if (oTable) {
		//oTable.fireEvent("onfilterchange");
		yfcOnRowsChanged(oTable);
	}
}

////////////////////////////////////////////////////////////////////////////////////
function onRowsChanged(e) {
	//CR 90457
	if(e != null && e.srcElement != null) {
		tbody = e.srcElement.tBodies[0];
	}
	var suppressRowColoring = element.getAttribute("SuppressRowColoring");

	if (suppressRowColoring == null || suppressRowColoring != "true") {
	    reComputeColors();
	}
	else {
		var suppressBorder = element.getAttribute("SuppressBorder");
		if (suppressBorder == null || suppressBorder != "true") {
		    applyBorders();
		}
	}
    return false;
}

/////////////////////////////////////////////////////////////////////////////////////
//function to emulate onFilterchange event
/////////////////////////////////////////////////////////////////////////////////////
function yfcOnRowsChanged(oTable) {
	element=oTable;	
	var tblBody = element.getAttribute('BodyTable');
	//alert(tblBody);
	if (tblBody)
	    tbody = tblBody.tBodies[0];
	else
	    tbody = element.tBodies[0];	
	if (!tbody) return;
	onRowsChanged();	
	
}

////////////////////////////////////////////////////////////////////////////////////
function reComputeColors() {
	if (!tbody)
        return;
	
    var existingClass = '';
    for (var i=0;i<tbody.rows.length;i++) {

	if ((existingClass == null) || (existingClass == '') || (existingClass == 'oddrow')) {
		tbody.rows[i].className = "evenrow";
		if(i+1 < tbody.rows.length){
			if(!isNaN(tbody.rows[i+1].getAttribute("BypassRowColoring")) && tbody.rows[i+1].getAttribute("BypassRowColoring") != " " && tbody.rows[i+1].getAttribute("BypassRowColoring") != "true"){
				existingClass = "evenrow";
			}else{
				existingClass = "oddrow";
			}
		}

        } else {
                tbody.rows[i].className = "oddrow";
		if(i+1 < tbody.rows.length){
			if(!isNaN(tbody.rows[i+1].getAttribute("BypassRowColoring")) && tbody.rows[i+1].getAttribute("BypassRowColoring") != " " && tbody.rows[i+1].getAttribute("BypassRowColoring") != "true"){
				existingClass = "oddrow";
			}else{
				existingClass = "evenrow";
			}
		}
        }
    }
}
////////////////////////////////////////////////////////////////////////////////////
function applyBorders() {

    if (!tbody)
        return;

    for (var i=0;i<tbody.rows.length;i++){
		for (var j=0;j<tbody.rows(i).cells.length; j++) {
			tbody.rows(i).cells(j).style.borderBottom = "1px solid #EAEAF6";
			if (j < tbody.rows(i).cells.length - 1) {
				tbody.rows(i).cells(j).style.borderRight = "1px solid #EAEAF6";
			}
		}
    }
}

////////////////////////////////////////////////////////////////////////////////////
function cleanup()
{
	element.detachEvent("onfilterchange", onRowsChanged );
}

////////////////////////////////////////////////////////////////////////////////////
function init() {
	// get TBODY - take the first TBODY for the table to sort
	//alert(element);
	var tblBody = element.getAttribute('BodyTable');
	//alert(tblBody);
	if (tblBody)
	    tbody = tblBody.tBodies[0];
	else
	    tbody = element.tBodies[0];
	
	if (!tbody) return;
	
	//Get THEAD  
	var thead = element.tHead;
	
	if (!thead)  return;
	
	cellCollection = thead.getElementsByTagName("TD");

	if (cellCollection == null) return;

	var clickCell = null;

	element.cellSpacing =0;

	//following loop searches all chilldren cells n level deep and sets look of hand or auto 

	for (var j = 0; j<cellCollection.length; j++) {
		clickCell = cellCollection[j];
		clickCell.style.cursor = "auto";
		if (tbody.rows.length <= getyfcMaxSortingRecords ()) {
			if(paginatedList)
			{
				var orderBy = clickCell.getAttribute('orderBy')
				if(orderBy != null && trim(orderBy) != "") {
					if(orderBy == currentOrderBy)
					{
						if(currentSortDirection == "DESC")
						{
							clickCell.innerHTML=clickCell.innerHTML+'&#8595;';
							clickCell.setAttribute("sortDirection","ASC");
						}
						else
						{
							clickCell.innerHTML=clickCell.innerHTML+'&#8593;';
							clickCell.setAttribute("sortDirection","DESC");
						}

					}
					clickCell.style.cursor = "pointer";
				}
			}
			else
			{
		sortable=clickCell.getAttribute('sortable');
			if ((sortable == null) || (sortable != "no")) {
				clickCell.style.cursor = "pointer";
			}
		}
		}
	}

	theadrow = thead.rows[0]; //Assume just one Head row will be sortable.
	
	if (theadrow.tagName != "TR") return;
	
	clickCell = null;
	
	for (var i=0; i < theadrow.cells.length; i++) 
	{
		clickCell = theadrow.cells[i];
		if (tbody.rows.length <= getyfcMaxSortingRecords() ) {
			if(paginatedList)
			{
				var orderBy = clickCell.getAttribute('orderBy')
				if(orderBy != null && trim(orderBy) != "") {
					clickCell.selectIndex = i;
					clickCell.attachEvent("onclick", doClick);
				}
			}
			else
			{
		sortable=clickCell.getAttribute('sortable');
			if ((sortable == null) || (sortable != "no")) {
				clickCell.selectIndex = i;
				clickCell.attachEvent("onclick", doClick);
			}
			}
			var browser=navigator.appName;
if(browser=="Microsoft Internet Explorer")
{
clickCell.attachEvent("ondragleave", getExportData);
 }else{
			clickCell.attachEvent("ondragexit", getExportData);
			}
			clickCell.attachEvent("oncontextmenu", displayCustomContextMenu);
		}
	}
	reComputeColors();
	changeFooterNames(element.tFoot);
	defaultRows();
}

function displayCustomContextMenu(e) {
	e=window.event;
	var obj = e.srcElement;	
	
	var ctrlKeyPressed = e.ctrlKey;
	if (ctrlKeyPressed || obj == null) {
		return;
	}

	if (obj.tagName != "TD") {
		obj = getParentObject(obj, "TD");
	}
	// clear 'CurrentlyClickedHeader' if already exist.
	var prevObj = window.document.all("CurrentlyClickedHeader");
	if(prevObj != null)	{
		prevObj.setAttribute("id", obj.getAttribute("OrigId"));
	}

	var origId = obj.getAttribute("id");
	obj.setAttribute("id","CurrentlyClickedHeader");
	obj.setAttribute("OrigId",origId);

	createDiv(e);	
	
	obj.setAttribute("window", tableContextPopup);
	e.returnValue = false;	
}

function createDiv(e) {	
	var obj = e.srcElement;
	yfcClickObject = obj;
	var divExists = document.getElementById("customContextMenu");
	var browser=navigator.appName;
	if (!divExists) {
		var hiddenDiv = document.createElement("div");
		hiddenDiv.setAttribute("id","customContextMenu");
		hiddenDiv.style.cssText = "visibility:hidden;display:none;";

			document.body.appendChild(hiddenDiv);

		var contextMenu = document.getElementById("customContextMenu");
		addContextMenuOptions("export", contextMenu, Export_Table_Data);
		addContextMenuOptions("sort", contextMenu, Sort_Column);
		PopupWin_mb('Left',contextMenu,e.srcElement,".menuitempopuprownormal",".menuitempopuprowhighlight","","",(browser != "Opera"));
	}
	else {
		PopupWin_mb('Left',divExists,e.srcElement,".menuitempopuprownormal",".menuitempopuprowhighlight","","",(browser != "Opera"));
	}

}

function addContextMenuOptions (tableAction, parDiv, menuOptionText) {	
	var contextMenu = window.document.getElementById("customContextMenu");	
	var subCol = document.createElement("div");
	parDiv.appendChild(subCol);
	subCol.innerText = menuOptionText;
	if (tableAction == "export") {
		subCol.innerHTML = subCol.innerHTML + '&nbsp;' + '&#8594;' ;
		subCol.setAttribute("myonclick", "setTableAction_mb('export')");
	} else if (tableAction == "sort") {
		subCol.innerHTML = subCol.innerHTML + '&nbsp;' + '&#8595;' + '&#8593;' ;
		subCol.setAttribute("myonclick", "setTableAction_mb('sort')");
	}
}

var yfcClickObject = null;

function getExportData(e) {
e=window.parent.event;
	
	var clickObject = yfcClickObject;//document.getElementById("customContextMenu");
	if(!clickObject)
		clickObject = e.srcElement;
	if (clickObject.tagName != "TD") {
		clickObject = getParentObject(clickObject, "TD");
	}
	var commaDelimText = "";
	var theadrow = clickObject.parentNode;		
	var columnHeaders = "";
	for (var i=0; i < theadrow.cells.length;i++) {				
		clickCell = theadrow.cells[i];
		var className = clickCell.className;
		var innerText = clickCell.innerText;
		if (className != "checkboxheader") {
			if ((i+1) == theadrow.cells.length) {
				columnHeaders = columnHeaders + trim(innerText) + "\n";
			} else {
				columnHeaders = columnHeaders + trim(innerText) + "\t";
			}
		}
	}		
	commaDelimText = columnHeaders;
	var thead = theadrow.parentNode;
	var table = thead.parentNode;
	var tbodyelem = table.getElementsByTagName("tbody");
	var tbodyrows = tbodyelem[0].getElementsByTagName("tr");
	for (var j=0; j < tbodyrows.length;j++) {
		var rowVals = "";
		currow = tbodyrows[j];
		var columns = currow.getElementsByTagName("td");
		for (var k=0; k < columns.length;k++) {
			curcolumn = columns[k];
			var className = curcolumn.className;
			var innerText = curcolumn.innerText;
			var inputs = curcolumn.getElementsByTagName('input') ;
			if (className != "checkboxcolumn") {	
				rowVals = rowVals + trim(innerText);
				if( inputs != null && inputs.length > 0 )					
				rowVals = rowVals + trim(inputs[0].value) ;
				if ((k+1) == columns.length) {
					rowVals = rowVals  + "\n";
				} else {
					rowVals = rowVals  + "\t";
				}
			}				
		}
		commaDelimText = commaDelimText + rowVals;
	}
	//var features = "height:750px;width:1110px;left:0px;top:0px;scroll:no;resizable:yes;help:no;status:no;edge:sunken;unadorned:yes";
	//var tableDataWindow = window.showModelessDialog("../yfc/source.jsp",commaDelimText,features);
	var features = "height:750px;width:1000px;left:0px;top:0px";
	commaDelimText.scroll = false;
	var tableDataWindow = openDialogBox_mb("../yfc/source_mb.jsp",commaDelimText,features);
	e.returnValue = false;
}
function CreateExcelSheet(e) {
	if (window.ActiveXObject){ 

		var  xlApp = new ActiveXObject("Excel.Application");  
		var xlBook = xlApp.Workbooks.Add(); 

		xlBook.worksheets("Sheet1").activate; 
		var XlSheet = xlBook.activeSheet; 

		var clickObject = e.srcElement;
		if (clickObject.tagName != "TD") {
			clickObject = getParentObject(clickObject, "TD");
		}
		var theadrow = clickObject.parentNode;		
		for (var i=0; i < theadrow.cells.length;i++) {				
			clickCell = theadrow.cells[i];
			var className = clickCell.className;
			var innerText = clickCell.innerText;
			if (className != "checkboxheader") {
				XlSheet.Cells(1, i+1).Value = innerText;
			}
		}		
		var thead = theadrow.parentNode;
		var table = thead.parentNode;
		var tbodyelem = table.getElementsByTagName("tbody");
		var tbodyrows = tbodyelem[0].getElementsByTagName("tr");
		for (var j=0; j < tbodyrows.length;j++) {
			var rowVals = "";
			currow = tbodyrows[j];
			var columns = currow.getElementsByTagName("td");
			for (var k=0; k < columns.length;k++) {
				curcolumn = columns[k];
				var className = curcolumn.className;
				var innerText = curcolumn.innerText;
				if (className != "checkboxcolumn") {	
					XlSheet.Cells(j + 2, k +1).Value = innerText;
				}				
			}
		}
		XlSheet.columns.autofit;  
	}
	xlApp.visible = true;  
}


////////////////////////////////////////////////////////////////////////////////////
//If there are no rows in the table, then based on the initial rows parameter, add some empty lines.
////////////////////////////////////////////////////////////////////////////////////
function defaultRows() {
    var initialRows = element.getAttribute("initialRows");
    if ((initialRows) && (initialRows > 0)) {
	    if ((!tbody.rows) || (tbody.rows.length == 0)) {
		    templateRow = getTemplateRow(element.tFoot);
			addLines(tbody, templateRow, null, initialRows);
		}
	}
}

///////////////////////////////////////////////////////////////////////////////////
//function to set element,theadrow and tbody correctly before sorting when multiple
//tables are present
////////////////////////////////////////////////////////////////////////////////////
function yfcInit(par){

	element=par;
	var tblBody = element.getAttribute('BodyTable');
	
	if (tblBody)
	    tbody = tblBody.tBodies[0];
	else
	    tbody = element.tBodies[0];
	
	if (!tbody) return;
	
	//Get THEAD  
	var thead = element.tHead;
	theadrow=thead.rows[0];
	lastclick=element.getAttribute("lastclick");
	if(lastclick==null){
	lastclick=-1;
	}
}
// doClick handler
////////////////////////////////////////////////////////////////////////////////////
	function doClick(e) 
	{	
		var browser=navigator.appName;
		if(browser =="Opera" && window.event.shiftKey)
		{
			displayCustomContextMenu(e);
			return;
		}
		e=window.event;
		var clickObject = e.srcElement;
		
		if(paginatedList)
		{
			yfcGoOrderBy(clickObject.getAttribute("orderBy"), clickObject.getAttribute("sortDirection"));
			return;
		}

		if(tbody.rows.length > getyfcMaxSortingRecords()){
		    input_box=false;
		} else if(tbody.rows.length > getyfcMaxSortingRecordsWithoutWarning()){
		    input_box=confirm(YFCMSG114);
		}else{
		    input_box=true;	
		}
		if (input_box==true){
		var parent=clickObject.parentElement;
		while (parent.tagName != "TABLE") {
			parent = parent.parentElement;
			
		   }
		   
		   yfcInit(parent);	
		   while (clickObject.tagName != "TD") {
			clickObject = clickObject.parentElement;
			
		   }
		   // clear the sort images in the head
		   //alert(clickObject.innerHTML);
		   var td = theadrow.cells;
		  
	
		   for(var x = 0; x < td.length; x++) {		   
		 if (x==lastclick)	{
		 	td[x].innerHTML = td[x].innerHTML.substr(0,td[x].innerHTML.length-1);
			
		 }
		}
	
		if(lastclick == clickObject.selectIndex)
		{
		if(reverse == false)	{
			clickObject.innerHTML=clickObject.innerHTML+'&#8595;';
				reverse = true;			
			}
		else {
			clickObject.innerHTML=clickObject.innerHTML+'&#8593;';
		    reverse = false;
		}
		}
		else
		{
		//alert("here");
			reverse = false;
			clickObject.innerHTML=clickObject.innerHTML+'&#8593;';
			parent.setAttribute("lastclick",clickObject.selectIndex);
			//lastclick = clickObject.selectIndex;
			//alert(clickObject.selectIndex);
		}
		var b = false;
		var ieVersion = getInternetExplorerVersion_mb();
	
		if (ieVersion != -1 && ieVersion < 7){
			b = true;
			for (i=0;i<tbody.rows.length;i++){
				var chkBoxArr = tbody.rows[i].getElementsByTagName('input');
				for (j=0;j<chkBoxArr.length ;j++ ){
					if (chkBoxArr[j].getAttribute("type")=="checkbox"){
						chkBoxArr[j].myChecked = chkBoxArr[j].checked;
					}			
				}
			}
		}
		insertionSort(tbody, tbody.rows.length-1,  reverse, clickObject.selectIndex);
		if (b && tbody.rowsChangeOccurred){
			tbody.rowsChangeOccurred = null;
			for (i=0;i<tbody.rows.length;i++){
				var chkBoxArr = tbody.rows[i].getElementsByTagName('input');
				for (j=0;j<chkBoxArr.length ;j++ ){
					if (chkBoxArr[j].getAttribute("type")=="checkbox"){
						chkBoxArr[j].checked = chkBoxArr[j].myChecked;
						chkBoxArr[j].myChecked = null;
					}			
				}
			}
		}
		onRowsChanged();	
		  }else{		
			//Do nothing
		  }
	  
}

function insertionSort(t, iRowEnd, fReverse, iColumn)
{
//alert("insertion");
	var iRowInsertRow, iRowWalkRow, current, insert, isNumeric, currClass, outerLoopMultiCopy;
	
	outerLoopMultiCopy = false;
	
	if ((t.rows) && (t.rows.length > 0))
		currClass = t.rows[0].cells[iColumn].className;
		
	
	if ((currClass) && (currClass == "numerictablecolumn")) {
		isNumeric = true;
	}
	else {
		isNumeric = false;
	}
	
    for ( iRowInsert = 1 ; iRowInsert <= iRowEnd ; iRowInsert++ )
    {
   // alert(iRowInsert);
    if(!isNaN(t.rows[iRowInsert].getAttribute("BypassRowColoring")) && t.rows[iRowInsert].getAttribute("BypassRowColoring") != " " && t.rows[iRowInsert].getAttribute("BypassRowColoring") != "true"){
        
        if(iRowInsert < iRowEnd){
            if(!isNaN(t.rows[iRowInsert+1].getAttribute("BypassRowColoring")) && t.rows[iRowInsert+1].getAttribute("BypassRowColoring") != " " && t.rows[iRowInsert+1].getAttribute("BypassRowColoring") != "true"){
                outerLoopMultiCopy = false;
            }else{
                outerLoopMultiCopy = true;
            }
        }else{
            outerLoopMultiCopy = false;
        }
		try {
              if(t.rows[iRowInsert].cells[iColumn].getAttribute("sortValue"))
              {
			     textRowInsert = t.rows[iRowInsert].cells[iColumn].getAttribute("sortValue");
			     
                 isNumeric = true;
			  }
			  else{
                 textRowInsert = t.rows[iRowInsert].cells[iColumn].innerText;
                 }
		} catch (ex) {
			textRowInsert = "";
		}
		
        for ( iRowWalk = 0; iRowWalk <= iRowInsert ; iRowWalk++ )
        {
	    if(!isNaN(t.rows[iRowWalk].getAttribute("BypassRowColoring")) && t.rows[iRowWalk].getAttribute("BypassRowColoring") != " " && t.rows[iRowWalk].getAttribute("BypassRowColoring") != "true"){
			try 
			{
                 if(t.rows[iRowWalk].cells[iColumn].getAttribute("sortValue"))
                 {
                    textRowCurrent = t.rows[iRowWalk].cells[iColumn].getAttribute("sortValue");
                    isNumeric = true;
                 }
                 else
				    textRowCurrent = t.rows[iRowWalk].cells[iColumn].innerText;
            } 
            catch (ex) 
            {
				textRowCurrent = "";
			}

            //
            // We save our values so we can manipulate the numbers for
            // comparison
            //
            current = textRowCurrent;
            insert  = textRowInsert;


            //  If the value is not a number, we sort normally, else we evaluate	
            //  the value to get a numeric representation
            //
            if ((isNumeric == true)  && (insert != " ") && (current != " ") && !isNaN(current) && !isNaN(insert) )
            {
            	try {
		            current = eval(current);
		            insert = eval(insert);
	            }
	            catch (ex) {
	            	//current = current.toLowerCase();
	            	//insert = insert.toLowerCase();
	            }
            }
            
            if ( (   (!fReverse && insert < current)
                 || ( fReverse && insert > current) )
                 && (iRowInsert != iRowWalk) )
            {
		if(outerLoopMultiCopy == false){
		    eRowInsert = t.rows[iRowInsert];
		    eRowWalk = t.rows[iRowWalk];
		    t.insertBefore(eRowInsert, eRowWalk);
		}
		else{
		    eRowInsert = t.rows[iRowInsert];
		    eRowWalk = t.rows[iRowWalk];
		    t.insertBefore(eRowInsert, eRowWalk);

		    eRowInsertPlusOne = t.rows[iRowInsert+1];
			    eRowWalkPlusOne = t.rows[iRowWalk+1];
			    t.insertBefore(eRowInsertPlusOne, eRowWalkPlusOne);
		}
		var ieVersion = getInternetExplorerVersion_mb();
		if (ieVersion != -1 && ieVersion < 7){
			t.rowsChangeOccurred = true;
		}
                iRowWalk = iRowInsert; // done
            }
        }// end of inner parenttr
        }
    }// end of parenttr
    if(outerLoopMultiCopy == true){
        if(iRowInsert < iRowEnd)
            iRowInsert++;
    }
    }
}

function changeFooterNames(footer) {

	if (!footer)
		return;
		
    if (footer.rows && footer.rows.length > 0) {
        processFooterInputs(footer.rows[0].getElementsByTagName("input"));
        processFooterInputs(footer.rows[0].getElementsByTagName("select"));
        processFooterInputs(footer.rows[0].getElementsByTagName("textarea"));
    }
}

function processFooterInputs(inputs) {
    var name ;

    for (var i = 0; i < inputs.length; i ++){
        name = inputs.item(i).name;
        if (name) {
            inputs.item(i).setAttribute("yName", name);
            inputs.item(i).name = "";
        }
    }
}

function getyfcMaxSortingRecords () {
    var maxSortRows = element.getAttribute("yfcMaxSortingRecords");
    if(isVoid(maxSortRows)){
	return 100000;
    }
    return maxSortRows;
}

function getyfcMaxSortingRecordsWithoutWarning() {
    var maxSortRowsWithoutWarning = element.getAttribute("yfcMaxSortingRecordsWithoutWarning");
    if(isVoid(maxSortRowsWithoutWarning)){
	return 250;
    }
    return maxSortRowsWithoutWarning;
}

// Returns true if value only contains spaces
function isVoid(val){
   if(val==null){
	return true;
   }
   for(var i=0;i<val.length;i++) {
      if ((val.charAt(i)!=' ')&&(val.charAt(i)!="\t")&&(val.charAt(i)!="\n")&&(val.charAt(i)!="\r")){
	return false;
      }
   }
   return true;
}