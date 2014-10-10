#sudo ovs-appctl --target ovs-vswitchd vlog/set classifier:file:dbg
#sudo ovs-appctl --target ovs-vswitchd vlog/set ofproto:file:dbg
#sudo ovs-appctl --target ovs-vswitchd vlog/set ofp_errors:file:dbg
sudo ovs-appctl --target ovs-vswitchd vlog/set :file:dbg
sudo ovs-appctl --target ovs-vswitchd vlog/set poll_loop:file:info

source openrc admin admin
neutron net-create vlan-net --provider:network_type vlan --provider:segmentation_id 2001 --provider:physical_network physnet1
neutron subnet-create vlan-net 10.100.1.0/24 --name vlan-subnet
neutron router-create vlan-rtr
sleep 2
neutron router-interface-add vlan-rtr vlan-subnet

sleep 5
sudo ovs-ofctl --protocol OpenFlow13 dump-flows br-int
