/*******************************************************************************
IBM Confidential
IBM Sterling Selling and Fulfillment Suite
(C) Copyright IBM Corp. 2015, 2016 All Rights Reserved.
The source code for this program is not published or otherwise divested of its trade secrets, irrespective of what has been deposited with the U.S. Copyright Office.
**********************************************************************************/

package com.ibm.sterling.sample.graphite;

import static com.ibm.sterling.sample.graphite.Utils.formatDotsToDashes;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.ibm.sterling.sample.graphite.jvm.stats.JVMStatisticsFactory;
import com.yantra.yfc.statistics.interfaces.IStatisticObject;
import com.yantra.yfc.statistics.interfaces.PLTStatisticsConsumer;

public class StatisticalDataExporterForGraphite implements PLTStatisticsConsumer {
	private static final String linesep = "\n";
	
	ExporterConfig conf;
	Client client;
	String commonPrefix;
	
	public StatisticalDataExporterForGraphite() throws GraphiteClientConfigurationException {
		conf = ExporterConfig.getInstance();
		client = conf.getClient();
		commonPrefix = conf.getCommonPrefix();
	}

	@Override
	public void consumeStatistics(Collection<IStatisticObject> stats) {
		Logger.verbose("Starting client run at " + new Date().toString());
			if (stats.size() == 0) 
				return; // No data to work with
		try {	
			// Copy the unmodifiable collection to a modifiable one
			Collection<IStatisticObject> statCol = new ArrayList<>(stats);
	
			/*
			 *  Host identifiers are expected to remain the same for all IStatisticObjects. 
			 *  We'll use the value provided in the first such object and use it for all
			 *  as well as for JVM stats.
			 */
			String hostName, serverName, serverId;
			IStatisticObject first = statCol.iterator().next();
	
			hostName = formatDotsToDashes(first.getHostName());
			serverName = formatDotsToDashes(first.getServerName());
			serverId = formatDotsToDashes(first.getServerId());
			
			// Obtain JVM statistical data.
			statCol.addAll(JVMStatisticsFactory.generateJVMStats(hostName, serverName, serverId));
			
			for ( IStatisticObject statObj : statCol ) {
				String service = statObj.getServiceName();
				String type = statObj.getServiceType();
				String statname = statObj.getStatName();
				String metrics = hostName + "." + serverName + "." + serverId + "." + type + "." + service + "." + statname;
				
				Logger.verbose("Processing metrics: " + metrics);
				
				double value = statObj.getStatValue();
				
				Metrics m = getMetrics(statname, metrics);
				m.process(value);
			}
			
			try {
				writeToGraphite();
			} catch (Exception e) {
				Logger.error("Got the following exception while consuming statistics", e);
			} finally {
				metricsMap.clear();
				Logger.verbose("Finished writing to graphite at " + new Date().toString());
			}
		} finally {
			Logger.verbose("Ending client run at " + new Date().toString());
		}
	}

	private void writeToGraphite() throws Exception {
		long time = System.currentTimeMillis()/1000;
		client.init();
		try {
			for (Metrics m : metricsMap.values()) {
				String catprefix = m.getCategory().getPrefix();
				for (Digest<?> d : m.getDigests()) {
					String data = d.getData().toString();
					String digestPostfix = d.getPostfix();
					String payload = new StringBuilder(commonPrefix).								// initiate with the common prefix
							append(catprefix).append(m.getMetricsname()).append(".").append(digestPostfix).		// merge word units to build the metrics name
							append(" ").
							append(data). 
							append(" ").
							append(time).
							append(linesep).toString();
					client.write(payload);
				}
			}
		} finally {
			client.close();
		}
	}

	Map<String, Metrics> metricsMap = new HashMap<>();
	private Metrics getMetrics(String statname, String metricsname) {
		if (!metricsMap.containsKey(metricsname)) {
			metricsMap.put(metricsname, new Metrics(statname, metricsname));
		} 
		return metricsMap.get(metricsname);
	}
}
