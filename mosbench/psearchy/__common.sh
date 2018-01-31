if [ $CFGF ]
then
	echo "config: " $CFGF
	. $CFGF
else
	. configs/default.sh
fi

LBX=$HOME/lazybox

if [ ! -d $LBX ]
then
	echo "Lazybox is not installed at $LBX"
	exit 1
fi
