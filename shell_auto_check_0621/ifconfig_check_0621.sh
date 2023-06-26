#!/bin/bash

#=============================#
#   ifconfig up/down check    #
#=============================#
echo "########## ifconfig up|down check start ############" >> report.sh 2>&1
echo "########## ifconfig RX|TX check start   ###########" >> report.sh 2>&1
ifconfig -a >> report.sh 2>&1
echo -e \ >> report.sh 2>&1

count=0
fstab_1=$(cat /etc/fstab | grep defaults | awk -F " " '{print $2}' | grep -v /boot)
df=$(df -h | awk -F " " '{print $6}' | grep -v /dev | grep -v Mounted | grep -v /run | grep -v /sys/fs/cgroup | grep -v /boot)

echo "######### mount check start ##########" >> report.sh 2>&1
for fstab_var in $fstab_1
do
     for df_var in $df
     do
   if [ $fstab_var == $df_var ] ; then
     count=$((count+1)) 
     mount_correct=$fstab_var
   fi 
     done
   if [ $count == 1 ] ; then
     count=0
     echo "######### mount perfect ############"  $mount_correct >> report.sh 2>&1
         fi
      #echo -e "\n" >> report.sh 2>&1
done
#echo "####### mount check stop ########" >> report.sh 2>&1
echo -e \ >> report.sh 2>&1
