#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: $0 <path to commandline log>"
	exit 1
fi

logfile=$1

lookup=`grep "#lookup" $logfile | awk -F']' '{print $2}' | awk '{print $3}'`
insert=`grep "#insert" $logfile | awk -F']' '{print $2}' | awk '{print $3}'`
delete=`grep "#delete" $logfile | awk -F']' '{print $2}' | awk '{print $3}'`

echo $(($lookup + $insert + $delete))
