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
import java.util.Map;

import org.w3c.dom.Document;

import com.yantra.interop.client.ClientVersionSupport;
import com.yantra.interop.japi.YIFClientFactory;
import com.yantra.shared.dbi.YFS_Charge_Name;
import com.yantra.shared.dbi.YFS_Line_Charges;
import com.yantra.shared.dbi.YFS_Order_Header;
import com.yantra.shared.dbi.YFS_Order_Line;
import com.yantra.shared.dbi.YFS_Payment;
import com.yantra.shared.dbi.YFS_Promotion_Award;
import com.yantra.shared.omp.OMPFactory;
import com.yantra.shared.ycp.YFSContext;
import com.yantra.shared.ypm.YPMLiterals;
import com.yantra.shared.ypm.YPMUserExitConsts;
import com.yantra.shared.ysc.YSCFactory;
import com.yantra.ycp.business.cache.YSCRuleCacheManager;
import com.yantra.ycp.core.YCPTemplateManager;
import com.yantra.yfc.core.YFCObject;
import com.yantra.yfc.dom.YFCDocument;
import com.yantra.yfc.dom.YFCElement;
import com.yantra.yfc.log.YFCLogCategory;
import com.yantra.yfc.util.YFCException;
import com.yantra.yfs.japi.YFSEnvironment;
import com.yantra.yfs.japi.YFSUserExitException;
import com.yantra.yfs.util.YFSRulesDefn;
import com.yantra.ypm.japi.ue.YPMGetOrderPriceUE;

/**
 * @author mmnair
 *
 */
public class YPMGetOrderPriceUEWCIntegrationImpl implements YPMGetOrderPriceUE {
	
	private static YFCLogCategory cat = YFCLogCategory.instance(YPMGetOrderPriceUEWCIntegrationImpl.class);
	private static HashMap<String, YFS_Charge_Name> chargeNameMap= new HashMap<String, YFS_Charge_Name>(); 

	/* (non-Javadoc)
	 * @see com.yantra.ypm.japi.ue.YPMGetOrderPriceUE#getOrderPrice(com.yantra.yfs.japi.YFSEnvironment, org.w3c.dom.Document)
	 */
	public Document getOrderPrice(YFSEnvironment env, Document inXML) throws YFSUserExitException {
		YFCDocument inputDoc = YFCDocument.getDocumentFor(inXML);
		YFCElement rootElement = inputDoc.getDocumentElement();
		YFSContext oCtx = (YFSContext)env;		
		String orderHeaderKey = rootElement.getAttribute(YPMLiterals.YPM_ORDER_REFERENCE);
		String orgCode = rootElement.getAttribute(YPMLiterals.YPM_ORGANIZATION_CODE);
		
		populateBuyerCustomerFromEnvironment(env, rootElement);
		if(!YFCObject.isVoid(orderHeaderKey)){
			YFS_Order_Header order = OMPFactory.getCache(oCtx).getOrderHeader(oCtx, orderHeaderKey, "", "", "", "");
			if(!YFCObject.isVoid(order)){				
				rootElement.setAttribute(YFS_Order_Header.ORDER_NO, order.getOrder_No());
				rootElement.setAttribute(YFS_Order_Header.DOCUMENT_TYPE, order.getDocument_Type());				
				YFCDocument templateDoc = YCPTemplateManager.getInstance().getUserExitTemplate(oCtx, YPMUserExitConsts.YPM_GET_ORDER_PRICE_UE);
				YFCElement templateElement = templateDoc.getDocumentElement(); 				
				appendPaymentMethod(order, templateElement, inputDoc, rootElement);				
				populateLineAttributes(oCtx, order, templateElement, inputDoc); 
			}
		}
		// Use the Organization's PricingOrganization
		if(!YFCObject.isVoid(orgCode)){
			String pricingOrgCode = getPricingOrganization(env, orgCode);
			if(!YFCObject.isVoid(pricingOrgCode)){
				rootElement.setAttribute(YPMLiterals.YPM_ORGANIZATION_CODE, pricingOrgCode);
			}
		}		
		if(cat.isDebugEnabled()){cat.debug("output from YPMGetOrderPriceUEWCIntegrationImpl getOrderPrice is: "+ rootElement);}
		return inputDoc.getDocument();
	}

	/*
	 * populates BuyerUserId and CustomerContactId from YFSEnvironment object if not passed in input. 
	 */
	private void populateBuyerCustomerFromEnvironment(YFSEnvironment env, YFCElement rootElement) {
		String buyerUserId = rootElement.getAttribute(YPMLiterals.YPM_BUYER_USER_ID);
		String customerContactId = rootElement.getAttribute(YPMLiterals.YPM_CUSTOMER_CONTACT_ID);
		ClientVersionSupport ctx = (ClientVersionSupport) env;
        HashMap props = ctx.getClientProperties();
		if(YFCObject.isVoid(buyerUserId)){
			buyerUserId = (String)env.getTxnObject(YPMLiterals.YPM_BUYER_USER_ID);
			if(YFCObject.isVoid(buyerUserId) && !YFCObject.isVoid(props)){
				buyerUserId = (String)props.get(YPMLiterals.YPM_BUYER_USER_ID);
			}
			rootElement.setAttribute(YPMLiterals.YPM_BUYER_USER_ID, buyerUserId);
		}
		if(YFCObject.isVoid(customerContactId)){
			customerContactId = (String)env.getTxnObject(YPMLiterals.YPM_CUSTOMER_CONTACT_ID);
			if(YFCObject.isVoid(customerContactId) && !YFCObject.isVoid(props)){
				customerContactId = (String)props.get(YPMLiterals.YPM_CUSTOMER_CONTACT_ID);
			}
			rootElement.setAttribute(YPMLiterals.YPM_CUSTOMER_CONTACT_ID, customerContactId);
		}	
	}

	/*
	 * set Awards applied to each Line. WC looks at certain award types to determine whether line is a free line.
	 * set ParentLineID to each components Line.
	 * set exisitng UnitPrice on each Line.
	 * set lineIds against Item,Quantity. This will be used to map certain lines in response which does not have LineID set.
	 * populates Shipping Element for each Line. 
	 */
	private void populateLineAttributes(YFSContext oCtx, YFS_Order_Header order, YFCElement templateElement, YFCDocument inputDoc) {
		Map<String, List<YFCElement>> lineAwardMap = new HashMap<String, List<YFCElement>>();
		YFCElement rootElement = inputDoc.getDocumentElement();		
		HashMap<String, ArrayList<String>> itemQtyLineIDMap = new HashMap<String, ArrayList<String>>();
		populateLineAwardMap(order, templateElement, inputDoc, lineAwardMap);
		YFCElement orderLineListElement = rootElement.getChildElement(YPMLiterals.YPM_ORDER_LINE_LIST, true);
		String shippingChargeName = YSCRuleCacheManager.getInstance().getRuleValue(oCtx, order.getRuleMap(), " ", YFSRulesDefn.RSFN_SHIPPING_CHARGE);
		for(YFCElement orderLineElement : orderLineListElement.getElementsByTagName(YPMLiterals.YPM_ORDER_LINE)){
			String lineID = orderLineElement.getAttribute(YPMLiterals.YPM_LINE_ID);
			YFCElement orderLineAwardListElement  = orderLineElement.getChildElement("Awards", true);
			if(!YFCObject.isVoid(lineID)){
				List<YFCElement> lineAwardList = lineAwardMap.get(lineID);
				if(!YFCObject.isVoid(lineAwardList)){					
					for(YFCElement orderLineAwardElement : lineAwardList){
						orderLineAwardListElement.appendChild(orderLineAwardElement);
					}				
				}
			}
			YFS_Order_Line orderLine = order.getOrderLine(oCtx, lineID, 0, 0);
			if(!YFCObject.isVoid(orderLine)){
				orderLineElement.setAttribute("ParentLineID", orderLine.getBundle_Parent_Order_Line_Key());	
				orderLineElement.setAttribute(YPMLiterals.YPM_UNIT_PRICE, orderLine.getUnit_Price());
			}
			addLineAttributesToLineIDMap(orderLineElement, itemQtyLineIDMap);
			if(!YFCObject.isVoid(shippingChargeName)){
				loadLineShippingCharge(oCtx, orderLineElement, orderLine, shippingChargeName, rootElement.getChildElement(YPMLiterals.YPM_SHIPPING_ELEM));
			}
		}
		oCtx.setTxnObject(GETORDERPRICE_INPUT, itemQtyLineIDMap);
	}
	
	/*
	 * populates a map with orderlinekey as key and awardlist as value. 
	 * Caller method will use this map to iterate over order lines and populate Awards Element under each line  
	 */
	private void populateLineAwardMap(YFS_Order_Header order, YFCElement templateElement,YFCDocument inputDoc, Map<String, List<YFCElement>> lineAwardMap) {
		YFCElement rootElement = inputDoc.getDocumentElement();		
		List<YFS_Promotion_Award> awardList = order.getAllAwardList();
		YFCElement orderAwardTemplate = null, orderLineAwardTemplate = null;
		orderAwardTemplate = getOrderAwardTemplate(templateElement);
		orderLineAwardTemplate = getOrderLineAwardTemplate(templateElement);		
		YFCElement orderAwardListElement = rootElement.getChildElement("Awards", true);
		for(YFS_Promotion_Award award : awardList){
			if(!YFCObject.isVoid(award.getOrder_Line_Key())){
				YFCElement orderLineAwardElement = award.getXML(inputDoc, orderLineAwardTemplate);
				List<YFCElement> lineAwardList = lineAwardMap.get(award.getOrder_Line_Key());
				if(YFCObject.isNull(lineAwardList)){
					lineAwardList = new ArrayList<YFCElement>();
					lineAwardMap.put(award.getOrder_Line_Key(), lineAwardList);
				}
				lineAwardList.add(orderLineAwardElement);
			}else{
				YFCElement orderAwardElement = award.getXML(inputDoc, orderAwardTemplate);
				orderAwardListElement.appendChild(orderAwardElement);
			}
		}
	}

	/*
	 * get template for Award element at order level 
	 */
	private YFCElement getOrderAwardTemplate(YFCElement templateElement) {
		YFCElement orderAwardTemplate = null;
		YFCElement orderAwardListTemplateElement = templateElement.getChildElement("Awards");		
		if(!YFCObject.isVoid(orderAwardListTemplateElement)){
			orderAwardTemplate =  orderAwardListTemplateElement.getChildElement("Award");			
		}
		return orderAwardTemplate;
	}
	
	/*
	 * get template for Award element at order line level 
	 */
	private YFCElement getOrderLineAwardTemplate(YFCElement templateElement){
		YFCElement orderLineAwardTemplate = null;
		YFCElement orderLineListTemplateElement = templateElement.getChildElement(YPMLiterals.YPM_ORDER_LINE_LIST);
		if(!YFCObject.isVoid(orderLineListTemplateElement)){
			YFCElement orderLineTemplateElement = orderLineListTemplateElement.getChildElement(YPMLiterals.YPM_ORDER_LINE);
			if(!YFCObject.isVoid(orderLineTemplateElement)){
				YFCElement orderLineTemplateAwardListElement = orderLineTemplateElement.getChildElement("Awards");
				if(!YFCObject.isVoid(orderLineTemplateAwardListElement)){
					orderLineAwardTemplate = orderLineTemplateAwardListElement.getChildElement("Award");
				}
			}
		}
		return orderLineAwardTemplate;
	}
	
	/*
	 * populate Shipping Element at Line Level 
	 */
	private void loadLineShippingCharge(YFSContext oCtx, YFCElement orderLineElement, YFS_Order_Line orderLine, String shippingChargeName, YFCElement orderShippingElement) {
		cat.beginTimer("loadLineShippingCharge");
		double dShippingCharge = 0;
		if(cat.isDebugEnabled()){
			cat.debug("line charges size: "+orderLine.getCharges(oCtx, false).size());
		}
		for (Object o : orderLine.getCharges(oCtx, false)) {			
			YFS_Line_Charges oCharge = (YFS_Line_Charges)o;
			if(cat.isDebugEnabled()){
				cat.debug("Line charge details Charge_Category|Charge_Name|Charge_Amount|ChargePerLine|PerUnit: "+oCharge.getCharge_Category()+"|"
						+oCharge.getCharge_Name()+"|"+oCharge.getChargeAmount()+"|"+oCharge.getChargeperline()+"|"+oCharge.getChargeperunit());
			}
			YFS_Charge_Name oChargeName = null;
			String chargeNameMapKey =  oCharge.getCharge_Category()+"|"+oCharge.getCharge_Name()+"|"
			+oCharge.getOrderHeader().getDocument_Type()+"|"+oCharge.getOrderHeader().getEnterprise_Code();
			if(chargeNameMap.containsKey(chargeNameMapKey)){
				oChargeName = chargeNameMap.get(chargeNameMapKey);
			}else{				
			    oChargeName = YSCFactory.getInstance().getChargeName(
			            oCtx, 
	                    oCharge.getCharge_Category(), 
	                    oCharge.getCharge_Name(),
	                    oCharge.getOrderHeader().getDocument_Type(), 
	                    oCharge.getOrderHeader().getEnterprise_Code()        
			    );
				chargeNameMap.put(chargeNameMapKey, oChargeName);
			}
			if(YFCObject.isVoid(oChargeName)){
				continue;
			}
			if(cat.isDebugEnabled()){
				cat.debug("Line charge details isDiscount|shippingChargeNameKey|current ChargeNameKey: "+oCharge.isDiscount()+"|"+shippingChargeName+"|"+oChargeName.getCharge_Name_Key()+"|");
				cat.debug("Line charge details equals: "+YFCObject.equals(shippingChargeName, oChargeName.getCharge_Name_Key()));
			}
			if (YFCObject.equals(shippingChargeName, oChargeName.getCharge_Name_Key())) {
				if (oCharge.isDiscount()) {
					if(oCharge.getChargeperline() > 0){
						dShippingCharge += new Double(-oCharge.getChargeperline());
					}else{
						dShippingCharge += new Double(-oCharge.getChargeperunit() * orderLine.getOrdered_Qty());
					}					
				} else {					
					if(oCharge.getChargeperline() > 0){
						dShippingCharge += new Double(oCharge.getChargeperline());
					}else{
						dShippingCharge += new Double(oCharge.getChargeperunit() * orderLine.getOrdered_Qty());
					}
				}
			}
		}		
		YFCElement shippingElement = orderLineElement.getChildElement(YPMLiterals.YPM_SHIPPING_ELEM, true);
		if(!YFCObject.isVoid(orderShippingElement)){
			shippingElement.setAttributes(orderShippingElement.getAttributes());
		}		
		shippingElement.setDoubleAttribute(YPMLiterals.YPM_SHIPPING_CHARGE, dShippingCharge);
		cat.endTimer("loadLineShippingCharge");
	}

	/*
	 * populate a map with item,uom,quantity, IsPriceLocked as key and list of lines as value.
	 * when response comes from WC this map will be used to populate LineID on lines which does not have LineID populated
	 */
	private void addLineAttributesToLineIDMap(YFCElement orderLineElement, HashMap<String, ArrayList<String>> itemQtyLineIDMap) {
		if(orderLineElement.getDoubleAttribute(YPMLiterals.YPM_QUANTITY) == 0){
			if(cat.isVerboseEnabled()){
				if(cat.isVerboseEnabled()){cat.verbose("Quantity is 0. should be a canceled line: "+orderLineElement);}				
			}
			return;
		}
		String lineID = orderLineElement.getAttribute(YPMLiterals.YPM_LINE_ID);
		String itemQtyKey = orderLineElement.getAttribute(YPMLiterals.YPM_ITEM_ID)+"|"+orderLineElement.getAttribute(YPMLiterals.YPM_UNIT_OF_MEASURE)
								+"|"+orderLineElement.getDoubleAttribute(YPMLiterals.YPM_QUANTITY)+"|"+orderLineElement.getAttribute(YPMLiterals.YPM_IS_PRICE_LOCKED);		
		ArrayList<String> lineIDListWithQty = itemQtyLineIDMap.get(itemQtyKey);		
		if(YFCObject.isVoid(lineIDListWithQty)){
			lineIDListWithQty = new ArrayList<String>();
			itemQtyLineIDMap.put(itemQtyKey, lineIDListWithQty);
		}		
		lineIDListWithQty.add(lineID);				
	}

	/*
	 * append PaymentMethod element to Root element.
	 * Payment Element will be added only if the order has single payment method.
	 */
	private void appendPaymentMethod(YFS_Order_Header order, YFCElement templateElement, YFCDocument inputDoc, YFCElement rootElement) {
		if(order.getPaymentMethodList().size() == 1){
			YFS_Payment payment = (YFS_Payment)order.getPaymentMethodList().get(0);
			YFCElement paymentTemplateElement =  templateElement.getChildElement("PaymentMethod");
			if(!YFCObject.isVoid(paymentTemplateElement)){
				YFCElement paymentElement = payment.getXML(inputDoc, paymentTemplateElement, "PaymentMethod");
				rootElement.appendChild(paymentElement);						
			}			
		}		
	}
	
	
	/*
	 * Obtain OrganizationHierarchy to find PricingOrganization
	 */
	static String getPricingOrganization(YFSEnvironment env, String org) {
		YFCDocument inDoc = createInputForGetOrganizationHierarchy(org);
		YFCDocument templateDoc = createTemplateForGetOrganizationHierarchy();
		Document currTemplate = (Document) env.getApiTemplate(API_GET_ORGHIERARCHY);
		Document outXML = null;		
		try{
			env.setApiTemplate(API_GET_ORGHIERARCHY, templateDoc.getDocument());
			outXML = YIFClientFactory.getInstance().getLocalApi().invoke(env, API_GET_ORGHIERARCHY, inDoc.getDocument());
		}catch(Exception e){
			throw new YFCException(e);
		}finally{
			env.setApiTemplate(API_GET_ORGHIERARCHY, currTemplate);
		}
		if(YFCObject.isVoid(outXML)){
			return org;
		}
		YFCDocument outDoc = YFCDocument.getDocumentFor(outXML);
		return outDoc.getDocumentElement().getAttribute(PRICING_ORG);
	}

	private static String API_GET_ORGHIERARCHY = "getOrganizationHierarchy";
	private static String ORGANIZATION = "Organization";
	private static String ORG_CODE = "OrganizationCode";
	private static String ORG_KEY = "OrganizationKey";
	private static String PRICING_ORG = "PricingOrganizationCode";	
	private static String GETORDERPRICE_INPUT = "getOrderPriceInput";	
	
	private static YFCDocument createInputForGetOrganizationHierarchy(String org) {
		YFCDocument inputDoc = YFCDocument.createDocument(ORGANIZATION);
		YFCElement apiElement = inputDoc.getDocumentElement();
		apiElement.setAttribute(ORG_CODE, org);
		return inputDoc;
	}
	
	private static YFCDocument createTemplateForGetOrganizationHierarchy() {
		YFCDocument inputDoc = YFCDocument.createDocument(ORGANIZATION);
		YFCElement apiElement = inputDoc.getDocumentElement();
		apiElement.setAttribute(ORG_CODE, "");
		apiElement.setAttribute(ORG_KEY, "");
		apiElement.setAttribute(PRICING_ORG, "");
		return inputDoc;
	}

}
