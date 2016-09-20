#!/bin/bash

nova boot --poll --flavor m1.nano --image $(nova image-list | grep 'uec\s' | awk '{print $2}' | tail -1) --nic net-id=$(neutron net-list | grep -w vx-net0 | awk '{print $2}') vmvx01 --availability-zone=nova:odl31 --key-name admin_key
sleep 5
nova boot --poll --flavor m1.nano --image $(nova image-list | grep 'uec\s' | awk '{print $2}' | tail -1) --nic net-id=$(neutron net-list | grep -w vx-net0 | awk '{print $2}') vmvx02 --availability-zone=nova:odl32 --key-name admin_key
sleep 5
nova get-vnc-console vmvx01 novnc
nova get-vnc-console vmvx02 novnc

