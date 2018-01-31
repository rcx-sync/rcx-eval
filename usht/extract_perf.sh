#!/bin/bash

if [ $# -ne 3 ]
then
	echo "Usage: $0 <rcu|rlu> <write ratio> <uniq id>"
	exit 1
fi

impl=$1
wrate=$2
uniqid=$3

odir="results/$impl/$wrate/"

nr_thrs=`ls $odir | grep "[0-9]*" | sort -g`
echo $nr_thrs

for n in $nr_thrs
do
	printf "%3d\t" $n
	grep "^#ops" $odir/$n/$uniqid/commlog | awk '{print $3}'
done
