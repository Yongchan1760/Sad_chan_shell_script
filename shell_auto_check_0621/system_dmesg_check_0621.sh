
#!/bin/bash
#echo "###########################################################"
#echo "#                                                   		 "
#echo "#       File Name : system_dmesg_check_0621.sh             "
#echo "#         Funtion : dmesg check 			                 "
#echo "#       Parmeters :                                        "
#echo "#           Notes :                                        "
#echo "#           emerg - system is unusable                     "
#echo "#           alert - action must be taken immediately       "
#echo "#            crit - critical conditions                    "
#echo "#             err - error conditions                       "
#echo "#            warn - warning conditions                     "
#echo "#          notice - normal but significant condition       "
#echo "#            info - informational                          "
#echo "#           debug - debug-level messages                   "
#echo "#                                                          "
#echo "#                                                          "
#echo "#    Help peoples : clouder                                "
#echo "#                                                          "
#echo "###########################################################"

#=============================#
#       dmesg erro check      #
#=============================#
dmesg_im=$(dmesg -l emerg,alert,crit)
dmesg_unim=$(dmesg -l  err)

echo "#### system kernel log check start ####" >> report.sh 2>&1

if [ -z "$dmesg_im" ] ; then
   echo "system kernel No Problem No emerg,alert,crit" >> report.sh 2>&1
else
   echo "system kernel error you must check system" >> report.sh 2>&1
fi

if [ -z "$dmesg_unim" ] ; then
   echo "system kernel No Problem No error" >> report.sh 2>&1
else
   echo "system kernerl error you must check system" >> report.sh 2>&1
fi
#echo "#### system kernel log check stop ####" >> report.sh 2>&1

echo -e \ >> report.sh 2>&1
echo -e \ >> report.sh 2>&1
