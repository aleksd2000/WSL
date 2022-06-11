#!/bin/bash

# Test script for banning lots of IP Addresses

# Database for banned IP Addresses
bannedips=./bannedips.db

banips() {

BLOCKDB=$bannedips
IPS=$(grep -Ev "^#" $BLOCKDB)
for i in $IPS
	do
		iptables -A INPUT -s $i -j DROP
		#iptables -A OUTPUT -d $i -j DROP
	done
}
