
#!/bin/bash
#=============================#
#        uptime check         #
#=============================#
echo "######## Uptime test #########"  >> report.sh 2>&1

host=$(hostname)
upt=$(uptime | awk -F "," '{print $1}' | awk -F " " '{print $2" "$3" "$4}' )

Yongchan Kwon, [2023-06-26 오후 2:05]
if [ ! -f /home1/ncloud/report/report.sh ] ; then 
  echo "No report.sh" >> report.sh 2>&1
  echo "mkdir report.sh wating" >> report.sh 2>&1
  echo "wating................" >> report.sh 2>&1
  mkdir /home1/ncloud/report/report.sh
     if [ -x /home1/ncloud/report/report.sh ] ; then
    echo "mkdir report.sh complete" >> report.sh 2>&1
     fi
   else
  echo "report.sh already exists" >> report.sh 2>&1
    echo -e \ >> report.sh 2>&1
  echo "######## checking start #########" >> report.sh 2>&1
  echo "hostname="$host >> report.sh 2>&1
  echo "uptime="$upt >> report.sh 2>&1
   fi
echo -e \ >> report.sh 2>&1





