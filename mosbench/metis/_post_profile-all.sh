#!/bin/bash

. ./__common.sh

for k in $kernels
do
	for t in $nr_threads
	do
		RESDIR=./results/$config_name/kernel$k/thr$t
		for d in `find $RESDIR -type d -name 0*`
		do
			echo "post_profile $d"
			./_post_profile.sh $d
		done
	done
done
