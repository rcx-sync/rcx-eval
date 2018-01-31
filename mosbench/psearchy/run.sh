#!/bin/bash

RUN_EXP=$HOME/lazybox/run_exps.py

. ./__common.sh

for t in $nr_threads
do
	cmd="./_run.sh $t"
	./_mklbxcfg.sh kernel`uname -r`/thr$t "$cmd" $config_name | \
		sudo $RUN_EXP stdin
done
