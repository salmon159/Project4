/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite.category;

import com.ibm.sterling.sample.graphite.GraphiteClientConfigurationException;
import com.ibm.sterling.sample.graphite.Logger;
import com.ibm.sterling.sample.graphite.Utils;

public class CustomCategory extends AbstractCategory{
	String statNames;
	String prefix;
	public CustomCategory(String name, String statNames, String digests, String prefix) throws GraphiteClientConfigurationException {
		super(name, digests, prefix);
		if (Utils.isVoid(statNames)) 
			throw new GraphiteClientConfigurationException("'statnames' for the category '" + name + "' needs to be specified");
		this.statNames = statNames;
		processStatNames();
	}
	
	/*
	 * Create a reverse look up (aka index) of statistic names -> category
	 */
	private void processStatNames() {
		for (String statName : statNames.split(",")) {
			statName = statName.trim();
			if (Utils.isVoid(statName)) {
				Logger.warn("Skipping blank stat-name while processing category " + name);
				continue;
			} else {
				CategoryIndex.register(statName, this);
			}
		}
	}
	
	public static void createAndRegister(String name, String statNames, String digests, String prefix) throws GraphiteClientConfigurationException {
		new CustomCategory(name, statNames, digests, prefix);
	}
}
