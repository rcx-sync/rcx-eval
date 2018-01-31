#!/bin/bash

. ./__common.sh

RESDIR=results/$config_name

function aggregate() {
	src_file=$1
	target_dir=$2
	target_file=$3

	for k in $kernels
	do
		path=$RESDIR/kernel$k
		mkdir -p $path/$target_dir/
		targetpath=$path/$target_dir/$target_file
		rm -fr $targetpath
		touch $targetpath

		for t in $nr_threads
		do
			printf "%s %s\n" $t `cat $path/thr$t/$src_file` \
				>> $targetpath
		done
	done
}

aggregate "avg/perf" "perf_avg" "perf"
