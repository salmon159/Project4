/*
 * IBM Confidential 
 *
 * OCO Source Materials
 *
 * IBM Sterling Selling and Fullfillment Suite
 *
 * (c) Copyright IBM Corp. 2001, 2013 All Rights Reserved.
 *
 * The source code for this program is not published or otherwise divested of its trade secrets,
 * irrespective of what has been deposited with the U.S. Copyright Office.
 */

package com.yantra.jasperreports;

import java.text.ParsePosition;
import com.ibm.icu.text.SimpleDateFormat;

import net.sf.jasperreports.engine.JRDefaultScriptlet;
import net.sf.jasperreports.engine.JRScriptletException;
 
/**
 */
public class SampleAlertReferenceReportScriptlet extends JRDefaultScriptlet{
	public void beforeDetailEval() throws JRScriptletException
	{
		try{
		String referenceName = (String)this.getFieldValue("ReferenceName") ;
		String referenceValue = (String)this.getFieldValue("ReferenceValue");
		if (referenceName.equalsIgnoreCase("LastOccurredOn") )
		{
			String formattedgeneratedDate = this.formatDate(referenceValue) ;
			this.setVariableValue("formattedValue", formattedgeneratedDate);
		} else {
			this.setVariableValue("formattedValue", referenceValue);
		}
		} catch(Exception e){
			this.setVariableValue("formattedValue", "Exception Occurred");
		}
	}
	private String formatDate(String isoDate){
		String formattedDate = null ;
		if (isoDate == null || isoDate.trim().equals(""))
			formattedDate = " " ;
		else {
			formattedDate = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss").format((new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss")).parse( isoDate, new ParsePosition(0)));
		}
	    return formattedDate ;
	}
	
}
