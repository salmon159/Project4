/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite.digests;

public class Avg extends DataHolder<Double> {
	double sum;
	int count;
	public Avg() {
		super();
		clear();
	}
	public String getPostfix() {
		return "avg";
	}
	public void process(Double data) {
		count++;
		sum += data;
		this.data = sum/count;
	}
	public void clear() {
		sum = 0.0;
		count = 0;
		data = 0.0;
	}
}
