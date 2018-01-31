#!/bin/bash

. __common.sh
for k in $kernels
do
	for t in $nr_threads
	do
		RESDIR=./results/$config_name/kernel$k/thr$t
		echo "Calculate stat of $RESDIR"
		./_stat.sh $RESDIR $RESDIR/0*
	done
done
