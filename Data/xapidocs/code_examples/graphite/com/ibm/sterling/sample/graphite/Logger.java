/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite;

public class Logger {
	private static boolean verbose = false;
	public static void setVerbose(boolean verbose) {
		Logger.verbose = verbose;
	}
	
	public static void verbose(String str) {
		if (verbose)
			System.out.println("[graphite] " + str);
	}
	
	public static void info (String str) {
		System.out.println(str);
	}
	
	public static void warn (String str) {
		System.err.println(str);
	}
	
	public static void error (String msg, Exception e) {
		System.err.println(msg);
		e.printStackTrace(System.err);
	}
}
