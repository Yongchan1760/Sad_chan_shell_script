
#!/bin/bash
#echo "###########################################################"
#echo "#                                                          "
#echo "#       File Name : uuid_check_0621.sh.sh                  "
#echo "#         Funtion : fstab uuid, blkid uuid check           "
#echo "#       Parmeters :                                        "
#echo "#           Notes : only xfs check, not lvm                "
#echo "#    Help peoples : clouder                                "
#echo "#                                                          "
#echo "###########################################################"

echo "########## Start Fsatb UUID Check ############" >> report.sh 2>&1
blkid_var=$(blkid | grep -v LVM2_member | awk '{print $2}'|sed 's/"//g')
fstab_var=$(cat /etc/fstab | awk '{print $1}' | grep UUID)
blkid_cnt=$(blkid | grep -v LVM2_member | awk '{print $2}'|sed 's/"//g' | wc -l)
fstab_cnt=$(cat /etc/fstab | awk '{print $1}' | grep UUID | wc -l)
count=0

for blkid in $blkid_var
do
     for fstab2 in $fstab_var
     do
         if [ $blkid == $fstab2 ] ; then
           count=$((count+1))
           mount_correct=$fstab2
         fi
     done
         if [ $count == 1 ] ; then
           count=0
           echo "mount perfect" $mount_correct >> report.sh 2>&1
         fi
      #echo -e "\n"
done

echo "blkid cnt?"$blkid_cnt >> report.sh 2>&1
echo "fstab cnt?"$fstab_cnt >> report.sh 2>&1
#echo "########## Stop Fsatb UUID Check ############" >> report.sh 2>&1
echo -e \ >> report.sh 2>&1

