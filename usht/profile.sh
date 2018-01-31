#!/bin/bash

# This script is a lazybox automated experiment configuration generator.  Pipe
# the generated configuration to `run_exps.py` of lazybox to start experiment
# and profiling.

if [ $# -ne 2 ]
then
	echo "USAGE: $0 <expname> <command>"
	echo ""
	echo "expname should be in <workload>/<variance> format"
	exit 1
fi

LAZYBOX=$HOME/lazybox

BINDIR=`dirname $0`
FULLCMD=$2
COMM_ARR=($FULLCMD)
COMM=`basename ${COMM_ARR[0]}`
EXPNAME=$1
ODIR_ROOT=results
ODIR=$ODIR_ROOT/$EXPNAME

MAX_REPEAT=10
for (( unqid=1; unqid <= $MAX_REPEAT; unqid+=1 ))
do
	CANDIDATE=$ODIR/`printf "%02d" $unqid`
	if [ ! -d $CANDIDATE ]
	then
		ODIR=$CANDIDATE
		break
	fi
	if [ $unqid -eq $MAX_REPEAT ]
	then
		echo "[Error] $MAX_REPEAT repeated results already exists!!!"
		exit 1
	fi
done


echo "
start echo 3 > /proc/sys/vm/drop_caches
start mkdir -p $ODIR
main perf stat -a -d -o $ODIR/perf.stat -- $FULLCMD | tee $ODIR/commlog
back vmstat 1 > $ODIR/vmstat
end chown -R $USER:$USER $ODIR_ROOT"
