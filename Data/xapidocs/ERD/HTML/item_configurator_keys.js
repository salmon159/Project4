 /*
 * 
 * Licensed Materials - Property of IBM 
 *
 * IBM Sterling Selling and Fullfillment Suite
 *
 * (c) Copyright IBM Corp. 2012 All Rights Reserved. 
 * 
 * US Government Users Restricted Rights - Use, duplication or disclosure
 * restricted by GSA ADP Schedule Contract with IBM Corp. 
 */
function keyHandler()
{
	var e = window.event;
	var tag = e.srcElement.tagName;
	var override = !(tag == "A" || tag == "INPUT" || tag == "SELECT" || tag == "FORM" || tag == "SUBMIT");
	
	if(override && e.keyCode == 13) //13 is <enter> key
	{
		e.srcElement.click();
	}
}

document.onkeypress = keyHandler;
