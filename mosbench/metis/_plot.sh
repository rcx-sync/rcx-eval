#!/bin/bash

. __common.sh

plotdir=plots/$config_name
mkdir -p $plotdir

REPORT=$plotdir/report-$config_name.html
echo "<center>" > $REPORT
echo "<table>" >> $REPORT

middlepaths=""
for k in $kernels
do
	middlepaths=$middlepaths"kernel"$k" "
done

# Performance
		echo "<tr>" >> $REPORT

plotname="perf"
plotpath=$plotdir/$plotname

resdir=results/$config_name
paths=`$LBX/scripts/report/paths.sh \
	$resdir/ /perf_avg/perf \
	$middlepaths`

echo $paths
$LBX/scripts/report/files_to.py records $paths > $plotpath
cat $plotpath | $LBX/gnuplot/plot_stdin.sh scatter \
	"Number of threads" "Jobs per hour"

mv plot.pdf $plotpath".pdf"
$LBX/gnuplot/pdftopng $plotpath

echo "<td><center>" >> $REPORT
echo "<h2>"$plotname "</h2>" >> $REPORT
echo "<img src=$plotname.png><br>" >> $REPORT
echo "</td>" >> $REPORT
echo "</tr>" >> $REPORT
echo "</table>" >> $REPORT
