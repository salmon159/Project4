/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite;

@SuppressWarnings("serial")
public class GraphiteExporterException extends Exception {
	public GraphiteExporterException(String msg, Exception e) {
		super(msg, e);
	}
	
	public GraphiteExporterException(String msg) {
		super(msg);
	}
}
