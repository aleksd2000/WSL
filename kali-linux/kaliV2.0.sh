#!/bin/bash

cleverecho="/bin/echo -e -n"
blankline="/bin/echo -e -n \n"
version="2.0"
progname="$(basename "$0")"

# Check to see if someone is already running the script and exit if it is so.

if pidof -x $0 >/dev/null; then
    echo "Script already running"
    exit
fi

# System Variables

repoaddress="apt.ukhosts.cc"
port="8000"

setup() {
    $cleverecho "This will install kali-win-kex onto your Virtual Machine.\n"
    $cleverecho "Is this what you want to do?: "
    read setupinstall

    if [[ "$setupinstall" = "Yes" || "$setupinstall" = "yes" || "$setupinstall" = "Y" || "$setupinstall" = "y" ]]; then
        sudo apt update
        sudo apt install kali-win-kex -y
    fi

    if [[ "$setupinstall" = "No" || "$setupinstall" = "no" || "$setupinstall" = "N" || "$setupinstall" = "n" ]]; then
        $cleverecho "Ok no worries ...\n"
    fi
}

disk-existing() {
	$cleverecho "Enter Disk Location: "
	read image

	$cleverecho "Disk Location: $image\n"
	$blankline
	$cleverecho "Options: [U]pload, [D]ownload, [M]ount, [S]etup, [Q]uit: "
	read diskoptions

	case $diskoptions in
		[Uu]) 	rclone copy $image linuxutopia.com:/Work/disks/ --progress ;;
		[Dd]) 	$cleverecho "Do you wish to Download $image?: "
				read yesno

				if [[ "$yesno" = "Yes" ]] | [[ "$yesno" = "yes" ]] | [[ "$yesno" = "Y" ]] | [[ "$yesno" = "y" ]]; then
					rclone copy linuxutopia.com:/Work/disks/$image . --progress
				fi

				if  [[ "$yesno" = "No" ]] | [[ "$yesno" = "no" ]]  | [[ "$yesno" = "N" ]] | [[ "$yesno" = "n" ]]; then
					$cleverecho "That's not a problem, come back soon\n";
					exit 0;
				fi
				;;
		[Qq])	return 0;;
	esac

	$blankline
	$cleverecho "Download image?: "; read yesno

	if [[ "$yesno" = "Yes" ]] | [[ "$yesno" = "yes" ]] | [[ "$yesno" = "Y" ]] | [[ "$yesno" = "y" ]]; then
		rclone copy linuxutopia.com:/Work/disks/$image . --progress
	fi

	if  [[ "$yesno" = "No" ]] | [[ "$yesno" = "no" ]]  | [[ "$yesno" = "N" ]] | [[ "$yesno" = "n" ]]; then
		$cleverecho "That's not a problem, come back soon\n";
		exit 0;
	fi

	$cleverecho "Upload image?: "; read yesno

	if [[ "$yesno" = "Yes" ]] | [[ "$yesno" = "yes" ]] | [[ "$yesno" = "Y" ]] | [[ "$yesno" = "y" ]]; then
		rclone copy $image linuxutopia.com:/Work/disks/ --progress
	fi

	if  [[ "$yesno" = "No" ]] | [[ "$yesno" = "no" ]]  | [[ "$yesno" = "N" ]] | [[ "$yesno" = "n" ]]; then
		$cleverecho "That's not a problem, come back soon\n";
		exit 0;
	fi
}

disk() {
	# New Virtual Disk Creation in Linux
	$cleverecho "Are you sure you want to setup a new Virtual Disk (Yes/No): "
	read yesno

	$cleverecho "Enter Virtual Disk Location: "
	read image

	if [[ "$yesno" = "Yes" ]] | [[ "$yesno" = "yes" ]] | [[ "$yesno" = "Y" ]] | [[ "$yesno" = "y" ]]; then
		dd if=/dev/zero of=$image bs=1G count=5
	fi

	if  [[ "$yesno" = "No" ]] | [[ "$yesno" = "no" ]]  | [[ "$yesno" = "N" ]] | [[ "$yesno" = "n" ]]; then
		$cleverecho "That's not a problem, come back soon\n";
		exit 0;
	fi

	$cleverecho "Ready to configure the disk image? (Yes/No): "
	read answer

	if [[ "$answer" = "Yes" ]] | [[ "$answer" = "yes" ]] | [[ "$answer" = "Y" ]] | [[ "$answer" = "y" ]]; then
	sudo cfdisk $image
	fi

	if [ "$answer" = "No" ]; then
		$cleverecho "That's not a problem, come back soon\n";
		exit 0;
	fi

	$cleverecho "Ready to copy $image to Server?: "
	read yesno

	if [[ "$yesno" = "Yes" ]] | [[ "$yesno" = "yes" ]] | [[ "$yesno" = "Y" ]] | [[ "$yesno" = "y" ]]; then
		rclone copy $image linuxutopia.com:/Work/disks/ --progress
	fi

	if  [[ "$yesno" = "No" ]] | [[ "$yesno" = "no" ]]  | [[ "$yesno" = "N" ]] | [[ "$yesno" = "n" ]]; then
		$cleverecho "That's not a problem, come back soon\n";
		exit 0;
	fi

}

repo-setup1() {
	$cleverecho "Install Packages?: "
	read yesno

	if [[ "$yesno" = "Yes" || "$yesno" = "yes" || "$yesno" = "Y" || "$yesno" = "y" ]]; then
		echo sudo dpkg-dev apt-get install -y gcc gpg dpkg-dev libc6-dev
	fi

	if  [[ "$yesno" = "No" || "$yesno" = "no" || "$yesno" = "N" || "$yesno" = "n" ]]; then
		$cleverecho "That's not a problem, come back soon\n";
		exit 0;
	fi

}

repo-setup0() {

# Host on Linode ??
# Custom Apt Repository

repoaddress="apt.ukhosts.cc"
repoport="8000"

# Install APT Repo into /etc/apt/sources.d/$repoaddress.list

$cleverecho "Install Custom Repository for $repoaddress?: "
read yesno
	if [[ "$yesno" = "Yes" || "$yesno" = "yes" || "$yesno" = "Y" || "$yesno" = "y" ]]; then
		sudo $cleverecho "deb [arch=amd64] http://$repoaddress:$repoport/ stable main" > /etc/apt/sources.list.d/aleksd2000.list
		sudo apt update --allow-insecure-repositories

	fi
	if  [[ "$yesno" = "No" || "$yesno" = "no" || "$yesno" = "N" || "$yesno" = "n" ]]; then
		$cleverecho "That's not a problem, come back soon\n";
		exit 0;
	fi
# custom packages for apt repo: gpg gcc dpkg-dev libc6-dev

sudo apt-get install -y gcc gpg dpkg-dev libc6-dev

#######

# Place all custom scripts in 
#    Repo/Packages/
# then

cd Repo/Packages/

dpkg --build aleksd2000-scripts_0.0.0.0-1/
dpkg --info aleksd2000-scripts_0.0.0.0-1.deb

move *.deb files into APT/pool/main
cd ../../
cd APT/

dpkg-scan packages --arch amd64 pool/ > dists/stable/main/binary-amd64/Packages
cat APT/dists/stable/main/binary-amd64/Packages | gzip -9 > APT/dists/stable/main/binary-amd64/Packages.gz

cd APT/dists/stable && APT/generate-release.sh > Release

screen -dmS apt-repo python -m http.server 8000 --bind $repoaddress

# sudo apt install custom.shellscripts.for.aleksd2000

}

nooptions() {
	$cleverecho "$progname\n"
	$blankline
	$cleverecho "\tThis command requires command line arguments\n"
	$cleverecho "\tTry $progname --help\n"
}

repo-start() {
	screen -dmS APT-Repo python -m http.server 8000 --bind $repoaddress
}

repo-address() {
	
$cleverecho "Install Custom Repository for $repoaddress?: "
read yesno
	if [[ "$yesno" = "Yes" || "$yesno" = "yes" || "$yesno" = "Y" || "$yesno" = "y" ]]; then
		sudo $cleverecho "deb [arch=amd64] http://$repoaddress:$repoport/ stable main" > /etc/apt/sources.list.d/aleksd2000.list
		sudo apt update --allow-insecure-repositories

	fi
	if  [[ "$yesno" = "No" || "$yesno" = "no" || "$yesno" = "N" || "$yesno" = "n" ]]; then
		$cleverecho "That's not a problem, come back soon\n";
		exit 0;
	fi
}

if [ "$1" = "" ]; then nooptions; fi
if [[ "$1" = "repo" && "$2" = "add" ]];   then repo-setup1; fi
if [[ "$1" = "repo" && "$2" = "setup" ]]; then repo-setup1; fi
