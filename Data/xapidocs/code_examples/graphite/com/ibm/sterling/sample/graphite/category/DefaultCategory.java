/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite.category;

import com.ibm.sterling.sample.graphite.GraphiteClientConfigurationException;

public class DefaultCategory extends AbstractCategory{
	public DefaultCategory(String digests, String prefix) throws GraphiteClientConfigurationException {
		super("default", digests, prefix);
		CategoryIndex.registerDefaultCategory(this);
	}

	public static void createAndRegister(String digests, String prefix) throws GraphiteClientConfigurationException {
		new DefaultCategory(digests, prefix);
	}
}
