#!/bin/bash

nova keypair-add --pub-key ~/.ssh/id_rsa.pub admin_key
nova keypair-list
