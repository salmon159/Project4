/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite.digests;

public class LastValue extends DataHolder<Double> {
	public LastValue() {
		super();
	}
	public String getPostfix() {
		return "value";
	}
	public void process(Double data) {
		this.data = data;
	}
	public void clear() {
		data = null; 
	}
}
