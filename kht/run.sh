#!/bin/bash

DRYRUN=no

RLU=$HOME/rlu
RUN_EXP=$HOME/lazybox/run_exps.py

. ./__common.sh

function run() {
	bench=$1
	dur=$2
	nd_per_buck=$3
	bucks=$4
	rate_upd=$5
	nr_thrs=$6

	res_name=`RES_NAME $bench $dur $nd_per_buck $bucks $rate_upd \
		$nr_thrs`
	if [ "$DRYRUN" = "yes" ]
	then
		echo "run for $res_name"
		return
	fi

	cmd=""
	if [ ! $UNPIN_THREAD0 ]
	then
		cmd="taskset -c 0"
	fi
	cmd="$cmd ./_run-kernbench.sh $bench $dur $nd_per_buck \
		$bucks $rate_upd $nr_thrs"
	./_mklbxcfg.sh \
		$res_name \
		"$cmd" $config_name | sudo $RUN_EXP stdin
}

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

run $b $dur $nd $nb $wr $t
					done
				done
			done
		done
	done
done
