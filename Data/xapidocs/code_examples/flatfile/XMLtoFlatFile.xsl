<?xml version="1.0" ?>
<!--
Licensed Materials - Property of IBM
IBM Sterling Selling and Fulfillment Suite
(C) Copyright IBM Corp. 2001, 2013 All Rights Reserved.
US Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
-->
<!--
                     LIMITATION OF LIABILITY
THIS SOFTWARE SAMPLE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED 
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
IN NO EVENT SHALL STERLING COMMERCE, Inc. BE LIABLE UNDER ANY THEORY OF 
LIABILITY (INCLUDING, BUT NOT LIMITED TO, BREACH OF CONTRACT, BREACH 
OF WARRANTY, TORT, NEGLIGENCE, STRICT LIABILITY, OR ANY OTHER THEORY 
OF LIABILITY) FOR (i) DIRECT DAMAGES OR INDIRECT, SPECIAL, INCIDENTAL, 
OR CONSEQUENTIAL DAMAGES SUCH AS, BUT NOT LIMITED TO, EXEMPLARY OR 
PUNITIVE DAMAGES, OR ANY OTHER SIMILAR DAMAGES, WHETHER OR NOT 
FORESEEABLE AND WHETHER OR NOT STERLING OR ITS REPRESENTATIVES HAVE 
BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES, OR (ii) ANY OTHER 
CLAIM, DEMAND OR DAMAGES WHATSOEVER RESULTING FROM OR ARISING OUT OF
OR IN CONNECTION THE DELIVERY OR USE OF THIS INFORMATION.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<Order>
			<ORDHDR>
				<xsl:attribute name="carrier_service">
					<xsl:value-of select="Order/@CarrierServiceCode"/>
				</xsl:attribute>
				<xsl:attribute name="corporation_code">
					<xsl:value-of select="Order/@EnterpriseCode"/>
				</xsl:attribute>
				<xsl:attribute name="cust_carrier_charge_account_no">
					<xsl:value-of select="Order/@CarrierAccountNo"/>
				</xsl:attribute>
				<xsl:attribute name="delivery_code">
					<xsl:value-of select="Order/@DeliveryCode"/>
				</xsl:attribute>
				<xsl:attribute name="delivery_date">
					<xsl:value-of select="Order/@ReqDeliveryDate"/>
				</xsl:attribute>
				<xsl:attribute name="order_create_date">
					<xsl:value-of select="Order/@OrderDate"/>
				</xsl:attribute>
				<xsl:attribute name="order_no">
					<xsl:value-of select="Order/@OrderNo"/>
				</xsl:attribute>
				<xsl:attribute name="order_type">
					<xsl:value-of select="Order/@OrderType"/>
				</xsl:attribute>
				<xsl:attribute name="orig_ship_date">
					<xsl:value-of select="Order/@ReqShipDate"/>
				</xsl:attribute>
				<xsl:attribute name="ship_to_addr1">
					<xsl:value-of select="Order/PersonInfoShipTo/@AddressLine1"/>
				</xsl:attribute>
				<xsl:attribute name="ship_to_addr2">
					<xsl:value-of select="Order/PersonInfoShipTo/@AddressLine2"/>
				</xsl:attribute>
				<xsl:attribute name="ship_to_addr3">
					<xsl:value-of select="Order/PersonInfoShipTo/@AddressLine3"/>
				</xsl:attribute>
				<xsl:attribute name="ship_to_addr4">
					<xsl:value-of select="Order/PersonInfoShipTo/@AddressLine4"/>
				</xsl:attribute>
				<xsl:attribute name="ship_to_city">
					<xsl:value-of select="Order/PersonInfoShipTo/@City"/>
				</xsl:attribute>
				<xsl:attribute name="ship_to_country_code">
					<xsl:value-of select="Order/PersonInfoShipTo/@Country"/>
				</xsl:attribute>
				<xsl:attribute name="ship_to_cust_id">
					<xsl:value-of select="Order/PersonInfoShipTo/@PersonID"/>
				</xsl:attribute>
				<xsl:attribute name="ship_to_customer_name">
					<xsl:value-of select="Order/PersonInfoShipTo/@LastName"/>
				</xsl:attribute>
				<xsl:attribute name="ship_to_state">
					<xsl:value-of select="Order/PersonInfoShipTo/@State"/>
				</xsl:attribute>
				<xsl:attribute name="ship_to_zip_code">
					<xsl:value-of select="Order/PersonInfoShipTo/@ZipCode"/>
				</xsl:attribute>
				<xsl:attribute name="terms_code">
					<xsl:value-of select="Order/@TermsCode"/>
				</xsl:attribute>
			</ORDHDR>
			<ContactInfo>
				<xsl:attribute name="addr1">
					<xsl:value-of select="Order/PersonInfoBillTo/@AddressLine1"/>
				</xsl:attribute>
				<xsl:attribute name="addr2">
					<xsl:value-of select="Order/PersonInfoBillTo/@AddressLine2"/>
				</xsl:attribute>
				<xsl:attribute name="addr3">
					<xsl:value-of select="Order/PersonInfoBillTo/@AddressLine3"/>
				</xsl:attribute>
				<xsl:attribute name="addr4">
					<xsl:value-of select="Order/PersonInfoBillTo/@AddressLine4"/>
				</xsl:attribute>
				<xsl:attribute name="city">
					<xsl:value-of select="Order/PersonInfoBillTo/@City"/>
				</xsl:attribute>
				<xsl:attribute name="country_code">
					<xsl:value-of select="Order/PersonInfoBillTo/@Country"/>
				</xsl:attribute>
				<xsl:attribute name="customer_name">
					<xsl:value-of select="Order/PersonInfoBillTo/@LastName"/>
				</xsl:attribute>
				<xsl:attribute name="state">
					<xsl:value-of select="Order/PersonInfoBillTo/@State"/>
				</xsl:attribute>
				<xsl:attribute name="zip_code">
					<xsl:value-of select="Order/PersonInfoBillTo/@ZipCode"/>
				</xsl:attribute>
			</ContactInfo>
			<xsl:for-each select="Order/Instructions/Instruction">
				<HdrInstrctn>
					<xsl:attribute name="instruction_type">
						<xsl:value-of select="@InstructionType"/>
					</xsl:attribute>
					<xsl:attribute name="instruction_text">
						<xsl:value-of select="@InstructionText"/>
					</xsl:attribute>
				</HdrInstrctn>
			</xsl:for-each>
			<xsl:apply-templates select="Order/OrderLines"/>
			<xsl:for-each select="Order/OrderLines/OrderLine/Instructions/Instruction">
				<LnInstrctn>
						<xsl:attribute name="instruction_type">
							<xsl:value-of select="@InstructionType"/>
						</xsl:attribute>
						<xsl:attribute name="instruction_text">
							<xsl:value-of select="@InstructionText"/>
						</xsl:attribute>
				</LnInstrctn>
			</xsl:for-each>
			<OrderTrailer>
				<xsl:attribute name="trailer_data">
					<xsl:value-of select="Order/@EnterpriseCode"/>
					<xsl:value-of select="Order/@OrderNo"/>
				</xsl:attribute>
				<xsl:attribute name="whse">
					<xsl:value-of select="Order/@SellerOrganizationCode"/>

				</xsl:attribute>
			</OrderTrailer>
		</Order>
	</xsl:template>
	<xsl:template match="OrderLines">
		<xsl:for-each select="OrderLine">
			<ORDDTL>
				<xsl:attribute name="carrier_code">
					<xsl:value-of select="@CarrierServiceCode"/>
				</xsl:attribute>
				<xsl:attribute name="customer_po_line_no">
					<xsl:value-of select="@CustomerLinePONo"/>
				</xsl:attribute>
				<xsl:attribute name="customer_po_no">
					<xsl:value-of select="@CustomerPONo"/>
				</xsl:attribute>
				<xsl:attribute name="customer_sku">
					<xsl:value-of select="Item/@CustomerItem"/>
				</xsl:attribute>
				<xsl:attribute name="department_code">
					<xsl:value-of select="@DepartmentCode"/>
				</xsl:attribute>
				<xsl:attribute name="item_id">
					<xsl:value-of select="Item/@ItemID"/>
				</xsl:attribute>
				<xsl:attribute name="line_price">
					<xsl:value-of select="LinePriceInfo/@LineTotal"/>
				</xsl:attribute>
				<xsl:attribute name="non_shippable_qty">
					<xsl:value-of select="@OpenQty"/>
				</xsl:attribute>
				<xsl:attribute name="order_prime_line">
					<xsl:value-of select="@PrimeLineNo"/>
				</xsl:attribute>
				<xsl:attribute name="order_sub_line">
					<xsl:value-of select="@SubLineNo"/>
				</xsl:attribute>
				<xsl:attribute name="orig_req_ship_date">
					<xsl:value-of select="@ReqShipDate"/>
				</xsl:attribute>
				<xsl:attribute name="pack_type">
					<xsl:value-of select="@PackListType"/>
				</xsl:attribute>
				<xsl:attribute name="product_class">
					<xsl:value-of select="Item/@ProductClass"/>
				</xsl:attribute>
				<xsl:attribute name="qty_ordered">
					<xsl:value-of select="@OrderedQty"/>
				</xsl:attribute>
				<xsl:attribute name="ship_together_code">
					<xsl:value-of select="@ShipTogetherNo"/>
				</xsl:attribute>
				<xsl:attribute name="shippable_qty">
					<xsl:value-of select="@InvoicedQty"/>
				</xsl:attribute>
				<xsl:attribute name="whse">
					<xsl:value-of select="@ShipNode"/>
				</xsl:attribute>
			</ORDDTL>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
