# $1: directory to store files
# $2: prepend text to name of file

#set -vx

outdir=$1
pre=$2

mkdir -p $outdir

ovsdb-tool -mm show-log &> $outdir/show.log
cp /etc/openvswitch/conf.db $outdir

cp /var/log/openvswitch/*.log $outdir

/opt/tools/osdbg.sh $pre &> $outdir/osdbg.txt

logdir=$(grep SCREEN_LOGDIR /opt/devstack/local.conf | sed -e 's/SCREEN_LOGDIR=//')
logdir=${logdir:-/opt/stack/logs}
cp -rf $logdir $outdir

/opt/tools/dbgiptables.sh &> $outdir/iptables.txt

history &> $outdir/history.txt

cp /opt/devstack/local.conf $outdir

exit 0
