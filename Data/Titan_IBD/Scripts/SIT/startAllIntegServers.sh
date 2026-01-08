#Integration servers
export JAVA_HOME=/opt/Sterling10AWS/jdk
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh UpdateDADIAvlStagingIntegServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBD_PushInventoryIntegServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBDReceiveStoreInvUpdateIntegServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBDReceiveJewFeedIntegServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBDReceiveLotMasterIntegServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBDReceivePriceFeedIntegServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBDRetrieveAWBandShipmentIntegServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh  SCWC_SDF_createOrder  "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBD_TransguardShipmentStatusUpdateServer  "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh  SCWC_SDF_pushOrderMessages  "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh  IBDRetrieveOrderOmniPossIntegServer  "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBD_CreateOrderMsgIntegServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBD_CancelOrderMsgIntegServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBDReceiveStoreUpdatesOMNIIntegServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBDOrderShippedMailIntegServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBDOrderDeliveredMailIntegServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh UpdateZeroInvDADIAvlStagingIntegServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh CreateReturnOrderInvcIntegServer  "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh PublishReturnShipmentIntegServer  "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBDEncircleIntegServer  "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBDReceiveUSJewFeedIntegServer  "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBDReceiveUSPriceFeedIntegServer  "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBDUSReceiveLotMasterIntegServer  "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBDUSReceiveStoreInvUpdateIntegServer  "-Xms1024m -Xmx1024m" &
sleep 5
#sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBDEncircleReturnRefundIntegServer  "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBDReceiveStoreUpdatesERPIntegServer  "-Xms1024m -Xmx1024m" &
sleep 5
#sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh FetchEncircleDetailsIntegServer  "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh TrackingNoIntegServer  "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh SFCC_DeltaInventoryIntegServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh SFCCCreateOrderMsgIntegServer  "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh SFCC_OrderAckIntegServer  "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh RetrieveLITRTOIntegServer   "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBD_ProcessJPMCReversalIntegServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBD_ProcessJPMCRefundIntegServer "-Xms1024m -Xmx1024m" &
sleep 5

sh /opt/Sterling10AWS/bin/titanstartIntegrationServer.sh IBD_ProcessJPMCIntegServer "-Xms1024m -Xmx1024m" &
sleep 5