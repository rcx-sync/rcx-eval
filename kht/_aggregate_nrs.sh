#!/bin/bash

. ./__common.sh

RESDIR=results/$config_name

function aggregate() {
	src_file=$1
	target_dir=$2
	target_file=$3

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
	variant=$b/dur$dur/nd$nd/bck$bck/upd$wr
	path=$RESDIR/$variant
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
				done
			done
		done
	done
}

aggregate "avg/perf" "perf_avg" "perf"
aggregate "avg/aborts_per_1000upd" "aborts_per_1000upd" "aborts"
aggregate "avg/aborts_explicit" "aborts" "aborts_explicit"
aggregate "avg/aborts_retry" "aborts" "aborts_retry"
aggregate "avg/aborts_conflict" "aborts" "aborts_conflict"
aggregate "avg/aborts_capa" "aborts" "aborts_capa"
aggregate "avg/aborts_dbg" "aborts" "aborts_dbg"
aggregate "avg/aborts_nest" "aborts" "aborts_nest"

aggregate "stdev/perf" "perf_stdev" "perf"
aggregate "stdev/aborts_per_1000upd" "aborts_per_1000upd_stdev" "aborts"

function aggregate_fields() {
	src_files=$1
	target_dir=$2
	target_file=$3

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
	variant=$b/dur$dur/nd$nd/bck$bck/upd$wr
	path=$RESDIR/$variant
	mkdir -p $path/$target_dir/
	targetpath=$path/$target_dir/$target_file

	src_files_paths=""
	for s in $src_files
	do
		src_files_paths="$src_files_paths $path/$s"
	done

	$LBX/scripts/report/files_to.py table $src_files_paths | tail -n +3 \
		> $targetpath
					done
				done
			done
		done
	done
}

aggregate_fields "perf_avg/perf perf_stdev/perf" "perf_avg_stdev" "perf"
