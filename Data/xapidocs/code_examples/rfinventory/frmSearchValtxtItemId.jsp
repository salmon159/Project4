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
// This jsp is called for validation of txtItemId field on frmSearch
    String errorDesc = null ;
    String errorField = null ;
    errorField = "txtItemId" ;
    String inputItemId = getParameter("xml:/InventoryItem/@ItemID") ;

    if (inputItemId == null || inputItemId.equals("") ) {
        errorDesc = "item not entered" ;
    }
    else {
%>
        <yfc:callAPI apiID="AP1" />
<%
        String NumRecs = getValue("ItemList", "xml:/ItemList/@TotalItemList") ;

        YFCElement elem = (YFCElement)request.getAttribute("ItemList") ;

        if (NumRecs.equals("") || NumRecs.equals("0")){
                errorDesc = "Invalid Item ID" ;
        }
    }
    if (errorDesc == null ) {
        String formName ="/frmSearch" ;
        String output = sendForm(formName, "txtUom", false) ;
        response.getOutputStream().println(output) ;
    }
    if (errorDesc != null) {
        String errorXML = getErrorXML(errorDesc, errorField);
%>
    <%=errorXML%>
<%
    }
%>