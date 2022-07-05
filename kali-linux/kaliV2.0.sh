#!/bin/bash

cleverecho="/bin/echo -e - n"
blankline="/bin/echo -e -n \n"
version="2.0"
progname="$(basename "$0")"

setup() {
    $cleverecho "This will install kali-win-kex onto your Virtual Machine.\n"
    $cleverecho "Is this what you want to do?: "
    read setupinstall

    if [[ "$setupinstall" = "Yes" ]] | [[ "$setupinstall" = "yes" ]] | [[ "$setupinstall" = "Y" ]] | [[ "$setupinstall" = "y" ]]; then
        sudo apt update
        sudo apt install kali-win-kex -y
    fi

    if [[ "$setupinstall" = "No" ]] | [[ "$setupinstall" = "no" ]] | [[ "$setupinstall" = "N" ]] | [[ "$setupinstall" = "n" ]]; then
        $cleverecho "Ok no worries ...\n"
    fi
}

disk() {
	# New Virtual Disk Creation in Linux
	$cleverecho "Are you sure you want to setup a new Virtual Disk (Yes/No): "
	read yesno

	if [[ "$yesno" = "Yes" ]] | [[ "$yesno" = "yes" ]] | [[ "$yesno" = "Y" ]] | [[ "$yesno" = "y" ]]; then
		dd if=/dev/zero of=$image bs=1G count=50
	fi

	if [[ "$yesno" = "No" ]] | [[ "$yesno" = "no" ]] | [[ "$yesno" = "N" ]] | [[ "$yesno" = "n" ]]; then
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
