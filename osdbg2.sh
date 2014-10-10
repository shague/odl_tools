#!/bin/bash
# $1: directory to store files
# $2: prepend text to name of file

set -vx

mkdir -p $1

ovsdb-tool show-log &> $1/show.log
cp /etc/openvswitch/conf.db $1

cp /var/log/openvswitch/*.log $1

/opt/tools/osdbg.sh &> $1/$2_osdbg.txt

cp -rf /opt/logs/stack $1

exit 0
