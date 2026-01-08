#kill -9 $(ps -ef | grep java | grep invokeargs | awk '{print $2}');
#kill -9 $(ps -ef | grep java | grep HealthMonitor | awk '{print $2}');

echo "Check current processes before kill"
ps -ef | grep java | grep invokeargs | awk '{print $2}' | wc -l
ps -ef | grep java | grep HealthMonitor | awk '{print $2}' | wc -l

ps -ef | grep java | grep invokeargs | awk '{print $2}' > /tmp/123.txt; for p in $(cat /tmp/123.txt); do kill -9 $p; done
sleep 10
ps -ef | grep java | grep HealthMonitor | awk '{print $2}' > /tmp/456.txt; for q in $(cat /tmp/456.txt); do kill -9 $q; done
sleep 10

echo "Check current processes after kill"
ps -ef | grep java | grep invokeargs | awk '{print $2}' | wc -l
ps -ef | grep java | grep HealthMonitor | awk '{print $2}' | wc -l
