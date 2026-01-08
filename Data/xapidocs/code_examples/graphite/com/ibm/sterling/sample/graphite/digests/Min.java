/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite.digests;

public class Min extends DataHolder<Double> {
	public Min() {
		super();
		clear();
	}
	public void process(Double data) {
		if (this.data == null || this.data > data) 
			this.data = data;
	}
	public String getPostfix() {
		return "lower";
	}
	public void clear() {
		data = null;
	}
}
