#!/bin/bash

#impls="rcu rlu harris hp-harris"
impls="rcu rlu"
#nr_threads="1 2 4 9 17 18 19 26 35 36 37 45 53 54 55 63 71 72 73 90 91 108 109 126 127 144"
nr_threads="1 2 4 9 18 36 54 72 90 108 126  144"
#wrates="100 200 400 500 700 800"
wrates="0 200 2000 4000"

RLU=/home/$USER/rlu
RUN_EXP=/home/$USER/lazybox/run_exps.py

function run() {
	impl=$1
	wrate=$2
	thrs=$3

	#cmd="$RLU/bench-$impl -a -b1000 -d30000 -i100000 -r200000 -w10"
	cmd="$RLU/bench-$impl -a -b1000 -d3000 -i4000 -r8000 -w10"
	cmd=$cmd" -u$wrate -n$thrs"
	./profile.sh usht/$impl/$wrate/$thrs "$cmd" | sudo $RUN_EXP stdin
}

for impl in $impls
do
	for wr in $wrates
	do
		for nr in $nr_threads
		do
			run $impl $wr $nr
		done
	done
done
