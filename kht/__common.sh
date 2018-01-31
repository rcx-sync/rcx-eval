if [ $CFGF ]
then
	echo "config: " $CFGF
	. $CFGF
else
	. configs/default.sh
fi

RLU_DIR=$HOME/rcx-hashtables
LBX=$HOME/lazybox

if [ ! -d $RLU_DIR ]
then
	echo "RCX hashtables are not installed at $RLU_DIR"
	exit 1
fi

if [ ! -d $LBX ]
then
	echo "Lazybox is not installed at $LBX"
	exit 1
fi

function RES_NAME() {
	echo $1/dur$2/nd$3/bck$4/upd$5/thr$6
}
