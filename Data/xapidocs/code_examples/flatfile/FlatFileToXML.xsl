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
			<xsl:attribute name="CarrierAccountNo">
				<xsl:value-of select="Order/ORDHDR/@cust_carrier_charge_account_no"/>
			</xsl:attribute>
			<xsl:attribute name="CarrierServiceCode">
				<xsl:value-of select="Order/ORDHDR/@carrier_service"/>
			</xsl:attribute>
			<xsl:attribute name="DeliveryCode">
				<xsl:value-of select="Order/ORDHDR/@delivery_code"/>
			</xsl:attribute>
			<xsl:attribute name="EnterpriseCode">
				<xsl:value-of select="Order/ORDHDR/@corporation_code"/>
			</xsl:attribute>
			<xsl:attribute name="OrderDate">
				<xsl:value-of select="Order/ORDHDR/@order_create_date"/>
			</xsl:attribute>
			<xsl:attribute name="OrderNo">
				<xsl:value-of select="Order/ORDHDR/@order_no"/>
			</xsl:attribute>
			<xsl:attribute name="OrderType">
				<xsl:value-of select="Order/ORDHDR/@order_type"/>
			</xsl:attribute>
			<xsl:attribute name="ReqDeliveryDate">
				<xsl:value-of select="Order/ORDHDR/@delivery_date"/>
			</xsl:attribute>
			<xsl:attribute name="ReqShipDate">
				<xsl:value-of select="Order/ORDHDR/@orig_ship_date"/>
			</xsl:attribute>
			<xsl:attribute name="SellerOrganizationCode">
				<xsl:value-of select="Order/OrderTrailer/@whse"/>
			</xsl:attribute>
			<xsl:attribute name="TermsCode">
				<xsl:value-of select="Order/ORDHDR/@terms_code"/>
			</xsl:attribute>
			<OrderLines>
			        <xsl:for-each select="Order/ORDDTL">
				<OrderLine>
					<xsl:attribute name="CarrierServiceCode">
						<xsl:value-of select="@carrier_code"/>
					</xsl:attribute>
					<xsl:attribute name="CustomerLinePONo">
						<xsl:value-of select="@customer_po_line_no"/>
					</xsl:attribute>
					<xsl:attribute name="CustomerPONo">
						<xsl:value-of select="@customer_po_no"/>
					</xsl:attribute>
					<xsl:attribute name="DepartmentCode">
						<xsl:value-of select="@department_code"/>
					</xsl:attribute>
					<xsl:attribute name="InvoicedQty">
						<xsl:value-of select="@shippable_qty"/>
					</xsl:attribute>
					<xsl:attribute name="OpenQty">
						<xsl:value-of select="@non_shippable_qty"/>
					</xsl:attribute>
					<xsl:attribute name="OrderedQty">
						<xsl:value-of select="@qty_ordered"/>
					</xsl:attribute>
					<xsl:attribute name="PackListType">
						<xsl:value-of select="@pack_type"/>
					</xsl:attribute>
					<xsl:attribute name="PrimeLineNo">
						<xsl:value-of select="@order_prime_line"/>
					</xsl:attribute>
					<xsl:attribute name="ReqShipDate">
						<xsl:value-of select="@orig_req_ship_date"/>
					</xsl:attribute>
					<xsl:attribute name="ShipNode">
						<xsl:value-of select="@whse"/>
					</xsl:attribute>
					<xsl:attribute name="ShipTogetherNo">
						<xsl:value-of select="@ship_together_code"/>
					</xsl:attribute>
					<xsl:attribute name="SubLineNo">
						<xsl:value-of select="@order_sub_line"/>
					</xsl:attribute>
					<Item>
						<xsl:attribute name="CustomerItem">
							<xsl:value-of select="@customer_sku"/>
						</xsl:attribute>
						<xsl:attribute name="ItemID">
							<xsl:value-of select="@item_id"/>
						</xsl:attribute>
						<xsl:attribute name="ProductClass">
							<xsl:value-of select="@product_class"/>
						</xsl:attribute>
					</Item>
					<LinePriceInfo>
						<xsl:attribute name="LineTotal">
							<xsl:value-of select="@line_price"/>
						</xsl:attribute>
					</LinePriceInfo>
					<Instructions>
						<xsl:for-each select="LnInstrctn">
						<Instruction>
							<xsl:attribute name="InstructionText">
								<xsl:value-of select="@instruction_text"/>
							</xsl:attribute>
							<xsl:attribute name="InstructionType">
								<xsl:value-of select="@instruction_type"/>
							</xsl:attribute>
						</Instruction>
 				                </xsl:for-each>
					</Instructions>
				</OrderLine>
				</xsl:for-each>
			</OrderLines>
			<Instructions>
				<xsl:for-each select="Order/HdrInstrctn">
				<Instruction>
					<xsl:attribute name="InstructionText">
						<xsl:value-of select="@instruction_text"/>
					</xsl:attribute>
					<xsl:attribute name="InstructionType">
						<xsl:value-of select="@instruction_type"/>
					</xsl:attribute>
				</Instruction>
				</xsl:for-each>
			</Instructions>
			<PersonInfoShipTo>
				<xsl:attribute name="AddressLine1">
					<xsl:value-of select="Order/ORDHDR/@ship_to_addr1"/>
				</xsl:attribute>
				<xsl:attribute name="AddressLine2">
					<xsl:value-of select="Order/ORDHDR/@ship_to_addr2"/>
				</xsl:attribute>
				<xsl:attribute name="AddressLine3">
					<xsl:value-of select="Order/ORDHDR/@ship_to_addr3"/>
				</xsl:attribute>
				<xsl:attribute name="AddressLine4">
					<xsl:value-of select="Order/ORDHDR/@ship_to_addr4"/>
				</xsl:attribute>
				<xsl:attribute name="City">
					<xsl:value-of select="Order/ORDHDR/@ship_to_city"/>
				</xsl:attribute>
				<xsl:attribute name="Country">
					<xsl:value-of select="Order/ORDHDR/@ship_to_country_code"/>
				</xsl:attribute>
				<xsl:attribute name="LastName">
					<xsl:value-of select="Order/ORDHDR/@ship_to_customer_name"/>
				</xsl:attribute>
				<xsl:attribute name="PersonID">
					<xsl:value-of select="Order/ORDHDR/@ship_to_cust_id"/>
				</xsl:attribute>
				<xsl:attribute name="State">
					<xsl:value-of select="Order/ORDHDR/@ship_to_state"/>
				</xsl:attribute>
				<xsl:attribute name="ZipCode">
					<xsl:value-of select="Order/ORDHDR/@ship_to_zip_code"/>
				</xsl:attribute>
			</PersonInfoShipTo>
			<PersonInfoBillTo>
				<xsl:attribute name="AddressLine1">
					<xsl:value-of select="Order/ContactInfo/@addr1"/>
				</xsl:attribute>
				<xsl:attribute name="AddressLine2">
					<xsl:value-of select="Order/ContactInfo/@addr2"/>
				</xsl:attribute>
				<xsl:attribute name="AddressLine3">
					<xsl:value-of select="Order/ContactInfo/@addr3"/>
				</xsl:attribute>
				<xsl:attribute name="AddressLine4">
					<xsl:value-of select="Order/ContactInfo/@addr4"/>
				</xsl:attribute>
				<xsl:attribute name="City">
					<xsl:value-of select="Order/ContactInfo/@city"/>
				</xsl:attribute>
				<xsl:attribute name="Country">
					<xsl:value-of select="Order/ContactInfo/@country_code"/>
				</xsl:attribute>
				<xsl:attribute name="LastName">
					<xsl:value-of select="Order/ContactInfo/@customer_name"/>
				</xsl:attribute>
				<xsl:attribute name="State">
					<xsl:value-of select="Order/ContactInfo/@state"/>
				</xsl:attribute>
				<xsl:attribute name="ZipCode">
					<xsl:value-of select="Order/ContactInfo/@zip_code"/>
				</xsl:attribute>
			</PersonInfoBillTo>
		</Order>
	</xsl:template>
</xsl:stylesheet>
