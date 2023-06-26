
#!/bin/bash
#echo "###########################################################"
#echo "#                                               		      "
#echo "#       File Name : mount_check_0621.sh                    "
#echo "#         Funtion : /etc/fstab compare df -h, mount check  "
#echo "#       Parmeters :                                        "
#echo "#           Notes :                                        "
#echo "#    Help peoples : clouder                                "
#echo "#                                                          "
#echo "###########################################################"

count=0
fstab=$(cat /etc/fstab | grep defaults | awk -F " " '{print $2}' | grep -v /boot)
df=$(df -h | awk -F " " '{print $6}' | grep -v /dev | grep -v Mounted | grep -v /run | grep -v /sys/fs/cgroup | grep -v /boot)

echo "####### mount check start ########" >> report.sh 2>&1
for fstab_var in $fstab
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
	   echo "mount perfect"$mount_correct >> report.sh 2>&1
         fi
      echo -e "\n" >> report.sh 2>&1
done
echo "####### mount check stop ########" >> report.sh 2>&1
echo -e \ >> report.sh 2>&1
echo -e \ >> report.sh 2>&1





