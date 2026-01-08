/*******************************************************************************
IBM Confidential
IBM Sterling Selling and Fulfillment Suite
(C) Copyright IBM Corp. 2015, 2016 All Rights Reserved.
The source code for this program is not published or otherwise divested of its trade secrets, irrespective of what has been deposited with the U.S. Copyright Office.
**********************************************************************************/

package com.ibm.sterling.sample.graphite;
import java.util.Properties;

import com.ibm.sterling.sample.graphite.test.TestClient;

public class ClientFactory {
	static final Client getClient(Properties cfg) throws GraphiteClientConfigurationException {
		if (Boolean.parseBoolean(cfg.getProperty("test.mode", "false"))) {
			return new TestClient();
		} else {
			String host = cfg.getProperty("graphite.host");
			String port = cfg.getProperty("graphite.port");
			if (Utils.isVoid(host) || Utils.isVoid(port)) 
				throw new GraphiteClientConfigurationException("Host and port for graphite need to be specified");
			return new GraphiteClient(host.trim(), Integer.parseInt(port.trim()));
		}
	}
}
