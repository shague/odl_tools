#!/bin/bash
# cleans out anything openstack created

sudo killall nova-api nova-compute nova-conductor nova-cert nova-network \
nova-scheduler nova-novncproxy nova-xvpvncproxy nova-objectstore nova-consoleauth \
horizon neutron glance

for i in `sudo virsh list | grep instance | awk '{print $2}'` ; do
    sudo virsh destroy $i
done

#set -e
#set -vx

for qvb in `ifconfig -a | grep qvb | cut -d' ' -f1`
do
    `sudo ip link set $qvb down`
    `sudo ip link delete $qvb`
done
for qbr in `ifconfig -a | grep qbr | cut -d' ' -f1`
do
    `sudo ip link set $qbr down`
    `sudo ip link delete $qbr`
done
for qvo in `ifconfig -a | grep qvo | cut -d' ' -f1`
do
    `sudo ovs-vsctl --if-exists del-port br-int $qvo`
done
for tap in `ifconfig -a | grep tap | cut -d' ' -f1`
do
    tap="${tap%?}"
    `sudo ip link set $tap down`
    `sudo ovs-vsctl --if-exists del-port br-int $tap`
done

for i in `sudo ovs-vsctl show | grep Bridge | awk '{print $2}'` ; do
    if [[ $i == *br-eth1* ]]; then
        sudo ovs-vsctl --if-exists del-br 'br-eth1'
    else
        sudo ovs-vsctl --if-exists del-br $i
    fi
done

for i in `ip addr | grep tap | awk '{print $2}'`; do
    tap="${i%?}"
    echo "tap=$tap"
    sudo ip link del dev $tap
done

for i in phy-br-eth1 int-br-eth1; do
    ip -o link show dev $i &> /dev/null
    if [ $? -eq 0 ]; then
        sudo ip link del dev $i
    fi
done

sudo pkill /usr/bin/python

#sudo /opt/odl_os_ovs.sh 192.168.120.31
