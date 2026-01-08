{
"customer":{
"id":15125 - PersonInfoKey
,"customer_ulp":"500000234582" - ExtnEncircleNo
,"first_name":"Gnanavel PALANISAMY"  PersonInfoBillTo/details
,"store_code":"XTD" - ShipNode
,"customer_contact1":"919600914777" PersonInfoBillTo/details
,"mail_id":"gnani24@gmail.com" PersonInfoBillTo/details
,"address1":"NO 193, TITAN COMPANY LIMITED INTEGRITY, ELECTRONCI CITY PHASE 2" PersonInfoBillTo/details
,"country":"United States" PersonInfoBillTo/details
,"state":"Connecticut" PersonInfoBillTo/details
,"city":"New Britain" PersonInfoBillTo/details
,"created_by":"PRAMOTH" - Shipments/Shipment/createBy --> will add here
,"created_dt":"13-NOV-2025 04:40:48" Order -> createts
,"order_id":10053 - OrderLine->OrderHeaderKey
,"source":"ENCIRCLE" - Shipments/Shipment/createBy
}
,"header":{
"id":10053  OrderLine->OrderHeaderKey
,"order_no":"17895" - order no
,"btq_code":"XTD" - ShipNode
,"order_type":"QB" - Shipment -> OrderType -->  will add here
,"order_qty":1 - Quantity
,"order_total":1000 - ExtnTotalNetAmount
,"order_dt":"13-NOV-2025 04:40:48" - OrderDate
,"order_by":"PRAMOTH" - Shipments/Shipment/createBy --> will add here
,"gold_rate":0 Order/Extn/ExtnGoldRate
,"status":"INVOICED" - Shipment -> Status
,"created_by":"PRAMOTH" -> Shipments/Shipment/createBy --> will add here
,"created_dt":"13-NOV-2025 04:40:48" Order -> createts
,"updated_by":"PRAMOTH" Shipments/Shipment/createBy --> will add here
,"updated_dt":"13-NOV-2025 04:40:48" Order -> createts
,"type":"GC" - Shipment -> Type -->  will add here
,"source_type":"ECOM" Shipments/Shipment/createBy --> will add here
}
,"lines":[
{
"id":16931 - OrderLine -> OrderLineKey
,"line_no":1 -> OrderLine -> PrimeLineNo
,"item_code":"GC1000" - ItemID 
,"gv_gc_number":"5895807259659095" - OrderLine/Extn/TitanGCLineDetailList/GiftCardNo
,"quantity":1 - Qty
,"cfa_code":"GC" -> OrderLine/Extn/ ExtnCFAProdCode
,"price_attribute_5":1000 - LinePriceInfo/ LineTotal
,"discount":0 LineCharges/LineCharge/[ if ChargeCategory='ERPDiscount'] ChargeAmount
,"tax":0 LineTaxes/LineTax/[if ChargeCategory="Price"] Tax
,"line_value":1000 - LinePriceInfo/ LineTotal
,"created_by":"PRAMOTH"Shipments/Shipment/createBy --> will add here
,"created_dt":"13-NOV-2025 04:40:48" Order -> createts
,"updated_by":"PRAMOTH"Shipments/Shipment/createBy --> will add here
,"updated_dt":"13-NOV-2025 04:40:50" Order -> createts
,"base_metal":"GC" - OrderLine -> BaseMetal --> will add here
,"tax_per":0 - LineTaxes/LineTax/[if ChargeCategory="Price"] TaxPercentage
,"rso":"PRAMOTH"  Shipments/Shipment/createBy --> will add here
,"header_id":10053  OrderLine->OrderHeaderKey
}
]
,"discount":[
]
,"pay":[
{
"id":18464 - 
,"header_id":10053  OrderLine->OrderHeaderKey
,"payment_mode":"CARD" PaymentType
,"payment_value":100  AmountPerUnit
,"created_by":"PRAMOTH"  Shipments/Shipment/createBy --> will add here
,"created_dt":"13-NOV-2025 04:40:48" TitanPaymentDetail -> TransactionTimestamp
,"header_type":"INV" -Shipments/Shipment/HeaderType --> will add here
}
]
}