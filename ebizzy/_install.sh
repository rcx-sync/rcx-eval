#!/bin/bash

BINDIR=`dirname $0`
cd $BINDIR

cd ebizzy-0.3
cc -pthread -lpthread -O3 -o ebizzy ebizzy.c
