#!/bin/bash

. ./__common.sh

for b in $benchs
do
	for dur in $duration
	do
		for nd in $nodes_per_buck
		do
			for nb in $nr_bucks
			do
				for wr in $wrates
				do
					for t in $nr_threads
					do

RESDIR=./results/$config_name/`RES_NAME $b $dur $nd $nb $wr $t`
for d in `find $RESDIR -type d -name 0*`
do
	echo "post_profile $d"
	./_post_profile.sh $d
done

					done
				done
			done
		done
	done
done
