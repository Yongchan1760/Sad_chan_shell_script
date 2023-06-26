
#!/bin/bash
#=============================#
#     listenig port check     #
#=============================#
port=$(netstat -anlp | grep LISTEN | egrep -i "tcp" | awk -F ":" '{print $2}' | sed 's/0.0.0.0//g')
echo "##########################" >> report.sh 2>&1
echo "current listening port ?" >> report.sh 2>&1
echo -e \ >> report.sh 2>&1
echo -n $port >> report.sh 2>&1
echo "##########################" >> report.sh 2>&1
echo -e \ >> report.sh 2>&1
echo -e \ >> report.sh 2>&1
