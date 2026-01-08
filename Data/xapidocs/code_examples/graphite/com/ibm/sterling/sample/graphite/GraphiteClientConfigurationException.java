/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite;

public class GraphiteClientConfigurationException extends Exception {
	private static final long serialVersionUID = 4755606704266776991L;
	public GraphiteClientConfigurationException(String msg, Exception e) {
		super(msg, e);
	}
	public GraphiteClientConfigurationException(String msg) {
		super (msg);
	}
}
