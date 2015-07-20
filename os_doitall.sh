#!/bin/bash

source openrc admin admin

/opt/tools/os_addnano.sh
sleep 1
/opt/tools/os_addadminkey.sh
sleep 1
/opt/tools/os_addextnetrtr.sh
sleep 3
/opt/tools/os_addvms.sh
sleep 5
/opt/tools/os_addfloatingips.sh
#sleep 1
#/opt/tools/os_addsecuritygroups.sh
