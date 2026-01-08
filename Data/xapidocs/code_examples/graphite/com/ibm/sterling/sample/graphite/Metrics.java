/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite;

import java.util.List;

import com.ibm.sterling.sample.graphite.category.Category;
import com.ibm.sterling.sample.graphite.category.CategoryIndex;

public class Metrics {
	String metricsname;
	Category cat;
	List<Digest<?>> digests;
	public Metrics(String statname, String metricsname) {
		this.metricsname = metricsname;
		this.cat = CategoryIndex.lookupCategory(statname);
		this.digests = cat.generateDigests();
	}
	public void process(Double d) {
		for (Digest<?> digest : digests) {
			digest.process(d);
		}
	}
	public String getMetricsname() {
		return metricsname;
	}
	public Category getCategory() {
		return cat;
	}
	public List<Digest<?>> getDigests() {
		return digests;
	}
}
