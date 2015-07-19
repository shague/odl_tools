#!/bin/bash

sudo ovs-vsctl add-port br-ex patch-int -- set interface patch-int type=patch options:peer=patch-ext
