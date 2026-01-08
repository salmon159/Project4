/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite.digests;

import com.ibm.sterling.sample.graphite.Digest;

public abstract class DataHolder<T> implements Digest<T> {
	protected T data = null;
	public T getData() {
		return data;
	}
}
