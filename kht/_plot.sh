#!/bin/bash

. __common.sh

plotdir=plots/$config_name
mkdir -p $plotdir

REPORT=$plotdir/report-$config_name.html
echo "<center>" > $REPORT
echo "<table>" >> $REPORT

middlepaths=""
for b in $benchs
do
	middlepaths=$middlepaths$b" "
done

# Performance
for nd in $nodes_per_buck
do
	for bck in $nr_bucks
	do
		echo "<tr>" >> $REPORT
		for wr in $wrates
		do

plotname="nd"$nd"-bck"$bck"-upd"$wr
plotpath=$plotdir/$plotname

resdir=results/$config_name

WITH_STDEV="yes"
if [ $WITH_STDEV = "yes" ]
then
	paths=`$LBX/scripts/report/paths.sh \
		$resdir/ /dur$duration/nd$nd/bck$bck/upd$wr/perf_avg_stdev/perf \
		$middlepaths`

	echo $paths
	$LBX/scripts/report/files_to.py records $paths > $plotpath
	cat $plotpath | $LBX/gnuplot/plot_stdin.sh scatter-yerr \
		"Number of threads" "Operations per second"
else
	paths=`$LBX/scripts/report/paths.sh \
		$resdir/ /dur$duration/nd$nd/bck$bck/upd$wr/perf_avg/perf \
		$middlepaths`

	echo $paths
	$LBX/scripts/report/files_to.py records $paths > $plotpath
	cat $plotpath | $LBX/gnuplot/plot_stdin.sh scatter \
		"Number of threads" "Operations per second"
fi

mv plot.pdf $plotpath".pdf"
$LBX/gnuplot/pdftopng $plotpath

echo "<td><center>" >> $REPORT
echo "<h2>"$plotname "</h2>" >> $REPORT
echo "<img src=$plotname.png><br>" >> $REPORT
echo "</td>" >> $REPORT

		done
		echo "</tr>" >> $REPORT
	done
done


# Performance standard deviation
for nd in $nodes_per_buck
do
	for bck in $nr_bucks
	do
		echo "<tr>" >> $REPORT
		for wr in $wrates
		do

plotname="nd"$nd"-bck"$bck"-upd"$wr-stdev
plotpath=$plotdir/$plotname

resdir=results/$config_name
paths=`$LBX/scripts/report/paths.sh \
	$resdir/ /dur$duration/nd$nd/bck$bck/upd$wr/perf_stdev/perf \
	$middlepaths`
echo $paths
$LBX/scripts/report/files_to.py records $paths > $plotpath
cat $plotpath | $LBX/gnuplot/plot_stdin.sh scatter \
	"Number of threads" "Operations per second"

mv plot.pdf $plotpath".pdf"
$LBX/gnuplot/pdftopng $plotpath

echo "<td><center>" >> $REPORT
echo "<h2>"$plotname "</h2>" >> $REPORT
echo "<img src=$plotname.png><br>" >> $REPORT
echo "</td>" >> $REPORT

		done
		echo "</tr>" >> $REPORT
	done
done


# Aborts per 1000 updates
for nd in $nodes_per_buck
do
	for bck in $nr_bucks
	do
		echo "<tr>" >> $REPORT
		for wr in $wrates
		do

plotname="nd"$nd"-bck"$bck"-upd"$wr"-aborts_per_1000_updates"
plotpath=$plotdir/$plotname

resdir=results/$config_name
paths=`$LBX/scripts/report/paths.sh \
	$resdir/ /dur$duration/nd$nd/bck$bck/upd$wr/aborts_per_1000upd/aborts \
	$middlepaths`
echo $paths
$LBX/scripts/report/files_to.py records $paths > $plotpath
cat $plotpath | $LBX/gnuplot/plot_stdin.sh scatter \
	"Number of threads" "Operations per second" y

mv plot.pdf $plotpath".pdf"
$LBX/gnuplot/pdftopng $plotpath

echo "<td><center>" >> $REPORT
echo "<h2>"$plotname "</h2>" >> $REPORT
echo "<img src=$plotname.png><br>" >> $REPORT
echo "</td>" >> $REPORT

		done
		echo "</tr>" >> $REPORT
	done
done


echo "</table>" >> $REPORT
