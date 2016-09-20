#!/bin/bash

for uuid in $(neutron security-group-list | grep default | awk '{print $2}') ; do
    echo "uuid ${uuid}"
    for direction in ingress egress ; do echo “direction ${direction}”
        neutron security-group-rule-create --prefix 10.100.0.0/16 --direction ${direction} ${uuid}
    done;
done;
