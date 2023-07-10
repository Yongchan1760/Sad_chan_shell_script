#!/bin/bash
echo "###########################################################"
echo "#                                                          "
echo "#       File Name : Report_Exec2.sh                        "
echo "#         Funtion : System Check                           "
echo "#       Parmeters :                                        "
echo "#           Notes :                                        "            
echo "#    Help peoples : clouder                                "
echo "#                                                          "
echo "###########################################################"


echo -e "[*] Starting gathering process."\ > report.sh 2>&1
echo "============================================================================================================================================" >> report.sh 2>&1
echo -e \ >> report.sh 2>&1


host=$(hostname)
upt=$(uptime | awk -F "," '{print $1}' | awk -F " " '{print $2" "$3" "$4}' )
echo "[*]  Uptime Check ." >> report.sh 2>&1
echo "============================================================================================================================================" >> report.sh 2>&1
if [ ! -f /home1/ncloud/report/report.sh ] ; then 
  echo "No Report.sh"
  echo "Mkdir Report.sh Wating" >> report.sh 2>&1
  echo "Wating................" >> report.sh 2>&1
  mkdir /home1/ncloud/report/report.sh
     if [ -x /home1/ncloud/report/report.sh ] ; then
    echo "Mkdir Report.sh Complete" >> report.sh 2>&1
     fi
   else
  echo "Report.sh Already Exists"
  echo "Uptime="$upt >> report.sh 2>&1
   fi
echo -e \ >> report.sh 2>&1


host=$(hostname)
dsg_cl=$(df -h | awk '{ gsub("%", ""); USE=$5; PATH=$6; if( USE > 10 ) print PATH, "파티션이", USE, "% 사용중입니다. "}' | grep -v "^[A-Z]") >> report.sh 2>&1
echo -e "[*] Disk Usage Check."\ >> report.sh 2>&1
echo "============================================================================================================================================" >> report.sh 2>&1
echo $host " " $dsg_cl >> report.sh 2>&1
echo -e \ >> report.sh 2>&1


firewall=$(systemctl status firewalld | grep Active | awk -F ":" '{print $2}' | awk -F " " '{print $1}' | sed 's/ //g')
echo "[*] Firewalld Inactive Check. - Using Cloud Acg, Firewalld Is Not Needed." >> report.sh 2>&1
echo "============================================================================================================================================" >> report.sh 2>&1
if [ $firewall == "active" ] ; then
    echo "We Dont Need Firewalld" >> report.sh 2>&1
    echo "=========== firewalld status ============" >> report.sh 2>&1
    systemctl stop firewalld >> report.sh 2>&1
  if [ $firewall == "active" ] ; then
      echo "Systemc Check Need"
  fi
else   
    echo "System Firewalld Inative - Proper Situation" >> report.sh 2>&1
    echo "Systemctl Firewalld Status ?" $firewall  >> report.sh 2>&1
fi
echo -e \ >> report.sh 2>&1


echo "[*] Ifconfig Up/Down Check." >> report.sh 2>&1
echo "============================================================================================================================================" >> report.sh 2>&1
ifconfig -a >> report.sh 2>&1
echo -e \ >> report.sh 2>&1


sestatu=$(sestatus | awk -F ":" '{print $2}' | sed 's/ //g')
echo "[*] Sestatus Disable Check." >> report.sh 2>&1
echo "============================================================================================================================================" >> report.sh 2>&1
if [ $sestatu == "disabled" ] ; then
   echo "Sesatus? Disable Status" >> report.sh 2>&1
else
   echo "SELinux Stop Need Check Your System" >> report.sh 2>&1
fi
echo -e \ >> report.sh 2>&1


dmesg_im=$(dmesg -l emerg,alert,crit)
dmesg_unim=$(dmesg -l  err)
echo "[*] Dmesg Erro Check. - System Kernel Log Check Start" >> report.sh 2>&1
echo "============================================================================================================================================" >> report.sh 2>&1
if [ -z "$dmesg_im" ] ; then
   echo "System Kernel No Problem No Emerg,Alert,Crit" >> report.sh 2>&1
else
   echo "System Kernel Error You Must Check System" >> report.sh 2>&1
fi

if [ -z "$dmesg_unim" ] ; then
   echo "System Kernel No Problem No error" >> report.sh 2>&1
else
   echo "System Kernerl Error You Must Check System" >> report.sh 2>&1
fi
echo -e \ >> report.sh 2>&1


blkid_var=$(blkid | grep -v LVM2_member | awk '{print $2}'|sed 's/"//g')
fstab_var=$(cat /etc/fstab | awk '{print $1}' | grep UUID)
blkid_cnt=$(blkid | grep -v LVM2_member | awk '{print $2}'|sed 's/"//g' | wc -l)
fstab_cnt=$(cat /etc/fstab | awk '{print $1}' | grep UUID | wc -l)
echo "[*] Fstab uuid Check." >> report.sh 2>&1
echo "============================================================================================================================================" >> report.sh 2>&1
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
done
echo "blkid cnt?"$blkid_cnt >> report.sh 2>&1
echo "fstab cnt?"$fstab_cnt >> report.sh 2>&1
echo -e \ >> report.sh 2>&1


count=0
fstab=$(cat /etc/fstab | grep defaults | awk -F " " '{print $2}' | grep -v /boot)
df=$(df -h | awk -F " " '{print $6}' | grep -v /dev | grep -v Mounted | grep -v /run | grep -v /sys/fs/cgroup | grep -v /boot)
echo "[*] Mount Check." >> report.sh 2>&1
echo "============================================================================================================================================" >> report.sh 2>&1

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
done
echo -e \ >> report.sh 2>&1


port=$(netstat -anlp | grep LISTEN | egrep -i "tcp" | awk -F ":" '{print $2}' | sed 's/0.0.0.0//g')
echo "[*] Listenig Port Check." >> report.sh 2>&1
echo "============================================================================================================================================" >> report.sh 2>&1
echo -n $port >> report.sh 2>&1
echo -e "\n" >> report.sh 2>&1

zombie=$(top -b -n 1 | grep zombie)
zombie_cnt=$(ps -ef | grep defunct | grep -v grep | wc -l)
echo "[*] Zombie Process Check."  >> report.sh 2>&1
echo "============================================================================================================================================" >> report.sh 2>&1
if [ $zombie_cnt -eq 0 ] ; then
  echo "NO Zombie Process" >> report.sh 2>&1
else
  echo "Zombie Process Detected" $zombie_cnt >> report.sh 2>&1
fi
echo -e \ >> report.sh 2>&1