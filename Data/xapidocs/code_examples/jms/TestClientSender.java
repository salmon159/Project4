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

/**
 * TestClientSender.java
 *
 *
 * Created: Tue Apr 10 11:41:35 2001
 *
 * @author <a href="mailto: "</a>
 * @version
 */

import com.ibm.sterling.G11N;
import com.ibm.sterling.Utils;
import com.yantra.yfc.log.YFCLogCategory;
import com.yantra.interop.japi.YIFApi;
import com.yantra.interop.japi.YIFClientFactory;
import com.yantra.yfc.dom.YFCDocument;
import com.yantra.yfc.dom.YFCElement;
import com.yantra.yfs.japi.YFSEnvironment;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.yantra.yfc.util.YFCCommon;


public class TestClientSender {
    private YIFApi api;    
    private static YFCLogCategory cat =
	YFCLogCategory.instance("TestClientSender");

    public TestClientSender ()
	throws Exception{
        api = YIFClientFactory.getInstance().getApi();
    }

    public Document send ( String xmlData, String flowName, String isFlow) {
        Document outDoc = null;
        String sessionId = null;
	try {
	    cat.debug("Sending message");
            YFCDocument envDoc = YFCDocument.createDocument("YFSEnvironment");
            YFCElement envRoot = envDoc.getDocumentElement();
            envRoot.setAttribute("userId", "admin");
            envRoot.setAttribute("progId", "Migrator");
            YFSEnvironment env = api.createEnvironment(envDoc.getDocument());
        	YFCDocument loginInput = YFCDocument.createDocument("Login");
        	YFCElement loginElement = loginInput.getDocumentElement();
        	loginElement.setAttribute("LoginId", "consoleadmin");
        	loginElement.setAttribute("Password", "password");
        	Document loginDoc = api.login(env, loginInput.getDocument());
        	env.setTokenID(loginDoc.getDocumentElement().getAttribute("UserToken"));
        	sessionId = loginDoc.getDocumentElement().getAttribute("SessionId");
            Document doc=null;
            try{
                doc = YFCDocument.parse(xmlData).getDocument();
            }catch(Exception e){
                cat.fatal(G11N.getString(G11N.AFC_DEFAULT_BUNDLE, "Could not parse input xml"), e);
            }
            
            if(Utils.isTrue(isFlow))
                outDoc = api.executeFlow(env, flowName, doc);            
            else
                outDoc = api.invoke(env, flowName, doc);
            
    		YFCDocument logoutDoc = YFCDocument.createDocument("registerLogout");
    		YFCElement logoutElement = logoutDoc.getDocumentElement();
    		logoutElement.setAttribute("UserId", env.getUserId());
    		logoutElement.setAttribute("SessionId", sessionId);
    		api.registerLogout(env, logoutDoc.getDocument());
    		api.releaseEnvironment(env);
	    cat.debug("Sent message");
	}
	catch (Exception e) {
	    cat.fatal(G11N.getString(G11N.AFC_DEFAULT_BUNDLE, "Exception while sending message"),
		      e);
	}
        return outDoc;
    }

    public static void main (String [] args) {

	cat.assertLog(args.length == 3,
		   "Insufficient number of arguments");
        
        if(args.length != 3){
            System.out.println("Usage: TestClientSender"
                + " <flowName/systemApiName> <is firstParameter Flow (Y/N)> <xmlFileName>");
            System.exit(0);
        }
	
	String flowName = args[0];
        String isFlow = args[1];
	String xmlFileName = args[2];
	
	
	
	if (flowName == null){
	    System.out.println("Flow Name should be the first parameter");
	    System.exit(0);
	}
		
	if (xmlFileName == null) {
	    System.out.println("XML File Name should be the third parameter");
	    System.exit(0);
	}
        
        if (YFCCommon.isVoid(isFlow)){
	    System.out.println("isFlow (Y/N) should be the secodn parameter");
	    System.exit(0);            
        }
	
	TestClientSender sender = null;
	try {
	    sender = new TestClientSender();
	}
	catch (Exception e) {
	    System.out.println("Unable to create a client");
	    e.printStackTrace();
	    System.exit(0);
	}
	StringBuffer xml = new StringBuffer ();
	try {
	    java.io.FileInputStream fsr =
		new java.io.FileInputStream(xmlFileName);
	    java.io.BufferedReader bfr = 
		new java.io.BufferedReader(new java.io.InputStreamReader(fsr, "UTF-8"));
	    	    String line = null;
	    while (null != (line = bfr.readLine())) {
		xml.append(line);
	    }
	    fsr.close();
	    bfr.close();
	}
	catch (java.io.FileNotFoundException e) {
	    System.out.print("Could not find file: " + xmlFileName);
            e.printStackTrace();
	    System.exit(0);
	}
	catch (java.io.IOException e) {
	    System.out.print("IO Exception while reading file ");
            e.printStackTrace();
	    System.exit(0);
	}
	
	Document outDoc = sender.send(xml.toString(), flowName, isFlow);	
        if(outDoc != null)
            System.out.println("Output Document is: " + YFCDocument.getDocumentFor(outDoc).getString());
    }
}// TestClientSender
