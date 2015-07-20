#!/bin/bash

sudo iptables --line-number -nvL

for ns in $(ip netns); do
    echo "==============================================================================="
    echo "$ns"
    echo "==============================================================================="
    echo "----- ip netns exec $ns ip link"
    sudo ip netns exec $ns ip link
    echo
    echo "----- ip netns exec $ns ip addr"
    sudo ip netns exec $ns ip addr
    echo
    echo "----- ip netns exec $ns ip route"
    sudo ip netns exec $ns ip route
    echo
    echo "----- ip netns exec $ns iptables --line-number -nvL"
    sudo ip netns exec $ns iptables --line-number -nvL
    echo
    echo "----- iptables --line-number -nvL"
    sudo iptables --line-number -nvL
    echo
done
