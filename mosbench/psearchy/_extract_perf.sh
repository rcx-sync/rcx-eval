#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: $0 <path to commandline log>"
	exit 1
fi

logfile=$1

nr_cores=`grep "jobs/hour/core$" $logfile | awk -F':' '{print $1}'`
perf_per_core=`grep "jobs/hour/core$" $logfile | awk '{print $8}'`
echo $nr_cores $perf_per_core | awk '{print $1 * $2}'
