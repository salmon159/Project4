/* ******************************************************************************
IBM Confidential
OCO Source Materials
IBM Sterling Selling and Fulfillment Suite
(C) Copyright IBM Corp. 2005, 2016
The source code for this program is not published or otherwise divested of its trade secrets, irrespective of what has been deposited with the U.S. Copyright Office.
**********************************************************************************/
/**
 * 
 */
package com.yantra.ypm.business.ue.impl;

import java.util.HashMap;

import org.w3c.dom.Document;

import com.yantra.interop.client.ClientVersionSupport;
import com.yantra.shared.ypm.YPMLiterals;
import com.yantra.yfc.core.YFCObject;
import com.yantra.yfc.dom.YFCDocument;
import com.yantra.yfc.dom.YFCElement;
import com.yantra.yfc.log.YFCLogCategory;
import com.yantra.yfs.japi.YFSEnvironment;
import com.yantra.yfs.japi.YFSUserExitException;
import com.yantra.ypm.japi.ue.YPMValidateCouponUE;

/**
 * @author mmnair
 *
 */
public class YPMValidateCouponUEWCIntegrationImpl implements YPMValidateCouponUE {

	/* (non-Javadoc)
	 * @see com.yantra.ypm.japi.ue.YPMValidateCouponUE#validateCoupon(com.yantra.yfs.japi.YFSEnvironment, org.w3c.dom.Document)
	 */
	
	private static YFCLogCategory cat = YFCLogCategory.instance(YPMValidateCouponUEWCIntegrationImpl.class);
	public Document validateCoupon(YFSEnvironment env, Document inXML) throws YFSUserExitException {
		YFCDocument inputDoc = YFCDocument.getDocumentFor(inXML);
		YFCElement rootElement = inputDoc.getDocumentElement();		
		String buyerUserId = rootElement.getAttribute(YPMLiterals.YPM_BUYER_USER_ID);
		String customerContactId = rootElement.getAttribute(YPMLiterals.YPM_CUSTOMER_CONTACT_ID);
		String orgCode = rootElement.getAttribute(YPMLiterals.YPM_ORGANIZATION_CODE);
		ClientVersionSupport ctx = (ClientVersionSupport) env;
        HashMap props = ctx.getClientProperties();
		if(YFCObject.isVoid(buyerUserId)){
			buyerUserId = (String)env.getTxnObject(YPMLiterals.YPM_BUYER_USER_ID);
			if(!YFCObject.isVoid(buyerUserId)){
				rootElement.setAttribute(YPMLiterals.YPM_BUYER_USER_ID, buyerUserId);
			}else if (!YFCObject.isVoid(props)){
				buyerUserId = (String)props.get(YPMLiterals.YPM_BUYER_USER_ID);
			}
		}
		if(YFCObject.isVoid(customerContactId)){
			customerContactId = (String)env.getTxnObject(YPMLiterals.YPM_CUSTOMER_CONTACT_ID);
			if(!YFCObject.isVoid(customerContactId)){
				rootElement.setAttribute(YPMLiterals.YPM_CUSTOMER_CONTACT_ID, customerContactId);
			}else if (!YFCObject.isVoid(props)){
				customerContactId = (String)props.get(YPMLiterals.YPM_CUSTOMER_CONTACT_ID);
			}
		}
		// Use the Organization's PricingOrganization
		if(!YFCObject.isVoid(orgCode)){
			String pricingOrgCode = YPMGetOrderPriceUEWCIntegrationImpl.getPricingOrganization(env, orgCode);
			if(!YFCObject.isVoid(pricingOrgCode)){
				rootElement.setAttribute(YPMLiterals.YPM_ORGANIZATION_CODE, pricingOrgCode);
			}
		}
		if(cat.isDebugEnabled()){cat.debug("output from validateCoupon UE: "+rootElement);}
		return inputDoc.getDocument();
	}
}
