/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite.jvm.stats;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import com.yantra.yfc.statistics.interfaces.IStatisticObject;

public class JVMStatisticsFactory {
	public static IJVMStatistics getJVMStatisticsImpl() {
		return new JVMStatisticsImpl();
	}
	
	public static Collection<? extends IStatisticObject> generateJVMStats(String hostName, String serverName, String serverId) {
		IJVMStatistics impl = getJVMStatisticsImpl();
		List<JVMStatisticData> data = new ArrayList<>();
		data.add(new JVMStatisticData(hostName, serverName, serverId, "UsedMemory", impl.getUsedMemory()));
		data.add(new JVMStatisticData(hostName, serverName, serverId, "TotalMemory", impl.getTotalMemory()));
		data.add(new JVMStatisticData(hostName, serverName, serverId, "GarbageCollectionCount", impl.getGCCount()));
		data.add(new JVMStatisticData(hostName, serverName, serverId, "GarbageCollectionTime", impl.getGCTime()));
		return data;
	}
}

class JVMStatisticData implements IStatisticObject {
	String hostName, serverName, serverId, statName;

	double value;
	
	public JVMStatisticData(String hostName, String serverName, String serverId, String statName, double value) {
		super();
		this.hostName = hostName;
		this.serverName = serverName;
		this.serverId = serverId;
		this.statName = statName;
		this.value = value;
	}
	
	@Override
	public String getHostName() {
		return hostName;
	}

	@Override
	public String getServerName() {
		return serverName;
	}

	@Override
	public String getServerId() {
		return serverId;
	}

	@Override
	public String getContextName() {
		throw new UnsupportedOperationException();
	}

	@Override
	public String getServiceName() {
		return "vmstat";
	}

	@Override
	public String getServiceType() {
		return "JVM";
	}

	@Override
	public String getStatName() {
		return statName;
	}

	@Override
	public double getStatValue() {
		return value;
	}

	@Override
	public Date getCreationTime() {
		throw new UnsupportedOperationException();
	}
	
}
