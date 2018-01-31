#!/bin/bash

BINDIR=`dirname $0`
cd $BINDIR

if [ $# -ne 1 ]
then
	echo "Usage: $0 <path to result dir>"
	exit 1
fi

RESD=$1

./_extract_perf.sh $RESD/commlog > $RESD/perf

#grep "#abort / updates" $RESD/commlog \
#	| awk -F']' '{print $2}' | awk '{print $6}' > $RESD/aborts_per_1000upd

grep "aborts_per_sec" $RESD/commlog \
	| awk -F']' '{print $2}' | awk '{print $2}' > $RESD/aborts_per_sec

grep "aborts_per_1000issue" $RESD/commlog \
	| awk -F']' '{print $2}' | awk '{print $2}' > $RESD/aborts_per_1000issue
grep "aborts_per_1000succ" $RESD/commlog \
	| awk -F']' '{print $2}' | awk '{print $2}' > $RESD/aborts_per_1000succ
grep "aborts_per_1000upd" $RESD/commlog \
	| awk -F']' '{print $2}' | awk '{print $2}' > $RESD/aborts_per_1000upd

grep "rtm_explicit" $RESD/commlog \
	| awk -F']' '{print $2}' | awk '{print $2}' > $RESD/aborts_explicit

grep "rtm_retry" $RESD/commlog \
	| awk -F']' '{print $2}' | awk '{print $2}' > $RESD/aborts_retry

grep "rtm_conflict" $RESD/commlog \
	| awk -F']' '{print $2}' | awk '{print $2}' > $RESD/aborts_conflict

grep "rtm_capa" $RESD/commlog \
	| awk -F']' '{print $2}' | awk '{print $2}' > $RESD/aborts_capa

grep "rtm_dbg" $RESD/commlog \
	| awk -F']' '{print $2}' | awk '{print $2}' > $RESD/aborts_dbg

grep "rtm_nest" $RESD/commlog \
	| awk -F']' '{print $2}' | awk '{print $2}' > $RESD/aborts_nest
