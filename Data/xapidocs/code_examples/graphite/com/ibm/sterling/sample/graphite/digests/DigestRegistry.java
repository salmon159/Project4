/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite.digests;

import java.util.HashMap;
import java.util.Map;

import com.ibm.sterling.sample.graphite.GraphiteClientConfigurationException;
import com.ibm.sterling.sample.graphite.Digest;

public class DigestRegistry {
	private static Map<String, Class<? extends Digest<?>>> digests = new HashMap<>();
	static {
		register("min", Min.class);
		register("max", Max.class);
		register("avg", Avg.class);
		register("count", Count.class);
		register("sum", Sum.class);
		register("lastval", LastValue.class);
	}
	private static void register(String name, Class<? extends Digest<?>> digestClass) {
		digests.put(name, digestClass);
	}
	public static Class<? extends Digest<?>> getDigestForName(String name) throws GraphiteClientConfigurationException {
		if (digests.containsKey(name)) {
			return digests.get(name);
		} else {
			throw new GraphiteClientConfigurationException("Unknown digest '" + name + "'. Available digests are: " + digests.keySet());
		}
	}
}
