#!/usr/bin/env bash
# Script to perform the following:
# - Checking status of the applciations
# - Print PID of running applciations
# - Exit if applciations are still running after 60sec(12 times * 5 Sec)
n=1
while [ $n -le 12 ]
do
#APPLICATIONDIR="$( cd "$( dirname "$0" )" && pwd)"
#APPLICATIONDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sleep 5
        echo "Checking status"
        ps -ef | grep -v grep | grep "$APPLICATIONDIR" --color
if [ $? = 0 ]
    then
        echo "-----------------------------------------------------------------------------"
        echo "Application still running"
    else
        echo "-----------------------------------------------------------------------------"
        echo "Application stopped"
        echo "End"
    exit
fi
n=$[$n+1]
if [ $? = 0 ]
    then
       echo "Printing PID"
       ps -ef | grep -v grep | grep "$APPLICATIONDIR" --color | awk '{print $2}'
    else
       echo "-----------------------------------------------------------------------------"
fi
if [ $n = 12 ]
   then
       echo "-----------------------------------------------------------------------------"
       echo "error encountered"
    exit 87
fi
done