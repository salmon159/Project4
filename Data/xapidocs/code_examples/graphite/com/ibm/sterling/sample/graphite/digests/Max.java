/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite.digests;

public class Max extends DataHolder<Double> {
	public  Max() {
		super();
		clear();
	}
	public String getPostfix() {
		return "upper";
	}
	public void process(Double data) {
		if (this.data == null || this.data < data) 
			this.data = data;
	}
	public void clear() {
		data = null;
	}
}
