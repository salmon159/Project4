/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite.category;

import java.util.List;

import com.ibm.sterling.sample.graphite.Digest;

public interface Category {
	public String getName();
	public List<Digest<?>> generateDigests();
	public String getPrefix();
}
