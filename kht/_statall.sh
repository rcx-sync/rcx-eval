#!/bin/bash

. __common.sh

for b in $benchs
do
	for dur in $duration
	do
		for nd in $nodes_per_buck
		do
			for bck in $nr_bucks
			do
				for wr in $wrates
				do
					for t in $nr_threads
					do
path=`RES_NAME $b $dur $nd $bck $wr $t`
echo "Calculate stat of $path"
./_stat.sh results/$config_name/$path results/$config_name/$path/0*
					done
				done
			done
		done
	done
done
