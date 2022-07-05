finish configure utility

ADD HELP MENU to respond to program ran without any arguments

Setup custom disk for stuff that I'm working on and store it in googledrive?
        \ - disks/projects.img [5G in size - first partition pending, second partition live]

Set up custom install scripts and finish it this time: 
        should check for WSL and install appropriate stuff      [WSL Stuff]
        if physical server install certain stuff                [Physical Stuff]

[WSL Stuff]
kali-win-kex
gh
git
code
code-insiders
screen

to setup a workspace
dd if=/dev/zero of=disks/projects.img bs=1G count=5 && \
        sudo cfdisk disks/project.img && \
        sudo mkfs.ext4 /dev/loop0p1 && \
        sudo mkfs.ext4 /dev/loop0p2

        screen -dmS "rclone copy projects.img linuxutoopia.com:/Work/disks/ --progress"
