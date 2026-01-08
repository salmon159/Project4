/*******************************************************************************
   IBM Confidential 
   OCO Source Materials 
   IBM Sterling Selling and Fullfillment Suite
   (c) Copyright IBM Corp. 2001, 2013 All Rights Reserved.
   The source code for this program is not published or otherwise divested of its trade secrets, 
   irrespective of what has been deposited with the U.S. Copyright Office. 
 *******************************************************************************/
//window.attachEvent("oncontentready",initView);
//window.attachEvent("DOMContentLoaded",initView);
/*alert(elment);*/
ele=window.document.body.getElementsByTagName('TABLE');
for(i=0;i<ele.length;i++){

	if((ele[i].className=='disabledview')||(ele[i].className=='viewwithformatting')){	
		element=ele[i];
		initView();
	}
	
}


function initView() {


	var protectLayout = element.getAttribute("protectLayout");
	if (element.tagName != 'TABLE') {
            alert("Error: View behavior can be attached only to a table element.");
    }
    var rows = element.rows;
    var close = element.getAttribute("closeWindow");

    if ((close) && (close == "true")) {
		window.close();
    }
    if ((protectLayout) && (protectLayout == "true")) {
        return;
    }

    if ((!element.rows) || (element.rows.length == 0))
        return;

    var elem;
    var cols = element.rows[0].cells.length;

    var percent = eval (100 / cols) + "%" ;
   
    if (cols == 1)
        return;

    var cell;

    for (var j = 0; j < element.rows.length; j++) {
        for (var i = 0; i < element.rows[j].cells.length; i++) {
            cell = element.rows[j].cells[i];
            cell.style.width = percent;
        }
    }
}