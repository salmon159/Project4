//Ngenius marking as paid
select * from YFS_CHARGE_TRANSACTION where order_header_key in
(select order_header_key from yfs_order_header where order_no='00002251' and ENTERPRISE_KEY='TITAN_GCC') order by modifyts desc;

select * from yfs_payment where order_header_key in
(select order_header_key from yfs_order_header where order_no='00002251' and ENTERPRISE_KEY='TITAN_GCC') order by modifyts desc;

select * from yfs_order_header where Order_no in ('00002329','00002190','00002446') and ENTERPRISE_KEY='TITAN_GCC';


//
SELECT  yi.ITEM_ID,yi.Organization_code,yi.EXTN_ITEM_CODE,yi.EXTN_LOT_NO,yi.POSTING_CLASSIFICATION,yi.EXTN_PRODUCT_CODE
FROM aws_ster_sch.YFS_ITEM yi WHERE yi.item_id IN ('UPT815CAJIAA002JA000001');     





select yoh.order_no, yoh.order_header_key, yct.CHARGE_TRANSACTION_KEY, yct.CHARGE_TYPE, yct.STATUS, yct.DISTRIBUTED_AMOUNT, yct.PAYMENT_KEY, ypmt.PAYMENT_REFERENCE2
from yfs_order_header yoh, yfs_payment ypmt, YFS_CHARGE_TRANSACTION yct
where yoh.order_no='00002649' and
ypmt.ORDER_HEADER_KEY = yoh.ORDER_HEADER_KEY and
yct.ORDER_HEADER_KEY=yoh.ORDER_HEADER_KEY
order by yct.modifyts desc;

select count(*) from yfs_order_header where HOLD_FLAG='Y';


//
//340 - Sep-24  -   19:00
//212 - Sep-26  -   03:00
//212 - Oct-14  -   11:00
//229 - Nov-14  -   11:00
//234 - Dec-16  -   10:46
//238 - Feb-04
//239 - Feb-05
//240 - Feb-07
//241 - Feb-17
//242 - Feb-24
//247 - 14 Apr


// Prod 

SET CURRENT_SCHEMA='AWS_STER_SCH';

SELECT DATE(CURRENT TIMESTAMP) AS Date, TIME(CURRENT TIMESTAMP) AS Time FROM sysibm.sysdummy1;

//Heartbeat
select * from yfs_heartbeat where status='00' and LAST_HEARTBEAT > '2024-06-28'  order by modifyts desc;

select * from yfs_heartbeat where status='00' and SERVER_START_TIME > '2024-12-17 00:00:00.0'  order by modifyts desc;
select * from yfs_heartbeat where status='00' and server_name like 'IBD_ProcessJPMCIntegServer'  order by createts desc;
select count(*) from yfs_heartbeat where status='00' and server_name like '%RTAMAgent3%' ;

select * from yfs_heartbeat order by SERVER_START_TIME desc;
select * from yfs_heartbeat where server_type ='APPSERVER' order by SERVER_START_TIME desc;

select * from yfs_heartbeat where status='00';
select * from yfs_heartbeat where status='00' order by SERVER_START_TIME asc;
select * from yfs_heartbeat where status='00' order by SERVER_START_TIME desc;
select count(*) from yfs_heartbeat where status='00';
//83+1 - May-05 - 13:30


select * from yfs_object_lock;
select * from YFS_TRANSACTION_LOCK;
//172

select * from yfs_order_header where order_header_key>'20250808' and ENTERPRISE_KEY='TITAN_US' and DOCUMENT_TYPE='0001' order by createts desc;

select * from yfs_order_header where order_header_key>'20250811' order by createts desc;
//Daily monitoring Queries
//In mail
//select ORDER_HEADER_KEY,ENTERPRISE_KEY,ORDER_NO,Hold_flag,createts from yfs_order_header where HOLD_FLAG='Y' order by createts desc;
select ORDER_HEADER_KEY,ENTERPRISE_KEY,ORDER_NO,Hold_flag,createts,modifyts from yfs_order_header where HOLD_FLAG='Y'  order by modifyts desc;
//and  order_no not in ('00002698','00002846')


//All Hold query
select oh.ORDER_HEADER_KEY, oh.ENTERPRISE_KEY, oh.ORDER_NO, oht.HOLD_TYPE, oht.STATUS, oh.EXTN_KOUNT_STATUS, oh.createts, oh.modifyts,
 oht.LAST_HOLD_TYPE_DATE
from yfs_order_header oh, YFS_ORDER_HOLD_TYPE oht
where oh.Order_header_key=oht.Order_header_key and
oht.status='1100' and oht.createts > '2025-06-01'
and oh.modifyts > '2025-06-01' order by oht.modifyts desc;

//Not Kount Hold query
select oh.ORDER_HEADER_KEY, oh.ENTERPRISE_KEY, oh.ORDER_NO, oht.HOLD_TYPE, oht.STATUS, oh.EXTN_KOUNT_STATUS, oh.createts, oh.modifyts,
 oht.LAST_HOLD_TYPE_DATE
from yfs_order_header oh, YFS_ORDER_HOLD_TYPE oht
where oh.Order_header_key=oht.Order_header_key and
oht.status='1100' and oht.createts > '2025-06-01' and 
oht.hold_type='KOUNT_STATUS_HOLD' and
oh.modifyts > '2025-06-01' order by oht.modifyts desc;


//Orders on Hold
select ORDER_HEADER_KEY,ENTERPRISE_KEY,ORDER_NO,Hold_flag,EXTN_KOUNT_STATUS,createts,modifyts from yfs_order_header where Order_header_key in (
select Order_header_key from YFS_ORDER_HOLD_TYPE where status ='1100' and CREATETS > '2025-06-01' )
and modifyts > '2025-06-01' order by modifyts desc;

//Kount hold Order
select ORDER_HEADER_KEY,ENTERPRISE_KEY,ORDER_NO,Hold_flag,EXTN_KOUNT_STATUS,createts,modifyts from yfs_order_header where Order_header_key in (
select Order_header_key from YFS_ORDER_HOLD_TYPE where status ='1100' and CREATETS > '2025-06-01' and hold_type!='KOUNT_STATUS_HOLD')
and modifyts > '2025-06-01' order by modifyts desc;

select ORDER_NO,ENTERPRISE_KEY from yfs_order_header where Order_header_key in (
select ORDER_HEADER_KEY from YFS_ORDER_HOLD_TYPE where status ='1100' and ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where HOLD_FLAG='Y' and modifyts > '2024-11-10' ) 
and modifyts > '2024-11-10' )order by modifyts desc;

select ORDER_HEADER_KEY,ENTERPRISE_KEY,ORDER_NO,Hold_flag,createts,modifyts from yfs_order_header where HOLD_FLAG='Y'
and modifyts > '20240829' order by modifyts desc;

select ORDER_HEADER_KEY,ENTERPRISE_KEY,ORDER_NO,Hold_flag,createts,modifyts from yfs_order_header where HOLD_FLAG='Y'
and modifyts > '2024-07-25' order by modifyts desc;

select * from YFS_ORDER_HOLD_TYPE where status ='1100' and ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where HOLD_FLAG='Y' and modifyts > '2025-06-01' ) 
and modifyts > '2025-06-01' order by modifyts desc;

select * from YFS_ORDER_HOLD_TYPE where status ='1100' and ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where HOLD_FLAG='Y' and modifyts > '2024-07-15' and ENTERPRISE_KEY='TITAN_US') 
and modifyts > '2024-07-15' order by modifyts desc; 

select * from YFS_ORDER_HOLD_TYPE where status ='1100' and ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where HOLD_FLAG='Y' and modifyts > '2024-10-14' and ENTERPRISE_KEY='TITAN_US') 
and modifyts > '2024-10-14' order by modifyts desc; 

select * from YFS_ORDER_HOLD_TYPE where status ='1100' and ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where HOLD_FLAG='Y' and modifyts > '2024-08-01' and ENTERPRISE_KEY='TITAN_GCC') 
and modifyts > '2024-08-01' order by modifyts desc; 

select ORDER_NO,ENTERPRISE_KEY from yfs_order_header where Order_header_key in (
select ORDER_HEADER_KEY from YFS_ORDER_HOLD_TYPE where status ='1100' and ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where HOLD_FLAG='Y' and modifyts > '2024-07-15' and ENTERPRISE_KEY='TITAN_US') 
and modifyts > '2024-07-15' order by modifyts desc) order by modifyts desc;

select * from yfs_order_header where order_header_key in ('20250807002448438372115');

select * from YFS_ORDER_HOLD_TYPE where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where Order_no='US00017887' and ENTERPRISE_KEY='TITAN_US')  order by modifyts desc; 

//Internal group
select count(*) from yfs_order_header where HOLD_FLAG='Y';

//246 - 30 Apr
//258 - 18 May
//263 - Jun 19
//271 - Jun 23

//Stuck Orders in scheduled status
select * from yfs_order_header where order_header_key in (
select DATA_KEY from yfs_task_q where task_q_key>'20250601' and data_type='OrderHeaderKey' 
and ( TRANSACTION_KEY like 'RELEASE%' or TRANSACTION_KEY like '%SCHEDULE%'))order by createts desc;

select ORDER_HEADER_KEY,ENTERPRISE_KEY,ORDER_NO,Hold_flag,EXTN_KOUNT_STATUS,createts,modifyts from yfs_order_header where order_header_key in (
select DATA_KEY from yfs_task_q where task_q_key>'20250601' and data_type='OrderHeaderKey' 
and ( TRANSACTION_KEY like 'RELEASE%' or TRANSACTION_KEY like '%SCHEDULE%'))order by createts desc;


select * from yfs_order_header where order_header_key in (
select ORDER_HEADER_KEY from yfs_order_release where order_release_key in (
select DATA_KEY from yfs_task_q where task_q_key>'2025061601' 
and (TRANSACTION_KEY like '%20220811113638544375%'))) order by createts desc;

//and data_type='OrderHeaderKey' 
select * from yfs_task_q where task_q_key>'2025061601' 
and ( TRANSACTION_KEY like 'RELEASE%' or TRANSACTION_KEY like '%SCHEDULE%' 
or TRANSACTION_KEY like '%20220811113638544375%') order by createts desc;



select * from yfs_task_q where task_q_key>'20250624';

select * from yfs_task_q where data_type ='OrderReleaseKey' order by modifyts desc;

//check errors and take action
select  FLOW_NAME,count(*) from yfs_reprocess_error where ERRORTXNID > '20250401' group by FLOW_NAME ;
select  FLOW_NAME,count(*) from yfs_reprocess_error where ERRORTXNID > '20250420' and STATE='Initial' group by FLOW_NAME ;
select  FLOW_NAME,count(*) from yfs_reprocess_error where ERRORTXNID > '20250430' and STATE='Initial' group by FLOW_NAME ;
select  FLOW_NAME,count(*) from yfs_reprocess_error where ERRORTXNID > '20250601' and STATE='Initial' group by FLOW_NAME ;
select  FLOW_NAME,count(*) from yfs_reprocess_error where ERRORTXNID > '20250624' and STATE='Initial' group by FLOW_NAME ;

select  FLOW_NAME,count(*) from yfs_reprocess_error where ERRORTXNID > '20250701' and STATE='Initial' group by FLOW_NAME ;

select  FLOW_NAME,count(*) from yfs_reprocess_error where ERRORTXNID > '20250725' and STATE='Initial' group by FLOW_NAME ;

select * from yfs_reprocess_error where ERRORTXNID > '20250624' and FLOW_NAME like '%IBD_AWBNoAndShipment_Async%'  order by createts desc;
select * from yfs_reprocess_error where ERRORTXNID > '20250725' and FLOW_NAME like '%IBD_ReceiveStatusUpdateFromERP_Async%' order by createts desc;
select * from yfs_reprocess_error where ERRORTXNID > '20250725' and FLOW_NAME like '%IBD_ReceiveStatusUpdateFromOMNIPOSS_Async%'  order by createts desc;
select * from yfs_reprocess_error where ERRORTXNID > '20250401' and FLOW_NAME like '%IBD_CancelOrderMsg_Async%' order by createts desc;
select * from yfs_reprocess_error where ERRORTXNID > '20250725' and FLOW_NAME like '%SF_CreateOrder_Async%'  order by createts desc;
select * from yfs_reprocess_error where ERRORTXNID > '20250501' and FLOW_NAME like '%IBD_ReceiveStatusUpdatesFromTransguardAsync%' and STATE='Initial'  order by createts desc;
select * from yfs_reprocess_error where ERRORTXNID > '20250701' and FLOW_NAME like '%IBD_CreateOrderMsg_Async%'  order by createts desc;
select * from yfs_reprocess_error where ERRORTXNID > '20250501' and FLOW_NAME like '%IBD_CreateReturnOrderInvoice_Async%' and STATE='Initial' order by createts desc;
select * from yfs_reprocess_error where ERRORTXNID > '20250523' and FLOW_NAME like '%IBD_ProcessJPMCRefundAsync%' and STATE='Initial' order by createts desc;
select * from yfs_reprocess_error where ERRORTXNID > '20250801' and FLOW_NAME like '%IBD_ProcessJPMCReversalAsync%' and STATE='Initial' order by createts desc;


select ERRORTXNID,FLOW_NAME,ERRORSTRING,STATE,MESSAGE,ERRORMESSAGE,MODIFYTS from yfs_reprocess_error where ERRORTXNID > '20250801' 
and FLOW_NAME like '%IBD_ProcessJPMCReversalAsync%' order by createts desc;

select FLOW_NAME,ERRORSTRING,STATE,MESSAGE,ERRORMESSAGE,MODIFYTS from yfs_reprocess_error where modifyts > '20250619' 
and FLOW_NAME like '%IBD_ReceiveStatusUpdatesFromTransguardAsync%' order by createts desc;



select FLOW_NAME,ERRORSTRING,STATE,MESSAGE,ERRORMESSAGE,MODIFYTS from yfs_reprocess_error where ERRORTXNID > '20240701' and 
FLOW_NAME like '%IBD_ReceiveStatusUpdatesFromTransguardAsync%'  and message like '%100005449%' order by createts desc;


select * from yfs_reprocess_error where ERRORTXNID > '20250522' 
and FLOW_NAME like '%IBD_ReceiveLotMasterFeed_Async%' order by createts desc;

select FLOW_NAME,ERRORSTRING,STATE,MESSAGE,ERRORMESSAGE,MODIFYTS from yfs_reprocess_error where ERRORTXNID > '20250522' 
and FLOW_NAME like '%IBD_ReceiveLotMasterFeed_Async%' and message like '%UPO5B1EMG1%'  order by createts desc;

select * from yfs_item where item_id like '%UPO5B1EMG1AAP1%';
//select * from yfs_reprocess_error where ERRORTXNID > '20240524' and FLOW_NAME like '%IBD_AWBNoAndShipment_Async%' and modifyts>'20240530';


select * from yfs_reprocess_error where ERRORTXNID > '20250601' and FLOW_NAME like '%IBD_ReceiveStatusUpdatesFromTransguardAsync%'  
and message like '%100015519%' order by createts desc;

select * from yfs_export where export_key>'20250116' and flow_name='TransguardStatusUpdates' 
and message like '%100010662%' order by modifyts desc;

select * from yfs_export where export_key>'20250529' and flow_name='TransguardStatusUpdates'  order by modifyts desc;


select  FLOW_NAME,count(*) from yfs_reprocess_error where ERRORTXNID > '20240524' group by FLOW_NAME;
//Daily monitoring end

// Inventory queries
SELECT  yi.ITEM_ID,yi.Organization_code,yi.EXTN_ITEM_CODE,yi.EXTN_LOT_NO,yi.POSTING_CLASSIFICATION,yi.EXTN_PRODUCT_CODE
FROM aws_ster_sch.YFS_ITEM yi WHERE yi.item_id IN 
('EZ0113ZAARAS002BL000705');

SELECT ITEM_ID,UNIT_WEIGHT,EXTN_NET_WEIGHT,EXTN_STD_NET_WEIGHT FROM aws_ster_sch.YFS_ITEM yi WHERE yi.item_id IN 
('EP1056FCJJAA002JA000023');

SELECT * FROM aws_ster_sch.YFS_ITEM yi WHERE yi.item_id IN 
('ULD3D1PWOAAA042JA000001','EPD2D1PQPAAA002EE000008');

SELECT   * FROM aws_ster_sch.YFS_ITEM yi WHERE yi.item_id  
 in (select ITEM_ID from TITAN_DADI_INV_AVL_STAGING where ITEM_ID like 'EP2218PRFAAA00%' and AVAILABLE_QTY >'0' );  

SELECT   yi.ITEM_ID,unit_weight,CREATETS,createprogid, modifyts, modifyprogid FROM aws_ster_sch.YFS_ITEM yi WHERE yi.item_id like (
'UPF5B1PCCAAA00%');

select * from yfs_inventory_Supply where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where 
Item_id in ('EZ0113ZAARAS002BL000666'));

select * from yfs_inventory_Supply where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where 
Item_id like 'UZ%'  )and QUANTITY>'0';

select * from yfs_inventory_item where Item_id like 'EP2218PRFAAA00%' and INVENTORY_ITEM_KEY in (
select INVENTORY_ITEM_KEY from yfs_inventory_Supply where QUANTITY='0');

select * from yfs_inventory_item where INVENTORY_ITEM_KEY in ('2023081800000047243761');

select * from yfs_inventory_demand where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where 
Item_id in ('EZ0113ZAARAS002BL000666')) order by createts asc;

select * from yfs_export where export_key>'20240825' and message like '%EPIOO4VAUQ1A002EA000011%';

select * from TITAN_DADI_INV_AVL_STAGING where ITEM_ID in 
('EZ0113ZAARAS002BL000666');

select ITEM_ID,NODE,AVAILABLE_QTY,createts,MODIFYTS,MODIFYUSERID from TITAN_DADI_INV_AVL_STAGING where AVAILABLE_QTY>'0' and  ITEM_ID in 
('ULD3D1PWOAAA042JA000001','EPD2D1PQPAAA002EE000008') ;


select * from YFS_INVENTORY_AUDIT where ORGANIZATION_CODE='TITAN_GCC' and ITEM like '%EZ0102ZFHAAP002BL000812%' order by modifyts desc;
select * from YFS_INVENTORY_AUDIT where ORGANIZATION_CODE='TITAN_US' and ITEM like '%UL2714STVAGA002JA000041%' order by modifyts desc;

select * from YFS_INVENTORY_AUDIT where ORGANIZATION_CODE='TITAN_GCC' and 
INVENTORY_AUDIT_KEY between '202408280019' and '202408300714' order by modifyts desc;

select * from yfs_inventory_Supply where modifyts between '2024-08-28 00:19:00.0' and '2024-08-30 07:14:00.0' 
and inventory_item_key in (select inventory_item_key from yfs_inventory_item where ORGANIZATION_CODE='TITAN_GCC')order by modifyts desc;

select * from yfs_inventory_item where inventory_item_key in (
select inventory_item_key from yfs_inventory_Supply where modifyts between '2024-08-28 00:19:00.0' and '2024-08-30 07:14:00.0' 
and inventory_item_key in (select inventory_item_key from yfs_inventory_item where ORGANIZATION_CODE='TITAN_GCC'))order by modifyts desc;

select * from yfs_inventory_audit where INVENTORY_AUDIT_KEY>'20241008' and ORGANIZATION_CODE='TITAN_GCC'  order by modifyts desc;

select * from yfs_inventory_supply_temp;

select * from YFS_INVENTORY_RESERVATION order by modifyts desc;

select * from yfs_inventory_item where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from YFS_INVENTORY_RESERVATION);


select * from yfs_audit where table_name like '%YFS_INVENTORY_RESERVATION%' order by createts desc;

//Item Master Load Check
select * from yfs_item where Organization_code='TITAN_US' and modifyts>'20250601' and modifyuserid='IBDReceiveUSJewFeedIntegServer' order by modifyts desc;

select * from yfs_item where Organization_code='TITAN_GCC' and modifyts>'20250530' and modifyuserid='IBDReceiveJewFeedIntegServer' order by modifyts desc;

//Lot Master Load Check
select * from yfs_item where Organization_code='TITAN_US' and modifyts>'20250407' and modifyuserid='IBDUSReceiveLotMasterIntegServer';

select * from yfs_item where Organization_code='TITAN_GCC' and modifyts>'20250530' and modifyuserid='IBDReceiveLotMasterIntegServer' order by createts desc;

select * from yfs_item where item_id in ('EL3024SHYAFA022JA000002');

//Store Inventory Load Check
select * from yfs_inventory_Supply where modifyts > '2025-03-12 00:00:00.0' and modifyuserid='IBDUSReceiveStoreInvUpdateIntegServer';

select * from yfs_inventory_Supply where modifyts > '2025-04-30 00:00:00.0' and modifyuserid='IBDReceiveStoreInvUpdateIntegServer' order by modifyts desc;

select * from TITAN_DADI_INV_AVL_STAGING where modifyts > '2024-11-11 00:00:00.0'
and Item_id in (select Item_id from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_GCC');

select ITEM_ID,NODE,AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where modifyts > '2024-10-08 00:00:00.0'
and Item_id in (select Item_id from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_GCC');

select * from yfs_inventory_Supply where  shipnode_key like '%XDX%' order by modifyts asc;

select * from TITAN_DADI_INV_AVL_STAGING where NODE='XDX' and AVAILABLE_QTY>'0' order by modifyts asc;



select * from yfs_reprocess_error where ERRORTXNID > '20250529' and FLOW_NAME like '%IBD_UpdateInventory_Async%'  
and message like '%XDX%' and message like '%Quantity="1"%' order by createts desc;

select message,createts from yfs_reprocess_error where ERRORTXNID > '20250529' and FLOW_NAME like '%IBD_UpdateInventory_Async%'  
and message like '%XDX%' and message like '%Quantity="1"%' order by createts desc;



select ITEM_ID,NODE,AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where AVAILABLE_QTY >'0' and 
Item_id in (select Item_id from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_GCC');

select * from TITAN_DADI_INV_AVL_STAGING order by modifyts asc;

select modifyuserid from yfs_item where Organization_code='TITAN_GCC'  group by modifyuserid;

select * from yfs_item where Organization_code='TITAN_GCC' and modifyts>'20240904' and modifyuserid='IBDReceiveLotMasterIntegServer' 
and unit_weight='0';

select * from yfs_item where Organization_code='TITAN_GCC'   
and modifyuserid='IBDReceiveLotMasterIntegServer';

select * from yfs_item where Organization_code='TITAN_GCC' and modifyts>'20241111'  
and modifyuserid='IBDReceiveLotMasterIntegServer' order by modifyts desc;

//Zero weight Items
select Item_id,unit_weight,organization_code,createts,modifyts from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_GCC' and UNIT_WEIGHT='0'  order by createts desc;

select Item_id,unit_weight,organization_code,createts,modifyts from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_US' and UNIT_WEIGHT='0'  order by createts desc;

select ITEM_ID,NODE,AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where ITEM_ID in (
select Item_id from yfs_item where length(trim(Item_id)) > '20' and unit_weight='0'
and organization_code='TITAN_GCC' ) and AVAILABLE_QTY >'0' order by createts desc;

select * from yfs_item where length(trim(Item_id)) < '20';

//Zero weight Items

select Item_id,unit_weight,organization_code,createts,CREATEUSERID,modifyts,MODIFYUSERID from yfs_item where unit_weight='0' 
and length(trim(Item_id)) > '20' and organization_code='TITAN_GCC' and item_id in (
select item_id from TITAN_DADI_INV_AVL_STAGING where AVAILABLE_QTY>'0')order by createts desc;
//IBDReceivePriceFeedIntegServer

//Count
select count(Item_id) from yfs_item where unit_weight='0' 
and length(trim(Item_id)) > '20' and organization_code='TITAN_GCC' and item_id in (
select item_id from TITAN_DADI_INV_AVL_STAGING where AVAILABLE_QTY>'0');
//614

select Item_id,unit_weight,organization_code,createts,CREATEUSERID,modifyts,MODIFYUSERID from yfs_item where unit_weight='0' 
and length(trim(Item_id)) > '20' and organization_code='TITAN_US'  and item_id in (
select item_id from TITAN_DADI_INV_AVL_STAGING where AVAILABLE_QTY>'0')order by createts desc;
//IBDReceiveUSPriceFeedIntegServer


//Count
select count(Item_id) from yfs_item where unit_weight='0' 
and length(trim(Item_id)) > '20' and organization_code='TITAN_US' and item_id in (
select item_id from TITAN_DADI_INV_AVL_STAGING where AVAILABLE_QTY>'0');


select Item_id,UNIT_COST,organization_code,createts,CREATEUSERID,modifyts,MODIFYUSERID from yfs_item where UNIT_COST='0' 
and length(trim(Item_id)) > '20' and organization_code='TITAN_GCC' order by createts desc;

select Item_id,unit_weight,organization_code,createts,CREATEUSERID,modifyts,MODIFYUSERID from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_GCC'  and item_id in (
select item_id from TITAN_DADI_INV_AVL_STAGING where AVAILABLE_QTY>'0')order by createts desc;


select Organization_code,Item_id,unit_weight,EXTN_ITEM_CODE,EXTN_LOT_NO,
POSTING_CLASSIFICATION,EXTN_PRODUCT_CODE, createts,CREATEUSERID,modifyts,MODIFYUSERID from yfs_item where unit_weight='0' 
and length(trim(Item_id)) > '20' and organization_code='TITAN_GCC' and item_id in (
select item_id from TITAN_DADI_INV_AVL_STAGING where AVAILABLE_QTY>'0')order by createts desc;


select * from yfs_reprocess_error where ERRORTXNID > '20250306' and FLOW_NAME like '%IBD_UpdateInventory_Async%'   order by createts desc;

select * from yfs_reprocess_error where ERRORTXNID > '20250310' and FLOW_NAME like '%IBD_ReceiveLotMasterFeed_Async%' 
 order by createts desc;


select * from yfs_reprocess_error where ERRORTXNID > '20250101' and FLOW_NAME like '%IBD_ReceiveLotMasterFeed_Async%' 
and message like '%EL3824YDVGAA02%' order by createts desc;

//GCC full inv report

select ITEM_ID, NODE, AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where Item_id in 
(select Item_id from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_GCC') and AVAILABLE_QTY>'0' and 
NODE in ('XAH', 'XDM', 'XDF', 'XDB', 'XDS', 'XDK', 'XDT', 'XSL', 'XDJ', 'XAW', 'XDG');
//23463  Rows


select ITEM_ID, NODE, AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where Item_id in 
(select Item_id from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_US') and AVAILABLE_QTY>'0' and 
NODE in ('XCG', 'XNJ', 'XTD', 'XTH');

select ITEM_ID, NODE, AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where Item_id in 
(select Item_id from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_US') and AVAILABLE_QTY>'0' and 
NODE in ('XCG', 'XNJ', 'XTD', 'XTH');

select yi.ITEM_ID,yi.EXTN_ITEM_CODE,yi.EXTN_LOT_NO, td.NODE, td.AVAILABLE_QTY
FROM YFS_ITEM yi, TITAN_DADI_INV_AVL_STAGING td
where length(trim(yi.Item_id)) > '20' and
yi.Item_id=td.Item_id and
yi.organization_code='TITAN_US' and
td.AVAILABLE_QTY>'0' and 
td.NODE in ('XCG', 'XNJ', 'XTD', 'XTH');

select ITEM_ID, NODE, AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where Item_id in 
(select Item_id from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_GCC') and AVAILABLE_QTY>'0' and 
NODE in ('XAH', 'XDM', 'XDF', 'XDB', 'XDS', 'XDK', 'XDT', 'XSL', 'XDJ', 'XAW', 'XDG');

select ITEM_ID, unit_cost from yfs_item where length(trim(Item_id)) > '20' and organization_code='TITAN_GCC'
and length(trim(Item_id)) > '20' and UNIT_COST<'1';
select * from yfs_item_price_set;


select dadi.ITEM_ID, dadi.NODE, dadi.AVAILABLE_QTY, yi.UNIT_COST as unit_price
from yfs_item yi, TITAN_DADI_INV_AVL_STAGING dadi
where length(trim(yi.Item_id)) > '20' and
yi.organization_code='TITAN_GCC' and
dadi.AVAILABLE_QTY>'0' and 
dadi.NODE in ('XAH', 'XDM', 'XDF', 'XDB', 'XDS', 'XDK', 'XDT', 'XSL', 'XDJ', 'XAW', 'XDG');

SELECT 
    inv.ITEM_ID,    inv.AVAILABLE_QTY,    inv.NODE,    itm.UNIT_COST AS PRICE
FROM 
    TITAN_DADI_INV_AVL_STAGING inv
JOIN 
    yfs_item itm ON inv.ITEM_ID = itm.ITEM_ID
WHERE 
    length(trim(itm.Item_id)) > '20'
    AND inv.AVAILABLE_QTY>'0'
    and inv.NODE in ('XAH', 'XDM', 'XDF', 'XDB', 'XDS', 'XDK', 'XDT', 'XSL', 'XDJ', 'XAW', 'XDG');


select ITEM_ID, NODE, AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where Item_id in 
(select Item_id from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_GCC') and AVAILABLE_QTY>'0' and 
NODE in (select ORGANIZATION_KEY from yfs_organization where PARENT_ORGANIZATION_CODE='TITAN_GCC');

select * from yfs_item where length(trim(Item_id)) < '20' and organization_code='TITAN_US';

select ITEM_ID from yfs_item where length(trim(Item_id)) < '20' and organization_code='TITAN_US';


select yi.ITEM_ID,yi.ORGANIZATION_CODE,yis.SHIPNODE_KEY,yis.SUPPLY_TYPE,yis.QUANTITY,yis.CREATETS,yis.MODIFYTS  
from yfs_item yi,yfs_inventory_item yii,yfs_inventory_supply yis 
where yi.ITEM_ID = yii.ITEM_ID and 
yii.INVENTORY_ITEM_KEY = yis.INVENTORY_ITEM_KEY and 
yi.organization_code='TITAN_US'
and QUANTITY>0;

// Inventory queries


select unique(FLOW_NAME) from yfs_export;
//NGenius
select message,createts from  yfs_export where Flow_name='IBD_NGeniusReq' and EXPORT_KEY > '20250801' order by createts desc;
select message,createts from  yfs_export where Flow_name='IBD_NGeniusResponse' and EXPORT_KEY > '20250801' order by createts desc;

select message,createts from  yfs_export where Flow_name='IBD_NGeniusReq' and 
EXPORT_KEY between '20250731' and '20250801'  order by createts desc;
select message,createts from  yfs_export where Flow_name='IBD_NGeniusResponse' and 
EXPORT_KEY between '20250731' and '20250801'  order by createts desc;


//Refund
select message,createts from  yfs_export where Flow_name='IBD_NGeniusRefReq' and EXPORT_KEY > '20250812' order by createts desc;
select message,createts from  yfs_export where Flow_name='IBD_RefResponse' and EXPORT_KEY > '20250812' order by createts desc;


select message,createts from  yfs_export where Flow_name='IBD_NGeniusRefReq' and 
EXPORT_KEY between '20250805' and '20250806'  order by createts desc;
select message,createts from  yfs_export where Flow_name='IBD_RefResponse' and 
EXPORT_KEY between '20250805' and '20250806'  order by createts desc;


//Check Payment message
select * from yfs_charge_transaction where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_no in ('US00020066') and ENTERPRISE_KEY='TITAN_US' ) order by modifyts asc;

select * from YFS_PAYMENT where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_no in ('00017801') 
and ENTERPRISE_KEY='TITAN_GCC' ) order by modifyts desc;

select * from TITAN_PAYMENT_DETAILS where order_line_key in (
select TRIM(ORDER_LINE_KEY) from yfs_order_line where order_header_key in (
select order_header_key from yfs_order_header where order_no in ('US00020066')));

select * from yfs_order_header where ORDER_HEADER_KEY in(
select ORDER_HEADER_KEY from yfs_payment where PAYMENT_KEY>'20250101' and payment_reference2 like '%undefined%') order by createts desc;

select * from yfs_order_header where Order_header_key in (
select ORDER_HEADER_KEY from yfs_payment where PAYMENT_REFERENCE2='98e49013-15bb-496e-8238-66b792251080');
//Check Payment message
//JPMC
select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganReq' and EXPORT_KEY > '20250501'  order by createts desc;
select * from  yfs_export where Flow_name='IBD_JPMorganReq' and EXPORT_KEY > '20250501'  order by createts desc;

select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganResponse' and EXPORT_KEY > '20250501' order by createts desc;

//2024-07-04 16:18:44.0
select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganReq' and EXPORT_KEY between '20250801' and '20250805'
 order by createts desc;

select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganResponse' and EXPORT_KEY between '20250801' and '20250805'
order by createts desc;

select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganReq' and EXPORT_KEY between '20250523' and '20250526'
and message like '%US00018043%' order by createts desc;


select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganReq' and EXPORT_KEY > '20250101' 
and message like '%00011696%' order by createts desc;

select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganResponse' and EXPORT_KEY > '20250101' 
and message like '%message%' order by createts desc;

select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganResponse' and EXPORT_KEY between '20250211' and '20250212'
order by createts desc;
//2024-06-28 06:29:29.0

//JPMC


//Encircle

select * from YFS_PAYMENT where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_no in ('US00015808') 
and ENTERPRISE_KEY='TITAN_US' ) order by modifyts desc;

select * from yfs_export where export_key>'20250501' and Flow_Name='IBD_EncircleIIBDB' order by CREATETS desc;
//Encircle

//Avalara
//status - commited
select message,createts from  yfs_export where Flow_name='IBD_AvalaraCommitReq' and EXPORT_KEY > '20240910' order by createts desc;
select message,createts from  yfs_export where Flow_name='IBD_AvalaraCommitRes' and EXPORT_KEY > '20240910' order by createts desc;

//or cancel and return. trans type is returninv
select message,createts from  yfs_export where EXPORT_KEY > '20250501' and Flow_name='IBD_AvalaraRefundReq' order by createts desc;
select message,createts from  yfs_export where EXPORT_KEY > '20250501' and Flow_name='IBD_AvalaraRefundRes' order by createts desc;

select message,createts from  yfs_export where Flow_name='IBD_AvalaraRefundReq' and EXPORT_KEY between '20240529' and '20240530'
 order by createts desc;

//Avalara
//TransGuard AWB Generation
select *  from yfs_export where export_key>'20250811' and flow_name like '%TransguardCreateOrder%' order by createts desc;
select *  from yfs_export where export_key>'20250701' and flow_name like '%TransguardReturnOrder%'  order by createts desc;

select *  from yfs_export where export_key between '20250529' and '20250602' and flow_name like '%TransguardReturnOrder%' 
and message='%100015440%' order by createts desc;


select *  from yfs_export where export_key between '20240912' and '20240913' and flow_name like '%TransguardCreateOrder%' order by createts desc;

select *  from yfs_export where export_key between '20240912' and '20240913' and flow_name like '%TransguardReturnOrder%'  order by createts desc;

//TransGuard AWB Generation
select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,createts from yfs_shipment where order_no in ('US00021643');

select * from yfs_shipment where order_no in ('00010980');
select * from yfs_shipment_line where shipment_key in (select shipment_key from yfs_shipment where order_no in ('Y100016076'));

select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,createts from yfs_shipment where order_no in (
'US00016923','US00017176','US00016940','US00017004','US00016886','US00017050');

//Get Return Order with sales order No
select order_no as RO_No from yfs_order_header where order_header_key in (
select ORDER_HEADER_KEY from yfs_order_line where DERIVED_FROM_ORDER_HEADER_KEY in (
select order_header_key from yfs_order_header where order_no='US00018133'));

select EXTN_SALES_TAX_PERCENT from yfs_order_line where DERIVED_FROM_ORDER_HEADER_KEY in (
select order_header_key from yfs_order_header where order_no='Y100014866');

select * from yfs_order_header where order_no='US00020931';
//UPS AWB Generation
select message,createts from  yfs_export where Flow_name='IBD_UPSAWBReqDB' and EXPORT_KEY > '20250718' order by createts desc;

select message,createts from  yfs_export where Flow_name='IBD_UPSAWBResDB' and EXPORT_KEY > '20250718' order by createts desc;

select message,createts from  yfs_export where Flow_name='IBD_UPSAWBReqDB' and EXPORT_KEY between '20240918' and '20240920' order by createts desc;
select message,createts from  yfs_export where Flow_name='IBD_UPSAWBResDB' and EXPORT_KEY between '20250527' and '20250528' order by createts desc;

select message,createts from  yfs_export where Flow_name='IBD_UPSAWBReqDB' and EXPORT_KEY > '20250520' 
and message like '%US00016748%' order by createts desc;


select message,createts from  yfs_export where Flow_name='IBD_UPSRetReqDB' and EXPORT_KEY > '20250620' 
and message like '%Y100014832%' order by createts desc;


//Return
select message,createts from  yfs_export where Flow_name='IBD_UPSRetReqDB' and EXPORT_KEY > '20241217' order by createts desc;

select message,createts from  yfs_export where Flow_name='IBD_UPSRetReqDB' and EXPORT_KEY between '20250527'  
and  '20250528' order by createts desc;

select message,createts from  yfs_export where Flow_name='IBD_UPSRetResDB' and EXPORT_KEY > '20250430'  order by createts desc;


select message,createts from  yfs_export where Flow_name='IBD_UPSRetReqDB' and EXPORT_KEY > '20240910' order by createts desc;

Y100001383
//UPS AWB Generation
//AWB number checks

select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where modifyts>'20240627' and scac='UPSC';

select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where order_no in ('Y100015420');

select SCAC,shipment_no,order_no,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where Shipment_no in ('100013790');

select SCAC,shipment_no,order_no,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where Shipment_no IS NOT NULL 
and airway_bill_no IS NULL and createts>'20240529';

select SCAC,shipment_no,order_no,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where Shipment_no IS NOT NULL 
and airway_bill_no IS NOT NULL and createts>'20240528';

select ORDER_HEADER_KEY,ENTERPRISE_KEY,ORDER_NO,Hold_flag,createts from yfs_order_header where Order_no in (
select order_no from yfs_shipment where Shipment_no IS NOT NULL and airway_bill_no IS NOT NULL and createts>'20240528');
select SCAC,shipment_no,order_no,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where Shipment_no IS NOT NULL 
and airway_bill_no IS NOT NULL and createts>'20240528';

select SCAC,shipment_no,order_no,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where order_no in (
select ORDER_NO from yfs_order_header where createts>'20240530') order by createts desc;

select SCAC,shipment_no,order_no,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where createts>'20240529' order by createts desc;
//AWB Number

//all messages
select * from  yfs_export where EXPORT_KEY > '20250801' and message like '%00017701%' order by createts desc;
select * from  yfs_import where IMPORT_KEY > '20250801' and message like '%00018019%' order by createts desc;


select * from  yfs_import where IMPORT_KEY > '20250505' and flow_name='IBD_LogEmail' and message like '%US00015819%' order by createts desc;


select * from  yfs_export where EXPORT_KEY between '20250201' and '20250202' and message like '%Y100007293%' order by createts desc;
//all messages

select * from  yfs_export where EXPORT_KEY > '20250326' order by createts desc;

//US
select * from yfs_export where export_key > '20250601' and  flow_name like '%IBD_OrderDetailERPStoreDB%'  
 order by createts desc;
//GCC
select MESSAGE,CREATETS from yfs_export where export_key > '20250527' and  flow_name like '%IBD_OrderDetailOmniPossStoreDB%' order by createts desc;
select MESSAGE,CREATETS from yfs_export where export_key > '20250610' and  flow_name like '%IBD_OrderDetailOmniPossStoreDB%' 
and message like '%00006286%' order by createts desc;



select MESSAGE,CREATETS from yfs_export where export_key > '20250520' and  flow_name like '%OrderDetDB%' order by createts desc;


select * from  yfs_export where EXPORT_KEY > '20240920' and message like '%StatusCode="20"%' and flow_name in ('IBD_PostUpdatesToERPDB') order by createts desc;
select * from  yfs_export where EXPORT_KEY > '20241220' and flow_name like '%POS%' order by createts desc;

select * from  yfs_export where EXPORT_KEY between '20241114' and '20241115' and message like '%Y100002016%' order by createts desc;

select * from  yfs_import where IMPORT_KEY > '20240910' and message like '%dhrustar@gmail.com%' order by createts desc;


select * from  yfs_import where IMPORT_KEY between '20241223' and '20241224' and message like '%00010034%' order by createts desc;

select * from  yfs_export where EXPORT_KEY > '20240930' and Flow_name='IBD_OrderDetailOmniPossStoreDB' order by createts desc;

select * from  yfs_export where EXPORT_KEY > '20241001' and Flow_name='IBD_PostUpdatesToOMNIPOSSDB' order by createts desc;



select * from  yfs_export where EXPORT_KEY > '20240930' and Flow_name='Test_CancelUpdatesToOMNIPOSS' order by createts desc;
select * from  yfs_export where EXPORT_KEY > '20240930' and Flow_name='Test_ReturnUpdatesToOMNIPOSS' order by createts desc;


select * from yfs_charge_transaction where Order_header_key='20240507142916174605796' order by modifyts desc;


select ORDER_HEADER_KEY,ENTERPRISE_KEY,ORDER_NO,Hold_flag,createts from yfs_order_header where order_header_key>'20240531' 
order by modifyts desc;
select SCAC,shipment_no,order_no,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where Order_no in(
select ORDER_NO from yfs_order_header where order_header_key>'202405301700' order by modifyts desc) and createts>'20240530';

select ORDER_HEADER_KEY,ENTERPRISE_KEY,ORDER_NO,Hold_flag,createts from yfs_order_header where order_no='00009969' 
and enterprise_key='TITAN_US';

select SCAC,shipment_no,order_no,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where Order_no  in ('US00019290');
//in (select ORDER_NO from yfs_order_header where order_no='00001350' and enterprise_key='TITAN_GCC');

select * from yfs_export where flow_name like '%email_DB%' order by modifyts desc;

select * from yfs_import where flow_name like '%IBD_LogEmail%' and createprogid= 'IBD_CreateOrderMsgIntegServer' order by modifyts desc;

select * from  yfs_export where Flow_name='IBD_OrderDetailOmniPossStoreDB' and message like '%00002102%' order by createts desc;

select * from  yfs_export where Flow_name='IBD_OrderDetailOmniPossStoreDB' and message like '%00002102%' 
and Export_key >'20240515' order by createts desc;

select * from  yfs_export where Flow_name='IBD_OrderDetailERPStoreDB' and message like '%00002102%' order by createts desc;
select * from  yfs_export where Flow_name='IBD_OrderDetailERPStoreDB' and message like '%00002412%' order by createts desc;


select * from yfs_export where Export_key >'20250216' and message like '%00013275%' order by createts desc;

select * from  yfs_import where Flow_name='SFCC_CO_XML_DB'and import_key >'20250801'  order by createts desc;

select * from  yfs_import where Flow_name='SFCC_CO_XML_DB'and import_key >'20250401' and message like '%US00014651%'  order by createts desc;
//or message like '%00002412%') order by createts desc;

select * from  yfs_import where Flow_name='SFCC_CO_XML_DB' and import_key between '20250310' and '20250311'  
and message like '%00009790%' order by createts desc;

select * from yfs_export where export_key>'20240913' and flow_name like '%SFCC_OrderCancel_DB%' and 
message like '%00003852%' order by createts desc;

select MESSAGE,CREATETS from yfs_export where export_key > '20250723' and  flow_name like '%IBD_OrderDetailOmniPossStoreDB%' order by createts desc;

select MESSAGE,CREATETS from yfs_export where export_key > '20250420' and  flow_name like '%IBD_OrderDetailOmniPossStoreDB%' 
and message like '%00011809%' order by createts desc;

select * from  yfs_export where Export_key >'20240515' and message like '%00001409%' order by createts desc;
select Order_no,createts,createuserid,EXTN_CUSTOMER_NO,EXTN_ENCIRCLE_NO from yfs_order_header where order_no in ('00002102','00002412');

select SCAC,shipment_no,order_no,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where Order_no ='00007853';

select SCAC,shipment_no,order_no,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where SCAC = 'TRANSGUARD' 
and AIRWAY_BILL_NO is null and createts>'20240531' order by modifyts desc;
select SCAC,shipment_no,order_no,AIRWAY_BILL_NO,order_no,createts,modifyts from yfs_shipment where SCAC = 'TRANSGUARD' 
and AIRWAY_BILL_NO is not null and createts>'20240525' order by createts desc;

select * from yfs_export where Export_key >'20241118' and message like '%Y100002829%' order by modifyts desc;
select * from yfs_import where import_key >'20240601' and message like '%00001391%' order by createts desc;

select * from yfs_shipment where Order_no in(
'00001086','00001170','00001219','00001350','00001276','00001369','00001284','00001372','00001298','00001300','00001379','00001385');
select * from yfs_shipment_line;

select message,createts from  yfs_export where Flow_name='IBD_UPSRetReqDB' and EXPORT_KEY > '20240601' and message like '%Y100000823%' order by createts desc;
select message,createts from  yfs_export where Flow_name='IBD_UPSRetResDB' and EXPORT_KEY > '20240601' and message like '%Y100000823%' order by createts desc;

select * from  yfs_export where Flow_name='IBD_UPSRetReqDB' and EXPORT_KEY > '20250624' order by createts desc;
 
select * from  yfs_export where Flow_name='IBD_UPSRetResDB' and EXPORT_KEY > '20250624' order by createts desc;

select SCAC,shipment_no,order_no,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where Order_no in (
'Y100014832');

select * from yfs_task_q where task_q_key>'20250601' and data_type='OrderHeaderKey' and data_key in (
select order_header_key from yfs_order_header where order_no in('US00017887'));

select * from yfs_order_header where order_no in ('US00017035','US00017048');

select * from yfs_order_header where enterprise_key='TITAN_US' order by createts desc;

select ORDER_HEADER_KEY,PRIME_LINE_NO,ITEM_ID,ORDERED_QTY,EXTN_SELLER_LINE_NO from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no='US00019399');

select * from  yfs_import where Flow_name='SFCC_CO_XML_DB' and (message like '%38470096025%') order by createts desc;

select SCAC,shipment_no,order_no,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where Order_no in (
'US00020649');

select * from yfs_reprocess_error where ERRORTXNID > '20240613' and FLOW_NAME like '%IBD_AWBNoAndShipment_Async%' and STATE='Initial';

select message,createts from  yfs_export where Flow_name='IBD_UPSRetReqDB' and EXPORT_KEY > '20240618' order by createts desc;
select message,createts from  yfs_export where Flow_name='IBD_UPSRetResDB' and EXPORT_KEY > '20240618'  order by createts desc;




// Inventory  queries
SELECT  yi.ITEM_ID,yi.Organization_code,yi.EXTN_ITEM_CODE,yi.EXTN_LOT_NO,yi.POSTING_CLASSIFICATION,yi.EXTN_PRODUCT_CODE
FROM aws_ster_sch.YFS_ITEM yi WHERE yi.EXTN_ITEM_CODE IN ('UL2994SFJADA022JA000007');


SELECT  yi.ITEM_ID,yi.Organization_code,yi.EXTN_ITEM_CODE,yi.EXTN_LOT_NO,yi.POSTING_CLASSIFICATION,yi.EXTN_PRODUCT_CODE
FROM aws_ster_sch.YFS_ITEM yi WHERE yi.item_id in  ('ECS1D1YAVGAQ733IH000001','EL2993YVGGAA022JA000006',
'EL3024NFPAAA322HD000002','EL5924BDDBAA132JA000003','ELD1I2YEMMAA342JA000007','ELD3PLBAMLAA041BL000001',
'EL0934SJAAAA022JA000022','EL1002SAEAAB043IH000005','EL1047SDFAAB022JA000029','EL1066SMWAAA022JA000037');



select SHIPNODE_KEY,QUANTITY,CREATETS,MODIFYTS,MODIFYPROGID from yfs_inventory_Supply where INVENTORY_ITEM_KEY in (
select INVENTORY_ITEM_KEY from yfs_inventory_item where Item_id in( 'EL3013HZGAAA002EE000016'));

select SHIPNODE_KEY,QUANTITY,CREATETS,MODIFYTS from yfs_inventory_demand where INVENTORY_ITEM_KEY in (
select INVENTORY_ITEM_KEY from yfs_inventory_item where Item_id in( ));

select ITEM_ID,PRODUCT_CLASS,NODE,AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where ITEM_ID like '%UP4013DQTABA401BL000003%' ;
//and available_qty>0
// Inventory queries

//get inv for all items in GCC not working as lot of duplicates
select yi.ITEM_ID,yi.Organization_code,yi.EXTN_ITEM_CODE,yi.EXTN_LOT_NO,yi.POSTING_CLASSIFICATION,yi.EXTN_PRODUCT_CODE,
ys.SHIPNODE_KEY, ys.QUANTITY, ys.CREATETS, ys.MODIFYTS
from aws_ster_sch.YFS_ITEM yi, aws_ster_sch.yfs_inventory_item yii, aws_ster_sch.yfs_inventory_Supply ys, aws_ster_sch.yfs_inventory_demand yd
where yi.Organization_code = 'TITAN_GCC' and
yi.ITEM_ID = yii.Item_id and
ys.INVENTORY_ITEM_KEY = yii.INVENTORY_ITEM_KEY and 
ys.QUANTITY>0;


select message,createts from  yfs_export where Flow_name='IBD_AvalaraCommitReq' and EXPORT_KEY > '20240624'  
and (message like '%00002705%' or message like '%00002704%') order by createts desc;

//2024-06-21 00:47:47.0
select message,createts from  yfs_export where Flow_name='IBD_AvalaraCommitRes' and EXPORT_KEY > '20240624' order by createts desc;

select * from yfs_flow where flow_name like '%IBD_StatusUpdatesToERP%';

select Order_no,order_header_key from yfs_order_header where order_no in ('00002925','00002877','00002923','00002850');

select * from YFS_ORDER_HOLD_TYPE where status ='1100' and ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_no in ('00002848'));
//,'00002877','00002923','00002850' ));

select message,createts from  yfs_export where Flow_name='IBD_JPMorganReq' and EXPORT_KEY > '20250326'  order by createts asc;

select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganReq' and EXPORT_KEY > '20240621' 
and message like '%00002698%' order by createts desc;
select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganResponse' and EXPORT_KEY > '20250326' order by createts desc;

select * from yfs_charge_transaction where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_no='00017247' and enterprise_key='TITAN_GCC' ) order by modifyts desc;

select * from YFS_PAYMENT where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_no='US00018043' ) order by modifyts desc;



//Invoice
select * from YFS_ORDER_INVOICE where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_no='00006528' ) order by modifyts desc;

select ORDER_HEADER_KEY from yfs_order_header where order_no='Y100000809';
select * from YFS_ORDER_INVOICE where Invoice_no='3756';
//Invoice Export
select * from  yfs_export where EXPORT_KEY > '20240602' and createuserid='CreateReturnOrderInvcIntegServer'
and message like '%00002680%' order by createts desc;


select * from yfs_export where Export_key >'20241113' and message like '%00011839%' order by modifyts desc;
select * from yfs_import where import_key >'20241113' and message like '%00011839%' order by createts desc;

select * from yfs_order_header where order_header_key>'20250101' and HOLD_FLAG='N' 
and SELLER_ORGANIZATION_CODE='TITAN_US' and DOCUMENT_TYPE='0001' order by createts desc;

select * from yfs_order_header where order_header_key>'20250101'  
and SELLER_ORGANIZATION_CODE='TITAN_GCC' and DOCUMENT_TYPE='0001' order by createts desc;


select unique(Flow_name) from yfs_export;
select unique(Flow_name) from yfs_import;

select * from yfs_charge_transaction where ORDER_HEADER_KEY in('20240626134945197641004' ) order by modifyts desc;


select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,order_no,createts,modifyts from yfs_shipment where order_no in (
'00011724') ;


select * from yfs_export where export_key>'20240530'  and message like '%00002611%' ;
select * from yfs_export where export_key>'20240610' and message like '%100004156%' ;
select * from yfs_import where import_key>'20240610' and message like '%100004156%' ;

select * from yfs_export where export_key>'20240630' and message like '%00002333%' ;
select * from yfs_export where export_key>'20240525' and message like '%100004004%';
select * from yfs_import where import_key>'20240610' and message like '%100004004%' ;

select Count(*) from yfs_export where export_key>'20240501' and flow_name like '%TransguardStatusUpdates%';
select *  from yfs_export where export_key>'20250811' and flow_name like '%TransguardCreateOrder%' order by createts desc;
select *  from yfs_export where export_key>'20250430' and flow_name like '%TransguardReturnOrder%'  order by createts desc;

select *  from yfs_export where export_key>'20250415' and flow_name like '%TransguardReturnOrder%' 
and message like '%100013929%' order by createts desc;

select *  from yfs_export where export_key>'20250720' and flow_name like '%TransguardCreateOrder%' 
and message like '%00017413%' order by createts desc;

select *  from yfs_export where export_key between '20250326' and '20250327' and flow_name like '%TransguardReturnOrder%'  order by createts desc;

select *  from yfs_export where export_key>'20250410' and flow_name like '%TransguardReturnOrder%'
and message like '%Y100011835%' order by createts desc;

select *  from yfs_export where export_key>'20250101' and flow_name like '%TransguardReturnOrder%'
and message like '%btqxsr@titancompany.com%' order by createts desc;


Y100000959
Y100000961
//UPS ReturnToOrigin using AWB Number
select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where order_no in ('US00015819');

select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,createts from yfs_shipment where AIRWAY_BILL_NO in ('1ZE4B3942631013506');

select MESSAGE,CREATETS from yfs_export where export_key>'20250505'  and flow_name like '%UPS_TrackShipmentDB%' 
and message like '%1ZE4B3944214620281%' order by createts desc ;

select * from yfs_export where export_key between '20250604'  and  '20240501'  and flow_name like '%UPS_TrackShipmentDB%' 
and message like '%1ZX4029YA800282120%' order by modifyts desc ;

select * from yfs_export where export_key > '20250620' and flow_name like '%UPS_TrackShipmentDB%' 
and message like '%<code>UA</code>%' order by modifyts desc ;


select MESSAGE,CREATETS from yfs_export where export_key>'20250620'  and flow_name like '%UPS_TrackShipmentDB%' 
 order by createts desc ;

select * from yfs_export where export_key>'20240901'   
and message like '%returned%' order by modifyts desc ;

select * from yfs_export where export_key>'20241101' and export_key<'20241231' and flow_name like '%UPSTrackResDB%' 
and  message like '%UA%' order by modifyts desc;

select * from yfs_export where export_key>'20240929' and flow_name like '%ACKDB1%' 
and  message like '%1ZX4029YA822716665%' order by modifyts desc;


select * from yfs_export where export_key between '20250604' and '20250610'  and flow_name like '%UPS_TrackShipmentDB%' order by modifyts desc ;

select ORDER_HEADER_KEY,PRIME_LINE_NO,ITEM_ID,ORDERED_QTY,EXTN_SELLER_LINE_NO from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no='00009953');

select * from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no in ('00013996')) order by order_header_key;

select * from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where ENTERPRISE_KEY='TITAN_GCC' and document_type='0001' 
and order_no in ('00013982','00013984','00013933','00013992','00013996')) order by createts desc;


select * from yfs_order_header where order_header_key in (
'20250604045731390505165','20250604042132390496254','20250604032136390486928','20250604015432390279749','20250604014045390278004');

select * from yfs_order_release where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no in ('US00019808')) order by order_header_key;



select * from yfs_order_release_status where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no in ('US00020585') and ENTERPRISE_KEY='TITAN_US' ) order by createts desc;

select * from yfs_order_release_status where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no in (
'US00021056','US00021031','US00021021','US00021019','US00020924','US00020929','US00020935','US00021004','US00020994',
'US00020992','US00020965','US00020906','US00020958','US00020891','US00020823','US00020808','US00020737','US00020730',
'US00020723','US00020781','US00020719','US00020759','US00020753','US00020649','US00020645','US00020640','US00020660',
'US00020657','US00020539','US00020520'
) and ENTERPRISE_KEY='TITAN_US'  and STATUS_QUANTITY='1') order by createts desc;




select * from yfs_order_release_status where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no in ('00016679') and ENTERPRISE_KEY='TITAN_GCC') order by CREATETS,STATUS asc;


select * from yfs_order_release_status where order_line_key in ('20250116190951298250982') order by status desc;

select * from yfs_order_release_status where ORDER_RELEASE_STATUS_KEY>'20250526' and  status='9000';

select * from yfs_order_header where Order_header_key in ('20250807175948439108912','20250807175948439108912','20250807075448438692862',
'20250806152948438317530','20250806021948437680099','20250805221949437519986');

select * from yfs_order_header where Order_header_key>'20230101' and order_type='RTO' order by modifyts desc;

select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where Order_no in ('Y100005175',
'Y100005177','Y100005178','Y100005179','Y100005180','Y100005183','Y100005183','Y100005183','Y100005181','Y100005182');
select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where AIRWAY_BILL_NO in ('1ZX4029Y7805345174');

select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where AIRWAY_BILL_NO='1ZX4029YA800282120';

select * from yfs_export where export_key>'20240701' and message like '%1ZX4029YA832450307%' order by createts desc;

select Count(*) from yfs_export where export_key>'20240501' and flow_name like '%TransguardStatusUpdates%';


select * from yfs_inventory_Supply where modifyts>'20240704' and modifyprogid='IBDReceiveStoreUpdatesOMNIIntegServer' order by modifyts desc;

select * from yfs_inventory_item where INVENTORY_ITEM_KEY in (
select INVENTORY_ITEM_KEY from yfs_inventory_Supply where modifyts>'20240704' and modifyprogid='IBDReceiveStoreUpdatesOMNIIntegServer');


select * from yfs_reprocess_error where ERRORTXNID > '20240704' and FLOW_NAME like '%IBD_UpdateInventory_Async%' 
and STATE='Initial' and Errorstring not like '%Invalid Item%' order by createts desc;

select * from yfs_heartbeat where status='00' and server_name ='IBDReceiveStoreInvUpdateIntegServer' order by modifyts desc;

select FLOW_NAME,errorcode,STATE,message,createts, modifyts from yfs_reprocess_error where ERRORTXNID > '20240705' and FLOW_NAME like '%IBD_ReceiveStatusUpdateFromOMNIPOSS_Async%' order by createts desc;

select * from  yfs_import where import_key>'20240709' and Flow_name='SFCC_CO_XML_DB'  order by createts desc;

select * from  yfs_export where export_key>'20240708' and Flow_name='IBD_OrderDetailERPStoreDB' order by createts desc;


select * from yfs_export where  export_key>'20250707' and flow_name like '%SF_Inv_Inp%' order by createts desc;
select * from yfs_export where  export_key>'20250707' and flow_name like '%SF_Inv_Out%' order by createts desc;

select * from  yfs_export where export_key>'20241201'and message like '%Y100003973%' order by createts desc;
select * from  yfs_import where import_key>'20240709'and message like '%00002105%' order by createts desc;


select Order_header_key from yfs_order_line where item_id='UP2757SAVAEA081BL000012' order by createts desc;

select * from yfs_order_header where Order_header_key in (
select Order_header_key from yfs_order_line where item_id in ('UP2757SAVAEA081BL000012'));

select * from yfs_order_header where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_line where item_id='UPD3B12HLAAA002EE000001');

select * from yfs_order_header where CUSTOMER_EMAILID_LC='dhrustar@gmail.com' order by createts desc;

select * from yfs_order_header where CUSTOMER_FIRST_NAME_LC='dhruvesh';

select ENTERPRISE_KEY, order_no,CUSTOMER_EMAILID,BUYER_USER_ID, CUSTOMER_EMAILID_LC,CUSTOMER_FIRST_NAME_LC,CUSTOMER_LAST_NAME_LC,MODIFYUSERID, modifyts
from yfs_order_header where BUYER_USER_ID!=CUSTOMER_EMAILID order by createts desc;

select * from yfs_person_info where PERSON_INFO_KEY in 
('20250818001350446374475','20250818001350446374476','20250818001350446374477','20250818001350446374482');

select * from yfs_person_info where emailid='shella.pagute@gmail.com';

select order_no,CUSTOMER_PHONE_NO,CUSTOMER_EMAILID_LC,BUYER_USER_ID,CUSTOMER_EMAILID from yfs_order_header 
where order_no in('US00021474');

select * from yfs_order_header where order_no='US00021474';
CUSTOMER_EMAILID_LC,BUYER_USER_ID,CUSTOMER_EMAILID


select * from yfs_order_header where order_no='00013103';
select * from yfs_order_header_h  order by createts desc;

select * from yfs_order_line where order_header_key in (
select order_header_key from yfs_order_header where CUSTOMER_EMAILID_LC='rohanmohan1997@gmail.com')order by createts desc;

select * from yfs_order_header where Order_header_key in (
select DERIVED_FROM_ORDER_HEADER_KEY from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_header_key>'20240701' 
and SELLER_ORGANIZATION_CODE='TITAN_US' and DOCUMENT_TYPE='0003' order by createts desc));


select ORDER_HEADER_KEY from yfs_order_line where   DERIVED_FROM_ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no='00009327' 
and SELLER_ORGANIZATION_CODE='TITAN_US' and DOCUMENT_TYPE='0001') order by createts desc;


select * from yfs_task_q where task_q_key>'20241201' and data_type='OrderHeaderKey' and data_key in (
select order_header_key from yfs_order_header where order_no='00009327');


select * from yfs_task_q where task_q_key>'20240601' and data_type='OrderHeaderKey';
select unique(TRANSACTION_KEY) from yfs_task_q;

select * from yfs_order_header where order_header_key in (
select DATA_KEY from yfs_task_q where task_q_key>'20240501' and data_type='OrderHeaderKey' 
and ( TRANSACTION_KEY like 'RELEASE%' or TRANSACTION_KEY like '%SCHEDULE%'));

select * from yfs_task_q where task_q_key>'20240501' and data_type='OrderHeaderKey' 
and ( TRANSACTION_KEY like 'RELEASE%' or TRANSACTION_KEY like '%SCHEDULE%');

select ORDER_HEADER_KEY,PRIME_LINE_NO,ITEM_ID,ORDERED_QTY,EXTN_SELLER_LINE_NO from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no='US00014581');


select * from yfs_shipment_line where SHIPMENT_KEY in (select SHIPMENT_KEY from yfs_shipment where order_no='Y100011075');
select * from yfs_order_header where order_no='00002887';
select ORDER_HEADER_KEY,PRIME_LINE_NO,ITEM_ID,ORDERED_QTY,EXTN_SELLER_LINE_NO from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no='00002887');


select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where order_no in ('US00020440');

select *  from yfs_export where export_key>'20241201' and flow_name like '%TransguardCreateOrder%' order by createts desc;

select * from yfs_reprocess_error where ERRORTXNID > '20240715' and FLOW_NAME like '%IBD_ReceiveStatusUpdateFromOMNIPOSS_Async%'  order by createts desc;

select unique(flow_name) from yfs_export;

//00002105      -       20240706040951201377135     -   2024-07-28 00:00:00.0       -   
select * from yfs_order_header where order_header_key in (  
select * from yfs_task_q where task_q_key>'20240601' and data_type='OrderHeaderKey' 
and ( TRANSACTION_KEY like 'RELEASE%' or TRANSACTION_KEY like '%SCHEDULE%'));

//2024-07-09 07:03:22.0

//2024-07-28 00:00:00.0
select * from YFS_ORDER_LINE_SCHEDULE where order_header_key in (
select order_header_key from yfs_order_header where order_no='US00019808' and ENTERPRISE_KEY='TITAN_US') order by createts desc;



select * from yfs_order_header where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from YFS_ORDER_HOLD_TYPE where status ='1100' and HOLD_TYPE='CC_REFUND_HOLD' and ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where HOLD_FLAG='Y' and modifyts > '2024-06-25' and ENTERPRISE_KEY='TITAN_GCC') )order by modifyts desc; 

select * from yfs_flow where flow_name like '%IBD_SQLProcessor%';





select * from yfs_order_release_status where  ORDER_HEADER_KEY in (
select order_header_key from yfs_order_header where Order_no in ('US00017620') and ENTERPRISE_KEY='TITAN_US' ) order by status_date desc;

select * from yfs_order_release_status where status='3700' and CREATEUSERID='IBD_TransguardShipmentStatusUpdateServer';

select * from yfs_order_invoice where  ORDER_HEADER_KEY in (
select order_header_key from yfs_order_header where Order_no in ('00003297') and ENTERPRISE_KEY='TITAN_GCC') ;


select * from yfs_order_release_status where status = '3700.7777' and ORDER_LINE_KEY='20240722113955207820422';

select * from yfs_export where export_key>'20241207' and message like '%1ZX4029YA823429830%' order by createts desc;


select * from yfs_export where  export_key>'20240716' and flow_name like '%SF_Inv_Inp%' and message order by createts desc;
select * from yfs_export where  export_key>'20240716' and flow_name like '%SF_Inv_Out%' order by createts desc;

select * from yfs_person_info where person_info_key ='20240714113407204570780';

select * from yfs_person_info where EMAILID='praveenkumar.elagala@gmail.com'; 

select * from yfs_order_header where order_header_key>'20240801' and ENTERPRISE_KEY='TITAN_US' and DOCUMENT_TYPE='0003';
select * from yfs_order_header where order_header_key>'20250526' and ENTERPRISE_KEY='TITAN_GCC' and DOCUMENT_TYPE='0003';

select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where order_no in (
select order_no from yfs_order_header where order_header_key>'20240801' and ENTERPRISE_KEY='TITAN_US' and DOCUMENT_TYPE='0003');



select ORDER_HEADER_KEY, ORDER_NO from yfs_order_header where Order_header_key in (
select DERIVED_FROM_ORDER_HEADER_KEY from yfs_order_line where ORDER_HEADER_KEY in (
select order_header_key from yfs_order_header where order_header_key>'20240801' and ENTERPRISE_KEY='TITAN_US' and DOCUMENT_TYPE='0003')) order by modifyts desc;;

select ORDER_HEADER_KEY,DERIVED_FROM_ORDER_HEADER_KEY from yfs_order_line where ORDER_HEADER_KEY in (
select order_header_key from yfs_order_header where order_header_key>'20240801' and ENTERPRISE_KEY='TITAN_US' and DOCUMENT_TYPE='0003') order by modifyts desc;;

select ORDER_HEADER_KEY, ORDER_NO from yfs_order_header where order_header_key>'20240401' and ENTERPRISE_KEY='TITAN_US' and DOCUMENT_TYPE='0003';


select *  from yfs_export where export_key>'20240627' and flow_name like '%TransguardCreateOrder%' order by createts desc;


select * from yfs_inventory_Supply where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item 
where Item_id='UP0148BBABAA002JA000065');

select * from TITAN_DADI_INV_AVL_STAGING where ITEM_ID in (
'ELUDP3DDEADA323IH000005');

select * from yfs_export where export_key>'20240704' and export_key<'20240707' and message like '%EP3515BEJBAA002JA000021%' order by createts desc;
//SF_Inv_Inp      SF_Inv_Out

select * from yfs_export where export_key>'20241002' and flow_name like '%SFCC_OrderCancel_DB%' 
and message like '%00005566%' order by createts desc;

select * from yfs_order_header where order_no in ('00003305','00003511','00003654');



select * from yfs_reprocess_error where ERRORTXNID > '20241201' 
and FLOW_NAME like '%IBD_ReceiveStatusUpdatesFromTransguardAsync%'  and message like '%100009683%' order by createts desc;

select FLOW_NAME,STATE,ERRORSTRING,MESSAGE,MODIFYTS from yfs_reprocess_error where ERRORTXNID > '20241201' 
and FLOW_NAME like '%IBD_ReceiveStatusUpdatesFromTransguardAsync%' and modifyts > '20241217' order by createts desc;

select * from yfs_export where flow_name='TransguardStatusUpdates' order by modifyts desc;



select * from yfs_export where export_key>'20250130' and message like '%00011357%' order by createts desc;
select * from yfs_import where import_key>'20240723' and message like '%00002454%' order by createts desc;
select * from yfs_export where export_key>'20240719' and message like '%Y100000918%' order by createts desc;

select unique(flow_name) from yfs_export where flow_name like '%SF%';

select * from yfs_export where export_key > '20250512' and flow_name like '%SF_ResInv_Input_DBTrace%' order by createts desc;
select * from yfs_export where export_key > '20250512' and flow_name like '%SF_ResInv_Output_DBTrace%' order by createts desc;

select * from yfs_export where export_key between '20250512' and '20250513' and flow_name like '%SF_ResInv_Input_DBTrace%' order by createts desc;
select * from yfs_export where export_key between '20250512' and '20250513' and flow_name like '%SF_ResInv_Output_DBTrace%' order by createts desc;


select * from yfs_export where export_key > '20250715'  and flow_name like '%SF_ResInv_Input_DBTrace%'
and message like '%UP1107CVBGAA002JA000043%'; 
select * from yfs_export where export_key > '20250715' and flow_name like '%SF_ResInv_Output_DBTrace%'
and message like '%UP1107CVBGAA002JA000043%';

select * from yfs_export where  export_key>'20250715' and flow_name like '%SF_CanResInv_Input_DBTrace%' 
and message like '%UP1107CVBGAA002JA000043%';

select * from yfs_export where export_key>'20240721' and flow_name like '%SFCC_OrderCancel_DB%' 
and message like '%00003654%' order by createts desc;

select * from yfs_export where export_key>'20240731' and message like '%1ZX4029Y7829677593%' order by modifyts desc;


select * from yfs_shipment_line where shipment_key in (select shipment_key from yfs_shipment where shipment_no='100004876');






//Manually marking as paid
select * from YFS_CHARGE_TRANSACTION where order_header_key in
(select order_header_key from yfs_order_header where 
order_no='00013287'
and ENTERPRISE_KEY='TITAN_US') order by modifyts asc;



select * from yfs_payment where order_header_key in
(select order_header_key from yfs_order_header where order_no='US00018043' and ENTERPRISE_KEY='TITAN_US') order by modifyts desc;

select * from yfs_order_header where Order_no in ('00002329','00002190','00002446') and ENTERPRISE_KEY='TITAN_GCC';

select * from yfs_order_line where order_header_key in (
select order_header_key from yfs_order_header where order_no='Y100015538' and ENTERPRISE_KEY='TITAN_US');

select * from YFS_REFERENCE_TABLE where TABLE_NAME='YFS_ORDER_LINE' and TABLE_KEY in ('20250625222007405918823','20250710092346417192182') order by modifyts desc;


//US
select * from YFS_CHARGE_TRANSACTION where order_header_key in
(select order_header_key from yfs_order_header where order_no='00003731' and ENTERPRISE_KEY='TITAN_US') order by modifyts;

select ORDER_HEADER_KEY,PAYMENT_TYPE,PAYMENT_REFERENCE2 from yfs_payment where order_header_key in
(select order_header_key from yfs_order_header where order_no='00004322' and ENTERPRISE_KEY='TITAN_US') order by modifyts desc;

//Manually marking as paid end

select * from yfs_payment where order_header_key in
(select order_header_key from yfs_order_header where order_no='00007988' and ENTERPRISE_KEY='TITAN_US') order by modifyts desc;


//JPMC
select message,createts from  yfs_export where Flow_name='IBD_JPMorganReq' and EXPORT_KEY > '20250610'  order by createts desc;
//
select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganReq' and EXPORT_KEY between  '20241105' and '20241106' 
order by createts desc;
//and message like '%00007716%' order by createts desc;

select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganResponse' and EXPORT_KEY > '20250610' order by createts desc;

select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganResponse' and EXPORT_KEY between  '20241105' and '20241106' 
order by createts desc;


select * from YFS_ORDER_RELEASE_STATUS where order_header_key in
(select order_header_key from yfs_order_header where order_no='00002190' and ENTERPRISE_KEY='TITAN_US') order by order_line_key, STATUS desc;

select * from yfs_export where export_key>'20240807' and message like '%00002816%' order by modifyts desc;

select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%IBD_OrderDetailOmniPoss%');
//Orders filtered by Delivery date 

select * from YFS_ORDER_RELEASE_STATUS where order_header_key in
(select order_header_key from yfs_order_header where order_no='00016059') order by order_line_key, STATUS_DATE desc;

select * from yfs_order_release_status where status='3700.7777' and STATUS_DATE between '20240727' and '20240728';

select * from YFS_ORDER_HEADER where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_release_status where status='3700.7777' and STATUS_DATE between '20240727' and '20240728' );
//Orders filtered by Delivery date 

select order_header_key, count(*) from yfs_order_line where createts>'20240807' group by order_header_key order by 2 desc;

select * from yfs_order_header where ENTERPRISE_KEY='TITAN_GCC' and  order_header_key in (
'20240816185311216524147') order by createts desc;

//AWB report generation
select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where order_no in('Y100003513');

select ORDER_NO,order_header_key from yfs_order_header where Order_header_key > '20250101'  and ENTERPRISE_KEY='TITAN_GCC' 
and document_type='0003' order by createts desc;


select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where order_no in (
select ORDER_NO from yfs_order_header where Order_header_key between '20240701' and '20240801' and ENTERPRISE_KEY='TITAN_US' 
and document_type='0003') order by createts desc;

select ORDER_HEADER_KEY,DERIVED_FROM_ORDER_HEADER_KEY from yfs_order_line where Order_header_key in (
select Order_header_key from yfs_order_header where Order_header_key between '20240701' and '20240801' and ENTERPRISE_KEY='TITAN_US' 
and document_type='0003');

select Order_header_key, Order_no from yfs_order_header where Order_header_key in (
'20240721121453207446652','20240714034407204030138','20240723150453208263986','20240723150453208263986','20240723001453207864080',
'20240718012907205897684','20240716125907205410194','20240714011407204011444','20240715154407204991807','20240709023945202398771',
'20240627201947198064509','20240630125945199230870','20240710104908203018039','20240710104908203018039','20240710104908203018039',
'2023122814190080269164','20240702000446199616641','20240513111443177659075','20240630150446199234307','20240706110945201614530',
'20240705095445201097760','20240704231445200841563','20240705140948201256147','20240628102948198345517','20240628102948198345517',
'20240704150945200825799','20240620124233195110441','20240701233945199614714','20240701120949199601897','20240626233945197654171',
'20240616115734193312532','20240628122945198504133','20240610174733191078419','20240528115733185239733');


select * from yfs_order_line where order_header_key in (
select order_header_key from yfs_order_header where order_no in 
('Y100013152') and enterprise_key='TITAN_GCC');


select * from YFS_REFERENCE_TABLE where TABLE_NAME='YFS_ORDER_LINE' and TABLE_KEY in ('20250514052132378033469');


select ORDER_HEADER_KEY,PRIME_LINE_NO,ITEM_ID,ORDERED_QTY,EXTN_SELLER_LINE_NO from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no='00003055' and ENTERPRISE_KEY='TITAN_GCC');

select * from yfs_export where export_key>'20240820' and flow_name like '%TransguardStatusUpdates%'  order by modifyts desc;

select ITEM_ID,EXTN_ITEM_CODE,EXTN_LOT_NO,unit_weight  from yfs_item where ORGANIZATION_CODE='TITAN_GCC' and (unit_weight='0.0000') and EXTN_ITEM_CODE is not null and EXTN_LOT_NO is not null;
select * from yfs_item where ORGANIZATION_CODE='TITAN_GCC' and (unit_weight='0.0000') and EXTN_DOMESTIC_REF is not null ;

select * from yfs_item where ORGANIZATION_CODE='TITAN_GCC' and (unit_weight='0.0000');
select * from yfs_item where item_id in ('UTD3D1FPULAA043IH000003');


select Item_id,unit_weight,organization_code,createts,modifyts from yfs_item where unit_weight='0' and length(trim(Item_id)) > '20' 
and organization_code='TITAN_GCC' order by createts desc;

select * from yfs_export where export_key>'20240816' and message like '%00002979%' order by createts desc;

select ORDER_HEADER_KEY,PRIME_LINE_NO,ITEM_ID,ORDERED_QTY,EXTN_SELLER_LINE_NO from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no='00003523');


select * from yfs_order_header where order_header_key > '202408280948' and order_header_key <'202408300445' and
enterprise_key='TITAN_GCC' order by createts desc;

select * from yfs_order_line where order_header_key in (
select order_header_key from yfs_order_header where order_header_key > '202408280948' and order_header_key <'202408300445' 
and enterprise_key='TITAN_GCC' order by createts desc);

select * from TITAN_DADI_INV_AVL_STAGING where ITEM_ID in (
'ET4015CAFGAA002BD000008','EL0934SBAAAA023IA000014','EL1047FDLLAB023IA000013','EL1042PAAAAA022JD000007','EL1718DGEAAA022JA000004',
'EP0561VTAK1A002EA000017','EP1159SYCAGA002EA000049','EPD3D1SHKABA002EA000006','EP1518DDHABA002EA000004','EL1720PHRAAA322JA000023',
'EL3023FFFLAA022JA000007','EP3023SBLABA002EE000002');





select * from YFS_ORDER_HOLD_TYPE where status ='1100' and ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where HOLD_FLAG='Y' and modifyts > '2024-07-15' and ENTERPRISE_KEY='TITAN_US' and order_no in (
'00003530','00003532','00002638','00003930','00003886','00004024','00004055','00004104','00004157','00004157','00004243','00004322','00003731')) 
and modifyts > '2024-07-15' order by modifyts desc; 

select Order_no, Order_header_key from yfs_order_header where order_header_key in ('20240818183809217158254','20240816111809216489960',
'20240808212809213727819','20240802233810211898958','20240807195310213468627','20240801234309211494968','20240727190953209869053',
'20240826130126220129613');


select * from YFS_ORGANIZATION ;


select * from yfs_ship_node where owner_key='TITAN_GCC';

select FLOW_NAME,USER_REFERENCE,message,createts from yfs_export where EXPORT_KEY > '20240906' and message like '%00004733%' order by createts desc;


select FLOW_NAME,USER_REFERENCE,message,createts from yfs_export where EXPORT_KEY between '20240907' and '20240908' 
and message like '%00004733%' order by createts desc;


select * from yfs_export where export_key>'20240911' and flow_name like '%SFCC_OrderCancel_DB%' order by createts desc;


select * from yfs_order_header where document_type='0003' and ENTERPRISE_KEY='TITAN_US' order by modifyts desc;


select * from  yfs_import where IMPORT_KEY > '20240917' and flow_name like '%IBD_LogEmail%' order by createts desc;


select * from yfs_export where export_key>'20241213' and flow_name like '%SF_OrderDetailInp%' order by createts desc;
select * from yfs_export where export_key>'20240910' and flow_name like '%SF_OrderDetailOut%' order by createts desc;

select * from yfs_export where export_key>'20241213' and flow_name like '%Test_DB_01%' 
and USER_REFERENCE='SFCC=GetOrder_Details'  order by createts desc;


SELECT  yi.ITEM_ID,yi.Organization_code,yi.EXTN_ITEM_CODE,yi.EXTN_LOT_NO,yi.POSTING_CLASSIFICATION,yi.EXTN_PRODUCT_CODE
FROM aws_ster_sch.YFS_ITEM yi WHERE yi.item_id IN ('EPD2D12YYABA002EE000022');


select ORDER_HEADER_KEY,PRIME_LINE_NO,ITEM_ID,ORDERED_QTY,EXTN_SELLER_LINE_NO from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no='00004596' and ENTERPRISE_KEY='TITAN_US');

select * from YFS_CHARGE_TRANSACTION where order_header_key in
(select order_header_key from yfs_order_header where order_no='00003984' and ENTERPRISE_KEY='TITAN_GCC') order by modifyts;




select * from yfs_inventory_Supply  where  INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item  where 
Item_id in 
('EP3X23NBDAAA002EA000009'));

select * from TITAN_DADI_INV_AVL_STAGING where ITEM_ID in ('EP3X23NBDAAA002EA000009');

select * from yfs_export where export_key between '20241001' and '20241002' and flow_name='SF_ResInv_Input_DBTrace' 
and message like '%EZ0102ZBARAP002BL000993%' order by createts desc;

select * from yfs_export where export_key between '20241004' and '20241005' and flow_name='SF_ResInv_Output_DBTrace' 
and message like '%EZ0102ZBARAP002BL000993%' order by createts desc;

select * from yfs_export where export_key between '20241004' and '20241005' and flow_name='SF_CanResInv_Input_DBTrace' 
and message like '%EZ0102ZBARAP002BL000993%' order by createts desc;

select * from yfs_export where export_key>'20241001' and flow_name='SF_ResInv_Output_DBTrace' 
and message like '%21d31fa2d6558886d09f7efcfc%' order by createts desc;


select FLOW_NAME,ERRORSTRING,STATE,MESSAGE,ERRORTXNID,ERRORMESSAGE,MODIFYTS from yfs_reprocess_error where ERRORTXNID > '20241001' 
and FLOW_NAME like '%IBD_USUpdateInventory_Async%' and message like '%UZ%' order by createts desc;

select FLOW_NAME,ERRORSTRING,STATE,MESSAGE,ERRORTXNID,ERRORMESSAGE,MODIFYTS from yfs_reprocess_error where ERRORTXNID > '20241001' and 
FLOW_NAME like '%IBD_USReceiveJewelleryFeed_Async%' and message like '%UPO3DHVDGQ1S00%' order by createts desc;

select * from TITAN_DADI_INV_AVL_STAGING where  AVAILABLE_QTY>'0' and ITEM_ID in
('UL4118FIOLAA041BL000001', 'UPD2FFBCXBAA002EE000002', 'UP2314SZHABA002EB000008', 'UP2314SFRABAP32EB000005', 'UL3017FVWUAA002JA000002',
'UPD3MEDDMABA002EA000009', 'UL1920SDAAGA002JA000013', 'UPD3C3DLAABA002EB000002', 'UL2923FWENAA002EE000004', 'UPW1D12GZ1BA002EA000003',
'UL2923SWDADA002EE000013', 'UP2619FHFBAA002JA000006', 'UL3018HPMAAA002EA000013', 'UL1920SDDAGA002JA000013');


select * from yfs_order_header where order_no='00004650';


select  FLOW_NAME,count(*) from yfs_reprocess_error where ERRORTXNID between '20240914' and '20240915' and STATE='Initial' group by FLOW_NAME ;

select * from yfs_reprocess_error where ERRORTXNID between '20240914' and '20240915' and FLOW_NAME like '%IBD_ReceiveStatusUpdateFromERP_Async%'  order by createts desc;

select * from yfs_export where export_key>'20241111' and  flow_name='IBD_PushInventoryErrorMessage' order by modifyts desc;

select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where 
order_no in('00009972','00009980','00009969') and SCAC='TRANSGUARD';


select * from yfs_export where export_key > '2025031806' and flow_name like '%TransguardStatusUpdates%' 
 order by createts desc;

select * from yfs_export where export_key > '20250701' and flow_name like '%TransguardStatusUpdates%' 
and message like '%100016738%' order by createts desc;
//and (message like '%00005765%' )

select * from yfs_reprocess_error where ERRORTXNID > '20250501' and FLOW_NAME like '%IBD_ReceiveStatusUpdatesFromTransguardAsync%'  
and message like '%100015509%' order by createts desc;

select * from yfs_reprocess_error where ERRORTXNID > '20250301' and FLOW_NAME like '%IBD_ReceiveStatusUpdatesFromTransguardAsync%' order by createts desc;


select * from yfs_reprocess_error where ERRORTXNID > '20241101' and FLOW_NAME like '%IBD_ReceiveStatusUpdateFromOMNIPOSS_Async%' 
and message like '%StatusCode="19"%' order by createts desc;


select * from YFS_TRACE_COMPONENT;

select * from yfs_order_line where order_header_key in (
select order_header_key from yfs_order_header where order_no='00009327');

select * from yfs_shipment where order_no in('00009327');

select * from yfs_shipment_line where shipment_key='20241210085112273805972';


select * from TITAN_PAYMENT_DETAILS where order_line_key in (
select TRIM(ORDER_LINE_KEY) from yfs_order_line where order_header_key in (
select order_header_key from yfs_order_header where order_no in ('US00018043')));

select * from YFS_TRACE_COMPONENT;


//AUDIT table inv
select * from yfs_AUDIT_HEADER where audit_header_key between '20241224'   and '20241226'
and createprogid='IBDReceiveLotMasterIntegServer' order by createts desc;

select * from yfs_AUDIT_HEADER where audit_header_key between '20240905'  and '20241226' and  REFERENCE_2='EL3013HZGAAA002EE000016' 
and createprogid='IBDReceiveLotMasterIntegServer';


select * from yfs_AUDIT_HEADER where REFERENCE_2='UP5090SANAGA002JA000011' order by createts desc;

select * from yfs_AUDIT_HEADER_3MONTHS where REFERENCE_2='UTD3D1FPULAA043IH000003' ;
select * from yfs_audit where AUDIT_KEY >'20250101' and REFERENCE_2='EP5060VAVR2AP51BL000001'  order by modifyts desc;

select * from yfs_audit where AUDIT_KEY >'20250101' and REFERENCE_2='UP5090SANAGA002JA000011' and 
table_name not like ('%YFS_ITEM%') order by modifyts desc;

select * from yfs_audit_3months where  REFERENCE_2='EL2113HXEAAA002EE000001'  order by modifyts desc;

select * from yfs_audit where AUDIT_KEY >'20250101' and REFERENCE_2='EL3013HZGAAA002EE000016'  order by modifyts desc;

select * from yfs_audit where AUDIT_KEY >'20240905' and REFERENCE_2='EPD2A2CLSGAA002ED000005'  
and CREATEUSERID='IBDReceiveLotMasterIntegServer' order by modifyts asc;

select * from yfs_audit where AUDIT_TRAN_KEY in (
select AUDIT_TRAN_KEY from yfs_AUDIT_HEADER_DROP_BKP where audit_header_key between '20240905'  and '20241226' and  
REFERENCE_2='EPD2A2CLSGAA002ED000005' 
and createprogid='IBDReceiveLotMasterIntegServer');

select * from yfs_AUDIT_HEADER_DROP_BKP where audit_header_key between '20240905'  and '20241226' and  REFERENCE_2='EPD2A2CLSGAA002ED000005' 
and createprogid='IBDReceiveLotMasterIntegServer';

select * from yfs_audit_DROP_BKP where AUDIT_KEY >'20240905' and REFERENCE_2='EPD2A2CLSGAA002ED000005'  order by modifyts asc;

select * from yfs_audit_DROP_BKP where AUDIT_KEY >'20240905' and REFERENCE_2='UL2820PKBAAA372JA000008'  
and CREATEUSERID='IBDReceiveLotMasterIntegServer' order by modifyts asc;


select * from yfs_audit_DROP_BKP where AUDIT_KEY >'20240905' and AUDIT_TRAN_KEY in (
select AUDIT_TRAN_KEY from yfs_AUDIT_HEADER_DROP_BKP where audit_header_key between '20240905'  and '20241226' and 
REFERENCE_2='EPD2A2CLSGAA002ED000005' and createprogid='IBDReceiveLotMasterIntegServer');



//AUDIT table inv

select * from yfs_reprocess_error where ERRORTXNID > '20240906' and FLOW_NAME like '%IBD_USUpdateInventory_Async%';


select FLOW_NAME,ERRORSTRING,STATE,MESSAGE,ERRORMESSAGE,MODIFYTS from yfs_reprocess_error where ERRORTXNID > '20240718' and FLOW_NAME like '%SF_CreateOrder_Async%' order by createts desc;
select * from yfs_reprocess_error where ERRORTXNID > '20241203' and FLOW_NAME like '%IBD_AWBNoAndShipment_Async%' order by createts desc;
select * from yfs_reprocess_error where ERRORTXNID > '20241203' and FLOW_NAME like '%IBD_ReceiveStatusUpdateFromERP_Async%' order by createts desc;
select * from yfs_reprocess_error where ERRORTXNID > '20241206' and FLOW_NAME like '%IBD_ReceiveStatusUpdateFromOMNIPOSS_Async%' order by createts desc;

select * from yfs_reprocess_error where ERRORTXNID > '20241206' and FLOW_NAME like '%IBD_ReceiveStatusUpdatesFromTransguardAsync%' order by createts desc;
select * from yfs_reprocess_error where ERRORTXNID > '20241206' and FLOW_NAME like '%SF_CreateOrder_Async%' order by createts desc;
select * from yfs_reprocess_error where ERRORTXNID > '20241130' and FLOW_NAME like '%IBD_ReceiveLotMasterFeed_Async%' order by createts desc;
select FLOW_NAME,STATE,ERRORSTRING,MESSAGE,MODIFYTS from yfs_reprocess_error where ERRORTXNID > '20240810' and FLOW_NAME like '%IBD_ReceiveStatusUpdatesFromTransguardAsync%'
and STATE!='Modified' order by MODIFYTS desc;

select FLOW_NAME,STATE,ERRORSTRING,MESSAGE,MODIFYTS from yfs_reprocess_error where ERRORTXNID > '20240827' and FLOW_NAME like '%IBD_ReceiveStatusUpdatesFromTransguardAsync%'  order by createts desc;


select FLOW_NAME,STATE,ERRORSTRING,MESSAGE,MODIFYTS  from yfs_reprocess_error where ERRORTXNID > '20240826' and FLOW_NAME like '%IBD_ReceiveStatusUpdateFromOMNIPOSS_Async%'  order by createts desc;

select * from yfs_reprocess_error where ERRORTXNID > '20240903' and  FLOW_NAME like '%IBD_ReceiveStatusUpdateFromOMNIPOSS_Async%'  order by createts desc;

select FLOW_NAME,STATE,ERRORSTRING,MESSAGE,MODIFYTS from yfs_reprocess_error where ERRORTXNID > '20240903' and FLOW_NAME like '%SF_CreateOrder_Async%'  order by createts desc;


select * from yfs_reprocess_error where ERRORTXNID > '20240807' order by createts desc;


select FLOW_NAME,errorcode,message,createts from yfs_reprocess_error where ERRORTXNID > '20240524' and FLOW_NAME 
like '%IBD_ReceiveStatusUpdateFromERP_Async%' and modifyts>'20240530';


select * from yfs_reprocess_error where ERRORTXNID > '20240906' and FLOW_NAME like '%IBD_AWBNoAndShipment_Async%' and STATE='Initial' order by createts desc;
select * from yfs_reprocess_error where ERRORTXNID > '20240906' and FLOW_NAME like '%IBD_CancelOrderMsg_Async%' and STATE='Initial' order by createts desc;
select * from yfs_reprocess_error where ERRORTXNID > '20240906' and FLOW_NAME like '%IBD_CreateOrderMsg_Async%' and STATE='Initial' order by createts desc;

select * from yfs_reprocess_error where ERRORTXNID > '20240920' and FLOW_NAME like '%IBD_ReceiveStatusUpdateFromERP_Async%' and STATE='Initial' order by createts desc;
select * from yfs_reprocess_error where ERRORTXNID > '20240920' and FLOW_NAME like '%IBD_ReceiveStatusUpdateFromOMNIPOSS_Async%' and STATE='Initial' order by createts desc;
select * from yfs_reprocess_error where ERRORTXNID > '20241111' and FLOW_NAME like '%IBD_ReceiveStatusUpdatesFromTransguardAsync%' and STATE='Initial' order by createts desc;

select * from yfs_reprocess_error where ERRORTXNID > '20241216' and 
FLOW_NAME like '%IBD_ReceiveJewelleryPriceFeed_Async%'  order by createts desc;


select FLOW_NAME,ERRORSTRING,STATE,MESSAGE,ERRORMESSAGE,MODIFYTS from yfs_reprocess_error where 
ERRORTXNID > '20240918' and FLOW_NAME like '%IBD_ReceiveJewelleryPriceFeed_Async%'  order by createts desc;


select MESSAGE from yfs_reprocess_error where 
ERRORTXNID > '20241216' and FLOW_NAME like '%IBD_USReceiveJewelleryPriceFeed_Async%'  order by createts desc;

select * from yfs_order_header where order_no='00006480';

select * from yfs_order_header where ENTERPRISE_KEY='TITAN_GCC' and DOCUMENT_TYPE='0001' 
and modifyprogid='PAYMENT_COLLECTION' order by modifyts desc;

select * from yfs_export where export_key>'20241218' and  flow_name='ReturnDB_Test01' order by modifyts desc;

select * from yfs_person_info order by modifyts desc;

select * from yfs_notes order by modifyts desc;

select yoh.ENTERPRISE_KEY, yoh.order_no, yoh.createts,
yn.REASON_CODE, yn.NOTE_TEXT 
from yfs_order_header yoh, yfs_notes yn
where yoh.order_header_key=yn.TABLE_KEY
and yoh.ENTERPRISE_KEY='TITAN_GCC' 
order by yoh.modifyts desc;



select yoh.ENTERPRISE_KEY, yoh.order_no, yol.ITEM_ID,yoh.createts as order_create_date, yn.createts as Order_Cancel_date,
yn.REASON_CODE, yn.NOTE_TEXT 
from yfs_order_header yoh , yfs_notes yn, yfs_order_line yol
where
yoh.ENTERPRISE_KEY='TITAN_GCC' and
yol.order_header_key=yoh.order_header_key and
(yn.TABLE_KEY = yol.order_line_key)
order by yoh.modifyts desc;

select * from yfs_order_header where order_no='00013103' and ENTERPRISE_KEY='TITAN_US';
select * from yfs_order_line where order_header_key in (
select ORDER_HEADER_KEY from yfs_order_header where order_no='00013103' and ENTERPRISE_KEY='TITAN_US');

select * from yfs_notes where table_key in ('20241111054031259047447','20241111054031259047448','20241111054031259047450') order by modifyts desc;

select * from yfs_order_header where order_header_key>'20240701' and enterprise_key='TITAN_GCC' 
and document_type='0003' and order_type ='RTO' order by createts desc;

select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where 
shipment_no in ('100013857','100013870','100013866','100013873','100013874','100013875','100013882',
'100013881','100013888','100013916','100013788','100013906','100013918','100013917','100013922');


select Item_id,unit_weight,organization_code,createts,CREATEUSERID,modifyts,MODIFYUSERID from yfs_item where unit_weight=0 
and length(trim(Item_id)) > 20 and organization_code='TITAN_GCC' and item_id in (
select item_id from TITAN_DADI_INV_AVL_STAGING where AVAILABLE_QTY>0) order by createts desc;


select * from yfs_export where export_key>'20241201' and flow_name = 'InvoiceCreationToPOS' order by createts desc;



select  FLOW_NAME,count(*) from yfs_reprocess_error where ERRORTXNID between '20250102' and '20250103' group by FLOW_NAME ;


select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganResponse' and EXPORT_KEY > '20240601' 
and message like '%Error%' order by createts desc;

select * from yfs_export where export_key > '20250101' and flow_name = 'Test_CancelUpdatesToOMNIPOSS' order by createts desc;


select * from yfs_export where export_key > '20250326' and flow_name like '%TransguardStatusUpdates%' order by createts desc;

select * from yfs_export where export_key > '20250301' and flow_name like '%TransguardStatusUpdates%' 
and message like '%100013671%' order by createts asc;

select * from yfs_reprocess_error where ERRORTXNID > '20250301' and FLOW_NAME like '%IBD_ReceiveStatusUpdatesFromTransguardAsync%'  order by createts desc;

select * from yfs_reprocess_error where ERRORTXNID > '20250401' and FLOW_NAME like '%IBD_ReceiveStatusUpdatesFromTransguardAsync%'  
and message like '%100013695%' order by createts desc;


select * from yfs_reprocess_error where ERRORTXNID > '20250209' and 
FLOW_NAME like '%IBD_ReceiveLotMasterFeed_Async%'  order by createts desc;


select * from yfs_order_header where order_header_key>'20250414' and ENTERPRISE_KEY='TITAN_GCC' 
and DOCUMENT_TYPE='0001' order by createts desc;

select * from yfs_reprocess_error where ERRORTXNID > '20250228' and 
FLOW_NAME like '%IBD_ReceiveLotMasterFeed_Async%' order by createts desc;


select * from yfs_reprocess_error where ERRORTXNID > '20250218' and 
FLOW_NAME like '%IBD_ReceiveLotMasterFeed_Async%' and message like '%EPD4B3VDY%' order by createts desc;

select * from TITAN_PAYMENT_DETAILS where AMOUNT_PER_LINE<>'0' order by modifyts desc;

select * from yfs_order_line;
select * from yfs_order_header where order;

select * from yfs_export where export_key>'20250101' and flow_name like '%SFCC_OrderCancel_DB%' order by createts desc;

select * from yfs_export where export_key > '20250329' and system_name='cancelSalesEvent'  order by createts desc;

select * from yfs_export where export_key > '20250529' and system_name='cancelSalesEvent' 
and message like '%STORE_REJECTION%' and ENTERPRISE_KEY='TITAN_US' order by createts desc;

select * from yfs_export where export_key > '20250329' and system_name='cancelSalesEvent' 
and ENTERPRISE_KEY='TITAN_US' order by createts desc;

select * from yfs_import where import_key>'20250220' and  message like '%00011696%' order by createts desc;


select * from yfs_import where import_key>'20250101' and message like '%OMS_TQAE_ORDCNC%' order by createts desc;

select * from yfs_inventory_Supply where SHIPNODE_KEY='XSR' ;

select * from yfs_reprocess_error where ERRORTXNID > '20250306' and FLOW_NAME like '%IBD_UpdateInventory_Async%' 
and modifyts> '20250301' and message like '%XSR%' order by createts desc;
//4829

select * from yfs_reprocess_error where ERRORTXNID > '20250306' and FLOW_NAME like '%IBD_UpdateInventory_Async%' 
and ( message like '%XSR%' and message like '%Quantity="1"%' ) order by createts desc;

select * from yfs_reprocess_error where ERRORTXNID > '20250306' and FLOW_NAME like '%IBD_UpdateInventory_Async%' 
 and message like '%EPW1D11RUABAP3%' order by createts desc;


SELECT  yi.ITEM_ID,yi.Organization_code,yi.EXTN_ITEM_CODE,yi.EXTN_LOT_NO,yi.POSTING_CLASSIFICATION,yi.EXTN_PRODUCT_CODE
FROM aws_ster_sch.YFS_ITEM yi WHERE yi.item_id like '%EPF2KPCCVMAA%';

select Item_id,unit_weight,organization_code,createts,CREATEUSERID,modifyts,MODIFYUSERID from yfs_item where
length(trim(Item_id)) > '20' and organization_code='TITAN_GCC' and item_id in (
'EL2998SEIADA043IA000006')order by createts desc;

SELECT  yi.ITEM_ID,yi.Organization_code,yi.EXTN_ITEM_CODE,yi.EXTN_LOT_NO,yi.POSTING_CLASSIFICATION,yi.EXTN_PRODUCT_CODE
FROM aws_ster_sch.YFS_ITEM yi WHERE yi.item_id IN 
('EL2998SEIADA043IA000006');

select * from yfs_reprocess_error where ERRORTXNID > '20250312' and FLOW_NAME like '%IBD_UpdateInventory_Async%'   order by createts desc;


select * from yfs_reprocess_error where ERRORTXNID > '20250306' and FLOW_NAME like '%IBD_UpdateInventory_Async%'  
and message like '%EP1819VXZR2AP1%' order by createts desc;

select * from yfs_reprocess_error where ERRORTXNID > '20250312' and FLOW_NAME like '%IBD_UpdateInventory_Async%'  
and message like '%XSR%' order by createts desc;




select ITEM_ID from yfs_item where length(trim(Item_id)) < '20' and organization_code='TITAN_GCC' order by createts desc;

select * from yfs_order_header where priority_code !='';


select MESSAGE,CREATETS from yfs_export where export_key>'2025031810'  and flow_name like '%UPS_TrackShipmentDB%'  order by createts asc ;


select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,createts,modifyts from yfs_shipment where order_no in 
(select order_no from yfs_order_header where order_header_key>'20250201' and ENTERPRISE_KEY='TITAN_GCC' 
and DOCUMENT_TYPE='0003') order by modifyts desc;


select * from yfs_order_header where Order_header_key in (
select DERIVED_FROM_ORDER_HEADER_KEY from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_header_key>'20240701' 
and SELLER_ORGANIZATION_CODE='TITAN_GCC' and order_no in ('Y100008128') order by createts desc));

select * from yfs_order_line where order_header_key in 
(select ORDER_HEADER_KEY from yfs_order_header where SELLER_ORGANIZATION_CODE='TITAN_GCC' and order_no in ('00010212'));


select * from yfs_export where flow_name='IBD_PostUpdatesToERPDB' and export_key>'20250326' order by createts desc;

select * from yfs_reprocess_error where ERRORTXNID > '20250401' and FLOW_NAME like '%IBD_USReceiveLotMasterFeed_Async%' 
 order by createts desc;

select * from yfs_reprocess_error where ERRORTXNID > '20250101' and FLOW_NAME like '%IBD_USReceiveLotMasterFeed_Async%' 
and message like '%EPIMR40RNGBA00%' order by createts desc;

SELECT   yi.ITEM_ID,unit_weight,CREATETS,createprogid, modifyts, modifyprogid FROM aws_ster_sch.YFS_ITEM yi WHERE yi.item_id like  
('%EPIMR40RNGBA00%');

select ITEM_ID, NODE, AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where Item_id in 
(select Item_id from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_GCC') and AVAILABLE_QTY>'0' and 
NODE in ('XAW');


select * from  yfs_export where Flow_name='Sol_WCSBeforeCreateOrder' and message like '%48712704002%' order by createts asc;


select * from yfs_order_header where ENTERPRISE_KEY='TITAN_GCC' and createts>'20250429' order by createts desc;

select * from yfs_order_line where Order_header_key in 
(select Order_header_key from yfs_order_header where ENTERPRISE_KEY='TITAN_GCC' and createts>'20250429' and DOCUMENT_TYPE='0001')
order by createts desc;

select * from yfs_export where export_key > '20250428' and system_name='RefundInitiateDB'  order by createts desc;

select * from yfs_export where flow_name='JPMCRefundInputDB' and export_key>'20250428' order by createts desc;



select * from yfs_inventory_Supply where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where 
Item_id in ('UP3515BMMDAA002ED000023','UPD3B2DCDABA002EA000021'));

select * from yfs_inventory_demand where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where 
Item_id in ('UP3515BMMDAA002ED000023','UPD3B2DCDABA002EA000021')) order by createts asc;

select * from TITAN_DADI_INV_AVL_STAGING where ITEM_ID in 
('EL0466HWAAAA002JA000016', 'EL04732BAABB043IA000006', 'EL0461OBAAAB022JA000025', 'EL0496FDARAA043IH000010', 'EL0761FZATAB043IA000007');

select ORDER_NO,ENTERPRISE_KEY,CUSTOMER_EMAILID_LC,createts, modifyts from yfs_order_header where Order_header_key in (
select Order_header_key from YFS_ORDER_HOLD_TYPE where status ='1100' and CREATETS > '2025-04-01' )
and modifyts > '2025-04-01' order by CUSTOMER_EMAILID_LC,modifyts desc;

select ITEM_ID, NODE, AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where Item_id in 
(select Item_id from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_GCC')  and 
NODE in ('XAH', 'XDM', 'XDF', 'XDB', 'XDS', 'XDK', 'XDT', 'XSL', 'XDJ', 'XAW', 'XDG','XSR') order by ITEM_ID,AVAILABLE_QTY asc;


select ITEM_ID, NODE, AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where Item_id in 
(select Item_id from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_GCC') and AVAILABLE_QTY>'0' and 
NODE in ('XAH', 'XDM', 'XDF', 'XDB', 'XDS', 'XDK', 'XDT', 'XSL', 'XDJ',  'XDG','XSR') order by ITEM_ID,AVAILABLE_QTY asc;

select ITEM_ID, NODE, AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where Item_id in 
(select Item_id from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_US') and AVAILABLE_QTY>'0' and 
NODE in ('XCG', 'XNJ', 'XTD', 'XTH','XBA','XAC','XWS') order by AVAILABLE_QTY desc;

//'XCG', 'XNJ', 'XTD', 'XTH'

select order_no,CUSTOMER_EMAILID_LC,enterprise_key,createts,createuserid from yfs_order_header 
where order_header_key and ENTERPRISE_KEY ='TITAN_US' and createuserid='SCWC_SDF_createOrder' order by createts desc;

select order_no,CUSTOMER_EMAILID_LC,enterprise_key,createts,createuserid from yfs_order_header 
where order_header_key and ENTERPRISE_KEY ='TITAN_US' and document_type='0003' order by createts desc;

select * from yfs_order_line where EXTN_SALES_TAX!='5' and EXTN_SALES_TAX!='0' order by createts desc;

//Get Return Order with sales order No
select order_no as RO_No from yfs_order_header where order_header_key in (
select ORDER_HEADER_KEY from yfs_order_line where DERIVED_FROM_ORDER_HEADER_KEY in (
select order_header_key from yfs_order_header where order_no='00016679'));

select *  from yfs_export where export_key>'20250708' and flow_name like '%IBD_OrderDetailERPStoreDB%' order by modifyts desc;



select Order_header_key,count(Order_header_key) from yfs_charge_transaction where MODIFYTS > '2025-05-26 00:00:00.0'
group by Order_header_key order by count(Order_header_key);

select * from yfs_charge_transaction where ORDER_HEADER_KEY='20250523201301384956614' order by createts desc;

//Full Sync
select * from yfs_item where ORGANIZATION_CODE='TITAN_GCC';
// 231575  Rows
select yi.Item_id, '' AS empty_column1, dadi.NODE, 
CASE WHEN dadi.AVAILABLE_QTY > 0 THEN 'AVL' ELSE 'UAVL' END AS availability_status,
COALESCE(dadi.AVAILABLE_QTY, 0) AS AVAILABLE_QTY , '' AS empty_column2,
'' AS empty_column3, '' AS empty_column4, 
NOW() AS AVAILABLE_time
from yfs_item yi
LEFT JOIN TITAN_DADI_INV_AVL_STAGING dadi ON TRIM(yi.Item_id) = TRIM(dadi.Item_id)
where yi.organization_code='TITAN_GCC' order by yi.ITEM_ID,dadi.AVAILABLE_QTY asc;

select * from yfs_item where ORGANIZATION_CODE='TITAN_US';
//160953  Rows
select yi.Item_id, '' AS empty_column1, dadi.NODE, 
CASE WHEN dadi.AVAILABLE_QTY > 0 THEN 'AVL' ELSE 'UAVL' END AS availability_status,
COALESCE(dadi.AVAILABLE_QTY, 0) AS AVAILABLE_QTY , '' AS empty_column2,
'' AS empty_column3, '' AS empty_column4, 
NOW() AS AVAILABLE_time
from yfs_item yi
LEFT JOIN TITAN_DADI_INV_AVL_STAGING dadi ON TRIM(yi.Item_id) = TRIM(dadi.Item_id)
where yi.organization_code='TITAN_US' order by yi.ITEM_ID,dadi.AVAILABLE_QTY asc;
//full sync

select * from yfs_order_release_status where status='3950' and STATUS_DATE > '20250526' order by createts desc ;
select * from yfs_order_release_status where status='3950' and STATUS_DATE between '20250526' and '20250528' order by createts desc ;

select * from yfs_order_header where enterprise_key='TITAN_GCC' and Order_header_key in (
select Order_header_key from yfs_order_release_status where status='3700.7777' and STATUS_DATE > '20250501' 
 ) order by modifyts desc;
 
select * from yfs_order_release_status where Order_header_key in (
select Order_header_key from yfs_order_header where enterprise_key='TITAN_GCC' and Order_no in ('00013650'))order by createts desc ;

SELECT ORS.ORDER_LINE_KEY,ORS.STATUS,STATUS_DATE,ORS.STATUS_QUANTITY,ORS.TOTAL_QUANTITY,OS.DESCRIPTION 
FROM AWS_STER_SCH.YFS_ORDER_RELEASE_STATUS ORS,AWS_STER_SCH.YFS_STATUS OS 
WHERE ORS.ORDER_LINE_KEY='20250531125445387959041' 
AND ORS.STATUS=OS.STATUS  
AND OS.PROCESS_TYPE_KEY='ORDER_FULFILLMENT' ORDER BY ORS.STATUS_DATE,ORS.STATUS ASC with ur;

select * from yfs_order_header where enterprise_key='TITAN_GCC' order by createts desc;

select * from yfs_order_line where order_header_key in (
select order_header_key from yfs_order_header where order_no in 
('US00017653','US00017549','US00017543','US00017574','US00017573'));


select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,createts from yfs_shipment where order_no in ('Y100016076');

select * from yfs_reprocess_error where ERRORTXNID > '20250401' and FLOW_NAME like '%IBD_CancelOrderMsg_Async%' order by createts desc;

//US00016603


select * from yfs_order_header where order_no in ('US00017723','US00017720') and ENTERPRISE_KEY ='TITAN_US' and 
document_type='0001' order by createts desc;

select ORDER_HEADER_KEY,ENTERPRISE_KEY,ORDER_NO,Hold_flag,EXTN_KOUNT_STATUS,createts,modifyts,modifyuserid from yfs_order_header where
Order_no in ('US00021504','US00021572');

select *  from yfs_export where export_key>'20250720' and flow_name like '%SFCC_KountStatusUpdate_DB%' order by createts desc;

select *  from yfs_export where export_key>'20250720' and flow_name like '%SFCC_KountStatusUpdate_DB%'
and message like '%US00019380%' order by createts desc;

select * from  yfs_export where EXPORT_KEY > '20250601' and flow_name='KountCancelDB'  order by createts desc;

select * from  yfs_export where EXPORT_KEY > '20250601' and flow_name='KountCancelDB' 
and message like '%US00018128%' order by createts desc;

select * from yfs_order_header where EXTN_KOUNT_STATUS='Declined' order by createts desc;


select * from YFS_ORDER_HOLD_TYPE where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_no in ('US00018605','US00018591') and modifyts > '2025-07-01' ) 
and modifyts > '2025-07-01' order by modifyts desc;

select * from yfs_order_header where order_no in
('US00020931') and  enterprise_key='TITAN_US';

select * from yfs_order_header where Document_type='0003' and enterprise_key='TITAN_US' order by createts desc;

select * from yfs_order_header where Document_type='0001'  order by createts desc;

 
select * from yfs_order_release_status where status='3700.02' and STATUS_DATE > '20250401' ;

select * from yfs_order_header where enterprise_key='TITAN_US' and Order_header_key in (
select Order_header_key from yfs_order_release_status where status='3700.02' and STATUS_QUANTITY>'0' and 
STATUS_DATE between '20250101' and  '20250601'
 ) order by modifyts desc;
 
SELECT   yi.ITEM_ID,unit_weight,ORGANIZATION_CODE,CREATETS,createprogid, modifyts, modifyprogid FROM aws_ster_sch.YFS_ITEM yi WHERE yi.item_id like (
'UPF5B1PCCAAA00%');

SELECT   * FROM aws_ster_sch.YFS_ITEM yi WHERE yi.item_id like (
'UPF5B1PCCAAA00%');
 

select * from yfs_reprocess_error where ERRORTXNID > '20250701' and FLOW_NAME like '%IBD_USReceiveLotMasterFeed_Async%' order by createts desc;

select * from yfs_reprocess_error where ERRORTXNID > '20250707' and MODIFYTS > '20250707' and 
FLOW_NAME like '%IBD_USReceiveLotMasterFeed_Async%' order by createts desc;

select * from yfs_item where Organization_code='TITAN_US' and modifyts>'20250707' and modifyuserid='IBDUSReceiveLotMasterIntegServer';

select ITEM_ID, NODE, AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where Item_id in 
(select Item_id from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_US') and AVAILABLE_QTY>'0' and 
NODE in ('XWS');

select * from yfs_reprocess_error where ERRORTXNID > '20250701' and MODIFYTS > '20250707' and 
FLOW_NAME like '%IBD_USReceiveJewelleryFeed_Async%' order by createts desc;

select * from yfs_item where Organization_code='TITAN_US' and modifyts>'20250701' and modifyuserid='IBDReceiveUSJewFeedIntegServer' order by modifyts desc;

select * from yfs_reprocess_error where ERRORTXNID > '20250701' and 
FLOW_NAME like '%IBD_USReceiveJewelleryFeed_Async%' order by createts desc;


select * from yfs_order_header where CUSTOMER_EMAILID_LC='hsharma@solveda.com' and ENTERPRISE_KEY='TITAN_GCC' order by createts desc;

select * from yfs_export where export_key > '20250612' and system_name='cancelSalesEvent'  
and message like '%00014317%' order by createts desc;

select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,createts from yfs_shipment 
where scac='UPSC' and order_no like 'Y10%' order by createts desc;

select * from yfs_order_header where Document_type='0003' and enterprise_key='TITAN_US' and Order_type='RTO' order by createts desc;

select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,createts from yfs_shipment 
where scac='UPSC' and order_no in 
(select order_no from yfs_order_header where Document_type='0003' and enterprise_key='TITAN_US' and Order_type='RTO') order by createts desc;

select * from yfs_shipment where order_no='US00020117';

select * from yfs_item;
//387762
select * from yfs_item where EXTN_PRICING_GROUP_TYPE not like '%UCP%';

select EXTN_PRICING_GROUP_TYPE,SHORT_DESCRIPTION from yfs_item where ORGANIZATION_CODE='TITAN_US' ;
//377870


select * from  yfs_import where IMPORT_KEY > '20250801' and message like '%btqxds@titancompany.com%' order by createts desc;

select MESSAGE,CREATETS from  yfs_import where IMPORT_KEY > '20250801' and message like '%btqxds@titancompany.com%' order by createts desc;
select MESSAGE,CREATETS from  yfs_import where IMPORT_KEY > '20250801' and message like '%OMNI_SFS_TQAE_ORDINFORETST%' order by createts desc;


select * from yfs_order_header where order_no in (
'00017247','00017436','00017550','00017839');


select * from yfs_order_header where order_header_key in(
select ORDER_HEADER_KEY from YFS_PAYMENT where PAYMENT_REFERENCE2 like '%d6668927-d6eb-4bd9-b0ee-9bd87a583011%');


//SF Inv

//Reserve Inventory

select * from  yfs_export where EXPORT_KEY > '20250801' and flow_name='SF_ResInv_Input_DBTrace'  order by createts desc;
select * from  yfs_export where EXPORT_KEY > '20250801' and flow_name='SF_ResInv_Output_DBTrace'  order by createts desc;


select * from yfs_reprocess_error where ERRORTXNID > '20250501' and FLOW_NAME like '%IBD_ProcessJPMCReversalAsync%' and STATE='Initial' order by createts desc;

select * from yfs_export where export_key between '20250529' and  '20250530' and system_name='OnCancel'  order by createts desc;


select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganResponse' and EXPORT_KEY > '20240601'
and message like '%Error%' order by createts desc;

select * from yfs_order_header where order_header_key in ('20250807104850438765189');





//JPMC
select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganReq' and EXPORT_KEY between '20250801' and '20250805'
 order by createts desc;

select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganResponse' and EXPORT_KEY between '20250801' and '20250805'
order by createts desc;

//Avalara
select message,createts from  yfs_export where EXPORT_KEY between '20250529' and '20250601' and Flow_name='IBD_AvalaraRefundReq' order by createts desc;
select message,createts from  yfs_export where EXPORT_KEY between '20250529' and '20250601' and Flow_name='IBD_AvalaraRefundRes' order by createts desc;

//Oncancel
select * from yfs_export where export_key between '20250529' and '20250601' and system_name='cancelSalesEvent'  order by createts desc;

select * from yfs_reprocess_error where ERRORTXNID between '20250529' and '20250601' and FLOW_NAME like '%IBD_CancelOrderMsg_Async%' order by createts desc;

select * from yfs_export where export_key between '20250529' and '20250601' and message like '%US00016820%' order by export_key desc;

select * from yfs_charge_transaction where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_no in ('US00016820') and ENTERPRISE_KEY='TITAN_US' ) order by modifyts asc;

select * from yfs_export where export_key > '20250821' and message like '%EZ0113ZAARAS002BL000705%' order by export_key desc;


select EXPORT_KEY,message,createts from  yfs_export where Flow_name='TestUpdStgDB' and EXPORT_KEY between '20250513' and '20250514'
and message like '%EZ0113ZAARAS002BL000666%' order by createts desc;


//Inv report with creatts
SELECT 
    yi.ITEM_ID,
    yi.EXTN_ITEM_CODE,
    yi.EXTN_LOT_NO,
    yi.POSTING_CLASSIFICATION,
    yi.EXTN_PRODUCT_CODE,
    ys.SHIPNODE_KEY,
    ys.CREATETS,
    ys.MODIFYTS,
    ts.AVAILABLE_QTY
FROM yfs_item yi
JOIN yfs_inventory_item yii 
    ON yi.ITEM_ID = yii.ITEM_ID
JOIN yfs_inventory_supply ys 
    ON yii.INVENTORY_ITEM_KEY = ys.INVENTORY_ITEM_KEY
JOIN TITAN_DADI_INV_AVL_STAGING ts 
    ON yi.ITEM_ID = ts.ITEM_ID
   AND ys.SHIPNODE_KEY = ts.NODE
WHERE ts.AVAILABLE_QTY > 0
and yi.organization_code='TITAN_GCC' and 
length(trim(yi.Item_id)) > '20' 
and ts.NODE in ('XAH', 'XDM', 'XDF', 'XDB', 'XDS', 'XDK', 'XDT', 'XSL', 'XDJ', 'XAW', 'XDG');
//23463  Rows

select ITEM_ID, NODE, AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where Item_id in 
(select Item_id from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_GCC') and AVAILABLE_QTY>'0' and 
NODE in ('XAH', 'XDM', 'XDF', 'XDB', 'XDS', 'XDK', 'XDT', 'XSL', 'XDJ', 'XAW', 'XDG');
//23463  Rows

 select * from TITAN_DADI_INV_AVL_STAGING where AVAILABLE_QTY>'0';
 
 
 //SIT
 SET CURRENT_SCHEMA='AWS_STER_SCH';

SELECT DATE(CURRENT TIMESTAMP) AS Date, TIME(CURRENT TIMESTAMP) AS Time FROM sysibm.sysdummy1;

//Heartbeat
select * from yfs_heartbeat order by SERVER_START_TIME desc;
select * from yfs_heartbeat where server_type ='APPSERVER';
select unique(server_name) from yfs_heartbeat;

select * from yfs_heartbeat where status='00' and server_name like '%SF%'  order by createts desc;
select * from yfs_heartbeat where status='00' and server_name like '%IBDNPSDeliverySurveyEmailAgentServer%'  order by createts desc;
select * from yfs_heartbeat where status='00' and server_name like '%Omni%' order by createts desc;
select * from yfs_heartbeat where status='00' and LAST_HEARTBEAT > '2024-10-01 04:30:00.0'  order by createts desc;
select count(*) from yfs_heartbeat where status='00' and LAST_HEARTBEAT > '2024-10-13 00:00:00.0' ;

select count(*) from yfs_heartbeat where status='00';
//58
//62

//Delete from yfs_heartbeat where SERVER_START_TIME < '2025-03-24 08:30:00.0' and server_type!='APPSERVER';
//Delete from yfs_heartbeat where SERVER_START_TIME < '2025-04-07 00:00:00.0';
Delete from yfs_heartbeat where server_type!='APPSERVER';
//Delete from yfs_heartbeat where server_type!='APPSERVER' and SERVER_START_TIME < '2025-08-13 00:00:00.0' ;
//Delete from yfs_heartbeat where server_name like '%IBDRetrieveOrderOmniPossIntegServer%' and SERVER_START_TIME < '2025-08-22 00:00:00.0';
//Delete from yfs_heartbeat where server_name ='IBD_PaymentCollectionAgentServer' and SERVER_START_TIME < '2025-06-18 10:00:00.0' ;
//Delete from yfs_heartbeat where HEARTBEAT_KEY in ('2025052303295953994413','2025052105242853868544');
//Delete from yfs_heartbeat;
select unique(Flow_name) from yfs_export;
select unique(Flow_name) from yfs_import;

select  FLOW_NAME,count(*) from yfs_reprocess_error where ERRORTXNID > '20250205' group by FLOW_NAME ;

select  FLOW_NAME,count(*) from yfs_reprocess_error where ERRORTXNID > '20250714' group by FLOW_NAME ;

select * from yfs_reprocess_error where ERRORTXNID > '20250808' and FLOW_NAME like '%IBD_FetchEncircleDetails_Async%'  order by createts desc;

select ERRORTXNID,FLOW_NAME,ERRORSTRING,STATE,MESSAGE,ERRORMESSAGE,MODIFYTS from yfs_reprocess_error where ERRORTXNID > '20250714' 
and FLOW_NAME like '%IBD_ReceiveStatusUpdateFromOMNIPOSS_Async%' order by createts desc;


select * from yfs_reprocess_error where ERRORTXNID > '20250701' and FLOW_NAME like '%SF_CreateOrder_Async%'  
and message like '%00006384%' order by createts desc;


select FLOW_NAME,ERRORSTRING,STATE,MESSAGE,ERRORMESSAGE,MODIFYTS from yfs_reprocess_error where ERRORTXNID > '20250525' and 
FLOW_NAME like '%SF_CreateOrder_Async%'  order by createts desc;

select * from yfs_reprocess_error where ERRORTXNID > '20250213' and FLOW_NAME like '%SF_CreateOrder_Async%'  
and message like '%00113280%' order by createts desc;

select * from yfs_order_header where order_header_key>'20250401' and enterprise_key='TITAN_US' and 
document_type='0001' order by createts desc;

select * from yfs_order_header where order_no in 
('00008784','00008599','00008668','00008652','00008638','00008543','00008538','00008524','00008522','00008516','00008492');

select * from yfs_order_header where order_header_key>'20250101' and enterprise_key='TITAN_GCC' and 
document_type='0001' order by createts desc;

select * from yfs_order_header where Order_no in 
('00006102','00006276','00006278','00006132','00006137','00006268');

select * from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_header_key>'20250609' and enterprise_key='TITAN_GCC' and 
document_type='0001') order by createts desc;


select * from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no in ('00005838','00005837') and enterprise_key='TITAN_GCC' and 
document_type='0001') order by createts desc;

select * from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_header_key>'20250608' and enterprise_key='TITAN_GCC' and 
document_type='0001') order by createts desc;

//update yfs_order_line set EXTN_SALES_TAX = '5.00' where ORDER_LINE_KEY in('2025060912585654692292');


select * from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no='US00114499' and enterprise_key='TITAN_US' and 
document_type='0001') order by createts desc;

//update yfs_order_line set EXTN_MAKING_CHARGES_PERCENT = '47.00' where ORDER_LINE_KEY in('2025060405550654581846');

IBD_EncircleIIBDB
// Inventory Change queries
SELECT  yi.Organization_code,yi.ITEM_ID,yi.EXTN_ITEM_CODE,yi.EXTN_LOT_NO,yi.POSTING_CLASSIFICATION,yi.EXTN_PRODUCT_CODE
FROM aws_ster_sch.YFS_ITEM yi WHERE yi.item_id in 
( 'UL2617BBQHAA041BL000006');

//DELETE FROM YFS_ITEM WHERE item_id in('EL1204FAHJAAP52BA000005','EP2216JHIABA002EA000004');


//'EP03ABXADAAA002BL000091','EP03ABXABAAA002BL001503','EP03ABXACAAA002BL000602'

select INVENTORY_ITEM_KEY, count(*) from yfs_inventory_Supply where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where 
Item_id in ('EL0006SCAAAA022JA000039')) group by INVENTORY_ITEM_KEY;

select * from yfs_inventory_Supply where INVENTORY_ITEM_KEY in('202409200755555437698608');

select * from yfs_inventory_item where INVENTORY_ITEM_KEY in('2023010507174510279404','2023010507174510279424');

//DELETE FROM yfs_inventory_Supply where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where Item_id in 
//('EL0006SCAAAA022JA000039'));

//DELETE FROM yfs_inventory_Supply where INVENTORY_SUPPLY_KEY in ('202301050714180610291092');

select * from yfs_inventory_demand  where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where Item_id in 
('EZ0102ZBARAS002BL005528')) order by modifyts desc;

//delete from yfs_inventory_demand where  INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where Item_id in 
//('EL0060SAAAGAPL2JA000028')) ;

select * from yfs_inventory_Supply where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where 
Item_id in ('UL2617BBQHAA041BL000006')) ;


select * from yfs_inventory_Supply where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where 
Item_id like  ('EZ0102ZEARAS00%')) ;

//update yfs_inventory_Supply set QUANTITY='1' where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where 
//Item_id in ('EP3818FDZLAA002ED000004')) ;

//delete from yfs_inventory_Supply where INVENTORY_SUPPLY_KEY in('202502091458143544529124','202502070501175344442486','202407081142105131103731');
//delete from yfs_inventory_Supply where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where 
//Item_id in ('EZ0102ZBARAS002BL005528')) ;

select * from yfs_item where Item_id like ('EP3314JDDABA002EA000029');



select ITEM_ID,UNIT_WEIGHT from yfs_item where Item_id in ('EP3314JDDABA002EA000027');

//update yfs_item set UNIT_WEIGHT='0.00' where Item_id in ('EP3314JDDABA002EA000027');
//26.5750
select * from yfs_inventory_item where ORGANIZATION_CODE = 'TITAN_GCC' and INVENTORY_ITEM_KEY in 
(select INVENTORY_ITEM_KEY from yfs_inventory_Supply where QUANTITY='1' );

select ITEM_ID, AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where node in('XDS') and AVAILABLE_QTY>'0' Order by AVAILABLE_QTY desc;

select * from TITAN_DADI_INV_AVL_STAGING where ITEM_ID in 
('UL2617BBQHAA041BL000006') Order by item_id;

select * from TITAN_DADI_INV_AVL_STAGING where ITEM_ID in ('EZ0102ZBARAS002BL005956');

select * from TITAN_DADI_INV_AVL_STAGING where AVAILABLE_QTY>'0' and ITEM_ID like ('EZ0102ZEARAS00%');
//update TITAN_DADI_INV_AVL_STAGING set AVAILABLE_QTY='1' where ITEM_ID in ('EZ0102ZBARAS002BL005953');

//DELETE FROM TITAN_DADI_INV_AVL_STAGING where ITEM_ID in ('EZ0102ZBARAS002BL005528') ;
//DELETE FROM TITAN_DADI_INV_AVL_STAGING where TITAN_SELLERS_KEY in ('2025051508205153646687','2025051508205153646688','2025081304195956965295');



select * from yfs_inventory_audit where item in ('UP2017VUQR4A002ED000004','ULUDP3HBOAAA043IH000009') order by modifyts desc;

//('EP2216JHIABA002EA000004','EL3920FDDLAA022JA000003','EP3818FDZLAA002ED000004') ;

select * from yfs_inventory_audit where INVENTORY_AUDIT_KEY>'20241124'   order by modifyts desc;


select * from yfs_reprocess_error where ERRORTXNID > '20240728'  and message like '%ULO4PT2PZADA02%' ;

select * from yfs_export where export_key > '20240728'  and message like '%ULO4PT2PZADA02%' ;


select * from yfs_ship_node where OWNER_KEY='TITAN_US';



//Store Inventory Load Check
select * from yfs_inventory_Supply where modifyts > '2025-02-27 00:00:00.0' and modifyuserid='IBDUSReceiveStoreInvUpdateIntegServer';

select * from yfs_inventory_Supply where modifyts > '2025-02-27 00:00:00.0' and modifyuserid='IBDReceiveStoreInvUpdateIntegServer' order by modifyts desc;

select * from yfs_inventory_Supply where modifyts > '2025-03-01 00:00:00.0' and SHIPNODE_KEY='XSR' and modifyuserid='IBDUSReceiveStoreInvUpdateIntegServer';


// Inventory Change queries
select ITEM_ID, NODE, AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where Item_id in 
(select Item_id from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_GCC') and AVAILABLE_QTY>'0' and 
NODE in ('XAH', 'XDM', 'XDF', 'XDB', 'XDS', 'XDK', 'XDT', 'XSL', 'XDJ',  'XDG','XSR') order by ITEM_ID,AVAILABLE_QTY asc;

select ITEM_ID, NODE, AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where Item_id in 
(select Item_id from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_US') and AVAILABLE_QTY>'0' and 
NODE in ('XCG', 'XNJ', 'XTD', 'XTH','XBA','XAC','XWS') order by AVAILABLE_QTY desc;

//'XCG', 'XNJ', 'XTD', 'XTH'




select ITEM_ID, NODE, AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where Item_id in 
(select Item_id from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_GCC') and AVAILABLE_QTY>'10' and 
NODE in ('XDM','XDS') order by AVAILABLE_QTY desc;


//Item Master Load Check
select * from yfs_item where Organization_code='TITAN_US' and modifyts>'20241223' and CREATEUSERID='IBDReceiveUSJewFeedIntegServer' order by modifyts desc;

select * from yfs_item where Organization_code='TITAN_GCC' and modifyts>'20240908' and modifyuserid='IBDReceiveJewFeedIntegServer' order by modifyts desc;

//Lot Master Load Check
select * from yfs_item where Organization_code='TITAN_US' and modifyts>'20241223' and modifyuserid='IBDUSReceiveLotMasterIntegServer';

select * from yfs_item where Organization_code='TITAN_GCC' and modifyts>'20240908' and modifyuserid='IBDReceiveLotMasterIntegServer';

//Store Inventory Load Check
select * from yfs_inventory_Supply where modifyts > '2024-12-24 00:00:00.0' and modifyuserid='IBDUSReceiveStoreInvUpdateIntegServer';

select * from yfs_inventory_Supply where modifyts > '2024-10-08 00:00:00.0' and modifyuserid='IBDReceiveStoreInvUpdateIntegServer' order by modifyts desc;


// Inventory Change queries


select * from yfs_inventory_Supply where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item 
where Item_id in( 'UL0464FDALAA023IA000005'));



select * from yfs_inventory_item where INVENTORY_ITEM_KEY in(
select INVENTORY_ITEM_KEY from yfs_inventory_Supply where SHIPNODE_Key='XNJ' and quantity>100 );

select * from aws_ster_sch.YFS_ITEM where extn_ITEM_CODE='EL3919VCKR1A02' and EXTN_LOT_NO='2JA000002' and EXTN_PRODUCT_CODE='V';

select * from TITAN_DADI_INV_AVL_STAGING where ITEM_ID in (
'EPF2KCPAYAAA002JA000023','EP1920PLSAAA002JA000009','EL2114PAAAAB022JD000014') order by ITEM_ID,NODE;

select * from TITAN_DADI where ITEM_ID='EZ0102ZEARAS002BL004186';


select * from yfs_sub_flow where sub_flow_name like '%IBD_getForEachOrderLineStatus%';
select * from yfs_sub_flow where modifyts>'20240717' ;
select flow_key from yfs_sub_flow where config_xml like '%IBD_getForEachOrderLineStatus%';
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%Test_ReturnUpdatesToERP%');




select * from yfs_sub_flow where config_xml like '%IBD_CarrierDetermination%';

select * from YFS_ACTION where actionname='IBD_CancelOrder';

select * from yfs_flow where flow_name like '%IBD_getForEachOrderLineStatus%';



select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%IBD_PackUpdateFromOmniPOSS%');

select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%OrderDetDB%');
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%IBD_DeliverySuccessOmniPossETP%');
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%IBD_PublishReturnShipment%');
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%titan.receivepackupdate.q%');
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%Test_CancelUpdatesToOMNIPOSS%');

select * from yfs_server where server_name in ('IBDCarrierSelectionROAgentServer','IBDCarrierSelectionAgentServer');



select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,createts from yfs_shipment where order_no in('US00115255');

select SCAC,shipment_no,order_no,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where SCAC='UPSC' and AIRWAY_BILL_NO is not null order by modifyts desc;

select * from yfs_shipment where order_no='US00114755';

select * from yfs_flow where flow_name like '%IBD_StatusUpdatesToERP%';


select * from yfs_shipment where order_no in 
('00005835','00005834','00005832','00005806','00005805','00005798','00005796');
select SCAC,shipment_no,order_no,AIRWAY_BILL_NO,order_no,SHIPNODE_KEY,createts from yfs_shipment where order_no in 
('00005835','00005834','00005832','00005806','00005805','00005798','00005796');

select * from yfs_reprocess_error where ERRORTXNID > '20240529'  and flow_name like '%IBD_AWBNoAndShipment_Async%' ;

select * from yfs_flow where flow_name like '%TCI_RevManifestCallTest%';
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%titan.orderdelivermail.q%');
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%IBD_PostUpdatesToERPDB%');
select SCAC,shipment_no,order_no,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where Order_no ='Y100011842';


select * from  yfs_export where Export_key >'20250601' and Flow_name='IBD_OrderDetailOmniPossStoreDB' 
and message like '%00006285%'  order by createts desc;

select * from  yfs_export where  Flow_name='InvoiceCreationToPOS'   order by createts desc;


select * from yfs_sub_flow where config_xml like '%500001058568%';
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%IBD_postCancelMsgtoQueue%');
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%IBD_PostCancelMsg%');
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%IBD_OrderDetailOmniPossPostQ%');
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%IBD_ChangeShipment%');

select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%IBD_UPSShipmentStatus%');
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%IBD_UPSTrackShipment%');
select * from yfs_sub_flow where config_xml like '%IBD_UPSExecuteJob%';



select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%Transguard%');
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%AWBReq%');

select * from yfs_flow where FLOW_NAME like '%Transguard%';

select * from yfs_flow where flow_name like '%SF_changeOrderRealTime_SFCC%';
select * from yfs_flow where flow_name like '%SFCC%';

select * from yfs_order_header where order_header_key>'20241120' and enterprise_key='TITAN_GCC' and document_type='0003' and order_type !='Customer Return';

select * from yfs_order_header where order_header_key>'20250301' and enterprise_key='TITAN_GCC' and document_type='0001';

select message,createts from  yfs_export where Flow_name='IBD_UPSRetReqDB' and EXPORT_KEY > '20250210' order by createts desc;
select message,createts from  yfs_export where Flow_name='IBD_UPSRetResDB' and EXPORT_KEY > '20250210'  order by createts desc;

select message,createts from  yfs_export where Flow_name='IBD_UPSAWBReqDB' and EXPORT_KEY > '20250730' order by createts desc;

select message,createts from  yfs_export where Flow_name='IBD_UPSAWBReqDB' and EXPORT_KEY > '20240911' 
and message like '%Y100012564%' order by createts desc;

select message,createts from  yfs_export where Flow_name='IBD_UPSAWBResDB' and EXPORT_KEY > '20250730' order by createts desc;

select message,createts from  yfs_export where EXPORT_KEY > '20241205' and message like '%100007101%' order by createts desc;


select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%OrderDetDB%');

select * from yfs_shipment_line where shipment_key in (
select shipment_key from yfs_shipment where order_no = '00004781'); 

select * from yfs_reprocess_error where ERRORTXNID > '20240723'  and message like '%00111343%' ;



select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganReq' and EXPORT_KEY > '20250528' order by createts desc;
select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganResponse' and EXPORT_KEY > '20250528' order by createts desc;


select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganReq' and EXPORT_KEY > '20250221' 
and message like '%00113345%' order by createts desc;
select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganResponse' and EXPORT_KEY > '20240601' 
and message like '%Error%' order by createts desc;

select * from yfs_item;

select * from  yfs_import where import_key>'20250701' and Flow_name='SFCC_CO_XML_DB' and message like '%Extn_Product_Category%'  order by createts asc;

select * from  yfs_import where import_key>'20250312' and Flow_name='SFCC_CO_XML_DB'   order by createts desc;

select * from  yfs_import where import_key>'20250527' and Flow_name='SFCC_CO_XML_DB' and message like '%00005842%'  order by createts desc;



select MESSAGE,CREATETS from yfs_export where export_key > '20250527' and  flow_name like '%IBD_OrderDetailOmniPossStoreDB%' 
and message like '%00006281%' order by createts desc;

select * from yfs_shipment where order_no='00006285';

update yfs_shipment set SHIPMENT_TYPE='GCC_JEWEL' where ORDER_NO in ('00006285','00006282','00006283','00006284','00006281');

select order_no,SHIPMENT_TYPE from yfs_shipment where order_no in(
select order_no from yfs_order_header where enterprise_key='TITAN_GCC' and Document_Type='0001') order by createts desc;

// all messages
select * from  yfs_import where IMPORT_KEY > '20250801' and message like '%00005057%'  order by createts desc;
select * from  yfs_export where EXPORT_KEY > '20250801' and message like '%US00115266%'  order by createts desc;
// all messages

select * from  yfs_export where EXPORT_KEY > '20250419' and FLOW_NAME!='Test_DB_01' and message like '%US00114054%'  order by createts desc;

select * from yfs_order_line where prime_line_no>'1' and order_line_key > '20240901';

select * from yfs_order_line where EXTN_MAKING_CHARGES>'0';

select * from yfs_order_line where EXTN_MAKING_CHARGES>'0' and order_header_key in (
select Order_header_key from  yfs_order_header where ENTERPRISE_KEY='TITAN_GCC' and Document_Type='0001') Order by createts desc;

select * from yfs_order_header;
select * from yfs_reprocess_error where ERRORTXNID > '20240621' and message like '%00002507%';

select * from yfs_order_header where Order_header_key in (
select Order_header_key from yfs_order_line where SHIPNODE_KEY = 'XAW') order by createts desc;

select message,createts from  yfs_export where Flow_name='IBD_PostUpdatesToERPDB' and EXPORT_KEY > '20250515'  order by createts desc;



select * from yfs_order_header where order_header_key>'20250325' order by createts desc;

select * from YFS_CHARGE_TRANSACTION where order_header_key in
(select order_header_key from yfs_order_header where order_no in ('US00114485')) order by modifyts asc;

select * from yfs_task_q where task_q_key>'20250808';

select * from yfs_task_q where task_q_key>'2025062302' and data_type='OrderHeaderKey' and data_key in (
select order_header_key from yfs_order_header where order_no in ('US00115261'));
select * from yfs_order_header where order_no in ();

//update yfs_task_q set AVAILABLE_DATE ='2025-08-19 07:35:00.0'  where TASK_Q_KEY in ('2025081906535757056946');
//update yfs_task_q set AVAILABLE_DATE ='2025-06-10 03:20:00.0'  where TRANSACTION_KEY in ('20220811113638544375');

//delete from yfs_task_q where data_type='OrderHeaderKey' and data_key in (select order_header_key from yfs_order_header where order_no in ('US00114568','US00114569'));

//Stuck Orders in scheduled status
select * from yfs_order_header where order_header_key in (
select DATA_KEY from yfs_task_q where task_q_key>'20250508' and data_type='OrderHeaderKey' 
and ( TRANSACTION_KEY like 'RELEASE%' or TRANSACTION_KEY like '%SCHEDULE%'));

//Forward Order
select * from yfs_task_q where task_q_key>'20250801' 
and ( TRANSACTION_KEY like 'RELEASE%' or TRANSACTION_KEY like '%SCHEDULE%' 
or TRANSACTION_KEY like '%20220811113638544375%' or TRANSACTION_KEY like '%202209122039481244531%') order by createts desc;

select * from yfs_task_q where task_q_key>'20250514' and TRANSACTION_KEY not in ('CLOSE_SHIPMENT','CLOSE_ORDER.0001','PURGE');

select * from yfs_task_q where data_type='OrderReleaseKey' and TRANSACTION_KEY not in ('20220811113638544375');



select * from yfs_order_header where order_header_key in (
select ORDER_HEADER_KEY from yfs_order_release where order_release_key in (
select DATA_KEY from yfs_task_q where task_q_key>'20250601' 
and (TRANSACTION_KEY like '%20220811113638544375%'))) order by createts desc;


select * from YFS_ORDER_LINE_SCHEDULE where order_header_key in (
select order_header_key from yfs_order_header where order_no='US00114479' and ENTERPRISE_KEY='TITAN_US') order by createts desc;

select * from YFS_ORDER_LINE_SCHEDULE where order_header_key in (
select order_header_key from yfs_order_header where order_no='US00114364' and ENTERPRISE_KEY='TITAN_US') order by createts desc;


select * from YFS_ORDER_RELEASE_STATUS where order_header_key in
(select order_header_key from yfs_order_header where order_no='US00020520') order by  CREATETS desc;

//update YFS_ORDER_RELEASE_STATUS set STATUS_DATE='2025-06-09 04:54:12.0' where ORDER_RELEASE_STATUS_KEY='202506090482541454666998';

select * from YFS_CHARGE_TRANSACTION where order_header_key in
(select order_header_key from yfs_order_header where order_no='00005657') order by modifyts asc;

select * from YFS_CHARGE_TRANSACTION where STATUS='OPEN' order by createts desc;

select * from yfs_reprocess_error where  FLOW_NAME like '%IBD_ReceiveStatusUpdateFromOMNIPOSS_Async%'  
and message like '%StatusCode="19"%' order by createts desc;


select * from yfs_flow where flow_name='SF_getCompleteOrderDetails';
select * from yfs_flow where flow_name='IBD_getShipmentListForRet';
select * from yfs_flow where flow_name='IBD_getForEachOrderLineStatus';
select * from yfs_flow where flow_name='IBD_ProcessReturnRecvFromOMNIPOSS';

select * from  yfs_export where Flow_name='IBD_OrderDetailOmniPossStoreDB' and message like '%00002390%' and Export_key >'20240526' order by createts desc;

select message,createts from  yfs_export where EXPORT_KEY > '20240621' and Flow_name='Test_DB_01' and 
message like '%00111059%' order by createts desc;

select * from YFS_SHIPMENT_STATUS_AUDIT where shipment_key in (
select shipment_key from yfs_shipment where order_no = '100005812');

select * from yfs_order_header where order_header_key >'20250403' and order_no like '%00012011%';

select * from yfs_order_line where order_line_key NOT in (
select TABLE_KEY from YFS_REFERENCE_TABLE ) and DERIVED_FROM_ORDER_HEADER_KEY IS not null order by modifyts desc;


SELECT ORS.ORDER_LINE_KEY,ORS.STATUS,STATUS_DATE,ORS.STATUS_QUANTITY,ORS.TOTAL_QUANTITY,OS.DESCRIPTION 
FROM AWS_STER_SCH.YFS_ORDER_RELEASE_STATUS ORS,AWS_STER_SCH.YFS_STATUS OS 
WHERE ORS.ORDER_LINE_KEY in ('2024062103191630013200','2024062103334030013994')
AND ORS.STATUS=OS.STATUS  AND OS.PROCESS_TYPE_KEY='RETURN_FULFILLMENT' ORDER BY ORS.STATUS_DATE ASC with ur;

SELECT ORS.ORDER_LINE_KEY,ORS.STATUS,STATUS_DATE,ORS.STATUS_QUANTITY,ORS.TOTAL_QUANTITY,OS.DESCRIPTION 
FROM AWS_STER_SCH.YFS_ORDER_RELEASE_STATUS ORS,AWS_STER_SCH.YFS_STATUS OS 
WHERE ORS.ORDER_LINE_KEY in ('2024062103191630013200','2024062103334030013994') 
AND ORS.STATUS=OS.STATUS  AND OS.PROCESS_TYPE_KEY='ORDER_FULFILLMENT' ORDER BY ORS.STATUS_DATE ASC with ur;

select * from yfs_order_line where order_header_key in (
select order_header_key from yfs_order_header where order_no in 
('US00114491'));

select * from yfs_order_header where order_no in 
('US00114491');

select * from yfs_order_line ; 

select * from YFS_REFERENCE_TABLE where TABLE_NAME='YFS_ORDER_LINE' and TABLE_KEY in ('2024062502213730139842','2024062502585430142196');


select * from yfs_flow where flow_name like '%IBD_UPSTrackShipment%';



select SCAC,shipment_no,order_no,AIRWAY_BILL_NO,shipnode_key,shipment_key,createts from yfs_shipment where order_no in
('US00114955');
select * from yfs_shipment where order_no in('Y100012502','Y100012503');
select * from yfs_shipment_line where shipment_key in
(select shipment_key from yfs_shipment where order_no in('Y100012502','Y100012503'));

select * from yfs_shipment_line where shipment_key='2024121210190342353574';
 
select * from yfs_charge_transaction where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_no='A00013452' ) order by modifyts asc;

select * from YFS_PAYMENT where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_no='00006285' ) order by modifyts desc;


select * from YFS_PAYMENT where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_header_key>'20250526' ) order by modifyts desc;

select * from yfs_order_header where order_header_key in ('2025052705574454285438');
select * from  yfs_export where Export_key >'20250225' and message like '%Y100012631%'   order by createts desc;

//and Flow_name='IBD_OrderDetailOmniPossStoreDB' 
select * from  yfs_export where Export_key >'20250227' and message like '%Y100012632%'   order by createts desc;
select * from  yfs_export where Export_key >'20250219' and message like '%00113311%'   order by createts desc;

select * from yfs_reprocess_error where ERRORTXNID > '20240618' and message like '%00002507%';

select * from yfs_export where Export_key >'20250701' and Flow_name='IBD_ReturnShipmentPublish_DB' order by createts desc;

select * from yfs_flow where flow_name in ('IBD_UPSStatusUpdateHTTP','IBD_UPSReturnShipmentReq',
'IBD_UPSCreatePickupReq','IBD_UPSShipmentReq');


select  FLOW_NAME,count(*) from yfs_reprocess_error where ERRORTXNID > '20240524' group by FLOW_NAME;

select * from yfs_export where  export_key>'20241230' and flow_name like '%TransguardStatusUpdates%' 
order by createts desc;
//and (message like '%100005837%' or message like '%100005838%') order by createts desc;
select SCAC,shipment_no,shipment_key,order_no,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where order_no in ('US00113831');

select * from yfs_shipment_line where shipment_key ='2024121107262342294177';

select * from yfs_export where export_key>'20240626' and message like '%00002562%'  order by createts desc;

select * from yfs_export where  export_key>'20240627' and flow_name like '%TransguardStatusUpdates%' order by createts desc;


select PAYMENT_REFERENCE2,MAX_CHARGE_LIMIT,PAYMENT_REFERENCE6 from yfs_payment where PAYMENT_REFERENCE1='00002588';

select * from yfs_export where  export_key>'20240101' and flow_name like '%UPSRTODB%' order by createts desc;


//Avalara
//status - commited
select message,createts from  yfs_export where Flow_name='IBD_AvalaraCommitReq' and EXPORT_KEY > '20250530' order by createts desc;
select message,createts from  yfs_export where Flow_name='IBD_AvalaraCommitRes' and EXPORT_KEY > '20250530' order by createts desc;


select message,createts from  yfs_export where Flow_name='IBD_AvalaraCommitRes' and EXPORT_KEY > '20250201' 
 and message like '%Error%' order by createts desc;

//or cancel and return. trans type is returninv
select message,createts from  yfs_export where EXPORT_KEY > '20250801' and Flow_name='IBD_AvalaraRefundReq' order by createts desc;
select message,createts from  yfs_export where EXPORT_KEY > '20250801' and Flow_name='IBD_AvalaraRefundRes' order by createts desc;
//Avalara


//JPMC
select message,createts from  yfs_export where Flow_name='IBD_JPMorganReq' and EXPORT_KEY > '20250601'  order by createts desc;

select message,createts from  yfs_export where Flow_name='IBD_JPMorganResponse' and EXPORT_KEY > '20250601' order by createts desc;
//JPMC
select * from YFS_CHARGE_TRANSACTION where order_header_key in
(select order_header_key from yfs_order_header where order_no='00113155') order by createts asc;

select * from yfs_order_header where order_no='US00114498';

select * from YFS_ORDER_HOLD_TYPE where status ='1100' and ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where HOLD_FLAG='Y' and modifyts > '2025-03-11' and ENTERPRISE_KEY='TITAN_US') 
and modifyts > '2025-03-11' order by modifyts desc; 

select * from yfs_export where  EXPORT_KEY > '20240923' and message like '%en10000003%';

//NGenius
select message,createts from  yfs_export where Flow_name='IBD_NGeniusReq' and EXPORT_KEY > '20250721' order by createts desc;
select message,createts from  yfs_export where Flow_name='IBD_NGeniusResponse' and EXPORT_KEY > '20250721' order by createts desc;

 
select message,createts from  yfs_export where Flow_name='IBD_NGeniusRefReq' and EXPORT_KEY > '20250621' order by createts desc;
select message,createts from  yfs_export where Flow_name='IBD_RefResponse'   and EXPORT_KEY > '20250721' order by createts desc;
//NGenius

select message,createts from  yfs_export where Flow_name='IBD_NGeniusReq' and EXPORT_KEY > '20250701' 
and message like '%48cc9559-f30f-4436-bb67-0ceeac6e66a9%' order by createts desc;

select message,createts from  yfs_export where Flow_name='IBD_NGeniusReq' and EXPORT_KEY > '20250721' 
and message like '%c465db44-640c-4842-a4ff-ab6e9a45e0f4%' order by createts desc;


select * from YFS_PAYMENT where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_no='00006281' ) order by modifyts desc;

select * from yfs_order_header where order_header_key in(
select ORDER_HEADER_KEY from YFS_PAYMENT where PAYMENT_REFERENCE2 like '%15f294be-2fbc-4fd6-8e7a-5c23be08c099%');

select message,createts from  yfs_export where Flow_name='IBD_NGeniusReq' and EXPORT_KEY > '20250203' and message like '%4740568a-8271-416d-b737-a2235e6629d2%' order by createts desc;

select * from  yfs_export where EXPORT_KEY > '20240716' and message like '%d1b215a%' order by createts desc;


select * from yfs_charge_transaction where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_no in ('00005842')) order by CHARGE_TRANSACTION_KEY asc;

select * from yfs_order_header where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_payment where PAYMENT_REFERENCE2='f20213cc-c743-4e2d-ba5e-c0a0c8f0d5fa');


select * from yfs_order_header where order_no in ('00005082');

//update yfs_order_header set ORDER_HEADER_KEY='2025031703384150694919' where order_no in ('00005082') and ENTERPRISE_KEY='TITAN_GCC';

select * from yfs_heartbeat where status='00' and server_name  like '%Agent%' order by modifyts desc;
select * from yfs_server where server_name  like '%ScheduleOrderAgentServer%';
select * from yfs_agent_criteria where server_key in (select SERVER_KEY from yfs_server where server_name  like '%UpdateDADIAvlStagingIntegServer%');


select * from yfs_export where  export_key>'20250701' and flow_name like '%SF_Inv_Inp%' order by createts desc;
select * from yfs_export where  export_key>'20250521' and flow_name like '%SF_Inv_Out%' order by createts desc;

select * from yfs_export where  export_key>'20240805' and flow_name like '%SF_Inv_Out%' 
and message like '%UL1033SDDADA043IH000001%' order by createts desc;
'UPW1D1DMBABA182BA000001',
'UL1033SDDADA043IH000001',
'UL1920SDDAGA002JA000014',
'UL5090SJLADA042JD000004',
'UL3618SAUABA003IH000001',
'UL3414DAXADA042JA000004'


select * from yfs_export where  export_key>'20250317' and flow_name like '%SF_ResInv_Input_DBTrace%' order by createts desc;
select * from yfs_export where  export_key>'20250327' and flow_name like '%SF_ResInv_Output_DBTrace%' order by createts desc;
select * from yfs_export where  export_key>'20250220' and flow_name like '%SF_CanResInv_Input_DBTrace%' order by createts desc;

select * from  yfs_export where flow_name='SFCC_OrderCancel_DB' and EXPORT_KEY > '20250301' and message like '%00002387%' order by createts desc;
select * from  yfs_export where flow_name='SFCC_OrderCancel_DB' and EXPORT_KEY > '20250501' order by createts desc;


select * from yfs_export where  export_key>'20241004' and flow_name='SF_ResInv_Input_DBTrace' 
and message like '%EL0494FWAPAA022JA000031%' order by createts desc;

select * from yfs_export where  export_key>'20241004' and flow_name='SF_ResInv_Output_DBTrace' 
and message like '%EL0494FWAPAA022JA000031%' order by createts desc;

select * from yfs_export where  export_key>'20241004' and flow_name='SF_CanResInv_Input_DBTrace' 
and message like '%EL0494FWAPAA022JA000031%' order by createts desc;

select * from  yfs_import where import_key>'20250530' and Flow_name='SFCC_CO_XML_DB' and message like '%US00115266%' order by createts desc;

select ORDER_HEADER_KEY,PRIME_LINE_NO,ITEM_ID,ORDERED_QTY,EXTN_SELLER_LINE_NO,ship_together_no,condition_variable_2 from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no in ('00005981') and ENTERPRISE_KEY='TITAN_GCC');

select ORDER_HEADER_KEY,PRIME_LINE_NO,ITEM_ID,ORDERED_QTY,EXTN_SO_SELLER_LINE_NO,ship_together_no,EXTN_SELLER_LINE_NO,condition_variable_2 from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no in ('US00113842','Y100012844') and ENTERPRISE_KEY='TITAN_US');

select ORDER_HEADER_KEY,PRIME_LINE_NO,ITEM_ID,ORDERED_QTY,EXTN_SO_SELLER_LINE_NO,ship_together_no,EXTN_SELLER_LINE_NO,condition_variable_2 from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no in ('US00113815') and ENTERPRISE_KEY='TITAN_US');


select ORDER_HEADER_KEY,PRIME_LINE_NO,ITEM_ID,ORDERED_QTY,EXTN_SO_SELLER_LINE_NO,ship_together_no,EXTN_SELLER_LINE_NO,condition_variable_2 
from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where Document_Type='0001' and ENTERPRISE_KEY='TITAN_US')
and SHIP_TOGETHER_NO!=' ' order by createts desc;

//Get Return Order with sales order No
select order_no as RO_No from yfs_order_header where order_header_key in (
select ORDER_HEADER_KEY from yfs_order_line where DERIVED_FROM_ORDER_HEADER_KEY in (
select order_header_key from yfs_order_header where order_no='US00115076'));

//update  yfs_order_line set SHIP_TOGETHER_NO='2'
//where ORDER_HEADER_KEY in (select ORDER_HEADER_KEY from yfs_order_header where order_no='00113656' and ENTERPRISE_KEY='TITAN_US');

select * from yfs_order_header where ORDER_HEADER_KEY='2025032006031051753102' order by createts desc;


select * from yfs_order_header where Document_Type='0001' and ENTERPRISE_KEY='TITAN_GCC' order by createts desc;

select * from yfs_export where export_key>'20250530' and flow_name like '%TestSaveXMLtoDB01%' order by createts desc;

select * from yfs_export where export_key>'20241009' and flow_name like '%SFCC_OrderCancel_DB%' order by createts desc;

select * from yfs_export where export_key>'20241009' and flow_name like '%SFCC_OrderCancel_DB%' 
and message like '%00111939%' order by createts desc;

select * from yfs_export where export_key>'20250711' and flow_name like '%SFCC_ReturnOrder_DB%' order by createts desc;

select * from yfs_export where export_key>'20250401' and flow_name like '%SF_OrderDetailInp%' order by createts desc;

select * from yfs_export where export_key>'20240905' and flow_name like '%SF_OrderDetailOut%' order by createts desc;

select * from yfs_export where export_key>'20240701' and flow_name like '%RTAM_DB%' order by createts desc;

select * from yfs_export where export_key>'20241206' and flow_name like '%Test_DB_01%' and message like '%00112469%' 
 order by createts desc;


select * from yfs_export where export_key>'20250801' and flow_name like '%TestDB_03%'  
 order by createts desc;
 
select * from  yfs_export where EXPORT_KEY > '20250107' and message like '%00112755%' order by createts desc;

select * from yfs_export where export_key>'20250801' and flow_name like '%Test_DB_01%' 
and USER_REFERENCE='SFCC=GetOrder_Details'  order by createts desc;

select * from yfs_export where export_key>'20250227' and flow_name like '%IBD_OrderDetailOmniPossStoreDB%'   order by createts desc;

select * from yfs_export where export_key>'20250227' and flow_name like '%IBD_PostUpdatesToERPDB%'   order by createts desc;
select SCAC,shipment_no,order_no,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where order_no='Y100012844';

select *  from yfs_export where export_key>'20250701' and flow_name like '%IBD_OrderDetailERPStoreDB%'  order by modifyts desc;

select *  from yfs_export where export_key>'20250501' and flow_name like '%IBD_OrderDetailERPStoreDB%' 
and message like '%US00115171%' order by modifyts desc;

select * from yfs_export where export_key>'20240704' and message like '%00002613%' order by createts desc;

select * from yfs_export where export_key>'20240708' order by createts desc;

//UPS AWB Generation
select message,createts from  yfs_export where Flow_name='IBD_UPSAWBReqDB' and EXPORT_KEY > '20240714'  and EXPORT_KEY < '20240717' order by createts desc;
select message,createts from  yfs_export where Flow_name='IBD_UPSAWBResDB' and EXPORT_KEY > '20240714'  and EXPORT_KEY < '20240717' order by createts desc;

select FLOW_NAME,ERRORSTRING,STATE,MESSAGE,ERRORMESSAGE,MODIFYTS from yfs_reprocess_error where ERRORTXNID > '20241212' and 
FLOW_NAME like '%IBD_AWBNoAndShipment_Async%'  order by createts desc;

//Return
select message,createts from  yfs_export where Flow_name='IBD_UPSRetReqDB' and EXPORT_KEY > '20250205' order by createts desc;
select message,createts from  yfs_export where Flow_name='IBD_UPSRetResDB' and EXPORT_KEY > '20250205'  order by createts desc;

select message,createts from  yfs_export where Flow_name='IBD_UPSRetReqDB' and EXPORT_KEY > '20240714'  and EXPORT_KEY < '20240717' order by createts desc;

select message,createts from  yfs_export where Flow_name='IBD_UPSRetResDB' and EXPORT_KEY > '20241211'  and EXPORT_KEY < '20240717'  order by createts desc;
//UPS AWB Generation
//AWB number checks
select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,order_no,createts from yfs_shipment where modifyts>'20240627' and scac='UPSC';

US00113823


select * from yfs_reprocess_error where ERRORTXNID > '20240705' order by modifyts desc; 

select * from yfs_flow where flow_name like '%IBD_AvalaraRefundReq%';
select * from yfs_sub_flow where SUB_FLOW_NAME like '%ApiorFlow%';

select * from yfs_server where server_key ='20220721162328190480';

select SYSTEM_NAME,flow_name,USER_REFERENCE,message,createts from  yfs_export where EXPORT_KEY > '20240708' and message like '%00111211%' order by createts desc;
 
 
 select * from yfs_export where export_key>'20241014' and flow_name like '%SFCC_OrderCancel_DB%' order by createts desc;
 
 select * from yfs_sub_flow where config_xml like '%IBD_GetShipmentListForTitanPayment%';
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%titan.carrierpublish.q%');
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%IBD_PublishReturnOrderToOmniPOSS%');
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%IBD_ReturnShipmentPublish_DB%')order by PROCESS_TYPE_KEY, FLOW_GROUP_NAME;
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%titan.returnshipmentpublish.q%');
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%IBD_PublishReturnOrderToOmniPOSS%');

select * from yfs_sub_flow where config_xml like '%IBD_GetShipmentListForTitanPayment%';
select * from yfs_flow where flow_name like '%IBD_GetShipmentListForTitanPayment%';

select message,createts from  yfs_export where Flow_name='IBD_PostUpdatesToERPDB' and EXPORT_KEY > '20240930' 
and message like '%Approved%' order by createts desc;

select message,createts from  yfs_export where Flow_name='IBD_PostUpdatesToERPDB' and EXPORT_KEY > '20250228'  order by createts desc;


select * from yfs_export where export_key>'20250701' and flow_name='IBD_ReturnShipmentPublish_DB' order by createts desc;



select * from yfs_charge_transaction where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_no='A00013452') order by modifyts asc;

select * from YFS_PAYMENT where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_no='A00013452' ) order by modifyts desc;

select * from YFS_ORDER_HOLD_TYPE where status ='1100' and ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where HOLD_FLAG='Y' and modifyts > '2025-02-04' and ENTERPRISE_KEY='TITAN_GCC'); 


select * from YFS_ORDER_HOLD_TYPE where  STATUS= '1300' and  ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where HOLD_FLAG='Y' and modifyts > '2025-01-01' and ENTERPRISE_KEY='TITAN_GCC'); 

select * from  yfs_import where IMPORT_KEY > '20240711'  order by createts desc;

select ORDER_HEADER_KEY,PRIME_LINE_NO,ITEM_ID,ORDERED_QTY,EXTN_SELLER_LINE_NO from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no='US00113815');

select * from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no='US00114679');

select * from yfs_order_line where ORDER_LINE_KEY >'20250501' order by createts desc;

select * from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where document_type='0003');

select ConditionVariable2 from yfs_order_line where ConditionVariable2 !='';


select * from yfs_export where export_key>'20240704' and flow_name like '%SFCC_ReturnOrder_DB%' and message like '%GCC%' order by createts desc;

select * from yfs_order_line where item_id in ('EL0064OFAAAB022JA000004');

select * from yfs_order_header where order_header_key in (
select ORDER_HEADER_KEY from yfs_order_line where item_id in ('EL0064OFAAAB022JA000004'));

select ORDER_HEADER_KEY from yfs_order_header where Order_no='00003242';

select * from  YFS_REFERENCE_TABLE where TABLE_NAME='YFS_ORDER_LINE' and table_key in (
select order_line_key from yfs_order_line where order_header_key in (
select order_header_key from yfs_order_header where order_no in ('00005594','Y100012749')));

select * from yfs_order_header where order_no in('Y100012003','Y100012004');
select * from yfs_order_line where order_header_key in ('2024071506073031541168','2024071506183231542613');
select * from  YFS_REFERENCE_TABLE where TABLE_NAME='YFS_ORDER_LINE' and table_key in('2024071506073031541167','2024071506183231542612');

select * from yfs_reprocess_error where ERRORTXNID > '20240715' order by modifyts desc; 
select FLOW_NAME,USER_REFERENCE,message,createts 
from  yfs_export where EXPORT_KEY > '20250110' and message like '%00112469%' order by createts desc;
select FLOW_NAME,USER_REFERENCE,message,createts from  yfs_import where IMPORT_KEY > '20240920' and message like '%en10000002%' order by createts desc;

select * from  yfs_export where EXPORT_KEY > '20250701' and message like '%US00114690%' and
USER_REFERENCE!='SFCC=GetOrder_Details' order by createts desc;

select * from  yfs_import where IMPORT_KEY > '20250310' and message like '%00005090%' order by createts desc;

select * from  yfs_import where IMPORT_KEY > '20250404' and message like '%US00113832%' and FLOW_NAME!='SFCC_CO_XML_DB' order by createts desc;


select * from yfs_order_header where order_header_key>'20250101' and enterprise_key='TITAN_GCC' and document_type='0001';


select * from  yfs_export where EXPORT_KEY > '20250212' and message like '%Y100012613%' order by createts desc;

select * from  yfs_export where EXPORT_KEY > '20240904' and message like '%00003158%' order by createts desc;

select FLOW_NAME,USER_REFERENCE,message,createts from  yfs_import where IMPORT_KEY between '20240826' and '20240827'
and message like '%00111528%' order by createts desc;


select FLOW_NAME,USER_REFERENCE,message,createts from  yfs_export where EXPORT_KEY > '20240826' and flow_name='' 
and message like '%00111528%' order by createts desc;


select * from yfs_order_line;
select * from yfs_order_header where EXTN_ENCIRCLE_POINTS>'1';

select FLOW_NAME,USER_REFERENCE,message,createts from  yfs_export where EXPORT_KEY > '20240715' and flow_name='IBD_PostUpdatesToERPDB' 
and message like '%StatusCode%' order by createts desc;

select FLOW_NAME,USER_REFERENCE,message,createts from  yfs_export where EXPORT_KEY > '20240715' and flow_name='IBD_PostUpdatesToERPDB' 
and message like '%StatusCode%' order by createts desc;


select * from YFS_ORDER_HOLD_TYPE where status ='1100' and HOLD_TYPE='CC_REFUND_HOLD' and ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where HOLD_FLAG='Y' and modifyts > '2024-07-01' and ENTERPRISE_KEY='TITAN_GCC') order by modifyts desc; 

select * from yfs_order_header where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from YFS_ORDER_HOLD_TYPE where status ='1100' and HOLD_TYPE='CC_REFUND_HOLD' and ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where HOLD_FLAG='Y' and modifyts > '2024-07-01' and ENTERPRISE_KEY='TITAN_GCC') )order by modifyts desc; 




select * from yfs_export where export_key>'20240715' and message like '%00003046%' order by modifyts desc;
select * from yfs_export where export_key>'20240715' and flow_name like '%ERP%'  order by modifyts desc;




select * from yfs_flow where flow_name like '%IBD_GetShipmentListForTitanPayment%';
select * from yfs_flow where flow_name like '%IBD_SQLProcessor%';

select * from yfs_inventory_item where INVENTORY_ITEM_KEY in(
select INVENTORY_ITEM_KEY from yfs_inventory_Supply where modifyts>'20240715' and 
modifyprogid='IBDUSReceiveStoreInvUpdateIntegServer' )order by modifyts desc;


select *  from yfs_export where export_key>'20250801' and flow_name like '%TransguardCreateOrder%'  order by createts desc;
select *  from yfs_export where export_key>'20250120' and flow_name like '%TransguardReturnOrder%'  order by createts desc;

select *  from yfs_export where export_key>'20240717' and flow_name like '%TransguardCreateOrder%' and message like '%100006352%' order by createts desc;
select *  from yfs_export where export_key>'20250110' and flow_name like '%TransguardReturnOrder%' and message like '%Y100012521%' order by createts desc;

select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%OMNI_SFS_TQAE_ORDINFORETST%');
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%IBD_OrderDetailOmniPoss%');
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%titan.deliverysuccess.omniposs.q%');

select * from  yfs_export where export_key>'20250609' and Flow_name='Sol_WCSBeforeCreateOrder' and message like '%US00114568%' order by createts asc;
select * from  yfs_export where Flow_name='Sol_WCSToOMSConverted' and message like '%455089229078a%' order by createts desc;

select * from  yfs_export where Flow_name='Sol_WCSBeforeCreateOrder'  and message like '%455089229078a%' order by createts desc;

select * from  yfs_import where Flow_name='IBD_CaptureWCSOrderXML' and message like '%455089229078a%'  order by createts desc;

select * from yfs_order_header where order_no='00006285';
select * from yfs_order_line where order_header_key='2025071406234656431902';
select * from TITAN_PAYMENT_DETAILS where order_line_key in ('2025071406234656431903','2025071406234656431905');

select * from TITAN_PAYMENT_DETAILS where order_line_key in (
select TRIM(ORDER_LINE_KEY) from yfs_order_line where order_header_key in (
select order_header_key from yfs_order_header where order_no in ('00006281')));



select * from 


select * from TITAN_PAYMENT_DETAILS order by modifyts desc;

select * from TITAN_PAYMENT_DETAILS where AMOUNT_PER_LINE>'0' order by modifyts desc;

select * from yfs_order_header where Order_header_key in (
select DERIVED_FROM_ORDER_HEADER_KEY from yfs_order_line where ORDER_HEADER_KEY in (
select order_header_key from yfs_order_header where order_no='00111248' and ENTERPRISE_KEY='TITAN_US')) order by modifyts desc;;


select * from yfs_reprocess_error where ERRORTXNID > '20240717' and FLOW_NAME like '%IBD_ReceiveStatusUpdateFromERP_Async%' order by createts desc;

select * from yfs_inventory_Supply where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where 
Item_id in ('UPW2TTOCIAAAP12EA000001','UP1160OUKAAAP12EB000006'));

select *  from yfs_export where export_key>'20250515' and flow_name like '%IBD_OrderDetailERPStoreDB%' order by modifyts desc;

select *  from yfs_export where export_key>'20250401' and flow_name like '%IBD_OrderDetailERPStoreDB%' 
and message like '%US00114054%' order by modifyts desc;

select * from yfs_audit order by modifyts desc;
select *  from yfs_export where export_key>'20240723' and message like '%00002738%' order by modifyts desc;


select *  from yfs_export where export_key>'20240709' and message like '%00002652%' order by modifyts desc;
select *  from yfs_export where export_key>'20240709' and flow_name like '%IBD_PostUpdatesToOMNIPOSSDB%' and message like '%00002652%' order by modifyts desc;
select * from yfs_export where flow_name='TransguardStatusUpdates' and message like '%PICK%' order by modifyts desc;

// Inventory Change queries
SELECT  yi.Organization_code,yi.ITEM_ID,yi.EXTN_ITEM_CODE,yi.EXTN_LOT_NO,yi.POSTING_CLASSIFICATION,yi.EXTN_PRODUCT_CODE
FROM aws_ster_sch.YFS_ITEM yi WHERE yi.item_id in
('UL2617BBQHAA042BD000001');

select * from yfs_inventory_Supply where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where 
Item_id in ('UL1002SLZADA012BD000002'));

select * from yfs_inventory_Supply where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where 
Item_id in ('EZ0102ZBARAS002BL005954'));

select * from yfs_inventory_demand where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where 
Item_id in ('UPW2TTOCIAAAP12EA000001','UP1160OUKAAAP12EB000006'));


//DELETE FROM yfs_inventory_Supply where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where Item_id in ('EZ0102ZBARAS002BL005954'));
//DELETE FROM yfs_inventory_demand where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where Item_id in ('UL2617BBQHAA042BD000001'));
select * from TITAN_DADI_INV_AVL_STAGING where ITEM_ID in
('EZ0102ZBARAS002BL005954');

//delete from TITAN_DADI_INV_AVL_STAGING where ITEM_ID in('EZ0102ZBARAS002BL005954');


select * from TITAN_DADI_INV_AVL_STAGING where AVAILABLE_QTY>'0' and ITEM_ID in 
('EL0063OFAAAB022JA000004','EL0063OKAAAA042JA000013','EL0063OLAAAC022JA000003','EL0063OXAAAC042JA000005',
'EL0064OFAAAB022JA000004','EL0060SAAAGAPL2JA000028','EL0063OJAAAB022JA000010','EL0104SQAABAPL3IH000074',
'EL0178SGAABA122JA000057','EL0819OIAABA022JA000007','EL0009SXAABA122JA000027','EL0063ODAAAB042JA000004',
'EL0063OJAAAB042JA000005','EL0063OXAAAC042JA000003','EL0063SLAABA132JA000037') ;




select * from TITAN_DADI_INV_AVL_STAGING where ITEM_ID in
('EZ0102ZBARAS002BL005498');


//DELETE FROM TITAN_DADI_INV_AVL_STAGING where ITEM_ID in('UL2617BBQHAA042BD000001');

select * from yfs_reprocess_error where ERRORTXNID > '20240724'  and flow_name like '%IBD_ReceiveStatusUpdateFromOMNIPOSS_Async%' ;

select * from yfs_order_release_status where  ORDER_HEADER_KEY in (
select order_header_key from yfs_order_header where Order_no in ('US00113816')) order by createts desc;

select * from yfs_order_release_status  where ORDER_LINE_KEY='2025020307454544290950' order by CREATETS desc;;

select * from yfs_order_release_status where  ORDER_HEADER_KEY in (
select order_header_key from yfs_order_header where Order_no in ('00111687')) order by status desc;

//update yfs_order_release_status set STATUS_DATE ='2024-09-12 03:55:29.0'  where ORDER_RELEASE_STATUS_KEY in ('202409120368553136678986');

select * from yfs_order_line where ORDER_HEADER_KEY in (
select order_header_key from yfs_order_header where Order_no in ('Y100012436'));

select * from yfs_reprocess_error where ERRORTXNID > '20240725' and FLOW_NAME like '%IBD_ReceiveStatusUpdateFromERP_Async%' and STATE='Initial' order by createts desc;
select * from yfs_reprocess_error where ERRORTXNID > '20240725' and FLOW_NAME like '%IBD_ReceiveStatusUpdateFromOMNIPOSS_Async%' and STATE='Initial' order by createts desc;

select * from yfs_reprocess_error where ERRORTXNID > '20240725' and FLOW_NAME like '%IBD_ReceiveStatusUpdateFromOMNIPOSS_Async%' 
and message like '%100006330%' and STATE='Initial' order by createts desc;

select * from yfs_reprocess_error where ERRORTXNID > '20240725' and FLOW_NAME like '%IBD_ReceiveStatusUpdateFromOMNIPOSS_Async%' 
and message like '%100006330%'  order by createts desc;

select *  from yfs_export where export_key>'20240725' and message like '%00111351%' order by modifyts desc;
select *  from yfs_export where export_key>'20240725' and message like '%00111352%' order by modifyts desc;

select FLOW_NAME,USER_REFERENCE,message,createts from  yfs_export where EXPORT_KEY > '20250228' and 
flow_name ='IBD_PostUpdatesToERPDB' and message like '%00113419%' order by createts desc;

//Manually marking as paid
select * from YFS_CHARGE_TRANSACTION where order_header_key in
(select order_header_key from yfs_order_header where order_no='gccen100006') order by createts asc;

//update YFS_CHARGE_TRANSACTION set STATUS='CHECKED' where CHARGE_TRANSACTION_KEY in ('2024070406534030925923','2024070416274630952631');
//DELETE FROM YFS_CHARGE_TRANSACTION where CHARGE_TRANSACTION_KEY in ('2024070809121831091445');

select * from yfs_payment where order_header_key in
(select order_header_key from yfs_order_header where order_no='10005017') order by modifyts desc;

select * from TITAN_PAYMENT_DETAILS where order_line_key in (
select TRIM(ORDER_LINE_KEY) from yfs_order_line where order_header_key in (
select order_header_key from yfs_order_header where order_no in ('gccen100006')));

select yoh.order_no, yoh.order_header_key, yct.CHARGE_TRANSACTION_KEY, yct.CHARGE_TYPE, yct.STATUS, yct.REQUEST_AMOUNT, yct.DISTRIBUTED_AMOUNT, yct.PAYMENT_KEY, ypmt.PAYMENT_REFERENCE2
from yfs_order_header yoh, yfs_payment ypmt, YFS_CHARGE_TRANSACTION yct
where yoh.order_no='00002817' and
ypmt.ORDER_HEADER_KEY = yoh.ORDER_HEADER_KEY and
yct.ORDER_HEADER_KEY=yoh.ORDER_HEADER_KEY
order by yct.modifyts desc;

select * from yfs_order_header where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from YFS_ORDER_HOLD_TYPE where status ='1100' and HOLD_TYPE='CC_REFUND_HOLD' and ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where HOLD_FLAG='Y' and modifyts > '2024-09-27' and ENTERPRISE_KEY='TITAN_GCC') )order by modifyts desc; 


select * from YFS_ORDER_HOLD_TYPE where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_no='gccen100006' and ENTERPRISE_KEY='TITAN_GCC') order by modifyts desc;

select * from YFS_INVENTORY_RESERVATION order by modifyts desc;

//delete from YFS_INVENTORY_RESERVATION;
select * from yfs_order_line_reservation order by modifyts desc;

select * from YFS_INVENTORY_RESERVATION where INVENTORY_ITEM_KEY in (
select INVENTORY_ITEM_KEY from yfs_inventory_item where 
Item_id in ('el0060saaagapl2ja000028'))order by modifyts desc;

select *  from yfs_export where export_key>'202407300620' and message like '%585c1c531c17a587b69237d348%' order by createts desc;

select * from yfs_export where  export_key>'20240730' and flow_name like '%SF_CanResInv_Input_DBTrace%' order by createts desc;

select * from yfs_inventory_item  where ORGANIZATION_CODE='TITAN_GCC' and  INVENTORY_ITEM_KEY in (
select INVENTORY_ITEM_KEY from yfs_inventory_Supply where modifyts>'20240906') order by modifyts ;

select * from yfs_item where Organization_code='TITAN_GCC' and modifyts>'20240906' and modifyuserid='IBDReceiveLotMasterIntegServer';

select * from yfs_item where Organization_code='TITAN_GCC' and modifyts>'20240906' and modifyuserid='IBDReceiveJewFeedIntegServer' order by modifyts desc;

select * from yfs_item  where item_id in ('EPIMR4HEDAAA002EE000007');
select * from yfs_inventory_Supply where modifyts>'20250527' and shipnode_key='XDX';

select  FLOW_NAME,count(*) from yfs_reprocess_error where ERRORTXNID > '20240730' and STATE='Initial' group by FLOW_NAME ;

select ERRORSTRING,count(*)  from yfs_reprocess_error where ERRORTXNID > '20240730' and FLOW_NAME like '%IBD_UpdateInventory_Async%' and STATE='Initial' and message like '%TITAN_GCC%' group by ERRORSTRING ;

select * from yfs_inventory_Supply where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where 
Item_id in ('EHD1I2PLMAAA013IA000003','EL1135FKALAA022JD000007','EL2015HIOAAA023IA000006',
'EL3119FMENAA022BD000002','EL3120FHGNAA022BD000007'));

select * from yfs_inventory_supply;

select * from yfs_inventory_item;

//Inv export test1
select yii.ITEM_ID, yii.ORGANIZATION_CODE, yis.SHIPNODE_KEY, yis.QUANTITY
from yfs_inventory_supply yis, yfs_inventory_item yii
where yis.QUANTITY>'0' and
yii.INVENTORY_ITEM_KEY=yis.INVENTORY_ITEM_KEY and
yii.ORGANIZATION_CODE='TITAN_GCC' Order by ITEM_ID;

select * from  yfs_export where Flow_name='IBD_OrderDetailOmniPossStoreDB'  and Export_key >'20240805' order by createts desc;

select * from  yfs_export where Export_key >'20250601' and Flow_name='IBD_OrderDetailOmniPossStoreDB' 
and message like '%00005796%'   order by createts desc;


select * from YFS_TRACE_COMPONENT;

select * from 

select message,createts from  yfs_export where EXPORT_KEY > '20240827'  and message like '%00111529%' order by createts desc;
select flow_name,message,createts from  yfs_import where IMPORT_KEY > '20240620'  and message like '%00111530%' order by createts desc;

select FLOW_NAME,message,createts from  yfs_export where EXPORT_KEY > '20240830'  and message like '%00111543%' order by createts desc;
select message,createts from  yfs_import where IMPORT_KEY > '20240620'  and message like '%00002379%' order by createts desc;


select * from yfs_export where export_key between '20250328' and '20250330' and  message like '%Y100012711%';

select * from yfs_export where EXPORT_KEY > '20250101' and flow_name='Test_CancelUpdatesToOMNIPOSS' order by createts desc;
select * from yfs_import where IMPORT_KEY > '20240620'  and message like '%00003006%';

select * from yfs_status;
select * from yfs_status where PROCESS_TYPE_KEY='ORDER_FULFILLMENT' order by status;
select * from yfs_status where PROCESS_TYPE_KEY='RETURN_FULFILLMENT' order by status;
select * from yfs_status where PROCESS_TYPE_KEY='ORDER_DELIVERY' order by status;

select * from yfs_status where PROCESS_TYPE_KEY='RETURN_SHIPMENT' order by status;

select * from yfs_order_invoice where order_header_key in (
select order_header_key from yfs_order_header where Order_no='00111948');

select * from yfs_export where export_key>'20240806' and message like '%00111425%';


select * from YFS_PAYMENT where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_no='US00114374' ) order by modifyts desc;

select * from TITAN_PAYMENT_DETAILS where order_line_key in (
select TRIM(ORDER_LINE_KEY) from yfs_order_line where order_header_key in (
select order_header_key from yfs_order_header where order_no in ('US00114374')));


//Encircle POC
select * from yfs_export where  export_key>'20250515' and Flow_Name='IBD_EncircleIIBDB' order by CREATETS desc;

select * from yfs_export where  export_key>'20250512' and Flow_Name='IBD_ReturnRefEncircleDB' order by CREATETS desc;

select * from yfs_export where  export_key>'20250515' and Flow_Name='IBD_PostInvlMsgForERRefund_InputDB' order by CREATETS desc;

select * from yfs_export where  export_key>'20250207' and Flow_Name='IBD_EncircleReturnRefundHttp_Input' order by CREATETS desc;

select * from YFS_PAYMENT where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_no='00113178' ) order by modifyts desc;

select * from YFS_PERSON_INFO;

select * from YFS_PERSON_INFO where PERSON_INFO_KEY in (
'2025073003514356715039','2025073003514356715039','2025073003514356715030','2025073003514356715031','2024101406400938996877');

update yfs_person_info set state='NY' where PERSON_INFO_KEY in 
('2025073003514356715039','2025073003514356715030','2025073003514356715031');


select * from yfs_order_header where CUSTOMER_EMAILID='hinduja.subburajan@qualitestgroup.com' order by modifyts desc;

select * from yfs_order_header  where order_header_key >'20250401' order by createts desc;

select * from yfs_Order_line order by createts desc;

select * from yfs_payment where payment_type like '%circle%' and PAYMENT_REFERENCE1='1000014501';
select * from yfs_charge_transaction where order_header_key in ('2023060507453014501018') order by modifyts desc;
select * from yfs_order_header where order_header_key in ('20250807104850438765189');

select * from yfs_export where message like '%337658393179%' order by createts desc;

select SCAC,order_no,shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,createts from yfs_shipment where order_no='US00115262';

select order_no,SCAC, shipment_no,SHIPNODE_KEY,AIRWAY_BILL_NO,createts from yfs_shipment where shipment_no='US00115254';


//update yfs_shipment set AIRWAY_BILL_NO='1ZXXXXUS00100008612' where SHIPMENT_NO='100008612' and order_no = 'US00115262' and SCAC='UPSC';


select * from yfs_shipment where order_no='00113359';

//Update yfs_shipment set AIRWAY_BILL_NO='1ZX4025Y0000113421' where order_no='00113421';
//Update yfs_shipment set AIRWAY_BILL_NO='1ZX4025Y0100007644' where SHIPMENT_NO='100007644';

//Update yfs_shipment set NOTIFICATION_SENT='Y' where order_NO in ('Y100003000');


select * from yfs_shipment_line where order_header_key in
(select order_header_key from yfs_order_header where order_no='00111522');

//update yfs_shipment_line set EXTN_AWB_NUMBER='1ZX4029Y7837310001'
//where order_header_key in (select order_header_key from yfs_order_header where order_no='294658370083');

select * from YFS_ORDER_RELEASE_STATUS where order_header_key in
(select order_header_key from yfs_order_header where order_no='00004391') order by order_line_key, createts desc;

select * from yfs_flow where flow_name like '%IBD_ReceiveStoreStatusUpdates%';

select * from yfs_ship_node;

select ORDER_HEADER_KEY,Order_line_key,PRIME_LINE_NO,SUB_LINE_NO,ITEM_ID,ORDERED_QTY,EXTN_SELLER_LINE_NO from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no='gccen100006');

select * from yfs_export where export_key>'20250520' and flow_name='TestSaveXMLtoDB01' order by createts desc;
select * from yfs_import where import_key>'20240930' and flow_name='Test_Cancel'  order by createts desc;

select * from yfs_import where import_key>'20240930' and flow_name='Test_Cancel' and message like '%en10000008%' order by createts desc;


select * from yfs_charge_transaction where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_no='US00113781') order by modifyts asc;


//update yfs_charge_transaction set STATUS='CLOSED' where CHARGE_TRANSACTION_KEY='2024093010323838247247';

//update yfs_charge_transaction set OPEN_AUTHORIZED_AMOUNT='1119.36' where CHARGE_TRANSACTION_KEY='2024082903541735312756';

select count(*) from yfs_charge_transaction where STATUS ='OPEN';

//update YFS_CHARGE_TRANSACTION set STATUS='CHECKED' where STATUS ='OPEN';

select * from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no='00005391' and ENTERPRISE_KEY='TITAN_GCC');

select * from  yfs_import where import_key>'20241210' and Flow_name='SFCC_CO_XML_DB' order by createts desc;

select * from  yfs_import where import_key>'20250501' and Flow_name='SFCC_CO_XML_DB' and message like '%00006384%' order by createts asc;

select * from  yfs_import where import_key between '20240813' and '20240814' and Flow_name='SFCC_CO_XML_DB' order by createts desc;


select * from yfs_export where  flow_name like '%TransguardStatusUpdates%' and 
message like '%StatusCode="RTM"%' order by modifyts desc;

select * from YFS_ORGANIZATION where PARENT_ORGANIZATION_CODE='TITAN_GCC';

select * from yfs_item where unit_weight!='0' and length(trim(Item_id)) > '20' and organization_code='TITAN_US';

select ITEM_ID,NODE,AVAILABLE_QTY  from TITAN_DADI_INV_AVL_STAGING where ITEM_ID in (
select Item_id from yfs_item where unit_weight!='0' and length(trim(Item_id)) > '20' 
and organization_code='TITAN_US' ) and AVAILABLE_QTY >'0' order by createts desc;

select * from yfs_charge_transaction;

select * from yfs_order_header where CUSTOMER_EMAILID_LC='msalmon@solveda.com' order by createts desc;

select * from yfs_order_header where order_no like 'US00114491';
select * from yfs_order_header where order_no like 'en%';
select * from yfs_order_header where order_header_key ='2024092309412237921342';

//update yfs_order_line set EXTN_SO_SELLER_LINE_NO='1' where ORDER_LINE_KEY='2024091608100937462077';

select * from yfs_task_q where task_q_key>'20250101' and data_type='OrderHeaderKey' and data_key in (
select order_header_key from yfs_order_header where order_no in ('00005592'));

select * from yfs_order_header where ENTERPRISE_KEY='TITAN_GCC' and DOCUMENT_TYPE='0001' order by createts desc;

select * from YFS_PAYMENT where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where order_no='US00114465' ) order by modifyts desc;
//Encircle
select * from YFS_CHARGE_TRANSACTION where order_header_key in
(select order_header_key from yfs_order_header where order_no='00005091' and ENTERPRISE_KEY='TITAN_GCC') order by createts asc;

select * from YFS_CHARGE_TRANSACTION where order_header_key in
(select order_header_key from yfs_order_header where order_no='00112259' and ENTERPRISE_KEY='TITAN_US') order by createts asc;

select * from YFS_ORDER_HOLD_TYPE where ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where Order_no='US00113832') order by modifyts desc; 

select * from TITAN_PAYMENT_DETAILS where order_line_key in (
select TRIM(ORDER_LINE_KEY) from yfs_order_line where order_header_key in (
select order_header_key from yfs_order_header where order_no in ('00006285')));

//update TITAN_PAYMENT_DETAILS set PAYMENT_DETAIL_KEY='2025071406234656431903' where ORDER_LINE_KEY='2025071406234656431903';

select * from TITAN_PAYMENT_DETAILS where payment_type='NgeniusPay' and order by createts desc;

--update  TITAN_PAYMENT_DETAILS set AMOUNT_PER_LINE = '29.00'
--where order_line_key in (
--select TRIM(ORDER_LINE_KEY) from yfs_order_line where order_header_key in (
--select order_header_key from yfs_order_header where order_no in ('US00113831')));


select ORDER_HEADER_KEY,PRIME_LINE_NO,ITEM_ID,ORDERED_QTY,EXTN_SELLER_LINE_NO from yfs_order_line where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_header where order_no='Y100012431' and ENTERPRISE_KEY='TITAN_US');

select * from yfs_reprocess_error where ERRORTXNID > '20240930' and FLOW_NAME like '%IBD_getCancelMsg_Async%' and STATE='Initial' order by createts desc;

select * from yfs_export where export_key>'20250520' and flow_name='IBD_EncircleIIBDB' order by createts desc;

select * from yfs_export where export_key>'20250206' and flow_name='IBD_EncircleIIBDB' and message like '%US00114367%' order by createts desc;

select * from yfs_export where export_key>'20250210' and flow_name like '%IBD_EncircleRefund_InputDB%' order by createts desc;
select * from yfs_export where export_key>'20250206' and flow_name like '%IBD_EncircleRefund_InputDB%' 
and message like '%00113178%' order by createts desc;

select * from yfs_export where export_key>'20250206' and flow_name = 'EncircleRefund_InputtoIIBRefundService' order by createts desc;

select * from yfs_export where export_key>'20241008' and flow_name = 'EncircleRefund_InputtoIIBRefundService' 
and message like '%00113178%' order by createts desc;

select * from yfs_export where export_key>'20250210' and flow_name = 'IBD_EncircleRefundHttp_Input' order by createts desc;

select * from yfs_export where export_key>'20241008' and flow_name = 'IBD_EncircleRefundHttp_Input' 
and message like '%00113178%' order by createts desc;

select * from yfs_export where export_key>'20250210' and flow_name = 'IBD_EncircleRefund_InputDB' order by createts desc;

select * from yfs_export where export_key>'20241008' and flow_name = 'IBD_EncircleRefund_InputDB' 
and message like '%00113178%' order by createts desc;


select unique(flow_name) from yfs_export where export_key>'20240930' and flow_name like '%Encircle%';

select * from YFS_PAYMENT_RULE;
select * from yfs_payment_type;

select * from yfs_export where export_key>'20241223' and flow_name = 'IBD_ProcessReturnRecvFromOMNIPOSS_DB' order by createts desc;


select PAYMENT_REFERENCE2 from yfs_payment where Order_header_key in 
(select Order_header_key from yfs_order_header where order_no='00111978')and PAYMENT_TYPE='Encircle';


select * from yfs_import where import_key>'20240701' and flow_name = 'IBD_LogEmail' 
and message like '%OMS_TQAE_ORDCNCTOSTR%' order by createts desc;


select * from yfs_inventory_
select INVENTORY_ITEM_KEY from yfs_inventory_Supply where modifyts > '2024-11-20 08:00:00.0' and modifyuserid='IBDUSReceiveStoreInvUpdateIntegServer';

select * from yfs_item where Organization_code='TITAN_US' and modifyts>'20241119' and modifyuserid='IBDReceiveUSPriceFeedIntegServer' order by modifyts desc;

select * from TITAN_DADI_INV_AVL_STAGING where item_id in (
select Item_id from yfs_item where length(trim(Item_id)) > '20' and Organization_code='TITAN_US' 
and modifyts>'20241119' and modifyuserid='IBDReceiveUSPriceFeedIntegServer' ) and AVAILABLE_QTY >'0' order by modifyts desc;

select ITEM_ID,NODE,AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where AVAILABLE_QTY >'0' and 
Item_id in (select Item_id from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_US' and unit_weight!='0');

select * from yfs_item where Organization_code='TITAN_US' and modifyts>'20241126' and modifyuserid='IBDUSReceiveLotMasterIntegServer';

select * from yfs_item where Organization_code='TITAN_US' and modifyts>'20241126' and CREATEuserID='IBDUSReceiveLotMasterIntegServer';

select ORGANIZATION_KEY from yfs_organization where PARENT_ORGANIZATION_CODE='TITAN_GCC';

select * from YFS_PERSON_INFO where person_info_key='2024112708524441838036';

select * from yfs_server order by modifyts desc;

select * from yfs_export where export_key>'20241220' and flow_name = 'Test_DB01' order by createts desc;

select * from yfs_export where export_key>'20250115' and flow_name='TransguardStatusUpdates'  order by createts desc;

select * from yfs_export where export_key>'20250115' and flow_name='TransguardStatusUpdates'  
and message like '%100007248%' order by createts desc;


select * from yfs_notes;

select * from yfs_order_header where ORDER_HEADER_KEY>'20250501' order by createts desc;
select * from yfs_order_header where ORDER_NO='US00114457' order by createts desc;

select * from yfs_order_header where ORDER_HEADER_KEY in (
select ORDER_HEADER_KEY from yfs_order_line where item_id='ULO2AK2BK1DAP42BA000001');

select * from yfs_export where export_key>'20250205' and flow_name = 'EncircleDB1' order by createts desc;

select * from yfs_export where export_key>'20250520' and flow_name = 'InvoiceCreation_DB' order by createts desc;

select * from yfs_export where export_key>'20250101' and flow_name = 'InvoiceCreationToPOS' order by createts desc;

select * from yfs_export where export_key>'20251001' and message like '%00112956%' order by createts desc;

select * from yfs_export order by createts desc;

select * from yfs_export where export_key > '20250720' and system_name='OnCancel'  order by createts desc;

select * from yfs_export where export_key > '20250404' and system_name='returnRefund'  order by createts desc;
select * from yfs_export where export_key > '20250801' and system_name='ConfirmShipment'  order by createts desc;
select * from yfs_export where export_key > '20250701' and system_name='ReturnCreate'  order by createts desc;

select * from yfs_export where export_key > '20250725' and flow_name = 'ReturnCreateDB' order by createts desc;
select * from yfs_export where export_key > '20250701' and flow_name = 'ReturnShipment_DB' order by createts desc;
select * from yfs_export where export_key > '20250701' and flow_name = 'ShipConfirmEmailDB' order by createts desc;

select * from yfs_export where export_key > '20250404' and system_name='returnRefund' 
and message like '%US00113839%' order by createts desc;


select * from yfs_export where export_key > '20250201' and system_name='OnCancel' and message like '%PaymentType="Encircle"%' order by createts desc;
select * from yfs_export where export_key > '20250320' and system_name='returnRefund' and message like '%PaymentType="Encircle"%' order by createts desc;

select * from yfs_export where export_key > '20240701' and system_name='OnCancel' and message like '%C13%' order by createts desc;

select * from yfs_export where export_key > '20250304' and system_name='OnCancel' 
and message like '%00113570%' order by createts desc;


select * from yfs_export where export_key > '20250206'
and message like '%Y100012577%' order by createts desc;

select * from yfs_export where export_key > '20250205' and flow_name = 'CancelOrder_DB01' order by createts desc;

select * from yfs_export where export_key > '20250205' and  flow_name like '%ReturnShipment_DB%' order by createts desc;
//and message like '%Y100012573%' order by createts desc;

select * from yfs_export where export_key > '20250201' and system_name='ReturnShipment' order by createts desc;


select * from yfs_export where export_key > '20250205' and  flow_name like '%IBD_ReturnShipmentXMLDB%' order by createts desc;

select * from yfs_order_line where order_header_key in (
select order_header_key from yfs_order_header where order_header_key>'20250101' and ENTERPRISE_KEY='TITAN_GCC' 
and DOCUMENT_TYPE='0003') order by createts desc;


select * from yfs_order_line where order_header_key in (
select order_header_key from yfs_order_header where order_header_key>'20250101' and ENTERPRISE_KEY='TITAN_US' 
and DOCUMENT_TYPE='0003') order by createts desc;

select order_header_key from yfs_order_header where order_header_key>'20250201' and ENTERPRISE_KEY='TITAN_GCC' 
and DOCUMENT_TYPE='0001';

select * from yfs_order_line where PRIME_LINE_NO='2' and 
SHIPNODE_KEY in ('XAH', 'XDM', 'XDF', 'XDB', 'XDS', 'XDK', 'XDT', 'XSL', 'XDJ', 'XAW', 'XDG','XSR')
and order_header_key in (
select order_header_key from yfs_order_header where  ENTERPRISE_KEY='TITAN_GCC' 
and DOCUMENT_TYPE='0003') order by modifyts desc;





select * from yfs_order_header where order_header_key >'20250315' order by createts desc;

select * from yfs_export where export_key > '20250523' and  flow_name like '%IBD_CreateOrderMsgDB%' order by createts desc;

select * from yfs_export where export_key > '20250227' and message like ;

select * from  yfs_import where import_key>'20250311' and Flow_name='SFCC_CO_XML_DB' order by createts desc;

select * from  yfs_import where import_key>'20250404' and Flow_name='SFCC_CO_XML_DB' and message like '%US00114508%'  order by createts asc;


select * from yfs_inventory_Supply where  shipnode_key='XSR';

select * from TITAN_DADI_INV_AVL_STAGING where NODE='XSR'  order by modifyts asc;

select * from yfs_export where export_key > '20250701' and  flow_name like '%OrderDetDB%'  order by createts desc;

select * from yfs_export where export_key > '20250701' and  flow_name like '%OrderDetDB%' and message like '%US00115261%' order by createts desc;

select * from  yfs_export where EXPORT_KEY > '20250310' and message like '%00005040%' order by createts desc;

select MESSAGE,CREATETS from yfs_export where export_key > '20250401' and  flow_name like '%IBD_OrderDetailOmniPossStoreDB%' 
and message like '%XAH%' order by createts desc;

select MESSAGE,CREATETS from yfs_export where export_key > '20240101' and  flow_name like '%IBD_OrderDetailOmniPossStoreDB%' 
and message like '%00006276%' order by createts desc;

select MESSAGE,CREATETS from yfs_export where export_key > '20250501' and  flow_name like '%IBD_OrderDetailOmniPossStoreDB%' 
order by createts desc;


select * from  yfs_import where import_key>'20250527' and Flow_name='SFCC_CO_XML_DB' and message like '%00005672%'  order by createts asc;
select * from  yfs_export where export_key>'20250501' and Flow_name='Sol_WCSBeforeCreateOrder' and message like '%00005594%'  order by createts asc;

select * from yfs_order_line where EXTN_SALES_TAX>'0' and order_header_key in 
(select order_header_key from yfs_order_header where enterprise_key='TITAN_GCC' and document_type='0001') order by modifyts desc;

select * from yfs_order_header where enterprise_key='TITAN_GCC' and document_type='0001' and order_header_key in
(select ORDER_HEADER_KEY from yfs_order_line where EXTN_SALES_TAX>'0') order by createts desc;

select * from yfs_order_header where enterprise_key='TITAN_GCC' and document_type='0001' and order_header_key in
('2025050805330253301206','2025050707355753279364') order by createts desc;

select * from yfs_export where export_key > '20250310'  
and message like '%Y100012645%' order by createts desc;


select MESSAGE,CREATETS from yfs_export where export_key > '20250610' and  flow_name like '%IBD_OrderDetailOmniPossStoreDB%' 
 order by createts desc;

select * from yfs_export where  export_key > '20250323' and Flow_Name='IBD_PostInvlMsgForERRefund_InputDB'
and message like '%Y100012707%' order by CREATETS desc;

select * from yfs_export where  export_key between '20250203' and '20250210' and Flow_Name='IBD_PostInvlMsgForERRefund_InputDB'
and message like '%Y100012570%' order by CREATETS desc;

select * from yfs_export where  export_key > '20250701'and Flow_Name='Test_beforeReturnCreate'
and message like '%Y100012846%' order by CREATETS desc;

select * from yfs_export where  export_key > '20250701'and Flow_Name='Test_beforeReturnCreate' order by CREATETS desc;

select * from yfs_export where  export_key > '20250429'and Flow_Name='ShippedNPSSurveyEmailDB' order by CREATETS desc;


select  REFERENCE_TYPE,count(*) from YFS_INBOX_REFERENCES where INBOX_REFERENCE_KEY > '20250301' group by REFERENCE_TYPE ;

select * from YFS_INBOX_REFERENCES where name like '%TCI CC Refund Failed%' order by createts desc;

select * from yfs_order_line order by createts desc;

select * from yfs_order_header where order_header_key in (
select order_header_key from yfs_order_line where ITEM_ID like 'EP3314%') order by createts desc;

SELECT  yi.Organization_code,yi.ITEM_ID,yi.EXTN_ITEM_CODE,yi.EXTN_LOT_NO,yi.POSTING_CLASSIFICATION,yi.EXTN_PRODUCT_CODE
FROM aws_ster_sch.YFS_ITEM yi WHERE yi.item_id in
('UL2617BBQHAA042BD000001');


select Item_id,unit_weight,organization_code,createts,CREATEUSERID,modifyts,MODIFYUSERID from yfs_item where unit_weight='0' 
and length(trim(Item_id)) > '20' and organization_code='TITAN_GCC' and item_id in (
select item_id from TITAN_DADI_INV_AVL_STAGING where AVAILABLE_QTY>'10')order by createts desc;


//EL1720VEJE1A002JA000006

//update yfs_item set UNIT_WEIGHT='3.12' where ITEM_ID='EL1720VEJE1A002JA000006' and ORGANIZATION_CODE='TITAN_GCC'

select order_no,CUSTOMER_EMAILID_LC,enterprise_key from yfs_order_header where order_header_key between '20231201' and '20240201' and createuserid='SCWC_SDF_createOrder' order by createts asc;


select * from yfs_export where export_key>'20241220' and flow_name = 'Test_DB01'  order by createts desc;

select * from yfs_export where export_key>'20250519' and flow_name = 'NPSSurveyGetDB'  order by createts desc;
select * from yfs_export where export_key>'20250821' and flow_name = 'NPSSurveyExecuteDB'  order by createts desc;

select * from yfs_export where export_key>'20250515' and flow_name = 'KountCancelDB'  order by createts desc;

select ITEM_ID, NODE, AVAILABLE_QTY from TITAN_DADI_INV_AVL_STAGING where Item_id in 
(select Item_id from yfs_item where length(trim(Item_id)) > '20' 
and organization_code='TITAN_GCC')  and 
NODE in ('XAH', 'XDM', 'XDF', 'XDB', 'XDS', 'XDK', 'XDT', 'XSL', 'XDJ', 'XAW', 'XDG','XSR') order by ITEM_ID,AVAILABLE_QTY asc;

yi.ITEM_ID,yi.Organization_code,yi.EXTN_ITEM_CODE,yi.EXTN_LOT_NO,yi.POSTING_CLASSIFICATION,yi.EXTN_PRODUCT_CODE;

select * from yfs_item;

select yi.Item_id, yi.UOM,  dadi.NODE, dadi.AVAILABLE_QTY, 
yi.DEFAULT_PRODUCT_CLASS,yi.EXTN_ITEM_CODE,yi.EXTN_LOT_NO,yi.POSTING_CLASSIFICATION,yi.EXTN_PRODUCT_CODE
from yfs_item yi, TITAN_DADI_INV_AVL_STAGING dadi
where length(trim(yi.Item_id)) > '20' and
yi.organization_code='TITAN_GCC' and
dadi.NODE in ('XAH', 'XDM', 'XDF', 'XDB', 'XDS', 'XDK', 'XDT', 'XSL', 'XDJ', 'XAW', 'XDG','XSR') and
yi.Item_id=dadi.Item_id 
order by yi.ITEM_ID,dadi.AVAILABLE_QTY asc;

select * from yfs_item where organization_code='TITAN_GCC';
select * from TITAN_DADI_INV_AVL_STAGING where item_id in ('EZ0102ZBARAS002BL005528');

select yi.Item_id, dadi.NODE, 
COALESCE(dadi.AVAILABLE_QTY, 0) AS AVAILABLE_QTY ,
CASE WHEN dadi.AVAILABLE_QTY > 0 THEN 'AVL' ELSE 'UAVL' END AS availability_status,
NOW() AS AVAILABLE_time
from yfs_item yi
LEFT JOIN TITAN_DADI_INV_AVL_STAGING dadi ON TRIM(yi.Item_id) = TRIM(dadi.Item_id)
where yi.organization_code='TITAN_GCC'  and
dadi.NODE in ('XAH', 'XDM', 'XDF', 'XDB', 'XDS', 'XDK', 'XDT', 'XSL', 'XDJ', 'XDG','XSR') order by yi.ITEM_ID,dadi.AVAILABLE_QTY asc;

//Final query for full sync
select yi.Item_id, '' AS empty_column1, dadi.NODE, 
CASE WHEN dadi.AVAILABLE_QTY > 0 THEN 'AVL' ELSE 'UAVL' END AS availability_status,
COALESCE(dadi.AVAILABLE_QTY, 0) AS AVAILABLE_QTY , '' AS empty_column2,
'' AS empty_column3, '' AS empty_column4, 
NOW() AS AVAILABLE_time
from yfs_item yi
LEFT JOIN TITAN_DADI_INV_AVL_STAGING dadi ON TRIM(yi.Item_id) = TRIM(dadi.Item_id)
where yi.organization_code='TITAN_GCC' order by yi.ITEM_ID,dadi.AVAILABLE_QTY asc;


SELECT YFS_INVENTORY.ITEM_ID, YFS_SHIP_NODE.NODE_ID, YFS_SHIP_NODE_INVENTORY.QUANTITY
FROM YFS_INVENTORY_SUPPLY
JOIN YFS_SHIP_NODE_INVENTORY ON YFS_INVENTORY.INVENTORY_ID = YFS_SHIP_NODE_INVENTORY.INVENTORY_ID
JOIN YFS_SHIP_NODE ON YFS_SHIP_NODE_INVENTORY.NODE_ID = YFS_SHIP_NODE.NODE_ID
WHERE YFS_INVENTORY.ITEM_ID;

select * from yfs_order_line where personalize_code !='';

select * from yfs_order_header where order_no in('00005968','00005969','00005970','00006070');

select * from yfs_order_header where order_no in('00005670');


select Order_header_key,count(Order_header_key) from yfs_charge_transaction where MODIFYTS > '2025-05-28 00:00:00.0'
group by Order_header_key order by count(Order_header_key);

select * from yfs_charge_transaction where ORDER_HEADER_KEY='2023122012021421520024' order by createts desc;

select * from yfs_export where export_key>'20250527' and flow_name = 'CarrierSelection_DB'  order by createts desc;


select * from yfs_order_header ;

select * from yfs_order_header where enterprise_key='TITAN_GCC' and order_header_key in (
select order_header_key from yfs_order_release_status where status='3350.300' and STATUS_DATE > '20250501' ) 
order by createts desc;
 
 
select * from yfs_order_release_status where status='3950' and STATUS_DATE between '20250526' and '20250528' order by createts desc ;

select * from yfs_order_header where order_header_key in (
select ORDER_HEADER_KEY from yfs_order_line where ITEM_ID in (
select Item_id from yfs_item where unit_weight='0' 
and length(trim(Item_id)) > '20' and organization_code='TITAN_GCC' and item_id in (
select item_id from TITAN_DADI_INV_AVL_STAGING where AVAILABLE_QTY>'0')))order by createts desc;


select * from yfs_export where export_key>'20250501' and flow_name = 'ACKDB1'  order by createts desc;

select * from yfs_item where ITEM_ID like 'EZ0102ZEARAS00%' order by createts desc;

select * from yfs_order_line order by createts desc;


select * from yfs_order_header where enterprise_key='TITAN_GCC' and Order_header_key in (
select Order_header_key from yfs_order_release_status where status='3700.7777' and STATUS_QUANTITY>'0' and 
STATUS_DATE between '20250101' and  '20250501'
 ) order by modifyts asc;
 
 select * from yfs_order_release_status where status='3700.7777' and STATUS_DATE > '20250401' ;


select * from  yfs_export where EXPORT_KEY > '20250601' and message like '%Y100012819%'  order by createts desc;

select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%IBD_USOnShippedNPSSurveyEmail%');
select * from yfs_flow where flow_key in (select flow_key from yfs_sub_flow where config_xml like '%IBD_GetShipmentList%');

select * from YFS_AGENT_CRITERIA where ;

select * from yfs_export where export_key>'20250701' and flow_name = 'Test_DB02'  order by EXPORT_KEY desc;

select Order_no, Shipment_no, SHIPNODE_KEY from yfs_shipment where STATUS between '1100' and '1200.100' and ENTERPRISE_CODE='TITAN_GCC' 
and SHIPNODE_KEY ='XDM' order by createts desc ;


select * from yfs_shipment where STATUS between '1100' and '1200.100' and ENTERPRISE_CODE='TITAN_GCC' 
and SHIPNODE_KEY ='XDM' order by createts desc ;


select SCAC,order_no,shipment_no,shipment_key,SHIPNODE_KEY,AIRWAY_BILL_NO,createts from yfs_shipment where order_no in('Y100012865');

select * from yfs_shipment line order by createts desc;

select ysh.Order_no, ysh.Shipment_no, ysh.SHIPNODE_KEY
from yfs_shipment ysh, yfs_shipment_line ysl
where STATUS between '1100' and '1200.100' and ENTERPRISE_CODE='TITAN_GCC' 
and SHIPNODE_KEY ='XDM' order by createts desc ;

select * from yfs_Order_header where Order_no='00113421';

select * from yfs_Order_header where EXTN_NPS_DELIVER_EMAIL = 'Y';
select * from yfs_Order_header where EXTN_NPS_SHIPPED_EMAIL = 'Y';
//update yfs_Order_header set EXTN_NPS_DELIVER_EMAIL='Y' where Order_no='US00114675';

select * from yfs_export where export_key>'20250701' and flow_name = 'IBD_CAgetOrderListDB' 
and message like '%US00115070%'order by EXPORT_KEY desc; 

select * from yfs_order_line where EXTN_PRODUCT_CATEGORY !='' order by createts desc;



yfs_item -> ItemId, 



select dadi.ITEM_ID, dadi.NODE, dadi.AVAILABLE_QTY, yi.UNIT_COST as unit_price
from yfs_item yi, TITAN_DADI_INV_AVL_STAGING dadi
where length(trim(yi.Item_id)) > '20' and
yi.organization_code='TITAN_GCC' and
dadi.AVAILABLE_QTY>'0' and 
dadi.NODE in ('XAH', 'XDM', 'XDF', 'XDB', 'XDS', 'XDK', 'XDT', 'XSL', 'XDJ', 'XAW', 'XDG');



SELECT 
    inv.ITEM_ID,    inv.AVAILABLE_QTY,    inv.NODE,    itm.UNIT_COST AS PRICE
FROM 
    TITAN_DADI_INV_AVL_STAGING inv
JOIN 
    yfs_item itm ON inv.ITEM_ID = itm.ITEM_ID
WHERE 
    length(trim(itm.Item_id)) > '20'
    AND inv.AVAILABLE_QTY>'0'
    and inv.NODE in ('XAH', 'XDM', 'XDF', 'XDB', 'XDS', 'XDK', 'XDT', 'XSL', 'XDJ', 'XAW', 'XDG');
	

select * from yfs_inventory_Supply where INVENTORY_ITEM_KEY in (select INVENTORY_ITEM_KEY from yfs_inventory_item where 
Item_id in ('EZ0113ZAARAS002BL000666'));




select yi.ITEM_ID,yi.Organization_code,yi.EXTN_ITEM_CODE,yi.EXTN_LOT_NO,yi.POSTING_CLASSIFICATION,yi.EXTN_PRODUCT_CODE
dadi.AVAILABLE_QTY 

from yfs_item yi, TITAN_DADI_INV_AVL_STAGING dadi, 


4 tables
yfs_item contain Item_id, EXTN_ITEM_CODE,yi.EXTN_LOT_NO,yi.POSTING_CLASSIFICATION,yi.EXTN_PRODUCT_CODE
yfs_inventory_item contain Item_id, INVENTORY_ITEM_KEY
yfs_inventory_Supply contains SHIPNODE_KEY, CREATETS, MODIFYTS
TITAN_DADI_INV_AVL_STAGING contains the ITEM_ID, NODE, AVAILABLE_QTY


write a query details of Item_id, EXTN_ITEM_CODE,yi.EXTN_LOT_NO,yi.POSTING_CLASSIFICATION,yi.EXTN_PRODUCT_CODE, SHIPNODE_KEY, CREATETS, MODIFYTS and AVAILABLE_QTY
to fetch all the items with inventory





SELECT yi.ITEM_ID,
    yi.EXTN_ITEM_CODE,
    yi.EXTN_LOT_NO,
    yi.POSTING_CLASSIFICATION,
    yi.EXTN_PRODUCT_CODE,
    ys.SHIPNODE_KEY,
    ys.CREATETS,
    ys.MODIFYTS,
    ts.AVAILABLE_QTY
FROM yfs_item yi
JOIN yfs_inventory_item yii 
    ON yi.ITEM_ID = yii.ITEM_ID
JOIN yfs_inventory_supply ys 
    ON yii.INVENTORY_ITEM_KEY = ys.SHIPNODE_KEY
JOIN TITAN_DADI_INV_AVL_STAGING ts 
    ON yi.ITEM_ID = ts.ITEM_ID 
   AND ys.SHIPNODE_KEY = ts.NODE;