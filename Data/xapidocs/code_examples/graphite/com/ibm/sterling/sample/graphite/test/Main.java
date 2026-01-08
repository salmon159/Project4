/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite.test;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import com.ibm.sterling.sample.graphite.GraphiteClientConfigurationException;
import com.ibm.sterling.sample.graphite.StatisticalDataExporterForGraphite;
import com.yantra.yfc.statistics.interfaces.IStatisticObject;



public class Main {
	private static List<IStatisticObject> sampleStats = new ArrayList<IStatisticObject>() {{
		add(new TestData("Average",1.0));
		add(new TestData("ResponseTime",1.0));
		add(new TestData("AgentPendingJobsCollected",1.0));
		add(new TestData("AppServerStatsCollected",0.4));
		add(new TestData("AppServerStatsCollected",0.6));
		add(new TestData("ExecuteMessageCreated",2.0));
		add(new TestData("AgentPendingJobsCollected",4.0));
		add(new TestData("ExecuteMessageCreated",9.0));
		add(new TestData("ResponseTime",3.0));
		add(new TestData("Blah",5.0));
	}};
	
	public static void main(String[] args) throws GraphiteClientConfigurationException {
		System.out.println(new Date());
		StatisticalDataExporterForGraphite exporter = new StatisticalDataExporterForGraphite();
		exporter.consumeStatistics(Collections.unmodifiableCollection(sampleStats));
		System.out.println();
		System.out.println();
		List<Object> test = new ArrayList<>();
		for (int i = 1; i < 10000; i++) 
			test.add(new Object());
		exporter.consumeStatistics(Collections.unmodifiableCollection(sampleStats));
		System.out.println(test.getClass());
	}
}
