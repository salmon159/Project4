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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.w3c.dom.Document;

import com.yantra.interop.client.ClientVersionSupport;
import com.yantra.interop.japi.YIFClientFactory;
import com.yantra.shared.ypm.YPMLiterals;
import com.yantra.ycp.core.YCPContext;
import com.yantra.yfc.core.YFCObject;
import com.yantra.yfc.dom.YFCDocument;
import com.yantra.yfc.dom.YFCElement;
import com.yantra.yfc.dom.YFCNodeList;
import com.yantra.yfc.log.YFCLogCategory;
import com.yantra.yfc.util.YFCException;
import com.yantra.yfs.core.YFSObject;
import com.yantra.yfs.japi.YFSEnvironment;
import com.yantra.yfs.japi.YFSUserExitException;
import com.yantra.ypm.japi.ue.YPMGetItemPriceUE;

/**
 * @author mmnair
 *
 */
public class YPMGetItemPriceUEWCIntegrationImpl implements YPMGetItemPriceUE {
	
	private static YFCLogCategory cat = YFCLogCategory.instance(YPMGetItemPriceUEWCIntegrationImpl.class);

	/* (non-Javadoc)
	 * @see com.yantra.ypm.japi.ue.YPMGetItemPriceUE#getItemPrice(com.yantra.yfs.japi.YFSEnvironment, org.w3c.dom.Document)
	 */
	public Document getItemPrice(YFSEnvironment env, Document inXML) throws YFSUserExitException {		
		YFCDocument inDoc = YFCDocument.getDocumentFor(inXML);
		YFCElement rootElement = inDoc.getDocumentElement();
        ClientVersionSupport cvs = (ClientVersionSupport) env;
        HashMap<String, ?> props = cvs.getClientProperties();
        populateAttributes(env, props, rootElement);
		populateQuantityRangeRequestFlag((YCPContext)env, rootElement);
		
		String orgCode = rootElement.getAttribute(YPMLiterals.YPM_ORGANIZATION_CODE);
		// Use the Organization's PricingOrganization
		if(!YFCObject.isVoid(orgCode)){
			String pricingOrgCode = YPMGetOrderPriceUEWCIntegrationImpl.getPricingOrganization(env, orgCode);
			if(!YFCObject.isVoid(pricingOrgCode)){
				rootElement.setAttribute(YPMLiterals.YPM_ORGANIZATION_CODE, pricingOrgCode);
			}
		}

		if(cat.isDebugEnabled()){cat.debug("output from YPMGetItemPriceUEWCIntegrationImpl is: "+ rootElement);}
		return inDoc.getDocument();
	}

	private void populateAttributes(YFSEnvironment env, HashMap<String, ?> props, YFCElement rootElement) {
		populateAttribute(env, props, rootElement, BUYER_USER_ID);
		populateAttribute(env, props, rootElement, CUSTOMER_CONTACT_ID);
		List<String> attributeNames = getAttributeNamesFromCommonCode(env);		
		for(String attrName : attributeNames){
			populateAttribute(env, props, rootElement, attrName);
		}
	}

	private List<String> getAttributeNamesFromCommonCode(YFSEnvironment env) {
		List<String> attrNames = new ArrayList<String>();
		YFCDocument inDoc = createGetCommonCodeListInput();
		Document outXML = null;		
		try{
			outXML = YIFClientFactory.getInstance().getLocalApi().invoke(env, GET_COMMON_CODE_LIST, inDoc.getDocument());
		}catch(Exception e){
			throw new YFCException(e);
		}
		if(YFCObject.isVoid(outXML)){
			return attrNames;
		}
		YFCDocument outDoc = YFCDocument.getDocumentFor(outXML);
		YFCNodeList<YFCElement> commonCodeList = outDoc.getDocumentElement().getElementsByTagName(COMMON_CODE);
		for(YFCElement commonCode : commonCodeList){
			attrNames.add(commonCode.getAttribute(CODE_VALUE));
		}	
		return attrNames;
	}

	private void populateAttribute(YFSEnvironment env, HashMap<String, ?> props, YFCElement rootElement, String attributeName) {
		String attributeValue = rootElement.getAttribute(attributeName);
		if(YFCObject.isVoid(attributeValue)){
			attributeValue = (String)env.getTxnObject(attributeName);
			if(!YFCObject.isVoid(attributeValue)){
				rootElement.setAttribute(attributeName, attributeValue);
			}else if (!YFCObject.isVoid(props)){
				attributeValue = (String)props.get(attributeName);
				if(!YFCObject.isVoid(attributeValue)){
					rootElement.setAttribute(attributeName, attributeValue);
				}
			}
		}		
	}

	private void populateQuantityRangeRequestFlag(YCPContext ctx, YFCElement rootElement) {		
        boolean isQuantityTierRequested = false;
		YFCDocument templateDoc = null;
		Object obj = ctx.getApiTemplate("getItemPrice");
		if(!YFCObject.isVoid(obj)){
			templateDoc = YFCDocument.getDocumentFor((Document) obj);
			if(!YFSObject.isEmpty(templateDoc.getElementsByTagName("PricelistLineQuantityTierList"))){
				isQuantityTierRequested = true;
			}
		}else{
			obj = ctx.getApiTemplate("getItemListForOrdering");
			if(!YFCObject.isVoid(obj)){
				templateDoc = YFCDocument.getDocumentFor((Document) obj);
				if(!YFSObject.isEmpty(templateDoc.getElementsByTagName("QuantityRangePriceList"))){
					isQuantityTierRequested = true;
				}
			}
		}
		rootElement.setAttribute("IsQuantityTierRequested", isQuantityTierRequested);		
	}
	
	private YFCDocument createGetCommonCodeListInput() {
		YFCDocument inputDoc = YFCDocument.createDocument(COMMON_CODE);
		YFCElement apiElement = inputDoc.getDocumentElement();
		apiElement.setAttribute(CODE_TYPE, WC_INTG_ATTR);
		apiElement.setAttribute(ORG_CODE, DEFAULT_ORG);
		apiElement.setAttribute(CALLING_ORG_CODE, DEFAULT_ORG);
		return inputDoc;
	}
	
	private static String COMMON_CODE = "CommmonCode";
	private static String CODE_TYPE = "CodeType";
	private static String CODE_VALUE = "CodeValue";
	private static String WC_INTG_ATTR = "WC_INTG_ATTR";
	private static String ORG_CODE = "OrganizationCode";
	private static String CALLING_ORG_CODE = "CallingOrganizationCode";
	private static String DEFAULT_ORG="DEFAULT";
	private static String GET_COMMON_CODE_LIST = "getCommonCodeList";
	private static final String CUSTOMER_CONTACT_ID="CustomerContactID";
	private static final String BUYER_USER_ID="BuyerUserId";
	
}
