#!/bin/bash

local_ip=""
bridge_mappings=""
odl_ip=""

function usage {
    local rc=$1
    local outstr=$2

    if [ "$outstr" != "" ]; then
        echo "$outstr"
        echo
    fi

    echo "Usage: `basename $0` [OPTION...]"
    echo
    echo "Script options:"
    echo "  --local_ip IP               IP address of the node, will be used as tunnel endpoint"
    echo "  --bridge_mappings MAPPINGS  physical provider mappings, i.e physnet1:eth1,physnet2:eth2"
    echo "  --odl_ip IP                 IP address of OpenDaylight controller"
    echo
    echo "Help options:"
    echo "  -?, -h, --h, --help  Display this help and exit"
    echo

    exit $rc
}

function parse_options {
    while true ; do
        case "$1" in
        --local_ip)
            shift; local_ip="$1"; shift
            ;;

         --bridge_mappings)
            shift; bridge_mappings="$1"; shift
            ;;

         --odl_ip)
            shift; odl_ip="$1"; shift
            ;;

      -? | -h | --h | --help)
            usage 0
            ;;
        "")
            break
            ;;
        *)
            echo "Ignoring unknown option: $1"; shift;
        esac
    done
}

parse_options "$@"

if [ `whoami` != "root" ]; then
    usage 1 "Please execute this script as superuser or with sudo previleges."
fi

if [ -n "$odl_ip" ]; then
    echo "setting odl_ip=$odl_ip"
    ovs-vsctl set-manager tcp:$odl_ip:6640
fi

read ovstbl <<< $(ovs-vsctl get Open_vSwitch . _uuid)

if [ -n "$bridge_mappings" ]; then
    sudo ovs-vsctl set Open_vSwitch $ovstbl other_config:bridge_mappings=$bridge_mappings
fi


if [ -n "$local_ip" ]; then
    sudo ovs-vsctl set Open_vSwitch $ovstbl other_config:local_ip=$local_ip
fi

ovs-vsctl list Manager
echo
ovs-vsctl list Open_vSwitch .

exit 0

