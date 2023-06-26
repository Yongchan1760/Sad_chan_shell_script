#!/bin/bash


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


#=============================#
#        uptime check         #
#=============================#
echo "######## Uptime test #########"  >> report.sh 2>&1

host=$(hostname)
upt=$(uptime | awk -F "," '{print $1}' | awk -F " " '{print $2" "$3" "$4}' )

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



#=============================#
#       fstab uuid check      #
#=============================#
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



#=============================#
#        mount check          #
#=============================#
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



#=============================#
#     zombie process check    #
#=============================#
zombie=$(top -b -n 1 | grep zombie)
zombie_cnt=$(ps -ef | grep defunct | grep -v grep | wc -l)

if [ $zombie_cnt -eq 0 ] ; then
  echo "NO zombie process" >> report.sh 2>&1
else
  echo "zombie process detected" $zombie_cnt >> report.sh 2>&1
fi
echo -e \ >> report.sh 2>&1