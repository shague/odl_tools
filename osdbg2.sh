#!/bin/bash

# $1: directory to store files
# $2: prepend text to name of file

#set -vx

outdir=$1
if [ -n $2 ]; then
    outdir=$1/$2
fi
pre=$2

mkdir -p $outdir

ovsdb-tool -mm show-log &> $outdir/ovsdbshow.log

cp /etc/openvswitch/conf.db $outdir

cp /var/log/openvswitch/*.log $outdir

/opt/tools/osdbg.sh $pre &> $outdir/osdbg.txt
/opt/tools/neutrondbg.sh $pre &> $outdir/neutrondbg.txt

logdir=$(grep SCREEN_LOGDIR /opt/devstack/local.conf | sed -e 's/SCREEN_LOGDIR=//')
logdir=${logdir:-/opt/stack/logs}
cp -rf $logdir $outdir

/opt/tools/dbgiptables.sh &> $outdir/iptables.txt

history &> $outdir/history.txt

cp /opt/devstack/local.conf $outdir

exit 0
