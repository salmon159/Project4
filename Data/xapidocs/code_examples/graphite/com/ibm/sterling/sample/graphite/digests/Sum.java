/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite.digests;

public class Sum extends DataHolder<Double> {
	public Sum() {
		super();
		clear();
	}
	public String getPostfix() {
		return "sum";
	}
	public void process(Double data) {
		this.data += data;
	}
	public void clear() {
		data = 0.0;
	}
}
