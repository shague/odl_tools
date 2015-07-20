#!/bin/bash

cidr=$(ip -o -4 addr | grep 192.168.254 | awk '{print $4}')
sudo ip addr del $cidr dev eth2
sudo ip addr del $cidr dev eth1
sudo ovs-vsctl add-br br-eth1
sudo ovs-vsctl add-port br-eth1 eth1
sudo ip addr add $cidr dev br-eth1
sudo ip link set dev br-eth1 up
