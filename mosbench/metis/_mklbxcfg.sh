#!/bin/bash

# This script is a lazybox automated experiment configuration generator.  Pipe
# the generated configuration to `run_exps.py` of lazybox to start experiment
# and profiling.

if [ $# -lt 2 ]
then
	echo "USAGE: $0 <expname> <command> [config name]"
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
if [ $# -eq 3 ]
then
	ODIR_ROOT=$ODIR_ROOT/$3
fi
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
start mkdir -p $ODIR"
if uname -r | grep spf
then
	echo "start cat /proc/vmstat | grep speculative > $ODIR/spf"
	echo "main perf stat -a -e pagefault:*,major-faults,minor-faults " \
		"-o $ODIR/perf.stat -- $FULLCMD | tee $ODIR/commlog"
else
	echo "main perf stat -a -d -o $ODIR/perf.stat -- " \
		"$FULLCMD | tee $ODIR/commlog"
fi
echo "back vmstat 1 > $ODIR/vmstat"
if uname -r | grep spf
then
	echo "end cat /proc/vmstat | grep speculative >> $ODIR/spf"
fi
echo "end chown -R $USER:$USER $ODIR_ROOT"
