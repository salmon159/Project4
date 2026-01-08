/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite.digests;

public class Count extends DataHolder<Integer> {
	public Count() {
		super();
		clear();
	}
	public String getPostfix() {
		return "count";
	}
	public void process(Double data) {
		this.data++;
	}
	public void clear() {
		data = 0;
	}
}
