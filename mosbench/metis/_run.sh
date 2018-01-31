#!/bin/bash

source __common.sh

if [ $# -ne 1 ]
then
	echo "Usage: $0 <number of threads>"
	exit 1
fi

NR_THREADS=$1

$LBX/workloads/mosbench/metis/run.sh $NR_THREADS
