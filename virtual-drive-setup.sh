#!/bin/bash

cleverecho="/bin/echo -e -n"

setup() {

	$cleverecho "Enter New Image Name: "; 			read image
	$cleverecho "Enter Size Requested: "; 			read sizerequested
	$cleverecho "Enter Size Type Requested (K/M/B/T): "; 	read sizetype

	$cleverecho "Enter Image Location (eg: /tmp): ";	read imagelocation
	
	#New Virtual Disk Setup in Linux

	$cleverecho "\tCreating: $image\tSize: $sizerequested$sizetype\n"; sleep 1
	$cleverecho "\nPress Enter to continue or ctrl-c to cancel"; read checkcancel
	
	dd if=/dev/zero of=$imagelocation/$image bs=$sizerequested$sizetype count=1

	$cleverecho "\n\n\a\tNow running fdisk to configure new drive ..."; sleep 1; echo " ...";

	sudo fdisk $imagelocation/$image

	# To View the partition table of the image file
	sudo fdisk -l $imagelocation/$image
	imagefile=$(sudo losetup --partscan --find --show $imagelocation/$image)
#	mkfs.ext4 $imagefile

#mkfs.ext4 /dev/loop?? /Servers/tmp

#sudo partx -v -a /Servers/Storage2/WSL/Kali/home.img
#sudo mount -t auto /dev/loop0p1 /Servers/WSL/notes
#sudo mount -t auto /dev/loop0p2 /Servers/WSL/p1
#export HOME=/Servers/WSL/p1

}


mount() {

sudo losetup --partscan --find --show image.img

sudo partx -v -a /Servers/Storage2/WSL/Kali/home.img
sudo mount -t auto /dev/loop0p1 /Servers/WSL/notes
sudo mount -t auto /dev/loop0p2 /Servers/WSL/p1

}

menu() {

	$cleverecho "Virtual Drive Management System:\n"
	$cleverecho ""
}
setup
