#!/bin/bash

#=============================#
#   ifconfig up/down check    #
#=============================#
echo "########## ifconfig up|down check start ############" >> report.sh 2>&1
echo "########## ifconfig RX|TX check start   ###########" >> report.sh 2>&1
ifconfig -a >> report.sh 2>&1
echo -e \ >> report.sh 2>&1

