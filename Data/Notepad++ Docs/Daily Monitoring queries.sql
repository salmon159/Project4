//Orders list which are on hold:
select ORDER_HEADER_KEY,ENTERPRISE_KEY,ORDER_NO,Hold_flag,createts,modifyts from yfs_order_header where HOLD_FLAG='Y'  order by modifyts desc;


//Order Holds - 
select * from YFS_ORDER_HOLD_TYPE where status ='1100' and ORDER_HEADER_KEY in 
(select ORDER_HEADER_KEY from yfs_order_header where HOLD_FLAG='Y' and modifyts > '2025-02-14' ) 
and modifyts > '2025-02-14' order by modifyts desc;


//Order Hold Count:
select count(*) from yfs_order_header where HOLD_FLAG='Y';
//240


// Orders Stuck in OMS proccessing
select * from yfs_order_header where order_header_key in (
select DATA_KEY from yfs_task_q where task_q_key>'20250214' and data_type='OrderHeaderKey' 
and ( TRANSACTION_KEY like 'RELEASE%' or TRANSACTION_KEY like '%SCHEDULE%'));


//Exception list query
select  FLOW_NAME,count(*) from yfs_reprocess_error where ERRORTXNID > '20250211' group by FLOW_NAME ;

//Ignore these if any exception apart from these - you can ping 
IBD_FetchEncircleDetails_Async
IBD_ReceiveJewelleryPriceFeed_Async
IBD_ReceiveLotMasterFeed_Async
IBD_USReceiveLotMasterFeed_Async
IBD_USReceiveJewelleryPriceFeed_Async
IBD_USUpdateInventory_Async
IBD_UpdateInventory_Async

select * from yfs_reprocess_error where ERRORTXNID > '20250110' and FLOW_NAME like '%IBD_AWBNoAndShipment_Async%'  order by createts desc;




//Jpmc
select EXPORT_KEY,message,createts from  yfs_export where Flow_name='IBD_JPMorganResponse' and EXPORT_KEY > '20250214' order by createts desc;


Sample Errors:
<Error ErrorCode="404"
    ErrorDescription="Error 404: java.io.FileNotFoundException: SRVE0190E: File not found: /jpMorganApi/outbound/gwapi/v4/gateway/capture " OrderNo="00002874"/>


<Errors>
<Error ErrorCode="00010" ErrorDescription="java.net.SocketTimeoutException: Read timed out"/>
</Errors>





Hi Team,

no new orders on hold in OMS.

No orders stuck in OMS.

no new exceptions in OMS.



