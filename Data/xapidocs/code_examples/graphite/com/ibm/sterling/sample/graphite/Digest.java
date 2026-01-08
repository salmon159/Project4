/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite;

public interface Digest<T> {
	String getPostfix();
	void process(Double data);
	T getData();
	void clear();
}
