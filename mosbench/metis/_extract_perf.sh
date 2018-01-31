#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: $0 <path to commandline log>"
	exit 1
fi

logfile=$1

# Jobs per one hour (3600,000 milliseconds)
grep -A1 "^Runtime in milliseconds " $logfile | grep Real | \
	awk '{print 3600000 / $12}'
