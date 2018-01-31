#!/bin/bash

for i in 1 2 3 4 5;
do
	THREADS="1 2 4 9 18 36 54 72 90 108 126 144" ./_run.sh | tee `uname -r`.$i
done
