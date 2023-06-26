
#!/bin/bash
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