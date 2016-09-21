#!/bin/bash

for vm in vmvx01 vmvx02 vmvx11 vmvx12; do
    vm_id=$(nova list | grep $vm | awk '{print $2}')
    port_id=$(neutron port-list -c id -c fixed_ips -- --device_id $vm_id | grep subnet_id | awk '{print $2}')
    neutron floatingip-create --port_id $port_id ext-net
done;
neutron floatingip-list
