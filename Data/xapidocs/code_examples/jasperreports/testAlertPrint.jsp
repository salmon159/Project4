<%
/* 
 * Licensed Materials - Property of IBM
 * IBM Sterling Selling and Fulfillment Suite
 * (C) Copyright IBM Corp. 2001, 2013 All Rights Reserved.
 * US Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 */
%>
<%@ page import="java.net.*" %>

<%@include file="/yfsjspcommon/yfsutil.jspf"%>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.*" %>
<%@ page import="net.sf.jasperreports.engine.JRException" %>
<%@ page import="net.sf.jasperreports.engine.JasperCompileManager" %>
<%@ page import="net.sf.jasperreports.engine.JasperExportManager" %>
<%@ page import="net.sf.jasperreports.engine.JasperFillManager" %>
<%@ page import="net.sf.jasperreports.engine.JasperPrint" %>
<%@ page import="net.sf.jasperreports.engine.JasperReport" %>
<%@ page import="net.sf.jasperreports.engine.data.JRXmlDataSource" %>
<%@ page import="net.sf.jasperreports.engine.JRParameter" %>
<%!

	public static void	modifyOutputXml(Document doc)
	{
		if (doc != null) {
			Element y = doc.createElement("JasperSampleAlertComments");
			Element e = doc.getDocumentElement();
			NodeList nlst = e.getChildNodes();
			Node remNd = null;
			if (nlst != null) {
				for (int j = 0; j < nlst.getLength(); j++) {
					Node temNod = nlst.item(j);
					if (temNod.getNodeName().equalsIgnoreCase("InboxReferencesList")) {
						remNd = temNod;
						break;
					}
				}
				e.appendChild(y);
				if (remNd != null) {
					NodeList ndlst = remNd.getChildNodes();
					for (int i = 0; i < ndlst.getLength(); i++) {
						Node genNode = ndlst.item(i);
						if (genNode.getNodeType() == Node.ELEMENT_NODE) {
							Element nd = (Element) genNode;
							if (nd.hasAttribute("ReferenceType") && ((String) (nd.getAttribute("ReferenceType"))).equalsIgnoreCase("COMMENT")) {
								Node newNd = remNd.removeChild(nd);
								y.appendChild(newNd);
							}
						}
					}
				}
			}
		}
	}

	public static boolean printReport(HttpServletResponse response, Document doc)
	{
		JasperReport jr = null ;
		JasperPrint jp = null ;
		boolean error = true ;
		try {
			long start = 0 ;
			response.reset() ;
			response.setContentType("application/pdf");	
			java.io.OutputStream outputStream = response.getOutputStream() ;

			start = System.currentTimeMillis();			
			Locale locale = new Locale ("en", "US") ;
			//Preparing parameters
			Map parameters = new HashMap();
			parameters.put("lit_ReportTitle", "Sample Alert Report");
			parameters.put(JRParameter.REPORT_LOCALE, locale);

			//For purposes of this demo, ignore a missing font. In a real scenario this
			//should not be set, and the report should use a font available in the system.
                        net.sf.jasperreports.engine.util.JRProperties.setProperty("net.sf.jasperreports.awt.ignore.missing.font", true);

		    JRXmlDataSource ds = new JRXmlDataSource(doc,"/Inbox");

			InputStream is = Class.forName("com.yantra.yfc.dom.YFCDocument").getResourceAsStream("/sampleAlertReport.jasper") ;
			if (is == null)
				System.out.println("is is null") ;

			jp=JasperFillManager.fillReport(is, parameters, ds) ;
			System.err.println("Filling time : " + (System.currentTimeMillis() - start)+" msec");

			start = System.currentTimeMillis();						
			JasperExportManager.exportReportToPdfStream(jp, outputStream);

			System.err.println("Export to pdf time : " + (System.currentTimeMillis() - start)+" msec");

			error = false ;
		} 

		catch (JRException e1) {
			e1.printStackTrace();
		}
		catch (IOException ioe) {
			ioe.printStackTrace() ;
		}
		catch (ClassNotFoundException cnf){
			cnf.printStackTrace() ;
		}
	

		return error ;

	}	

%>
<%
	String inboxKey = resolveValue("xml:/Inbox/@InboxKey") ;
	System.out.println ("Inside testAlertPrint.jsp. InboxKey : "+inboxKey) ;
	String output = null ;

YFCElement getExceptionDetailsInput = YFCDocument.parse("<Inbox InboxKey=\""+inboxKey+"\" />").getDocumentElement() ;
YFCElement getExceptionDetailsTemplate = YFCDocument.parse("<Inbox ActiveFlag=\"\" ApiName=\"\" AssignedToUserId=\"\" AssignedToUserKey=\"\" AutoResolvedFlag=\"\" ClosedOn=\"\" ConsolidationCount=\"\" Description=\"\" DetailDescription=\"\" EnterpriseKey=\"\" ErrorReason=\"\" ErrorType=\"\" ExceptionEscalatedFlag=\"\" ExceptionType=\"\" ExpirationDays=\"\" FlowName=\"\" FollowupDate=\"\" GeneratedOn=\"\" InboxKey=\"\" InboxType=\"\" LastExceedAlert=\"\" LastOccurredOn=\"\" LastUnassignAlert=\"\" LastUnresolveAlert=\"\" ListDescription=\"\" LockedByUserKey=\"\" LockedFlag=\"\" LockedOn=\"\" OwnerKey=\"\" OwnerType=\"\" ParentInboxKey=\"\" Priority=\"\" QueueId=\"\" QueueKey=\"\" ResolutionDate=\"\" ResolveBy=\"\" ShipnodeKey=\"\" Status=\"\" SubFlowName=\"\" ViewId=\"\" ><User Activateflag=\"\" BillingaddressKey=\"\" BusinessKey=\"\" ContactaddressKey=\"\" CreatorOrganizationKey=\"\" Imagefile=\"\" Localecode=\"\" Loginid=\"\" Longdesc=\"\" MenuId=\"\" NoteKey=\"\" OrganizationKey=\"\" ParentUserKey=\"\" Password=\"\" PreferenceKey=\"\" Pwdlastchangedon=\"\" Theme=\"\" UserKey=\"\" UsergroupKey=\"\" Username=\"\" Usertype=\"\"/><Queue AuditThisQueue=\"\" HoursAssignExceedAction=\"\" HoursForAssignRealert=\"\" HoursForAssignment=\"\" HoursForExceedRealert=\"\" HoursForResolution=\"\" HoursForResolveRealert=\"\" HoursResolveExceedAction=\"\" LastQueueExceedAlert=\"\" MaximumActiveSize=\"\" MaximumSizeExceedAction=\"\" OwnerKey=\"\" OwnerType=\"\" Priority=\"\" QKeyForAssignAlert=\"\" QKeyForExceedAlert=\"\" QKeyForResolveAlert=\"\" QueueDescription=\"\" QueueGroup=\"\" QueueId=\"\" QueueKey=\"\" QueueName=\"\"/><InboxReferencesList><InboxReferences InboxKey=\"\" InboxReferenceKey=\"\" Name=\"\" ReferenceType=\"\" Value=\"\" Createts=\"\" Createuserid=\"\"/></InboxReferencesList><InboxNotesList><InboxNotes AuditTransactionId=\"\" ContactReference=\"\" ContactType=\"\" ContactUser=\"\" InboxKey=\"\" InboxNotesKey=\"\" NoteText=\"\" ReasonCode=\"\" SequenceNo=\"\" Tranid=\"\"/></InboxNotesList><InboxAuditList><InboxAudit FromQueueId=\"\" FromQueueKey=\"\" FromQueueOwnerKey=\"\" FromStatus=\"\" FromUserId=\"\" FromUserKey=\"\" InboxAuditKey=\"\" InboxKey=\"\" OwnerKey=\"\" OwnerType=\"\" ReasonCode=\"\" ReasonText=\"\" ToQueueId=\"\" ToQueueKey=\"\" ToQueueOwnerKey=\"\" ToStatus=\"\" ToUserId=\"\" ToUserKey=\"\" TransactionType=\"\" Createts=\"\" /></InboxAuditList></Inbox>").getDocumentElement() ;

%> 
<yfc:callAPI apiName="getExceptionDetails" inputElement="<%=getExceptionDetailsInput%>" templateElement="<%=getExceptionDetailsTemplate%>" outputNamespace="ExceptionDetails"/>
<%		
	YFCElement elem = (YFCElement)	request.getAttribute("ExceptionDetails") ;
	Document doc = elem.getOwnerDocument().getDocument() ;
	System.out.println("Output:"+	elem.getString()) ;
	modifyOutputXml(doc);
	boolean error = printReport(response, doc) ;
	if (error) {
		output ="Encountered Error while running report. Please look at logs for details" ;
%>
		<html>
			<head>
				<title><yfc:i18n>Jasper_Print_Demo</yfc:i18n></title>
			</head>

			<body bgcolor="#8C92C6">

			<center>
			<font color="white"><h2><%=output%></h1></font>
			</center>

			</body>
			</html>
<%
	}

%>
