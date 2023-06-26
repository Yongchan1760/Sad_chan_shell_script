
#!/bin/bash
#echo "####################################################"
#echo "#                                                   "
#echo "#       File Name : firewall_check_0621.sh          "
#echo "#         Funtion : firewall inactive check         "
#echo "#       Parmeters :                                 "
#echo "#           Notes :                                 "
#echo "#    Help peoples : clouder                         "
#echo "#                                                   "
#echo "####################################################"

#=============================#
#  firewalld inactive check   #
#=============================#
echo "######### check firewalld start #########" >> report.sh 2>&1
echo "Using cloud acg, firewalld is not needed." >> report.sh 2>&1
#host=$(hostname)
firewall=$(systemctl status firewalld | grep Active | awk -F ":" '{print $2}' | awk -F " " '{print $1}' | sed 's/ //g')

if [ $firewall == "active" ] ; then
    echo "we dont need firewalld" >> report.sh 2>&1
    echo "########### firewalld status #############" >> report.sh 2>&1
    systemctl stop firewalld >> report.sh 2>&1
  if [ $firewall == "active" ] ; then
      echo "systemc check need"
  fi
else   
    echo "system firewalld inative - proper situation" >> report.sh 2>&1
    echo "systemctl firewalld status ?"$firewall  >> report.sh 2>&1
fi
echo -e \ >> report.sh 2>&1



