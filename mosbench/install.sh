#!/bin/bash

LBX=$HOME/lazybox

if [ ! -d $LBX ]
then
	echo "[error] Install lazybox at $LBX first"
	exit 1
fi

cd $LBX/workloads/mosbench

echo "Fetch mosbench source code..."
./fetch-mosbench.sh

echo "Build metis"
cd metis
./build.sh

echo "Build psearchy"
cd ../psearchy
./build.sh
