#!/bin/bash

cleverecho="/bin/echo -e -n"

if [ "$UID" != "0" ]; then
	$cleverecho "You need to be root to run this program!\n\n"
fi

image=$2
test() { 
	$cleverecho "Image file=$image"
	exit 0;
}

create() {
	# New Virtual Disk Creation in Linux
	$cleverecho "Are you sure you want to setup a new Virtual Disk (Yes/No): "
	read yesno

	if [ "yesno" = "Yes" ]; then
		dd if=/dev/zero of=$image bs=1G count=50
	fi

	if [ "yesno" = "yes" ]; then
		dd if=/dev/zero of=$image bs=1G count=50
	fi

	if [ "$yesno" = "No" ]; then
		$cleverecho "That's not a problem, come back soon\n";
		exit 0;
	fi

	if [ "$yesno" = "no" ]; then
		$cleverecho "That's not a problem, come back soon\n";
		exit 0;
	fi

	$cleverecho "Ready to configure the disk image? (Yes/No): "
	read answer

	if [ "$answer" = "Yes" ]; then
	sudo cfdisk $image
	fi

	if [ "$answer" = "yes" ]; then
	sudo cfdisk $image
	fi

	if [ "$answer" = "No" ]; then
		$cleverecho "That's not a problem, come back soon\n";
		exit 0;
	fi

	if [ "$answer" = "no" ]; then
		$cleverecho "That's not a problem, come back soon\n";
		exit 0;
	fi
}

mount() {
	sudo fdisk -l $image
	
}

custom() {
	partx -v -a /Servers/Storage2/WSL/Kali/home.img
	mount /dev/loop0p1 /Servers/WSL/notes
	mount /dev/loop0p2 /Servers/WSL/partitions/1
	exit 0;
}

unmount() {
	partx -v -d /dev/loop0
	losetup  -d /dev/loop0
	losetup  -d /dev/loop1
	losetup  -d /dev/loop2
	losetup  -d /dev/loop3
}

if [ "$1" = "test" ]; then test; fi
if [ "$1" = "custom" ]; then custom; fi
if [ "$1" = "create" ]; then create; fi
if [ "$1" = "unmount" ]; then unmount; fi
