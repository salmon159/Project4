/*******************************************************************************
IBM Confidential
IBM Sterling Selling and Fulfillment Suite
(C) Copyright IBM Corp. 2015, 2016 All Rights Reserved.
The source code for this program is not published or otherwise divested of its trade secrets, irrespective of what has been deposited with the U.S. Copyright Office.
**********************************************************************************/
package com.ibm.sterling.sample.graphite;

public interface Client {
	void init() throws Exception;
	void write(String payload) throws Exception;
	void flush() throws Exception;
	void close() throws Exception;
}
