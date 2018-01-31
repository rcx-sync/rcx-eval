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

# number of successful spf
if [ -f $RESD/spf ]
then
	echo $(( `sed '2q;d' $RESD/spf | awk '{printf $2}'` - \
		`sed '1q;d' $RESD/spf | awk '{print $2}'`)) > $RESD/nr_spf
fi
