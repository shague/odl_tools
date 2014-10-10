sudo ip link set dev vsff1-sf11 down
sudo ip link del dev vsff1-sf11
sudo ip link set dev vsf11-sff1 down
sudo ip link del dev vsf11-sff1
sudo ip link add vsff1-sf11 type veth peer name vsf11-sff1
sudo ip link set dev vsff1-sf11 address f6:00:00:ff:01:01
sudo ip link set dev vsf11-sff1 address f6:00:00:0f:11:01
sudo ip link set dev vsff1-sf11 up
sudo ip link set dev vsf11-sff1 up
sudo ovs-vsctl -- \
    --if-exists del-port sff1 vsff1-sf11 -- \
    --if-exists del-br sff1
sudo ovs-vsctl add-br sff1 -- set bridge sff1 other_config:hwaddr=f6:00:00:ff:01:00 -- \
    set bridge sff1 other-config:disable-in-band=true
sudo ovs-vsctl add-port sff1 vsff1-sf11 -- set Interface vsff1-sf11 ofport_request=1

sudo ovs-vsctl -- \
    --if-exists del-port sf11 vsf11-sff1 -- \
    --if-exists del-br sf11
sudo ovs-vsctl add-br sf11 -- set bridge sf11 other_config:hwaddr=f6:00:00:0f:11:00 -- \
    set bridge sf11 other-config:disable-in-band=true
sudo ovs-vsctl add-port sf11 vsf11-sff1 -- set Interface vsf11-sff1 ofport_request=1
sudo ovs-ofctl del-flows sf11
sudo ovs-ofctl add-flow sf11 priority=10,actions=
sudo ovs-ofctl add-flow sf11 priority=100,in_port=1,tcp,tp_dst=80,actions=output:in_port

# add sf12
sudo ip link set dev vsff1-sf12 down
sudo ip link del dev vsff1-sf12
sudo ip link set dev vsf12-sff1 down
sudo ip link del dev vsf12-sff1
sudo ip link add vsff1-sf12 type veth peer name vsf12-sff1
sudo ip link set dev vsff1-sf12 address f6:00:00:ff:01:02
sudo ip link set dev vsf12-sff1 address f6:00:00:0f:12:01
sudo ip link set dev vsff1-sf12 up
sudo ip link set dev vsf12-sff1 up
sudo ovs-vsctl --if-exists del-port sff1 vsff1-sf12
sudo ovs-vsctl --may-exist add-br sff1
sudo ovs-vsctl add-port sff1 vsff1-sf12 -- set Interface vsff1-sf12 ofport_request=2

sudo ovs-vsctl -- \
    --if-exists del-port sf12 vsf12-sff1 -- \
    --if-exists del-br sf12
sudo ovs-vsctl add-br sf12 -- set bridge sf12 other_config:hwaddr=f6:00:00:0f:12:00
sudo ovs-vsctl add-port sf12 vsf12-sff1 -- set Interface vsf12-sff1 ofport_request=1
sudo ovs-ofctl del-flows sf12
sudo ovs-ofctl add-flow sf12 priority=10,actions=
sudo ovs-ofctl add-flow sf12 priority=100,in_port=1,tcp,tp_dst=80,actions=output:in_port

sudo ovs-vsctl add-port sff1 ws6 -- set Interface ws6 type=internal \
    -- set Interface ws6 mac="f6\:00\:00\:ff\:01\:06" \
    -- set Interface ws6 ofport_request=6
sudo ip netns add ws6
sudo ip link set ws6 netns ws6
sudo ip netns exec ws6 ip addr add dev ws6 10.1.6.1/24
sudo ip netns exec ws6 ip link set dev lo up
sudo ip netns exec ws6 ip link set dev ws6 up
sudo ip netns exec ws6 ip route add default via 10.1.6.1
sudo ip route add 10.1.6.0/24 dev sff1

wget -O - http://10.1.6.1:80

