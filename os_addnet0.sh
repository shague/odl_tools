#!/bin/bash

neutron net-create vx-net0 --provider:network_type vxlan --provider:segmentation_id 1500
neutron subnet-create vx-net0 10.100.5.0/24 --name vx-subnet0 --dns-nameserver 8.8.8.8

