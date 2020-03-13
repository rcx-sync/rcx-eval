#!/bin/bash

if [ $# -lt 2 ]
then
	echo "Usage: $0 <output directory> <src directory [src directory ...]>"
	exit 1
fi

OUTPUT_DIR=$1
SRC_DIR=${@:2}

LBPATH=/home/$USER/lazybox

NOSTATFILES=""
STATFILES="perf"

for d in $SRC_DIR
do
	for f in $NOSTATFILES $STATFILES
	do
		if [ ! -f $d/$f ]
		then
			echo "[Error] $d/$f file missing"
			exit 1
		fi
	done
done

for stat in avg min max stdev
do
	STATDIR=$OUTPUT_DIR/$stat
	mkdir -p $STATDIR

	# Copy files that not appropriate for status calculation
	for f in $NOSTATFILES
	do
		cp $2/$f $STATDIR/
	done

	for f in $STATFILES
	do
		PATHS=""
		for d in $SRC_DIR
		do
			PATHS+=$d/$f" "
		done

		$LBPATH/scripts/report/statof.py $stat $PATHS > $STATDIR/$f
	done
done
