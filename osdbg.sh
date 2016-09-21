#!/bin/bash

set -x

echo
echo "New capture: $1"
echo 

echo "=========="
sudo virsh list

echo "=========="
ip link
echo "=========="
ip addr
echo "=========="
ip route
echo "=========="
arp -an

echo "=========="
for i in $(ip netns); do
    echo "-----"
    sudo ip netns exec $i ip link
    echo "-----"
    sudo ip netns exec $i ip addr
    echo "-----"
    sudo ip netns exec $i ip route
done

#sudo ovsdb-client dump
echo "=========="
sudo ovs-vsctl list open_vSwitch
echo "=========="
sudo brctl show
echo "=========="
sudo ovs-dpctl show
echo "=========="
sudo ovs-dpctl dump-flows
echo "=========="
sudo ovs-vsctl show

echo "=========="
sudo ovs-vsctl list Interface | grep -E '^name|^ofport '
echo "=========="
for br in `sudo ovs-vsctl list-br`; do
    sudo ovs-vsctl list bridge $br | grep OpenFlow13
    if [ $? -eq 0 ]; then
        proto="OpenFlow13"
    else
        proto="OpenFlow10"
    fi
    echo "-----"
    sudo ovs-ofctl --protocol=$proto show $br
    echo "-----"
    sudo ovs-ofctl --protocol=$proto dump-flows $br
    echo "-----"
    sudo ovs-ofctl --protocol=$proto dump-groups $br
    echo "-----"
    sudo ovs-ofctl --protocol=$proto dump-group-stats $br
    echo "-----"
    sudo ovs-appctl fdb/show $br
done

set +o xtrace

exit 0
