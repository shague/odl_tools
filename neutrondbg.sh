#!/bin/bash

set -x

echo
echo "New capture: $1"
echo 

neutron net-list
for i in $(neutron net-list -c name -f value); do
    neutron net-show $i
done

neutron subnet-list
for i in $(neutron subnet-list -c name -f value); do
    neutron subnet-show $i
done

neutron router-list
for i in $(neutron router-list -c name -f value); do
    neutron router-show $i
done

neutron port-list
for i in $(neutron port-list -c id -f value); do
    neutron port-show $i
done

neutron floatingip-list
for i in $(neutron floatingip-list -c id -f value); do
    neutron floatingip-show $i
done

neutron security-group-list
for i in $(neutron security-group-list -c id -f value); do
    neutron security-group-show $i
done

neutron security-group-rule-list
for i in $(neutron security-group-rule-list -c id -f value); do
    neutron security-group-rule-show $i
done

nova list
for i in $(nova list | grep ACTIVE | awk '{print $4}'); do
    nova show $i
done

neutron agent-list
