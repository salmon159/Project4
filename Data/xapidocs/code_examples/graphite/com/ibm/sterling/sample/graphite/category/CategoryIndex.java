/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite.category;

import java.util.HashMap;
import java.util.Map;

public class CategoryIndex {
	static Map<String, AbstractCategory> registry = new HashMap<>();
	static AbstractCategory def; 
	
	static void registerDefaultCategory(AbstractCategory cat) {
		def = cat;
	}
	static void register(String statname, AbstractCategory metricsCategory) {
		registry.put(statname, metricsCategory);
	}
	
	public static AbstractCategory lookupCategory(String statname) {
		if (registry.containsKey(statname)) return registry.get(statname);
		else return def;
	}
}
