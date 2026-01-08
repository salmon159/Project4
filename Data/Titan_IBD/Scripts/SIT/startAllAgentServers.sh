#Agent servers
export JAVA_HOME=/opt/Sterling10AWS/jdk
 
sh /opt/Sterling10AWS/bin/titanagentserver.sh RTAMAgent1 "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanagentserver.sh ScheduleOrderAgentServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanagentserver.sh ReleaseOrderAgentServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanagentserver.sh IBDCarrierSelectionAgentServer "-Xms1024m -Xmx1024m" &
sleep5
sh /opt/Sterling10AWS/bin/titanagentserver.sh IBD_PurgeInvReservationAgentServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanagentserver.sh  IBD_PaymentCollectionAgentServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanagentserver.sh  IBD_PaymentExecutionAgentServer  "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanagentserver.sh  IBDCarrierSelectionROAgentServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanagentserver.sh  ScheduleReturnAgentServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanagentserver.sh IBD_ResolveNgeniusCancelHoldAgentServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanagentserver.sh PurgeReprocessAgentServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanagentserver.sh PurgeInvAuditAgentServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanagentserver.sh PurgeStatisticAgentServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanagentserver.sh PurgeExportAgentServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanagentserver.sh PurgeImportAgentServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanagentserver.sh IBD_RefundProcessEmailAgentServer  "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanagentserver.sh IBDUPSStatusUpdateAgentServer "-Xms1024m -Xmx1024m" &
sleep 5
sh /opt/Sterling10AWS/bin/titanagentserver.sh IBDNPSDeliverySurveyEmailAgentServer "-Xms1024m -Xmx1024m" &
sleep 5