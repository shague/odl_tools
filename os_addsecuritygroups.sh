#!/bin/bash

for uuid in $(neutron security-group-list | grep default | awk '{print $2}') ; do
    echo "uuid ${uuid}"
    for direction in ingress egress ; do echo “direction ${direction}”
        neutron security-group-rule-create --protocol icmp --direction ${direction} ${uuid}
        neutron security-group-rule-create --protocol tcp --port-range-min 22 --port-range-max 22 --direction ${direction} ${uuid}
        neutron security-group-rule-create --protocol tcp --port-range-min 80 --port-range-max 80 --direction ${direction} ${uuid}
    done;
done;
