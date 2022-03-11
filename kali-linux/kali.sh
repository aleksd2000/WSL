#!/bin/bash

# Kali custom install script

full-install() {

    sudo apt update
    sudo apt install -y kali-linux-large
}

windows() {
    kex --esm --ip 
}


code-insiders() {
        # Installs code-insiders
            sudo apt install curl gpg gnupg2 software-properties-common apt-transport-https 
            curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
            echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
            sudo apt update
            sudo apt install -y code-insiders
            return 0;
}

code() {
        # Installs code
            sudo apt install curl gpg gnupg2 software-properties-common apt-transport-https 
            curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
            echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
            sudo apt update
            sudo apt install -y code
            rm microsoft.gpg
            return 0;
}

gh() {
    # Installs gh
    VERSION=`curl  "https://api.github.com/repos/cli/cli/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/' | cut -c2-` 
    echo $VERSION
    curl -sSL https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_amd64.tar.gz -o gh_${VERSION}_linux_amd64.tar.gz
    tar xvf gh_${VERSION}_linux_amd64.tar.gz
    sudo cp gh_${VERSION}_linux_amd64/bin/gh /usr/local/bin/
    # tidy up of files
    rm gh_${VERSION}_linux_amd64.tar.gz
    rm -rf gh_${VERSION}_linux_amd64
    sudo apt update
    sudo apt install -y git
    return 0
}

if [ "$1" = "windows" ]; 	                                then windows;		fi
if [ "$1" = "full-install" ]; 	                            then full-install;	fi

# Custom Apps support

if [[ "$1" = "custom-apps" && "$2" = "code-insiders" ]];	then code-insiders;	fi
if [[ "$1" = "custom-apps" && "$2" = "code" ]];	            then code;	        fi
if [[ "$1" = "custom-apps" && "$2" = "gh" ]];	            then gh;	        fi
