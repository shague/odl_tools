#!/bin/bash

sudo ovs-appctl --target ovsdb-server vlog/set ovsdb_server:file:dbg
#sudo ovs-appctl --target ovsdb-server vlog/set ovsdb_log:file:dbg
sudo ovs-appctl --target ovsdb-server vlog/set ovsdb_jsonrpc_server:file:dbg
sudo ovs-appctl --target ovsdb-server vlog/set ovsdb_file:file:dbg
sudo ovs-appctl --target ovsdb-server vlog/set ovsdb_error:file:dbg
sudo ovs-appctl --target ovsdb-server vlog/set jsonrpc:file:dbg

