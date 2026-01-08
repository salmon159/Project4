<%@ include file="/yfc/rfutil.jspf" %>
<% /*
 Copyright 2006, Sterling Commerce, Inc. All rights reserved.

                     LIMITATION OF LIABILITY
THIS SOFTWARE SAMPLE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED 
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
IN NO EVENT SHALL YANTRA CORPORATION BE LIABLE UNDER ANY THEORY OF 
LIABILITY (INCLUDING, BUT NOT LIMITED TO, BREACH OF CONTRACT, BREACH 
OF WARRANTY, TORT, NEGLIGENCE, STRICT LIABILITY, OR ANY OTHER THEORY 
OF LIABILITY) FOR (i) DIRECT DAMAGES OR INDIRECT, SPECIAL, INCIDENTAL, 
OR CONSEQUENTIAL DAMAGES SUCH AS, BUT NOT LIMITED TO, EXEMPLARY OR 
PUNITIVE DAMAGES, OR ANY OTHER SIMILAR DAMAGES, WHETHER OR NOT 
FORESEEABLE AND WHETHER OR NOT YANTRA OR ITS REPRESENTATIVES HAVE 
BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES, OR (ii) ANY OTHER 
CLAIM, DEMAND OR DAMAGES WHATSOEVER RESULTING FROM OR ARISING OUT OF
OR IN CONNECTION THE DELIVERY OR USE OF THIS INFORMATION.
*/ %>
<%
    // This jsp is called when the cmdInquire button is pressed
    String errorDesc = null ;
    String errorField = null ;
    errorField = "txtItemId" ;
    String inputItemId = getParameter("xml:/InventoryItem/@ItemID") ;
    if (inputItemId == null || inputItemId.equals("") ) {
        errorDesc = "Item not entered" ;
    }
    else {
        try {
%>
            <yfc:callAPI apiID='AP2' />
<%
        }
        catch (Exception e) {
            System.out.println("Caught Exception ") ;
            e.printStackTrace() ;
            errorDesc = "API returned Error" ;
        }
    }

    if (errorDesc == null ) {
        String formName = "/frmDetail" ;
        response.getOutputStream().println(sendForm(formName, "", true)) ;
    }
    else {
        String errorXML = getErrorXML(errorDesc, errorField);
%>
    <%=errorXML%>
<%
    }
%>