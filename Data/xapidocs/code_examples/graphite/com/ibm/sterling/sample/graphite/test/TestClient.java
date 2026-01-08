/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite.test;

import com.ibm.sterling.sample.graphite.Client;

public class TestClient implements Client {
	public void write(String payload) throws Exception {
		System.out.print("[test] " + payload);
	}
	public void init() throws Exception {
		System.out.println("[test init])");
	}
	public void flush() throws Exception {
		System.out.println("[test flush]");
	}
	public void close() throws Exception {
		System.out.println("[test close]");
	}
}
