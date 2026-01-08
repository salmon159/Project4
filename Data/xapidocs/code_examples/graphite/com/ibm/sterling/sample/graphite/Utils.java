/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite;

public class Utils {
	public static String formatDotsToDashes(String str) {
		return str.replaceAll("\\.", "-");
	}
	
	public static boolean isVoid(String str) {
		if (str == null || str.trim().equals("")) return true;
		else return false;
	}
}
