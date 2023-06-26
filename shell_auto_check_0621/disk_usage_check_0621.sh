
#!/bin/bash
#support:cloder

#echo "####################################################"
#echo "#                                                   "
#echo "#       File Name : disk_usage_check_0621.sh        "
#echo "#         Funtion : disk usage check                "
#echo "#       Parmeters :                                 "
#echo "#           Notes :                                 "
#echo "#    Help peoples : clouder                         "
#echo "#                                                   "
#echo "####################################################"

#=============================#
#       disk usage check      #
#=============================#
host=$(hostname)
dsg_cl=$(df -h | awk '{ gsub("%", ""); USE=$5; PATH=$6; if( USE > 10 ) print PATH, "파티션이", USE, "% 사용중 입니다."}' | grep -v "^[A-Z]") >> report.sh 2>&1

echo -e "######### CLOUD MANAGED CHECK START ##############"\ >> report.sh 2>&1
echo "####### SERVER NAME ?" $host >> report.sh 2>&1
echo -e \ >> report.sh 2>&1
echo -e \ >> report.sh 2>&1
echo -e "######### DISK USAGE CHECK START    ##########"\ >> report.sh 2>&1
echo $host " " $dsg_cl >> report.sh 2>&1
echo -e \ >> report.sh 2>&1
