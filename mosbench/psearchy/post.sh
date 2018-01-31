#!/bin/bash

BINDIR=`dirname $0`
cd $BINDIR

./_post_profile-all.sh
./_statall.sh
./_aggregate_nrs.sh
./_plot.sh
