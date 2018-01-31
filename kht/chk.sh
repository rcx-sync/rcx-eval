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
if [ ! -d $RESDIR/01 ]
then
	echo "$RESDIR/01 not exists!"
fi

if [ -d $RESDIR/avg ]
then
	avg=`cat $RESDIR/avg/perf`
	stdev=`cat $RESDIR/stdev/perf`
	errpct=`echo "" | awk -v avg="$avg" -v stdev="$stdev" \
		'{print int(stdev * 100 / avg)}'`
	if [ $errpct -gt 10 ]
	then
		echo "Error rate $errpct for $RESDIR"
	fi
fi
					done
				done
			done
		done
	done
done
