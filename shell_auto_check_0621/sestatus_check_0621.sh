
#!/bin/bash
#echo "###########################################################"
#echo "#                                                          "
#echo "#       File Name : sestatus_check_0621.sh                 "
#echo "#         Funtion : sestatus inactive check                "
#echo "#       Parmeters :                                        "
#echo "#           Notes : inactive - good, active - bad          "            
#echo "#    Help peoples : clouder                                "
#echo "#                                                          "
#echo "###########################################################"


#=============================#
#   sestatus disable check    #
#=============================#
sestatu=$(sestatus | awk -F ":" '{print $2}' | sed 's/ //g')
echo "########## sestatus check start #############" >> report.sh 2>&1
if [ $sestatu == "disabled" ] ; then
   echo "sesatus? disable status" >> report.sh 2>&1
else
   echo "SELinux STOP need check your systemc #####" >> report.sh 2>&1
fi
echo -e \ >> report.sh 2>&1
echo -e \ >> report.sh 2>&1