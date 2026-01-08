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
 * TestJAXClient.java
 *
 *
 * Created: Mon Sep 24 16:42:54 2001
 *
 * @author <a href="mailto: "</a>
 * @version
 */

import junit.framework.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import com.yantra.interop.japi.YIFApi;
import com.yantra.yfs.japi.YFSEnvironment;
import org.w3c.dom.Element;
import com.yantra.interop.japi.YIFClientFactory;
import java.io.File;


/**
 * This class is an example of how to invoke business apis exposed by Sterling
 * This class is written as a junit test case. This test case invokes a 
 * createOrder API using the sample order_Create.xml supplied within this
 * directory. 
 *
 */

public class TestJAXClient extends TestCase {

    /**
     * YIFApi is the primary interface to invoke Sterling APIs.
     * Refer to the javadocs of this interface for a documented
     * list of APIs supported by this interface, and the sample
     * input XMLs.
     *
     */
    
    private YIFApi api;
    
    
    /**
     * The document builder is used to create an instance of org.w3c.Document
     *
     */
    private DocumentBuilder docBuilder;

    
    /**
     * This is the environment that is needed to invoke any Sterling APIS.
     * The environment handle is obtained by calling the createEnvironment
     * method on YIFApi. The createEnvironment method takes a Document as
     * the sole input parameter.
     */

    private YFSEnvironment env ;

    
    private String sessionId;
    /**
     * Creates a new <code>TestJAXClient</code> instance.
     *
     * @param name a <code>String</code> is a name for this test case
     * 
     */
    public TestJAXClient (String name){
	super(name);
    }

    
    /**
     * This function initializes the api handle and  the environment
     * handle.
     * <p> The api handle is initialized by calling the getApi function
     * on the YIFClientFactory. The getApi function shields the programmer
     * from the underlying transport details (such as HTTP, EJB). The getApi
     * function inspects the yifclient.properties file to determine the
     * appropriate protocol handler to instantiate. For instance, if the 
     * client needs to communicate with the Sterling application via HTTP, he 
     * simply needs to set the yif.apifactory.protocol to HTTP and the 
     * the yif.httpapi.url to the appropriate value in yifclient.properties
     * The details of opening an HTTP Connection and posting the relevant
     * data to the application, and returning the document as return value of
     * the api invocation are handled transparent to the programmer.
     * <p> SImilarly, for EJB , the programmer simply needs to set up
     * the protocol value as EJB and set up the java.naming.provider.url,
     * and the java.naming.factory.initial properties appropriately in 
     * yifclient.properties. The api handle will retrieve the appropriate
     * EJB interface by performing a JNDI lookup. 
     * <p> In either mode of transport, EJB or HTTP, the programmer is shielded
     * from the complexity of opening an HTTP connection, or doing a JNDI
     * lookup to retreive an EJB handle. As far as the programmer is concerned,
     * it looks as though the API is being executed in the same VM as the 
     * client's program.
     * @exception Exception if an error occurs
     */
    protected void setUp () throws Exception  {
	
	api = YIFClientFactory.getInstance().getApi();
	DocumentBuilderFactory fac = DocumentBuilderFactory.newInstance();
	docBuilder = fac.newDocumentBuilder();
	Document environmentDoc = docBuilder.newDocument();
	Element envElement = environmentDoc.createElement("YFSEnvironment");
	envElement.setAttribute("userId", "createOrderTest");
	envElement.setAttribute("progId", "createOrderTest");
	environmentDoc.appendChild(envElement);
	env = api.createEnvironment(environmentDoc);
	Document loginInput = docBuilder.newDocument();
	Element loginElement = loginInput.createElement("Login");
	loginElement.setAttribute("LoginID", "consoleadmin");
	loginElement.setAttribute("Password", "password");
	loginInput.appendChild(loginElement);
	Document loginDoc = api.login(env, loginInput);
	env.setTokenID(loginDoc.getDocumentElement().getAttribute("UserToken"));
	sessionId = loginDoc.getDocumentElement().getAttribute("SessionId");
    }

    protected void tearDown () throws Exception {
    	Document logoutDoc = docBuilder.newDocument();
    	Element logoutElement = logoutDoc.createElement("registerLogout");
    	logoutElement.setAttribute("UserId", env.getUserId());
    	logoutElement.setAttribute("SessionId", sessionId);
    	logoutDoc.appendChild(logoutElement);
    	api.registerLogout(env, logoutDoc);
    	api.releaseEnvironment(env);
    }
    
    /**
     * This function invokes a createOrder API. 
     *
     * @exception Exception if an error occurs
     */
    public void testCreateOrder () throws Exception {
	Document createOrderDoc = docBuilder.parse(new File("order_Create.xml"));
	Document createOrderReturn = api.createOrder(env, createOrderDoc);
	assertNotNull("CreateOrder Cannot return a null document",
		      createOrderReturn);
    }


    /**
     * This function invokes a createItem api.
     *
     * @exception Exception if an error occurs
     */
    public void testCreateItem () throws Exception {
	Document createItemDoc = docBuilder.parse(new File("item_Create.xml"));
	Document createItemReturn = api.createOrder(env, createItemDoc);
	assertNull("Create Item returns a null document",
		   createItemReturn);
    }

    public static Test suite () {
	return new TestSuite(TestJAXClient.class);
    }

    public static void main (String[] args) {
	junit.textui.TestRunner.run(suite());
    }


}
