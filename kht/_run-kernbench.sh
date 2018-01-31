#!/bin/bash

if [ $# -ne 6 ]
then
	echo "Usage: $0 <benchmark> <duration> <nodes per bucket> \\"
	echo "		<nr_buckets> <update rate> <nr_threads>"
	echo "	benchmark: (rcu | rcu_forgive | rcu-fglock | rcu-numa | "
	echo "		    rlu | rlu-forgive | "
	echo "		    rcuhtm | forgive | retry | hwa | "
	echo "		    rcx-htmlock | rcx-hhtmlock | rcx)"
	echo "	duration: runtime of benchmark in milli-seconds"
	echo "	nodes per bucket: number of nodes in each bucket"
	echo "	nr_buckets: number of buckets in the hash table"
	echo "	update rate: number of updates per 10000 operations"
	echo "	nr_threads: number of threads"
	echo
	exit 1
fi

BENCH=$1
DURATION=$2
NODES_PER_BUCKET=$3
NR_BUCKS=$4
RATE_UPDATE=$5
NR_THRS=$6
RANGE=$(($NODES_PER_BUCKET * $NR_BUCKS * 2))

RLU_DIR=$HOME/rcx-hashtables/

cd $RLU_DIR

sudo dmesg -c > /dev/null
sudo insmod sync.ko benchmark=$BENCH threads_nb=$NR_THRS update=$RATE_UPDATE \
	range=$RANGE duration=$DURATION nr_buckets=$NR_BUCKS
sudo rmmod sync.ko
dmesg
