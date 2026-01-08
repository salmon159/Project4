package com.titan.sterling.oms.jpmc;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import com.cts.sterling.custom.accelerators.util.XMLUtil;
import com.titan.sterling.util.XmlConstants;
import com.yantra.yfc.log.YFCLogCategory;
import com.yantra.yfs.japi.YFSEnvironment;
public class TitanPaymentCaptureJPMC {
  private static YFCLogCategory logger = YFCLogCategory.instance(TitanPaymentCaptureJPMC.class); /**     * Initiate the logger class     */ /**     *      * @param inXML     * @return      * @return     * @throws Exception     */
  public Document jpmcCapturePayload(YFSEnvironment env, Document inXML) throws Exception {
    Document jpmcCaptureInput = null;
    String paymentRef3 = "";
    if (null != inXML) {
      logger.info("************ Start TitanPaymentCaptureJPMC: jpmcCapturePayload");
      logger.debug("Input to the class TitanPaymentCaptureJPMC :jpmcCapturePayload " + XMLUtil.getString(inXML));
      Element eleShipments = inXML.getDocumentElement();
      Element eleShipment = (Element) eleShipments.getElementsByTagName("Shipment").item(0);
      if (eleShipment.getAttribute("DocumentType").equalsIgnoreCase("0001")) {
        Element eleShipmentLines = (Element) eleShipment.getElementsByTagName("ShipmentLines").item(0);
        NodeList nlShipmentLine = eleShipmentLines.getElementsByTagName("ShipmentLine");
        jpmcCaptureInput = XMLUtil.createDocument(XmlConstants.E_ORDER);
        Element eleOrder = jpmcCaptureInput.getDocumentElement();
        eleOrder.setAttribute(XmlConstants.A_ORDER_NO, eleShipment.getAttribute("OrderNo"));
        eleOrder.setAttribute("ChargeType", "CHARGE");
        double totalAmountPerUnit = 0.00;
        //Looping through ShipmentLine             
        for (int i = 0; i < nlShipmentLine.getLength(); i++) {
          Element eleShipmentLine = (Element) nlShipmentLine.item(i);
          Element eleTitanPaymentDetailList = (Element) eleShipmentLine.getElementsByTagName("TitanPaymentDetailList").item(0);
          NodeList nlTitanPaymentDetail = eleTitanPaymentDetailList.getElementsByTagName("TitanPaymentDetail");
          //Looping through TitanPaymentDetail                
          for (int j = 0; j < nlTitanPaymentDetail.getLength(); j++) {
            Element eleTitanPaymentDetail = (Element) nlTitanPaymentDetail.item(j);
            if (eleTitanPaymentDetail.getAttribute("PaymentType").equalsIgnoreCase("JPMorganPay")) {
              totalAmountPerUnit += Double.parseDouble((eleTitanPaymentDetail.getAttribute("AmountPerUnit")));
            }
          }
          Element elePaymentMethods = (Element) eleShipmentLine.getElementsByTagName("PaymentMethods").item(0);
          NodeList nlPaymentMethod = elePaymentMethods.getElementsByTagName("PaymentMethod");
          for (int k = 0; k < nlPaymentMethod.getLength(); k++) {
            Element elePaymentMethod = (Element) nlPaymentMethod.item(k);
            if (elePaymentMethod.getAttribute("PaymentType").equalsIgnoreCase("JPMorganPay")) {
              paymentRef3 = elePaymentMethod.getAttribute("PaymentReference3");
            }
          }
        }
        logger.debug("totalAmountPerUnit is " + totalAmountPerUnit);
        logger.debug("paymentRef3 is " + paymentRef3);
        if (!paymentRef3.isEmpty()) {
          String StrAmount = String.format("%.2f", totalAmountPerUnit);
          if (!paymentRef3.isEmpty()) {
            eleOrder.setAttribute(XmlConstants.A_AMOUNT, StrAmount.replace(".", ""));
            eleOrder.setAttribute("TxRefNum", paymentRef3);
          }
          logger.info("Final Amount : " + StrAmount.replace(".", ""));
          logger.info("output Xml to JPMC request :\n\n " + XMLUtil.getString(jpmcCaptureInput));
        }
      }
    }
    return jpmcCaptureInput;
  }
}