/*
 * IBM Confidential 
 *
 * OCO Source Materials
 *
 * IBM Sterling Selling and Fullfillment Suite
 *
 * (c) Copyright IBM Corp. 2001, 2013 All Rights Reserved.
 *
 * The source code for this program is not published or otherwise divested of its trade secrets,
 * irrespective of what has been deposited with the U.S. Copyright Office.
 */

package com.yantra.util;

import com.yantra.ycp.japi.util.*;

import javax.servlet.http.*;


public class SingleSignonManagerImpl implements YCPSSOManager {

    public String getUserData(HttpServletRequest req, HttpServletResponse res) throws Exception	{

		String userid = "admin";
        // get the user id from SSOManager System here
		return userid;
	}


}


