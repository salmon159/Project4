/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite.test;

import java.util.Date;

import com.yantra.yfc.statistics.interfaces.IStatisticObject;

class TestData implements IStatisticObject {
	String statName;

	double value;
	
	public TestData(String statName, double value) {
		super();
		this.statName = statName;
		this.value = value;
	}
	
	@Override
	public String getHostName() {
		return "localhost";
	}

	@Override
	public String getServerName() {
		return "svr1";
	}

	@Override
	public String getServerId() {
		return "svrid";
	}

	@Override
	public String getContextName() {
		throw new UnsupportedOperationException();
	}

	@Override
	public String getServiceName() {
		return "svc";
	}

	@Override
	public String getServiceType() {
		return "test";
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
