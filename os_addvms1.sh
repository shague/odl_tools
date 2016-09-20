#!/bin/bash

nova boot --poll --flavor m1.nano --image $(nova image-list | grep 'uec\s' | awk '{print $2}' | tail -1) --nic net-id=$(neutron net-list | grep -w vx-net1 | awk '{print $2}') vmvx11 --availability-zone=nova:odl31 --key-name admin_key
sleep 5
nova boot --poll --flavor m1.nano --image $(nova image-list | grep 'uec\s' | awk '{print $2}' | tail -1) --nic net-id=$(neutron net-list | grep -w vx-net1 | awk '{print $2}') vmvx12 --availability-zone=nova:odl32 --key-name admin_key
sleep 5
nova get-vnc-console vmvx11 novnc
nova get-vnc-console vmvx12 novnc
